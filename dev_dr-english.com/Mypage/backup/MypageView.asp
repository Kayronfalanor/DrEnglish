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

Dim sche_seq : sche_seq = sqlCheck(Replace(Request("sche_seq"), "'", "''"))


chkRequestVal sche_seq,	"잘못된 접근입니다.\n정상적인 방법으로 이용해 주세요."

Dim Sql, arrData, objRs

Sql = "PRC_tb_Schedule_User_Select_View N'"& SiteCPCode &"', '"& sche_seq &"', '"& sUserSeq &"'"
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing

Dim arrWeek(7)
If IsArray(arrData) Then
	strPSSeq	= arrData(0, 0)
	strPName	= arrData(1, 0)
	strBName	= arrData(2, 0)
	strTName	= arrData(3, 0)
	strSSDate	= arrData(4, 0)
	strSEDate	= arrData(5, 0)
	strMon		= arrData(6, 0)
	strTue		= arrData(7, 0)
	strWed		= arrData(8, 0)
	strThu		= arrData(9, 0)
	strFri		= arrData(10, 0)
	strSat		= arrData(11, 0)
	strSun		= arrData(12, 0)
	siFlag		= arrData(13, 0)
	strScheTime	= arrData(14, 0)
	strPlayTime = arrData(15, 0)
	strScheType = arrData(16, 0)
	strCSeq		= arrData(17, 0)
	strTSeq		= arrData(18, 0)
	strMaxSeq	= arrData(19, 0)
	VideoClassConfigSeq	= arrData(23, 0)
	PhoneClassConfigSeq	= arrData(24, 0)
	nvcScheTypeCode	= arrData(25, 0)
	siScheTypeType	= arrData(26, 0)

	If strMon = "Y" Then arrWeek(0) = "월" End If
	If strTue = "Y" Then arrWeek(1) = "화" End If
	If strWed = "Y" Then arrWeek(2) = "수" End If
	If strThu = "Y" Then arrWeek(3) = "목" End If
	If strFri = "Y" Then arrWeek(4) = "금" End If
	If strSat = "Y" Then arrWeek(5) = "토" End If
	If strSun = "Y"	Then arrWeek(6) = "일" End If

	'// 수업시간에 맞는 화상 어플케이션 오픈
	strTime = Split(strScheTime, ":")
	strTime1= strTime(0)	:	strTime2 = strTime(1)
	S_SL_Ctime_1 = strTime1	:	S_SL_Ctime_2 = strTime2

	If strTime2 = "00" Then
		S_SL_Ctime_1 = CInt(strTime1) - 1
		S_SL_Ctime_2 = 50
	ElseIf strTime2 = "05" Then
		S_SL_Ctime_1 = CInt(strTime1) - 1
		S_SL_Ctime_2 = 55
	Else
		S_SL_Ctime_1 = CInt(strTime1)
		S_SL_Ctime_2 = CInt(strTime2) - 10
	End If

	If S_SL_Ctime_1 < 10 Then
		S_SL_Ctime_1 = "0" & S_SL_Ctime_1
	End If

	If S_SL_Ctime_2 < 10 Then
		S_SL_Ctime_2 = "0" & S_SL_Ctime_2
	End If

	S_video_SL_Ctime= S_SL_Ctime_1 & ":" & S_SL_Ctime_2
	E_SL_Ctime_2	= Int(strTime1) + Int(strTime2)

	IF E_SL_Ctime_2 >= "60" THEN
		E_SL_Ctime_1 = CInt(strTime1) + 1
		E_SL_Ctime_2 = E_SL_Ctime_2 - 60
	ELSE
		E_SL_Ctime_1 = CInt(strTime1)
		E_SL_Ctime_2 = E_SL_Ctime_2
	END IF

	IF E_SL_Ctime_1 < 10 THEN
		E_SL_Ctime_1 = "0" & E_SL_Ctime_1
	END If
	
	IF E_SL_Ctime_2 < 10 THEN
		E_SL_Ctime_2 = "0" & E_SL_Ctime_2
	END If
	
	E_video_SL_Ctime = E_SL_Ctime_1 & ":" & E_SL_Ctime_2

	nowHTime = Hour(now)
	nowMtime = Minute(now)

	If nowMTime < 10 Then
		nowMTime = "0" & nowMTime
	End If

	nowTimes = nowHTime & ":" & nowMTime

	bVideoState = True

	If nowTimes >= S_video_SL_Ctime And nowTimes < E_video_SL_Ctime Then
		bVideoState = True
	End If
	
	sTime = Replace(strScheTime,":","")


	'##### 강사 휴강 정보 #####
	Dim strReason
	Dim bTeacherPostPone : bTeacherPostPone = False
	Sql = "PRC_tb_TeacherPostPone_User_Select_List '"& strCSeq &"', '"& strTSeq &"'"
	Set objRs = dbSelect(Sql)
	If Not objRs.Eof Then
		bTeacherPostPone= True
		strReason		= objRs(2)
	End If
	objRs.Close	:	Set objRs = Nothing

	
	'##### 학생 출결석 현황 #####
	Dim iTotalLec	: iTotalLec		= 0
	Dim iTotalAttend: iTotalAttend	= 0
	Dim iPerAttend	: iPerAttend	= 0
	Dim iStudy		: iStudy		= 0
	Dim iPresent	: iPresent		= 0
	Dim iAbsend		: iAbsend		= 0
	Dim iPostpone	: iPostpone		= 0
	Dim iCancel		: iCancel		= 0
	Sql = "PRC_tb_DailyReport_User_Progress '"& sche_seq &"', '"& sUserSeq &"'"
	Set objRs = dbSelect(Sql)
	If Not objRs.Eof Then
		iTotalLec	= objRs(0) '총 강의수
		iStudy		= objRs(1) '남은 강의수
		iPresent	= objRs(2) '출석
		iAbsend		= objRs(3) '결석
		iPostpone	= objRs(4) '연기
		iCancel		= objRs(5) '취소

		iPerAttend = FormatNumber((iPresent / iTotalLec) * 100, 0) 
	End If
	objRs.Close	:	Set objRs = Nothing
