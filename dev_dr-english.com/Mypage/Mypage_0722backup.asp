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


strScheSeqs = ""
strTeacherNames = ""
strPlayTimes = ""
strFlags = ""
oldthseqs = ""
oldseqs = ""
oldflags = ""
oldplays = ""

'스탠바이 수업수
iStandbycount = 0
ipresentcount = 0
iabsentcount = 0
isooncount = 0

totalcount = 0

if isArray(arrData) = true then
        
        for ii=0 to Ubound(arrData, 2)
            
            
            if instr(oldthseqs,trim(arrData(3,ii)&",")) <= 0 then 
            
                oldthseqs = oldthseqs & trim(arrData(3,ii)&",") 
                strTeacherNames = strTeacherNames & trim(arrData(4,ii)&"/")                                 
                
            end If
            
            
            if instr(oldplays,trim(arrData(20,ii)&",")) <= 0 then 
            
                oldplays = oldplays & trim(arrData(20,ii)&",") 
                strPlayTimes = strPlayTimes & trim(arrData(20,ii)&"분/")                                 
                
            end If
            
            
            if instr(oldflags,trim(arrData(22,ii)&",")) <= 0 then 
            
                oldflags = oldflags & trim(arrData(22,ii)&",") 
                
                if trim(arrData(22,ii)&"")="0" then
                 strFlags = strFlags & "대기/"
                end If
                
                if trim(arrData(22,ii)&"")="1" then
                 strFlags = strFlags & "수업중/"
                end If
                
                if trim(arrData(22,ii)&"")="2" then
                 strFlags = strFlags & "수업종료/"
                end If
                
                if trim(arrData(22,ii)&"")="3" then
                 strFlags = strFlags & "수업해지(취소)/"
                end If                
                
            end If
          
            
            if trim(arrData(13,ii)&"") = "0" then            
                iStandbycount = iStandbycount + 1                
            elseif trim(arrData(13,ii)&"") = "1" then
                ipresentcount = ipresentcount + 1
            elseif trim(arrData(13,ii)&"") = "2" then
                iabsentcount = iabsentcount + 1
            else 
                isooncount = isooncount + 1
            end If
            
            totalcount = totalcount + 1
        next
        
        'totalcount = Ubound(arrData, 2) + 1
        
        if len(strTeacherNames) > 1 then
             strTeacherNames = left(strTeacherNames,len(strTeacherNames)-1)      
             strTeacherNames = replace(strTeacherNames,"/"," / ")
        end If
        
        if len(strPlayTimes) > 1 then
             strPlayTimes = left(strPlayTimes,len(strPlayTimes)-1)   
             strPlayTimes = replace(strPlayTimes,"/"," / ")    
        end If
        
        if len(strFlags) > 1 then
             strFlags = left(strFlags,len(strFlags)-1)       
             strFlags = replace(strFlags,"/"," / ")
        end If
        
        
end If

