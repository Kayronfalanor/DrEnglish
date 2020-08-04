<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = True
'// menu setting
Dim mMenu : mMenu = "1"
Dim sMenu : sMenu = "1"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<% 

BrowseFlag = ""

If InStr(Request.ServerVariables("HTTP_USER_AGENT"),"iPod") Or InStr(Request.ServerVariables("HTTP_USER_AGENT"),"iPhone") Or InStr(Request.ServerVariables("HTTP_USER_AGENT"),"iPad") Or InStr(Request.ServerVariables("HTTP_USER_AGENT"),"Macintosh")  Then 
		BrowseFlag="IOS"
		MobileFlag="IOS"
 End If

 If InStr(Request.ServerVariables("HTTP_USER_AGENT"),"Android")  Then 
		BrowseFlag="Android"
		MobileFlag=""
End If

Dim pageSize: pageSize= 10
Dim rowSize	: rowSize = 50
Dim currPage: currPage= sqlCheck(Replace(Request("currPage"), "'", "''"))
If Len(currPage) = 0 Then
	currPage = 1
End If
currPage = CInt(currPage)

searchDate = sqlCheck(Replace(Request("searchDate"), "'", "''"))

If searchDate = "" Then
	searchDate = Left(Now(),10)
End If 


nowdtime =  Right("0"&datepart("h",dateadd("n",3,now())),2) & ":" & Right("0"&datepart("n",dateadd("n",3,now())),2)
	




Dim arrData, objRs, Sql
'Sql = "Prc_tb_Schedule_User_Select_List N'"& SiteCPCode &"', '"& sUserSeq &"', N'', '"& currPage &"', '"& rowSize &"'"

sql = " select tdr.iDailyReportSeq , tdr.nvcDailyReportDate , tdr.nvcScheTime , tdr.iTeacherSeq , tch.nvcTeacherName, "
sql = sql & "  tdr.iScheduleSeq , ts.nvcCPCode , tdr.iSchedetailSeq ,tm.nvcMemberID , Tm.nvcMemberEName, "
sql = sql & "  tdr.iTBtooksToSeq, tb.nvcTBooksName , tb.nvcTBooksImage, isnull(tdr.siAttendance,0) as siAttendance , st.nvcScheTypeCode,  "
sql = sql & "  ssp.nvcScheNumber, cp.iClassConfigSeq as VideoClassConfigSeq, cct.iClassConfigSeq as PhoneClassConfigSeq , tdr.nvcScheTel ,"
sql = sql & " '' as nvcProductName,  ts.siSchePlayTime,tbc.nvcChapterName, tsd.sischeflag,isnull(tsd.nvcScheExpire,'')  as nvcScheExpire "
sql = sql & " from tb_dailyreport as tdr with(nolock) inner join tb_Schedule as ts with(nolock) on tdr.iScheduleSeq = ts.iScheduleSeq " 
sql = sql & "  inner join tb_Schedetail as tsd with(nolock) on tdr.ischedetailSeq = tsd.iSchedetailSeq  "
sql = sql & "  inner join tb_Member as tm with(nolock) on tdr.iMemberSeq = tm.iMemberSeq "
sql = sql & "  inner join tb_Teacher as tch with(nolock) on tdr.iTeacherSeq = tch.iTeacherSeq "
sql = sql & "  left outer join tb_TBooks as tb with(nolock) on tdr.iTBtooksToSeq = tb.itbooksSeq "
sql = sql & "  left outer join tb_Schetype as st with(nolock) on ts.ischetypeseq = st.ischetypeseq "
sql = sql & "  left outer join tb_Scheshape as ssp with(nolock) on ts.iScheShapeSeq = ssp.iScheShapeSeq "
sql = sql & "  left outer join tb_cp as cp with(nolock) on ts.nvcCPCode = cp.nvcCPCode "
sql = sql & "  left outer join tb_callcenter as cct with(nolock) on tch.icallcenterSeq = cct.icallcenterSeq "
sql = sql & "  left outer join tb_tbchapter as tbc with(nolock) on isnull(tbc.iTBChapterSeq,0) = isnull(tdr.iTBChapterToSeq,0) "
sql = sql & "  where tdr.siAttendance in (0,1,2) and (tsd.sischeflag in (1,2) or "
sql = sql & " (tsd.sischeflag = 3 and isnull(tsd.nvcScheExpire,'') <= '" & Left(now(),10) & "')) "
sql = sql & " and left(tdr.nvcDailyReportDate,7) ='" & Left(searchDate,7) & "'  "
sql = sql & "  and tdr.iMemberSeq = '" & sUserSeq & "' and ts.nvcCPCode=N'" & SiteCPCode & "'"
sql = sql & "  order by tdr.nvcDailyReportDate + ' ' + tdr.nvcScheTime asc "