Else
	Call DBClose()
	chkRequestVal "",	"진행중인 수업현황이 없습니다."
End If

isTodayStudy = 0
Dim arrDaily
	sql = "select top 1  iDailyReportSeq,nvcDailyReportDate,nvcScheTime from tb_DailyReport "
	sql = sql & " where iScheduleSeq='"&sche_seq&"' and iMemberSeq='"&sUserSeq&"' and nvcDailyReportDate='"&Left(Now(),10)&"' "
	sql = sql & " and (siAttendance=0 or siAttendance is null )  order by nvcDailyReportDate asc "
	Set objRs = dbSelect(Sql)
	If Not objRs.Eof Then
		sTime=objRs(2)
		isTodayStudy = 1
	End if	
	objRs.Close	:	Set objRs = Nothing

	sTime = Replace(sTime,":","")	


	sql = "select  te.nvcTeacherName, da.iDailyReportSeq,da.nvcDailyReportDate,da.nvcScheTime,isnull(da.siAttendance,0) "
	sql = sql & " , tb.nvctbooksName , tc.nvcChapterName "
	sql = sql & " from tb_DailyReport as da with(nolock) inner join tb_teacher as te with(nolock) on da.iteacherseq = te.iteacherseq "
	sql = sql & " left outer join tb_tbooks as tb with(nolock) on da.iTBTooksToSeq = tb.itbooksSeq "
	sql = sql & " left outer join tb_TBChapter as tc with(nolock) on da.iTBChapterToSeq = tc.iTBChapterSeq "						
	sql = sql & " where da.iScheduleSeq='"&sche_seq&"' and da.iMemberSeq='"&sUserSeq&"'  "
	sql = sql & " order by da.nvcDailyReportDate asc, da.nvcScheTime asc, da.iDailyReportSeq asc "
	Set objRs = dbSelect(Sql)
	If Not objRs.Eof Then
		arrData3 = objRs.GetRows()
	End If
	objRs.Close	:	Set objRs = Nothing


sql="select dbo.FUN_DailyReport_Time3('"&sche_seq&"','" & sUserSeq & "') "
Set objRs = dbSelect(Sql)
	If Not objRs.Eof Then
		strDateTime=objRs(0)
	End if	
	objRs.Close	:	Set objRs = Nothing