'response.Write " totalcount " & totalcount & "<br>"
'response.Write " iStandbycount " & iStandbycount & "<br>"
'response.Write " ipresentcount " & ipresentcount & "<br>"
'response.Write " iabsentcount " & iabsentcount & "<br>"
'response.Write " isooncount " & isooncount & "<br>"







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
	<tr>
	<td height="30" align="center" > 
	
	        <table width="710" border="0" cellspacing="0" cellpadding="0">
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
									
									<tr>
											<td height="30" width="100"><img src="../img/sub/sub01_1_img19.gif" width="96" height="14" /></td>
											<td width="300"><%=strTeacherNames%></td>
											<td height="30" width="100"><img src="../img/sub/sub01_1_img16.gif"  /></td>
											<td ><%=strPlayTimes%></td>
											
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
																								
												
													If isArray(arrData) Then 
														sstime = ""														
														For jj = 0 To Ubound(arrData, 2)
															sdatetime = Replace(arrData(1, jj),"-","")&Replace(arrData(2, jj),":","")
															sscindex = arrData(5, jj)&"_"&Replace(arrData(2, jj),":","")
															scheEndTime=""
		                                                    ScheEndTime = Right("0"&datepart("h",dateadd("n",Trim(arrData(20, jj)&"")+5,FormatDateTime(Trim(arrData(2, jj)&""),4))),2) & ":" & Right("0"&datepart("n",dateadd("n",Trim(arrData(20, jj)&"")+5,FormatDateTime(Trim(arrData(2, jj)&""),4))),2)

														%>
															<tr>
																<td width="100" height="30" align=center>[<%=arrData(4, jj)%>]</td>
																<td width="80"  align=center><%=arrData(1, jj)%></td>
																<td width="60"  align=center><%=arrData(2, jj)%></td>
																<td width="120"  align=center>[<%=arrData(11, jj)%>] <%=arrData(21, jj)%></td>
																
																<td   align=center>
																<% If Trim(Left(now(),10)) = Trim(arrData(1, jj)) Then %>
																    <% If CLng(replace(scheEndTime,":","")&"") < CLng(replace(Trim(nowdtime&""),":","")&"") Then %>		
																    	<%If Trim(arrData(13, jj)&"") = "0" Then %>
						                                                    <span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:gray;'><b>대기</b></span>
					                                                    <% ElseIf Trim(arrData(13, jj)&"") = "1" Then %>
						                                                    <span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:BLUE;'><b>출석</b></span>
					                                                    <% ElseIf Trim(arrData(13, jj)&"") = "2" Then %>
						                                                    <span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:Red;'><b>결석</b></span>
					                                                    <% ElseIf Trim(arrData(13, jj)&"") = "3" Then %>
						                                                    <span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:margenta;'><b>연기</b></span>
					                                                    <% ElseIf Trim(arrData(13, jj)&"") = "4" Then %>
						                                                   <span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:gray;'><b>취소</b></span>					                                                  
					                                                    <% End If %>
																    <%Else
					                                                        If arrData(14, jj) = "VE" Then %>														
																        <a href="javascript:ClassStart('<%=sdatetime%>','<%=sscindex%>','<%=arrData(15, jj)%>','<%=arrData(16, jj) %>','<%=arrData(20, jj)%>');"><img src='/img/sub/btn_class.gif' alt='화상수업' border="0"></a>
																        <% ElseIf arrData(14, jj) = "PE" Then %>
																          <span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:gray;'><b>Phone</b></span>
																        <% else %>
																         <span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:gray;'><b>None</b></span>
																        <% end If %>
																     <% end If %>
																<% else %> 																
					                                                    <%If Trim(arrData(13, jj)&"") = "0" Then %>
						                                                    <span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:gray;'><b>대기</b></span>
					                                                    <% ElseIf Trim(arrData(13, jj)&"") = "1" Then %>
						                                                    <span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:BLUE;'><b>출석</b></span>
					                                                    <% ElseIf Trim(arrData(13, jj)&"") = "2" Then %>
						                                                    <span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:Red;'><b>결석</b></span>
					                                                    <% ElseIf Trim(arrData(13, jj)&"") = "3" Then %>
						                                                    <span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:margenta;'><b>연기</b></span>
					                                                    <% ElseIf Trim(arrData(13, jj)&"") = "4" Then %>
						                                                   <span style='width:140px;height:30px;background:#ffffff;font-size:14px;color:gray;'><b>취소</b></span>					                                                  
					                                                    <% End If %>
				
																
																<% End If %></td>
															</tr>
															<%If jj <> Ubound(arrData, 2) then%>
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
														%>
														
														<% else%>
														
												    <tr>
																<td >
																<font size="4"><%=left(searchdate,4)%>년 <%=mid(searchdate,6,2) %>월 수업은 없습니다.</font>
																
																</td>		</tr>
												<%		
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
											<td ><span class="point">[<%=totalcount%> 일] </span></td>
											<td><img src="../img/sub/sub01_1_img15.gif" alt="수업상태" /></td>
											<td><%=strFlags%></td>
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
																	<td width="56%" align="left" class="point04">
																	<% if ipresentcount > 0 then  %>
																	출석률 <%=FormatNumber((ipresentcount / totalcount) * 100, 1) %>%
																	<%else %>
																	출석률 0%
																	<% end If %>
																	</td>
																</tr>
	                                                            </table>
														</td>
														<td width="51%">
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="96" height="23"><img src="../img/sub/sub01_img03.gif" alt="출석현황" /></td>
																	<td><span class="bl06">출석:<%=ipresentcount%></span>/ <span class="gr07">결석:<%=iabsentcount%></span>/ <span class="or08">취소:<%=isooncount%></span></td>
																</tr>
																<tr>
																	<td height="1" bgcolor="#007BEE"></td>
																	<td bgcolor="#007BEE"></td>
																</tr>
																<tr>
																	<td height="27"><img src="../img/sub/sub01_img04.gif" alt="잔여학습기간" /></td>
																	<td><%=iStandbycount%>회</td>
																</tr>
																<tr>
																	<td height="1" bgcolor="#007BEE"></td>
																	<td bgcolor="#007BEE"></td>
																</tr>
																<tr>
																	<td height="23"><img src="../img/sub/sub01_img05.gif" alt="총강의수" /></td>
																	<td><%=totalcount%>회</td>
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
	<td height=10></td>
	</tr>
	<tr><td align="center" valign="top" > 
	
	<%
	
	
        Dim to_month
        select case CInt(Month(searchDate))
	        case 1	:	to_month="January"
	        case 2	:	to_month="February"
	        case 3	:	to_month="March"
	        case 4	:	to_month="April"
	        case 5	:	to_month="May"
	        case 6	:	to_month="June"
	        case 7	:	to_month="July"
	        case 8	:	to_month="August"
	        case 9	:	to_month="September"
	        case 10	:	to_month="October"
	        case 11	:	to_month="November"
	        case 12	:	to_month="December "
        end select

        Dim intDay : intDay = 1
        Dim intNowDate, intNextDate, intLastDate, startDate, lastDate, intSDay, intEDay

        intNowDate	= DateSerial(Year(searchDate), Month(searchDate), intDay)	'선택된 년도, 월 - 01로 설정
        intNextDate = DateAdd("m", 1, intNowDate)							'다음달 값 구하기
        intLastDate = DateAdd("d", -1, intNextDate)							'선택된 년도, 월의 마지막 일 구하기

        '첫째 주차의 요일 갭 구하기
        intSDay = 0
        If WeekDay(intNowDate) > 1 Then
	        intSDay = WeekDay(intNowDate) - 1
        End If

        '마지막 주차의 요일 갭 구하기
        intEDay = 0
        If WeekDay(intLastDate) >= 1 Then
	        intEDay = 7 - WeekDay(intLastDate)
        End If

        startDate	= CDate(DateAdd("d", -intSDay, intNowDate))
        endDate		= CDate(DateAdd("d", intEDay, intLastDate))
        intDay		= CInt(Day(intLastDate) + intSDay + intEDay) '달력에 보여질 총 일수

      

        '##### 센터별 휴무일 가져오기
        Sql = "PRC_tb_Holiday_Select_List N'"& SiteCPCode &"', N'"& startDate &"', N'"& endDate &"', '4'"
        Set objRs = dbSelect(Sql)
        If Not objRs.Eof Then
	        arrHDay = objRs.GetRows()
        End If
        objRs.Close	:	Set objRs = Nothing
	
	 %>
	
		
	</td></tr>
	<tr>
	<td height=10></td>
	</tr>
	<tr>
		<td align="center" valign="top" > 
               
               
               
               
               
               
               <table width="710" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="15"><img src="../img/board/gbox_lt.gif" width="15" height="15" /></td>
		<td background="../img/board/gbox_tbg.gif"></td>
		<td width="15"><img src="../img/board/gbox_rt.gif" width="15" height="15" /></td>
	</tr>
	<tr>
		<td background="../img/board/gbox_lbg.gif">&nbsp;</td>
		<td align="left" valign="top" bgcolor="#FFFFFF">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="50" align="center" valign="top">
						<table width="250" height="39" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="36"><a href="MyPage.asp?searchDate=<%=DateAdd("m", -1, searchDate)%>"><img src="../img/sub/btn_cal_prev.gif" /></a></td>
								<td background="../img/sub/btn_cal_bg.gif" class="point05"><%=Year(searchDate)%>. <%=to_month%></td>
								<td width="26"><a href="MyPage.asp?searchDate=<%=DateAdd("m", 1, searchDate)%>"><img src="../img/sub/btn_cal_next.gif" /></a></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								
								<td width="100%" align="center" valign="top">
									<table width="100%" border="0" cellspacing="2" cellpadding="6" class="t_center">
										<tr> 
											<td width="14%" height="35" bgcolor="#FF6F6F"><img src="../img/sub/cal_sun.gif" alt="sun"  /></td>
											<td width="14%" bgcolor="#797979"><img src="../img/sub/cal_mon.gif" alt="mon"  /></td>
											<td width="14%" bgcolor="#797979"><img src="../img/sub/cal_tue.gif" alt="tue"  /></td>
											<td width="14%" bgcolor="#797979"><img src="../img/sub/cal_wed.gif" alt="wed"  /></td>
											<td width="14%" bgcolor="#797979"><img src="../img/sub/cal_thu.gif" alt="thu"  /></td>
											<td width="14%" bgcolor="#797979"><img src="../img/sub/cal_fri.gif" alt="fri"  /></td>
											<td width="14%" bgcolor="#1B92F6"><img src="../img/sub/cal_sat.gif" alt="sat"  /></td>
										</tr>
									</table>

									<table border="0" cellspacing="2" cellpadding="6" class="t_center" width="100%">
					                    <tr>
                                        <%
                                        Dim tmpDate, printDate, intWeek, Fcolor
                                        With Response
                                        For i = 0 To intDay - 1
                                        	
	                                        tmpDate = CDate(DateAdd("d", i, startDate))
	                                        intWeek	  = WeekDay(tmpDate)

	                                        Select Case CInt(intWeek)
		                                        Case 7	:	TableCBG = "#D6E3F3"	:	Fcolor = "blue"
		                                        Case 1	:	TableCBG = "#FFE7E7"	:	Fcolor = "red"
		                                        Case Else	:	TableCBG = "#EFEFEF":	Fcolor = ""
	                                        End Select

	                                        printDate = "<font color='"&Fcolor&"'>"& Day(tmpDate) &"</font>"
	                                        If Month(tmpDate) <> Month(send_Date) Then
		                                        printDate = "<sup><font color='"&Fcolor&"'>"& Day(tmpDate) &"</font></sup>"
	                                        End If

	                                        .Write "<td style='width:100px;height:60px;background-color:"& TableCBG &";' valign='top'>" & vbCrlf

	                                        .Write "	<table width='100%' border='0' cellspacing='0' cellpadding='0'>" & vbCrlf
	                                        .Write "		<tr>" & vbCrlf
	                                        .Write "			<td height='26' align='center'>&nbsp;</td>" & vbCrlf
	                                        .Write "			<td width='33%' align='center'>"& printDate &"</td>" & vbCrlf
	                                        .Write "		</tr>" & vbCrlf
	                                        .Write "	</table>" & vbCrlf

	                                        .Write "	<table width='82%'>" & vbCrlf


	                                        '##### 해당 년, 월에 센터 휴일 표시 #####
	                                        If IsArray(arrHDay) Then
		                                        For j = 0 To Ubound(arrHDay, 2)
			                                        If tmpDate = CDate(arrHDay(0, j)) Then					
				                                        .Write "<tr><td align='center'><img src='/img/sub/cal_icon_03s.gif' title='"& arrHDay(2, j) &"' /></td></tr>" & vbCrlf
			                                        End If
		                                        Next
	                                        End If

	                                        todaystudy=""
	                                        todaypostpone=""

	                                        '##### 학생 출결 정보 표시 #####
	                                        If IsArray(arrData) Then
		                                        strViewImg = ""
		                                        For j = 0 To Ubound(arrData, 2)
			                                        If tmpDate = CDate(arrData(1, j)) Then
                                        				
				                                        'If Trim(tmpDate&"") <= Trim(Left(Now(),10)&"") Then
				                                        todaystudy="&nbsp;<img src='/img/sub/cal_icon_15s.gif' style=""cursor:hand;"" onclick=""javascript:DailyComment('" & Trim(arrData(5, j)&"") & "','" & arrData(7, j) & "','" & arrData(1, j) & "','" & arrData(0, j) & "');"">"
				                                        'End if

				                                        Select Case CInt(arrData(13, j)&"")
					                                        Case 1 : strViewImg = "<img src='/img/sub/cal_icon_01s.gif'>"
					                                        Case 2 : strViewImg = "<img src='/img/sub/cal_icon_02s.gif'>"
					                                        Case 3 : strViewImg = "<img src='/img/sub/cal_icon_04s.gif'>"	
					                                        Case 4 : strViewImg = "<img src='/img/sub/cal_icon_08s.gif'>"
					                                        Case 5 : strViewImg = ""
					                                        Case 6 : strViewImg = ""
				                                        End Select	
                                        				
				                                        '녹화/녹취파일 다운로드 추가				
				                                        strDownload=""
				                                        If arrData(13, j)="1" then
					                                        strDownload="&nbsp;<img src=""/img/sub/cal_icon_07s.gif"" style=""cursor:hand;"" onclick=""javascript:FileRecordDownload('"&arrData(14, j)&"','"& arrData(5, j) & "_" & Replace(arrData(2, j),":","") &"','"&arrData(7, j)&"','" & arrData(1, j) &"','"&arrData(16,j)&"','2','" & SiteCPCode  &"','"&Trim(arrData(18, j))&"');"">"
				                                        End if

				                                        .Write "<tr><td align='center'>"& strViewImg & todaystudy & strDownload &"</td></tr>" & vbCrlf

			                                        End If
		                                        Next
	                                        End If
                                        	
	                                        .Write "	</table>" & vbCrlf

	                                        .Write "</td>" & vbCrlf

	                                        If ((i+1) Mod 7) = 0 Then
		                                        .Write "</tr><tr>"
	                                        End If
                                        Next
                                        End with
                                        %>
										</tr>
									</table>
								</td>
								
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
		<td background="../img/board/gbox_rbg.gif">&nbsp;</td>		
	</tr>
	<tr>
		<td width="15"><img src="../img//board/gbox_lb.gif" width="15" height="15" /></td>
		<td background="../img/board/gbox_bbg.gif"></td>
		<td width="15"><img src="../img/board/gbox_rb.gif" width="15" height="15" /></td>
	</tr>
</table>
               
           
               
<form method="post" Action="mypage.asp" name="Bform">
<input type="hidden" name="currPage" id="currPage" value="<%=currPage%>"/>
<input type="hidden" name="searchDate" id="searchDate" value="<%=searchDate%>"/>
</form>


		</td>
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
								<td width="102" align="left"><img src="../img/sub/cal_icon_04.gif" alt="연기" /></td>
								<td width="91" align="left"><img src="../img/sub/cal_icon_08.gif" alt="취소" /></td>
								<td width="81" align="left"></td>
								<td width="98" align="left"></td>
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
	
	<tr>
		<td >&nbsp;</td>
	</tr>
	
</table>
<!-- ##### Contents // ##### -->
</div>

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

<%

Call DBClose()
 %>
<!--#include virtual="/include/inc_footer.asp"-->