Set objRs = dbSelect(Sql)

If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing
Call DBClose()




Set oDOM = Server.CreateObject("Microsoft.XMLDOM")

with oDOM
    .async = False ' 
    .setProperty "ServerHTTPRequest", True ' HTTP XML  
    .Load("http://siteconfig.inetstudy.co.kr/ClassConfig/mobileapk.asp?CompanyCode="&SiteCPCode& "&MobileFlag="&MobileFlag)
end with

Set Nodes = oDOM.getElementsByTagName("row")

	For each SubNodes in Nodes

		MobilePath= SubNodes.getElementsByTagName("mobilepath")(0).Text
	Next

Set Nodes=nothing
Set oDOM=Nothing

%>
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/Commonfiles/Scripts/mypage.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$mypage.study.init.call(this);
});
function goProDown(){
	location.href="<%=VideoClassFile%>";
}





function ClassStart(sdatetime,sscindex, ssuser,ssconfig,ssplaytime){

	<% If (BrowseFlag = "Android" Or BrowseFlag = "IOS") Then %>
	document.videofrom.stime.value = sdatetime;
	document.videofrom.cindex.value = sscindex;
	document.videofrom.submit();
	<% Else %>
	document.videofrom.stime.value = sdatetime;
	document.videofrom.cindex.value = sscindex;
	document.videofrom.maxuser.value = ssuser;
	document.videofrom.ClassConfigSeq.value = ssconfig;
	document.videofrom.playtime.value = ssplaytime;
	document.videofrom.submit();

	<% End If %>

}


function FileRecordDownload(ncScheTypeCode,iScheduleSeq,iScheDetailSeq,attendate,videoclassconfigseq,phoneclassconfigseq,CompanyCode,nvcScheTel)
	{	

		if (ncScheTypeCode=="VE")
		{
			window.open('<%=VideoDownloadURL%>?iScheduleSeq='+iScheduleSeq+'&iScheDetailSeq='+iScheDetailSeq+'&attendate='+attendate+'&iClassConfigSeq='+videoclassconfigseq+'&CompanyCode='+CompanyCode+'&nvcScheTel='+nvcScheTel+'&ncScheTypeCode='+ncScheTypeCode,'FileRecord','width=500 ,height=500 , top=10,left=10 ,scrollbars=YES ,status=NO')
		}

		if (ncScheTypeCode=="PE")
		{
			window.open('<%=PhoneDownloadURL%>?iScheduleSeq='+iScheduleSeq+'&iScheDetailSeq='+iScheDetailSeq+'&attendate='+attendate+'&iClassConfigSeq='+phoneclassconfigseq+'&CompanyCode='+CompanyCode+'&nvcScheTel='+nvcScheTel+'&ncScheTypeCode='+ncScheTypeCode,'FileRecord','width=500 ,height=500 , top=10,left=10 ,scrollbars=YES ,status=NO')
		}

	}

	function DailyComment(iScheduleSeq,iSchedetailSeq,attendate,iDailyReportSeq)
	{
		window.open('/include/DailyComment.asp?iScheduleSeq='+iScheduleSeq+'&iScheDetailSeq='+iSchedetailSeq+'&attendate='+attendate+'&iDailyReportSeq='+iDailyReportSeq,'DailyComment','width=800 ,height=440 , top=10,left=10 ,scrollbars=YES ,status=NO')
	
	}