'교사이름
sql="select dbo.FUN_DailyReport_TeacherName('"&sche_seq&"','') "
Set objRs = dbSelect(Sql)
	If Not objRs.Eof Then
		strTchName=objRs(0)
	End if	
	objRs.Close	:	Set objRs = Nothing


'변경 가능 여부

Ischangeclass="0" 

sql = " select top 1 a.iScheduleSeq,a.iDailyReportseq from tb_dailyreport a inner join tb_schedule b on a.ischeduleseq = b.ischeduleseq "
sql = sql & " where a.siAttendance = 0 and b.siScheFlag=1 and a.iScheduleSeq = '" & sche_seq & "' "
Set objRs = dbSelect(Sql)
	If Not objRs.Eof Then
		Ischangeclass="1"
	End if	
	objRs.Close	:	Set objRs = Nothing


Call DBClose()


' 모바일용 시작 

 If InStr(Request.ServerVariables("HTTP_USER_AGENT"),"iPod") Or InStr(Request.ServerVariables("HTTP_USER_AGENT"),"iPhone") Or InStr(Request.ServerVariables("HTTP_USER_AGENT"),"iPad") Or InStr(Request.ServerVariables("HTTP_USER_AGENT"),"Macintosh")  Then 
		BrowseFlag="IOS"
		MobileFlag="IOS"

		
	sUserA=""
	user_agent_top = Request.ServerVariables("HTTP_USER_AGENT") 

	if instr(user_agent_top ,"Version/") > 0 then
		sUserA = Mid(user_agent_top, instr(user_agent_top,"Version/")+8,2)	
	end If

 End If

 If InStr(Request.ServerVariables("HTTP_USER_AGENT"),"Android")  Then 
		BrowseFlag="Android"
		MobileFlag=""
End If



Set oDOM = Server.CreateObject("Microsoft.XMLDOM")

with oDOM
    .async = False ' 
    .setProperty "ServerHTTPRequest", True ' HTTP XML  
    .Load("http://siteconfig.inetstudy.co.kr/ClassConfig/mobileapk.asp?CompanyCode="&SiteCPCode& "&MobileFlag="&MobileFlag&"&sUserA="&sUserA)
end with

Set Nodes = oDOM.getElementsByTagName("row")

	For each SubNodes in Nodes

		MobilePath= SubNodes.getElementsByTagName("mobilepath")(0).Text
	Next

Set Nodes=nothing
Set oDOM=Nothing




'모바일용 끝
'response.write "c_agent : " &c_agent
%>
<!--#include virtual="/include/inc_top.asp"-->
<link href="/Commonfiles/Scripts/datepicker/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/Commonfiles/Scripts/datepicker/jquery-ui.min.js"></script>
<script type="text/javascript" src="/Commonfiles/Scripts/ResizeFrameJS.js"></script>
<script type="text/javascript" src="/Commonfiles/Scripts/mypage.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$mypage.study.init.call(this);
});



function ClassStart(sdatetime,sscindex, ssflag){


	<% If (BrowseFlag = "Android" Or BrowseFlag = "IOS") Then %>
	document.videofrom.stime.value = sdatetime;
	document.videofrom.cindex.value = sscindex;
	document.videofrom.submit();
	<% Else %>
	document.videofrom.stime.value = sdatetime;
	document.videofrom.cindex.value = sscindex;
	document.videofrom.submit();
	<% End If %>

}
function goProDown(){
	location.href="<%=VideoClassFile%>";
}
</script>
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">

