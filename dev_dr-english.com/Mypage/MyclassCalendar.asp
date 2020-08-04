<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = False
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
Dim sche_seq : sche_seq = sqlCheck(Replace(Request("sche_seq"), "'", "''"))
VideoClassConfigSeq  = sqlCheck(Replace(Request("VideoClassConfigSeq"), "'", "''"))
PhoneClassConfigSeq  = sqlCheck(Replace(Request("PhoneClassConfigSeq"), "'", "''"))
nvcScheTypeCode = sqlCheck(Replace(Request("nvcScheTypeCode"), "'", "''"))

Dim send_date : send_date = sqlCheck(Request("send_date"))
If Len(Trim(send_date)) = 0 Then
	send_date = Date()
End If

Dim to_month
select case CInt(Month(send_date))
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

intNowDate	= DateSerial(Year(send_date), Month(send_date), intDay)	'선택된 년도, 월 - 01로 설정
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

Dim Sql, objRs, arrHDay, arrData

'##### 센터별 휴무일 가져오기
Sql = "PRC_tb_Holiday_Select_List N'"& SiteCPCode &"', N'"& startDate &"', N'"& endDate &"', '4'"
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrHDay = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing


'##### 학생 출결 현황 #####
Sql = "PRC_tb_DailyReport_User_Select_List '"& sche_seq &"', '"& sUserSeq &"', N'"& startDate &"', N'"& endDate &"'"
Set objRS = dbSelect(Sql)
If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing
Call DBClose()

'Response.write sql
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp"--> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script src="/Commonfiles/Scripts/jquery.min.js" type="text/javascript"></script>
<link href="/css/subcss02-2.css" rel="stylesheet" type="text/css" />
<title>  ::::::::::::::::::::::::::::::::::::::::</title>
<script language="javascript">
<!--
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

-->
</script>
</head>
<body style="overflow-x:hidden;">
<!-- ##### // Contents ##### -->
<table width="650" border="0" cellspacing="0" cellpadding="0">
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
								<td width="36"><a href="MyclassCalendar.asp?send_date=<%=DateAdd("m", -1, send_date)%>&sche_seq=<%=sche_seq%>&VideoClassConfigSeq=<%=VideoClassConfigSeq%>&PhoneClassConfigSeq=<%=PhoneClassConfigSeq%>&nvcScheTypeCode=<%=nvcScheTypeCode%>"><img src="../img/sub/btn_cal_prev.gif" /></a></td>
								<td background="../img/sub/btn_cal_bg.gif" class="point05"><%=Year(send_Date)%>. <%=to_month%></td>
								<td width="26"><a href="MyclassCalendar.asp?send_date=<%=DateAdd("m", 1, send_date)%>&sche_seq=<%=sche_seq%>&VideoClassConfigSeq=<%=VideoClassConfigSeq%>&PhoneClassConfigSeq=<%=PhoneClassConfigSeq%>&nvcScheTypeCode=<%=nvcScheTypeCode%>"><img src="../img/sub/btn_cal_next.gif" /></a></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="4%">
									<a href="MyclassCalendar.asp?send_date=<%=DateAdd("m", -1, send_date)%>&sche_seq=<%=sche_seq%>&VideoClassConfigSeq=<%=VideoClassConfigSeq%>&PhoneClassConfigSeq=<%=PhoneClassConfigSeq%>&nvcScheTypeCode=<%=nvcScheTypeCode%>"><img src="../img/sub/cla_prev01.gif" border="0" /></a> 
								</td>
								<td width="92%" align="center" valign="top">
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

									<table border="0" cellspacing="2" cellpadding="6" class="t_center">
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

	.Write "<td style='width:82px;height:60px;background-color:"& TableCBG &";' valign='top'>" & vbCrlf

	.Write "	<table width='82%' border='0' cellspacing='0' cellpadding='0'>" & vbCrlf
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
			If tmpDate = CDate(arrData(0, j)) Then
				
				'If Trim(tmpDate&"") <= Trim(Left(Now(),10)&"") Then
				todaystudy="&nbsp;<img src='/img/sub/cal_icon_15s.gif' style=""cursor:hand;"" onclick=""javascript:DailyComment('"&sche_seq&"','"&Trim(arrData(4, j))&"','"&Trim(arrData(0, j))&"','"&Trim(arrData(5, j))&"');"">"
				'End if

				Select Case CInt(arrData(1, j))
					Case 1 : strViewImg = "<img src='/img/sub/cal_icon_01s.gif'>"
					Case 2 : strViewImg = "<img src='/img/sub/cal_icon_02s.gif'>"
					Case 3 : 
						If arrData(2, j) = "0" Then
							strViewImg = "<img src='/img/sub/cal_icon_04s.gif'>"
						ElseIf arrData(3, j) = "2" Then
							strViewImg = "<img src='/img/sub/cal_icon_12s.gif'>"
						End If					
					Case 4 : strViewImg = ""
					Case 5 : strViewImg = ""
					Case 6 : strViewImg = ""
				End Select	
				
				'녹화/녹취파일 다운로드 추가				
				strDownload=""
				If arrData(1, j)="1" then
					strDownload="&nbsp;<img src=""/img/sub/cal_icon_07s.gif"" style=""cursor:hand;"" onclick=""javascript:FileRecordDownload('"&nvcScheTypeCode&"','"&sche_seq&"_"&Replace(arrData(6, j),":","")&"','"&Trim(arrData(4, j))&"','"&Trim(arrData(0, j))&"','"&VideoClassConfigSeq&"','"&PhoneClassConfigSeq&"','"&SiteCPCode&"','"&Trim(arrData(3, j))&"');"">"
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
								<td width="4%" align="right"><a href="MyclassCalendar.asp?send_date=<%=DateAdd("m", 1, send_date)%>&sche_seq=<%=sche_seq%>&VideoClassConfigSeq=<%=VideoClassConfigSeq%>&PhoneClassConfigSeq=<%=PhoneClassConfigSeq%>&nvcScheTypeCode=<%=nvcScheTypeCode%>"><img src="../img/sub/cla_next01.gif" border="0" /></a></td>
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
<!-- ##### Contents // ##### -->
</body>
</html>