</script>
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="contents_title"><img src="../img/sub/title_1_01.gif" alt="학습현황" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr><td align=center valign=top>
	
	<table width="650" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15"><img src="../img/board/box_b01.gif" width="15" height="15" /></td>
			<td background="../img/board/box_b02.gif"></td>
			<td width="15"><img src="../img/board/box_b03.gif" width="15" height="15" /></td>
		</tr>
		<tr>
			<td background="../img/board/box_b08.gif">&nbsp;</td>
			<td align="left" bgcolor="#F1F9FF">


	<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#F1F9FF">
	<tr><td height=4></td></tr>
	<% If BrowseFlag = "" Then %>
	
	<tr>
		<td width=681>
		<TABLE CELLPADDING=0 cellspacing=0 border=0 width=681>
		<tr>
			<td height=30 width=380 ><b>* <font color="#2e08ba">PC로 접속할 경우</font>, 화상 프로그램을 설치하지 않은 분은 클릭하여 설치하세요.</td>
			<td width=100><input type="button" value="화상 프로그램 다운로드" onclick="javascript:goProDown();" style="width:200px;height:36px;background:red;font-size:16px;color:#FFFFFF;"></td>
		</tr>
		</table>
		
		</td>
	</tr>	
	<tr>
		<td >&nbsp;</td>
	</tr>
	<% End If %>
	
	<%
	' 모바일용
	'if (BrowseFlag = "Android" Or BrowseFlag = "IOS") Then%>
	<tr>
		<td width=681>
		<TABLE CELLPADDING=0 cellspacing=0 border=0 width=681>
		<tr><td height=30 width=320><b>* <font color="#2e08ba">모바일로 접속할 경우</font>, 화상 APP을 설치하지 않은 분은</td><td width=106> <a href="<%=MobilePath%>" target='_blank'><img src='/img/sub/btn_class04.gif'  BORDER=0/> </A></td><td><b> 버튼을 클릭하여 설치하세요. </b>
		</td></tr>
		<!--<tr><td height=30 colspan="3">* 화상 APP 설치 완료 후, 화상수업 START 버튼을 클릭하세요.</b></td></tr>-->
		</table>
		
		</td>
	</tr>	
	<%' End If  %>
	<tr>
		<td >&nbsp;</td>
	</tr>
	<tr>
		<td width=681>
		
		<TABLE CELLPADDING=0 cellspacing=0 border=0 width=681>
		<tr><td height=30 width=320><b>* 수업일과 수업시간을 꼭 확인하시고, 아래 수업목록에서</td><td width=110> <img src='/img/sub/btn_class.gif' alt='화상수업' border="0" > </td><td><b> &nbsp;버튼을 클릭하여 수업입장하세요. </b>
		</td></tr>		
		</table>
		
		

		</td>
	</tr>	
	<tr>
		<td >&nbsp;</td>
	</tr>
	
	<tr><td height=4></td></tr>
	</table>
	
											</td>
					<td background="../img/board/box_b04.gif">&nbsp;</td>
				</tr>
				<tr>
					<td width="15"><img src="../img//board/box_b07.gif" width="15" height="15" /></td>
					<td background="../img/board/box_b06.gif"></td>
					<td width="15"><img src="../img/board/box_b05.gif" width="15" height="15" /></td>
				</tr>
			</table>
	</td>
	</tr>

	<tr>
	<td height=10></td>
	</tr>
	<tr><td align="center" valign="top" > 
	
	<table width="250" height="39" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="36"><a href="MyPage.asp?searchDate=<%=DateAdd("m", -1, searchDate)%>"><img src="/img/sub/btn_cal_prev.gif" /></a></td>
								<td background="/img/sub/btn_cal_bg.gif" class="point05"><%=Year(searchDate)%>. <%=Month(searchDate)%></td>
								<td width="26"><a href="MyPage.asp?searchDate=<%=DateAdd("m", 1, searchDate)%>"><img src="../img/sub/btn_cal_next.gif" /></a></td>
							</tr>
						</table>
	
	</td></tr>
	<tr>
	<td height=10></td>
	</tr>
	<tr>
		<td align="center" valign="top" > 


			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<!-- board_title -->
						<table width="650" border="0" cellspacing="0" cellpadding="0" style="font-size:14px;">
							<tr>
								<td width="11"><img src="../img/board/b_bar1.gif" width="11" height="31" /></td>
								<td width="100" align="center" background="../img/board/b_bar2.gif"><span style="color:#ffffff;"><b>수업일</b></font></td>
								<td width="100" align="center" background="../img/board/b_bar2.gif"><span style="color:#ffffff;"><b>수업시간/분</b></font></td>
								<td width="150" align="center" background="../img/board/b_bar2.gif"><span style="color:#ffffff;"><b>레벨/진도</b></font></td>
								<td width="150" align="center" background="../img/board/b_bar2.gif"><span style="color:#ffffff;"><b>수업참여</b></font></td>
								<td  align="center" background="../img/board/b_bar2.gif"><span style="color:#ffffff;"><b>녹화파일/Report</b></font></td>
								<td width="11"><img src="../img/board/b_bar3.gif" width="11" height="31" /></td>
							</tr>
						</table>
					<!-- board_title end -->
					</td>
				</tr>
				<tr>
					<td>
					<!-- board_list -->
						<table width="650" border="0" cellspacing="0" cellpadding="0" class="notice_style">