<form name="Bform" method="post">
<input type="hidden" name="sche_seq" value="<%=sche_seq%>" />
</form>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="contents_title"><img src="../img/sub/title_1_01.gif" alt="학습현황" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td ><img src="../img/sub/sub01_img01.gif" alt="출결및학습현황을 한눈에체크" /></td>
	</tr>
	<tr>
		<td >&nbsp;<!--<%=" Agent : " & c_agent%>--></td>
	</tr>
	<% If BrowseFlag = "" Then %>
	<tr>
		<td width=681>
		<TABLE CELLPADDING=0 cellspacing=0 border=0 width=681>
		<tr>
			<td height=30 width=420 ><b>* 화상 프로그램 이 설치되시지 않은 분은 버튼을 클릭하여 설치하세요.</td>
			<td width=110><input type="button" value="화상 프로그램 다운로드" onclick="javascript:goProDown();" style="width:200px;height:80px;background:red;font-size:17px;color:#FFFFFF;"></td>
		</tr>
		</table>
		
		</td>
	</tr>	
	<tr>
		<td >&nbsp;</td>
	</tr>
	<% End If %>
	
	<tr>
		<td width=681>
		<TABLE CELLPADDING=0 cellspacing=0 border=0 width=681>
		<tr><td height=30 ><b>*  아래 학습일에서 학습날짜와 학습시간을 꼭 확인하시고, <img src='/img/sub/btn_class.gif' alt='화상수업' border="0"> 버튼을 클릭하여 수업입장하세요.
		</td></tr>
		
		</table>

		</td>
	</tr>	
	<tr>
		<td >&nbsp;</td>
	</tr>
	<%
	' 모바일용
	if (BrowseFlag = "Android" Or BrowseFlag = "IOS") Then%>
	<tr>
		<td width=681>
		<TABLE CELLPADDING=0 cellspacing=0 border=0 width=681>
		<tr><td height=30 width=180><b>* 화상 APP 이 설치되시지 않은 분은</td><td width=110> <a href="<%=MobilePath%>" target='_blank'><img src='/img/sub/btn_class04.gif'  BORDER=0/> </A></td><td> 버튼을 클릭하여 설치하세요. 
		</td></tr>
		<tr><td height=30 colspan="3">* 화상 APP 설치 완료 후, 화상수업 START 버튼을 클릭하세요.</b></td></tr>
		</table>
		
		</td>
	</tr>	
	<tr>
		<td >&nbsp;</td>
	</tr>
	<% End If  %>
	<tr>
		<td height="30" align="center" > 
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="15"><img src="../img/board/box_b01.gif" width="15" height="15" /></td>
					<td background="../img/board/box_b02.gif"></td>
					<td width="15"><img src="../img/board/box_b03.gif" width="15" height="15" /></td>
				</tr>
				<tr>
					<td background="../img/board/box_b08.gif">&nbsp;</td>
					<td align="left" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
																							
														<!--<img src="../img/sub/btn_class02.gif" alt="교재학습" border=0 style="cursor:pointer;" class="cssstudy" caption="BSTUDY" />-->

<%
Dim strCaption, strMessage, strVideoUrl

With Response

If nvcScheTypeCode = "VE" Then '수업 타입이 화상일 경우만

	'strVideoUrl = "http://install.inetstudy.co.kr/Sdm/netstudy_install.asp"

	If bVideoState Then
		If bTeacherPostPone Then
			.Write "<div id='AlertMSG' title='강사 결근에 따른 공지' style='display:none;'>" & vbCrlf
			.Write "	<p><span class='ui-icon ui-icon-circle-check' style='float:left;margin:0 7px 40px 0;'></span>" & vbCrlf
			.Write "	오늘 <b>"& strTName &"</b> 강사님께서<p><b>"& strReason &"</b> (으)로 결근하게 되어</p>"
			.Write "	<p>대체 강사가 수업 진행합니다.</p></p>" & vbCrlf
			.Write "</div>" & vbCrlf

			strCaption = "POSTPONE"
		Else
			If isTodayStudy = 1 Then
				strCaption = "VIDEOVIEW"
			Else
				strCaption = "ALERT"
				strMessage = "오늘은 화상 수업일이 아닙니다."
			End If
		End If
	Else
		strCaption = "ALERT"
		If isTodayStudy = 1 Then
			strMessage = "화상수업 시간이 아닙니다. 수업시작시간 10분 전부터 종료 10분 후 까지 수업에 접속하실 수 있습니다. \n\n현재 페이지를 새로고침(F5) 후 접속하십시요."
		Else
			strMessage = "오늘은 화상 수업일이 아닙니다."
		End If
	End If

	If siFlag = 1 Then
		If CDate(Left(strSSDate,7)&"-01") > CDate(Left(Date(),7)&"-01") Then
			strCaption = "ALERT"
			strMessage = datepart("yyyy",strSSDate) & "년 " & datepart("m",strSSDate) & "월 수업입니다."
		End If
	ElseIf siFlag = 2 Then
		strCaption = "ALERT"
		strMessage = "종료된 수업입니다."
	ElseIf siFlag = 3 Then
		strCaption = "ALERT"
		strMessage = "해지된 수업입니다."
	End If

	'If sUserID = "baessi"  Then
	'	strCaption = "VIDEOVIEW"
	'End If

	' 모바일용
	if instr(c_agent,"Mobile") > 0 or instr(c_agent,"Andr") > 0 Then
		If strCaption = "VIDEOVIEW" then
			strCaption = "VIDEOVIEW2"
		End If

	'.Write "<img src='/img/sub/btn_class.gif' alt='화상수업' style='cursor:pointer;' class='cssstudy' caption='"& strCaption &"' message='"& strMessage &"' />" & vbCrlf
	else
	'.Write "<img src='/img/sub/btn_class.gif' alt='화상수업' style='cursor:pointer;' class='cssstudy' caption='"& strCaption &"' message='"& strMessage &"' />" & vbCrlf

	End If
	
	' 모바일용
End If
End With
%>														
																											
<%
' 모바일용
if instr(c_agent,"Mobile") > 0 or instr(c_agent,"Andr") > 0 Then%>
<form name="videofrom" id="videofrom" action="http://siteconfig.inetstudy.co.kr/ClassConfig/MobileLink.asp" method="post" target="_Blank">
<input type="hidden" name="CompanyCode" id="CompanyCode" value="<%=SiteCPCode%>">
<input type="hidden" name="id" id="id" value="<%=sUserID%>">
<input type="hidden" name="Name" id="Name" value="<%=sUserName%>">
<input type="hidden" name="state" id="state" value="2">
<input type="hidden" name="title" id="title" value="<%=strPName%>">
<input type="hidden" name="cindex" id="cindex" value="<%=sche_seq%>">
<input type="hidden" name="stime"		value="<%=Replace(Left(now(),10),"-","")&sTime%>" />  <!-- hhmm -->
<input type="hidden" name="MobileFlag" value="<%=MobileFlag%>">
</form>

<%else%>
<form name="videofrom" method="post"  action="<%=VideoClassURL%>">
<input type="hidden" name="id"			value="<%=sUserID%>" />
<input type="hidden" name="name"		value="<%=sUserEName%>" />
<input type="hidden" name="state"		value="2" /><!-- (1:강사 or 2:학생 or 17:Observer) -->
<input type="hidden" name="title"		value="<%=strPName%>" />
<input type="hidden" name="cindex"		value="<%=sche_seq%>" />  <!-- 수업은 iScheduleSeq_VE , 레벨테스트는 iLevelTestSeq_LV -->
<input type="hidden" name="maxuser"		value="<%=strMaxSeq%>" />
<input type="hidden" name="viewuser"	value="<%=strMaxSeq%>" />
<input type="hidden" name="playtime"	value="<%=strPlayTime%>" />
<input type="hidden" name="stime"		value="<%=Replace(Left(now(),10),"-","")&sTime%>" />  <!-- hhmm -->
<input type="hidden" name="CompanyCode"		value="<%=SiteCPCode%>" />   <!-- 업체코드 -->
<input type="hidden" name="ClassConfigSeq"		value="<%=VideoClassConfigSeq%>" />  <!-- tb_cp에 연결된 iClassConfigSeq -->
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

<form name="changeclass" method="post"  action="/TeacherClass/Postpone.asp">
<input type="hidden" name="iScheduleSeq"		value="<%=sche_seq%>" />  