<table border="0" width="100%" cellspacing="0" cellpadding="0" style="font-size:14px;">
<form method="post" Action="mypage.asp" name="Bform">
<input type="hidden" name="currPage" id="currPage" value="<%=currPage%>"/>
<input type="hidden" name="searchDate" id="searchDate" value="<%=searchDate%>"/>
</form>
<%
With Response
If IsArray(arrData) Then
'0.iScheDuleSeq,	1.nvcMemberName,	2.nvcTeacherID,		3.nvcScheStartDate,		4.nvcScheEndDate
'5.nvcScheTime,		6.siSchePlayTime,	7.nvcProductName,	8.siScheFlag,			9.RID
'10 . siScheType    11.TOTALRECORD,	12.TOTALPAGE

	Dim strFlag
	For i = 0 To Ubound(arrData, 2)

		If arrData(8, i) = "0" Then
			strFlag = "N"
		Else
			strFlag = "Y"
		End If
		
		scheEndTime=""
		ScheEndTime = Right("0"&datepart("h",dateadd("n",Trim(arrData(20, i)&"")+5,FormatDateTime(Trim(arrData(2, i)&""),4))),2) & ":" & Right("0"&datepart("n",dateadd("n",Trim(arrData(20, i)&"")+5,FormatDateTime(Trim(arrData(2, i)&""),4))),2)

		.Write "<tr align='center' height='30'>"
		.Write "	<td width='100'>"& arrData(1, i) &"</td>"
		.Write "	<td width='100'>"& arrData(2, i) & "/" & arrData(20, i) &" min</td>"
		
		.Write "	<td width='150'>"&arrData(11, i) & "/" & arrData(21, i) & "</td>"
		If arrData(1, i) < Left(now(),10) Then
		
				If Trim(arrData(13, i)&"") = "0" Then
					.Write "	<td width='150' align='center'><span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:gray;'><b>대기</b></span></td>"
				ElseIf Trim(arrData(13, i)&"") = "1" Then
					.Write "	<td width='150' align='center'><span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:BLUE;'><b>출석</b></span></td>"
				ElseIf Trim(arrData(13, i)&"") = "2" Then
					.Write "	<td width='150' align='center'><span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:Red;'><b>결석</b></span></td>"
				ElseIf Trim(arrData(13, i)&"") = "3" Then
					.Write "	<td width='150' align='center'><span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:margenta;'><b>연기</b></span></td>"
				ElseIf Trim(arrData(13, i)&"") = "4" Then
					.Write "	<td width='150' align='center'><span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:gray;'><b>취소</b></span></td>"
				else
				.Write "	<td width='150'></td>"
				End If
		Else
			If arrData(1, i) = Left(now(),10) Then					
				If CLng(replace(scheEndTime,":","")&"") < CLng(replace(Trim(nowdtime&""),":","")&"") Then
					If Trim(arrData(13, i)&"") = "0" Then
						.Write "	<td width='150' align='center'><span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:gray;'><b>대기</b></span></td>"
					ElseIf Trim(arrData(13, i)&"") = "1" Then
						.Write "	<td width='150' align='center'><span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:BLUE;'><b>출석</b></span></td>"
					ElseIf Trim(arrData(13, i)&"") = "2" Then
						.Write "	<td width='150' align='center'><span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:Red;'><b>결석</b></span></td>"
					ElseIf Trim(arrData(13, i)&"") = "3" Then
						.Write "	<td width='150' align='center'><span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:margenta;'><b>연기</b></span></td>"
					ElseIf Trim(arrData(13, i)&"") = "4" Then
						.Write "	<td width='150' align='center'><span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:gray;'><b>취소</b></span></td>"
					else
					.Write "	<td width='150'></td>"
					End If
				Else
					If arrData(14, i) = "VE" Then
					
					.Write "	<td width='150'><a href=""javascript:ClassStart('" & Replace(Left(now(),10),"-","")&Replace(arrData(2, i),":","") & "','" & arrData(5, i) & "_" & Replace(arrData(2, i),":","")  & "','" & arrData(15, i) & "','" & arrData(16, i) & "','" & arrData(20, i) & "');""><img src='/img/sub/btn_class.gif' border='0'></a></td>"
					
					ElseIf arrData(14, i) = "PE" Then
					
						.Write "	<td width='150'><span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:gray;'><b>Phone</b></span></td>"

					Else
						.Write "	<td width='150'><span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:gray;'><b>None</b></span></td>"
					End IF
				End If
			Else
				.Write "	<td width='150' align='center'><span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:gray;'><b>대기</b></span></td>"
			End If
		End If

		.Write "<td ><a href=""javascript:FileRecordDownload('"&arrData(14, i)&"','"& arrData(5, i) & "_" & Replace(arrData(2, i),":","") &"','"&arrData(7, i)&"','" & arrData(1, i) &"','"&arrData(16, i)&"','2','" & SiteCPCode  &"','"&Trim(arrData(18, i))&"');""><img src='/img/sub/cal_icon_07.gif' alt='녹화파일' border=0/></a>"
		.Write "/ <a href=""javascript:DailyComment('"&arrData(5, i)&"','"&arrData(7, i)&"','"&arrData(1, i)&"','"&arrData(0, i)&"');""><img src='/img/sub/cal_icon_15.gif' alt='코멘트' border=0 /></a></td>"		

		.Write "</tr>"

		.Write "<tr><td colspan='6' height='1' style='background-color:#e0e0e0;'></td></tr>"
	Next