</form>


										
										
										<tr>
											<td height="30"><img src="../img/sub/sub01_1_img19.gif" alt="학습종료일" width="96" height="14" /></td>
											<td><%=strTName%></td>
											<td height="30"><img src="../img/sub/sub01_1_img16.gif" alt="수업시간" /></td>
											<td ><%=strPlayTime%>분</td>
											
										</tr>
										<tr>
											<td height="1" background="../img/sub/dot_h.gif"></td>
											<td background="../img/sub/dot_h.gif"></td>
											<td background="../img/sub/dot_h.gif"></td>
											<td background="../img/sub/dot_h.gif"></td>
										</tr>
										<tr>
											<td height="30"><img src="../img/sub/sub01_1_img11_new.gif" alt="학습일" /></td>
											<td colspan="3">
											<%'=Replace(Replace(strDateTime&"","&lt;","<"),"&gt;",">")%>

											<table style="width:100%;" border="0" cellspacing="0" cellpadding="0">
												<%
													If isArray(arrData3) Then 
														sstime = ""														
														For jj = 0 To Ubound(arrData3, 2)
															sdatetime = Replace(arrData3(2, jj),"-","")&Replace(arrData3(3, jj),":","")
															sscindex = sche_seq&"_"&Replace(arrData3(3, jj),":","")
														%>
															<tr>
																<td width="100" height="30" align=center>[<%=arrData3(0, jj)%>]</td>
																<td width="80"  align=center><%=arrData3(2, jj)%></td>
																<td width="60"  align=center><%=arrData3(3, jj)%></td>
																<td width="120"  align=center>[<%=arrData3(5, jj)%>] <%=arrData3(6, jj)%></td>
																
																<td   align=center><% If Trim(Left(now(),10)) = Trim(arrData3(2, jj)) And (arrData3(4, jj) = "0" Or arrData3(4, jj) = "1" Or arrData3(4, jj) = "2" ) Then %>
																<a href="javascript:ClassStart('<%=sdatetime%>','<%=sscindex%>','<%=siFlag%>');"><img src='/img/sub/btn_class.gif' alt='화상수업' border="0"></a><% End If %></td>
															</tr>
															<%If jj <> Ubound(arrData3, 2) then%>
															<tr>
																<td height="1" background="../img/sub/dot_h.gif"></td>
																<td background="../img/sub/dot_h.gif"></td>
																<td background="../img/sub/dot_h.gif"></td>
																<td background="../img/sub/dot_h.gif"></td>																
																<td background="../img/sub/dot_h.gif"></td>
															</tr>
															<% End If %>
														<%
														Next 
													End If 
												%>
												</table>

											</td>
											
											
										</tr>
										<tr>
											<td height="1" background="../img/sub/dot_h.gif"></td>
											<td background="../img/sub/dot_h.gif"></td>
											<td background="../img/sub/dot_h.gif"></td>
											<td background="../img/sub/dot_h.gif"></td>
										</tr>
										<tr>
											<td height="30"><img src="../img/sub/sub01_1_img12.gif" alt="수업일수" /></td>
											<td><span class="point">[<%=iTotalLec%> 일] </span></td>
											<td><img src="../img/sub/sub01_1_img15.gif" alt="수업상태" /></td>
											<td><%=getScheTypeText(siFlag)%></td>
										</tr>
										<tr>
											<td height="1" background="../img/sub/dot_h.gif"></td>
											<td background="../img/sub/dot_h.gif"></td>
											<td background="../img/sub/dot_h.gif"></td>
											<td background="../img/sub/dot_h.gif"></td>
										</tr>
										
									</table>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="94"><img src="../img/sub/sub01_1_img17.gif" alt="현재나의진도" width="94" height="24" /></td>
											<td bgcolor="#007BEE">&nbsp;</td>
											<td width="7"><img src="../img/sub/sub01_1_img18.gif" width="7" height="24" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="7"></td>
							</tr>
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="10"><img src="../img/board/box_b001.gif" width="10" height="10" /></td>
											<td bgcolor="#F1F9FF"></td>
											<td width="10"><img src="../img/board/box_b002.gif" width="10" height="10" /></td>
										</tr>
										<tr>
											<td bgcolor="#F1F9FF">&nbsp;</td>
											<td bgcolor="#F1F9FF">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="49%" align="center">
															<table width="80%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="44%"><img src="../img/sub/sub01_img02.gif" alt="현재나의진도" /></td>
																	<td width="56%" align="center" class="point04">출석률<%=FormatNumber(iPerAttend, 0)%>%</td>
																</tr>
															</table>
														</td>
														<td width="51%">
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="96" height="23"><img src="../img/sub/sub01_img03.gif" alt="출석현황" /></td>
																	<td><span class="bl06">출석:<%=iPresent%></span>/ <span class="gr07">결석:<%=iAbsend%></span>/ <span class="or08">취소:<%=iCancel%></span></td>
																</tr>
																<tr>
																	<td height="1" bgcolor="#007BEE"></td>
																	<td bgcolor="#007BEE"></td>
																</tr>
																<tr>
																	<td height="27"><img src="../img/sub/sub01_img04.gif" alt="잔여학습기간" /></td>
																	<td><%=iStudy%>회</td>
																</tr>
																<tr>
																	<td height="1" bgcolor="#007BEE"></td>
																	<td bgcolor="#007BEE"></td>
																</tr>
																<tr>
																	<td height="23"><img src="../img/sub/sub01_img05.gif" alt="총강의수" /></td>
																	<td><%=iTotalLec%>회</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
											<td bgcolor="#F1F9FF">&nbsp;</td>
										</tr>
										<tr>
											<td><img src="../img/board/box_b004.gif" width="10" height="10" /></td>
											<td bgcolor="#F1F9FF"></td>
											<td><img src="../img/board/box_b003.gif" width="10" height="10" /></td>
										</tr>
									</table>
								</td>
							</tr>
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
		<td align="right" valign="top" >
			<table width="428" height="34" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="207" align="right" valign="bottom"></td>
					<td width="95" align="right" valign="bottom"><!--<img src="../img/sub/btn_check.gif" alt="수강확인증" style="cursor:pointer;" class="cssstudy" caption="CERTI" />--></td>
					<td width="96" align="right" valign="bottom"><a href="/Mypage/Diary/List.asp"><img src="../img/sub/btn_diary.gif" alt="일기쓰기" border="0"  /></a></td>
					<td width="30" valign="bottom">&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center" valign="top" >&nbsp;</td>
	</tr>
	<tr>
		<td align="center" valign="top" > 
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><iframe align="center" border="0" src="MyclassCalendar.asp?send_date=<%=strSSDate%>&sche_seq=<%=sche_seq%>&VideoClassConfigSeq=<%=VideoClassConfigSeq%>&PhoneClassConfigSeq=<%=PhoneClassConfigSeq%>&nvcScheTypeCode=<%=nvcScheTypeCode%>" name="ifrm" id="ifrm"   FRAMEBORDER=0 MARGINHEIGHT=0 MARGINWIDTH=0 SCROLLING="NO" width="100%" onload="iframeAutoResize(this);"></iframe></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center" > </td>
	</tr>
	<tr>
		<td align="center" valign="top" >&nbsp;</td>
	</tr>
	<tr>
		<td align="center" valign="top" >
		<!-- icon -->
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="11"><img src="../img/sub/app_top.gif" width="650" height="11" /></td>
				</tr>
				<tr>
					<td align="center" background="../img/sub/sub03_app_bg.gif">
						<table width="574" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="113" height="27" align="left"><img src="../img/sub/cal_icon_01.gif" alt="출석" /></td>
								<td width="89" align="left"><img src="../img/sub/cal_icon_02.gif" alt="결석" /></td>
								<td width="102" align="left"><img src="../img/sub/cal_icon_09.gif" alt="지각" /></td>
								<td width="91" align="left"><img src="../img/sub/cal_icon_08.gif" alt="조퇴" /></td>
								<td width="81" align="left"><img src="../img/sub/cal_icon_04.gif" alt="연기" /></td>
								<td width="98" align="left"><img src="../img/sub/cal_icon_12.gif" alt="연기" width="51" height="21" /></td>
							</tr>
							<tr>
								<td height="27" align="left"><img src="../img/sub/cal_icon_03.gif" alt="Hoilday" /></td>
								<td align="left"><img src="../img/sub/cal_icon_07.gif" alt="녹화파일" /></td>
								<td align="left"><img src="../img/sub/cal_icon_15.gif" alt="코멘트" /></td>
								<td align="left"></td>
								<td align="left">&nbsp;</td>
								<td align="left"><!--<img src="/img/saeternstudy2.gif" alt="학습" />--></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td><img src="../img/sub/sub03_app_bot.gif" /></td>
				</tr>
			</table>
		<!-- icon -->
		</td>
	</tr>
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->