Else
	.Write "<tr><td align='center' colspan='6' height='150'>수업정보가 없습니다.</td></tr>" & vbCrlf
End If
End With
%>


<%
' 모바일용
if instr(c_agent,"Mobile") > 0 or instr(c_agent,"Andr") > 0 Then%>
<form name="videofrom" id="videofrom" action="http://siteconfig.inetstudy.co.kr/ClassConfig/MobileLink.asp" method="post" target="_Blank">
<input type="hidden" name="CompanyCode" id="CompanyCode" value="<%=SiteCPCode%>">
<input type="hidden" name="id" id="id" value="<%=sUserID%>">
<input type="hidden" name="Name" id="Name" value="<%=iif(sUserEName&"","",sUserName,sUserEName)%>">
<input type="hidden" name="state" id="state" value="2">
<input type="hidden" name="title" id="title" value="UseTalking Video Class">
<input type="hidden" name="cindex" id="cindex" value="">
<input type="hidden" name="stime"		value="" />  <!-- hhmm -->
<input type="hidden" name="MobileFlag" value="<%=MobileFlag%>">
</form>

<%else%>
<form name="videofrom" method="post"  action="<%=VideoClassURL%>" target="_Blank">
<input type="hidden" name="id"			value="<%=sUserID%>" />
<input type="hidden" name="name"		value="<%=iif(sUserEName&"","",sUserName,sUserEName)%>" />
<input type="hidden" name="state"		value="2" /><!-- (1:강사 or 2:학생 or 17:Observer) -->
<input type="hidden" name="title"		value="UseTalking Video Class" />
<input type="hidden" name="cindex"		value="" />  <!-- 수업은 iScheduleSeq_VE , 레벨테스트는 iLevelTestSeq_LV -->
<input type="hidden" name="maxuser"		value="" />
<input type="hidden" name="playtime"	value="" />
<input type="hidden" name="stime"		value="" />  <!-- hhmm -->
<input type="hidden" name="CompanyCode"		value="<%=SiteCPCode%>" />   <!-- 업체코드 -->
<input type="hidden" name="ClassConfigSeq"		value="" />  <!-- tb_cp에 연결된 iClassConfigSeq -->
<input type="hidden" name="roomtype"					value="" />
<input type="hidden" name="bitrateT" value="160">
<input type="hidden" name="fpsT" value="10">
<input type="hidden" name="bitrateS" value="90">
<input type="hidden" name="fpsS" value="10">
</form>
<%
End If
' 모바일용
%>
						</table>
					<!-- board_list end-->
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td >&nbsp;</td>
	</tr>
	
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->