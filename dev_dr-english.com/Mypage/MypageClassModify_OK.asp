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



m_date = gReqI(gReq("m_date"))
m_hourmin = gReqI(gReq("m_hourmin"))

iDailyReportSeq = gReqI(gReq("iDailySeq"))
iMemberSeq = sUserSeq

iScheduleSeq = gReqI(gReq("iScheduleSeq"))
nowRunTime = gReqI(gReq("nowRunTime"))
StrOrderMonth = gReqI(gReq("StrOrderMonth"))
strDates = gReqI(gReq("strDates"))
PiCourseSeq = gReqI(gReq("PiCourseSeq"))
m_classTB0 = gReqI(gReq("m_classTB0"))
m_classTC0 = gReqI(gReq("m_classTC0"))
iTeacherSeq = gReqI(gReq("iTeacherSeq"))

chg_date = m_date
chg_time = m_hourmin
chg_playTime = nowRunTime

nuseclass = 0

If  iDailyReportSeq = "" Or iMemberSeq = "" Or iScheduleSeq = "" Or m_date = "" Or m_hourmin = "" Or nowRunTime = "" Or iTeacherSeq = ""  Then

nuseclass = "N||필수정보가  없습니다.1"	'파라미터 오류
Response.write nuseclass

Call DBClose()
response.end
End If



If Hour(now()) >= 16 Then

Dailysearchdate = Left(dateadd("d",1,now()),10)
searchStartDate = Left(dateadd("d",1,now()),10)
searchEndDate = Left(dateadd("m",1,now()),10)
'searchEndDate = Left(dateadd("d",14,now()),10)
searchlimitdate = searchEndDate


Else

Dailysearchdate = Left(dateadd("d",0,now()),10)
searchStartDate = Left(dateadd("d",0,now()),10)
searchEndDate = Left(dateadd("d",-1,dateadd("m",1,now())),10)
'searchEndDate = Left(dateadd("d",13,now()),10)
searchlimitdate = searchEndDate

End If



If m_date = Left(now(),10) And Hour(now()) >= 16 Then


nuseclass = "N||금일로 변경하는 것은  16시(오후4시) 이전에 가능합니다.1"
Response.write nuseclass
Call DBClose()
response.End

End If


sikorean = ""
'한국어 가능 여부 조사
sql = "select top 1 isnull(sikorean,0) as sikorean from tb_member where imemberseq = '" & sUserSeq & "' "
Set Rs = dbSelect(sql)
If Not Rs.eof Then
	sikorean = Trim(Rs(0)&"")
End If
Rs.close
Set Rs = Nothing

If sikorean = "0" Then
	sikorean = ""
End If


sql = "select top 1 iDailyReportSeq,nvcDailyReportDate from tb_DailyReport where nvcDailyReportDate >= '" & searchStartDate & "' and nvcDailyReportDate <= '" & searchEndDate & "' "
sql = sql & " and isnull(siAttendance,0) = 0 and iMemberSeq = '" & sUserSeq & "' "
sql = sql & " and iDailyReportSeq='" & iDailyReportSeq & "' "
Set Rs = dbSelect(sql)
If Not Rs.eof Then
	dbiDailyReportSeq = Trim(Rs(0)&"")
	dbnvcDailyReportDate = Trim(Rs(1)&"")
Else
	nuseclass = 100
End If
Rs.close
Set Rs = nothing



If nuseclass = 100 Then

nuseclass = "N||선택한 수업이 존재하지 않습니다."
Response.write nuseclass
Call DBClose()
response.End

End If


If dbnvcDailyReportDate = Left(now(),10) And Hour(now()) >= 16 Then

nuseclass = "N||금일 수업 변경은  16시(오후4시) 이전에 가능합니다.2"
Response.write nuseclass
Call DBClose()
response.End

End If




'##################################  월별 8회까지 체크하기 시작 ################


'1개월차 검색일
searchStartDateSweek1 = Left(searchStartDate,7) & "-01"
searchStartDateEweek1 = Trim(dateadd("d",-1,dateadd("m",1,searchStartDateSweek1))&"")
searchStartDateSweek1oldcount = 0
searchStartDateSweek1newcount = 0

'2개월차
searchStartDateSweek2 = dateadd("m",1,searchStartDateSweek1)&""
searchStartDateEweek2 = Trim(dateadd("d",-1,dateadd("m",1,searchStartDateSweek2))&"")
searchStartDateSweek2oldcount = 0
searchStartDateSweek2newcount = 0

'3개월차
searchStartDateSweek3 = dateadd("m",1,searchStartDateSweek2)&""
searchStartDateEweek3 = Trim(dateadd("d",-1,dateadd("m",1,searchStartDateSweek3))&"")
searchStartDateSweek3oldcount = 0
searchStartDateSweek3newcount = 0


If Left(chg_date,7) = Left(searchStartDateSweek1,7) Then
	searchStartDateSweek1newcount = searchStartDateSweek1newcount + 1
End If

If Left(chg_date,7) = Left(searchStartDateSweek2,7) Then
	searchStartDateSweek2newcount = searchStartDateSweek2newcount + 1
End If

If Left(chg_date,7) = Left(searchStartDateSweek3,7) Then
	searchStartDateSweek3newcount = searchStartDateSweek3newcount + 1
End If




sql = " select tdr.iDailyReportSeq , tdr.nvcDailyReportDate , tdr.nvcScheTime , tdr.iTeacherSeq , tch.nvcTeacherName, "
sql = sql & "  tdr.iScheduleSeq , ts.nvcCPCode , tdr.iSchedetailSeq ,tm.nvcMemberID , Tm.nvcMemberEName, "
sql = sql & "  tdr.iTBtooksToSeq,isnull(tdr.siAttendance,0) as siAttendance , tdr.nvcScheTel,  "
sql = sql & "  ts.siSchePlayTime, tsd.sischeflag,ts.nvcScheEndDate "
sql = sql & " from tb_dailyreport as tdr with(nolock) inner join tb_Schedule as ts with(nolock) on tdr.iScheduleSeq = ts.iScheduleSeq "
sql = sql & "  inner join tb_Schedetail as tsd with(nolock) on tdr.ischedetailSeq = tsd.iSchedetailSeq  "
sql = sql & "  inner join tb_Member as tm with(nolock) on tdr.iMemberSeq = tm.iMemberSeq "
sql = sql & "  inner join tb_Teacher as tch with(nolock) on tdr.iTeacherSeq = tch.iTeacherSeq "
sql = sql & "  where  tdr.iDailyReportSeq <> '" & iDailyReportSeq & "' and ts.iCourseSeq='" & PiCourseSeq & "' and  tdr.siAttendance in (0,1,2)  "
sql = sql & " and  (tsd.sischeflag in (1,2,3) and tdr.nvcDailyReportDate <= '" & searchStartDateEweek3 & "') "
sql = sql & "  and tdr.nvcDailyReportDate >= '" & searchStartDateSweek1 & "'   "
sql = sql & "  and tdr.iMemberSeq = '" & sUserSeq & "' and ts.nvcCPCode=N'" & SiteCPCode & "' and isnull(tdr.siScheType,0)  = 1 "
sql = sql & "  order by tdr.nvcDailyReportDate + ' ' + tdr.nvcScheTime asc "

Set objRs = dbSelect(Sql)

If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If

objRs.Close
Set objRs = Nothing


If isArray(arrData) Then

For ioldclass = 0 To ubound(arrData,2)
		If Trim(arrData(1,ioldclass)&"") >= searchStartDateSweek1 And Trim(arrData(1,ioldclass)&"") <= searchStartDateEweek1 Then
			searchStartDateSweek1oldcount = searchStartDateSweek1oldcount + 1
		End If

		If Trim(arrData(1,ioldclass)&"") >= searchStartDateSweek2 And Trim(arrData(1,ioldclass)&"") <= searchStartDateEweek2 Then
			searchStartDateSweek2oldcount = searchStartDateSweek2oldcount + 1
		End If

		If Trim(arrData(1,ioldclass)&"") >= searchStartDateSweek3 And Trim(arrData(1,ioldclass)&"") <= searchStartDateEweek3 Then
			searchStartDateSweek3oldcount = searchStartDateSweek3oldcount + 1
		End If
	Next

End If






If searchStartDateSweek1newcount > 0 Then
	If (searchStartDateSweek1newcount + searchStartDateSweek1oldcount ) > 8 Then
			nuseclass = "N||" & Left(searchStartDateSweek1,4) & "년 " & mid(searchStartDateSweek1,6,2) & "월 기존 수업의 횟수는  " & searchStartDateSweek1oldcount &" 회 입니다."
			nuseclass = nuseclass & vbcrlf & "1개월에 총 8회까지 수업가능합니다."
			Response.write nuseclass
			Call DBClose()
			response.end
	End If

End If

If searchStartDateSweek2newcount > 0 Then
	If (searchStartDateSweek2newcount + searchStartDateSweek2oldcount ) > 8 Then
			nuseclass = "N||" & Left(searchStartDateSweek2,4) & "년 " & mid(searchStartDateSweek2,6,2) & "월 기존 수업의 횟수는  " & searchStartDateSweek2oldcount &" 회 입니다."
			nuseclass = nuseclass & vbcrlf & "1개월에 총 8회까지 수업가능합니다."
			Response.write nuseclass
			Call DBClose()
			response.end
	End If

End If

If searchStartDateSweek3newcount > 0 Then
	If (searchStartDateSweek3newcount + searchStartDateSweek3oldcount ) > 8 Then
			nuseclass = "N||" & Left(searchStartDateSweek3,4) & "년 " & mid(searchStartDateSweek3,6,2) & "월 기존 수업의 횟수는  " & searchStartDateSweek3oldcount &" 회 입니다."
			nuseclass = nuseclass & vbcrlf & "1개월에 총 8회까지 수업가능합니다."
			Response.write nuseclass
			Call DBClose()
			response.end
	End If

End If



'##################################  월별 8회까지 체크하기 끝 ################

nuseclass = 0



dupcnt = 0

chksql = "SELECT count(iDailyReportSeq) as cnt FROM tb_DailyReport "
chksql = chksql & " WHERE iScheduleSeq='" & iScheduleSeq & "' AND nvcDailyReportDate='" & chg_date & "' "
chksql = chksql & " AND nvcScheTime='" & chg_time & "' and iMemberSeq = '" & iMemberSeq & "' "
chksql = chksql & "  and iDailyReportSeq <> '" & iDailyReportSeq & "' and siAttendance in (0,1,2) "
Set Rs = dbSelect(chksql)

if Not(Rs.Eof And Rs.Bof) then
	dupcnt = Rs(0)
End if

Rs.close
Set Rs = Nothing


If dupcnt > 0 Then

nuseclass = "N||선택한 변경수업일/시간에 수업이 이미 존재합니다"
Response.write nuseclass
Call DBClose()
response.end

End If






		chg_Etime = Right("0" & Hour(dateadd("n",chg_playTime,chg_time)),2) & ":" & Right("0" & minute(dateadd("n",chg_playTime,chg_time)),2)

		If Left(chg_Etime,2) ="00" Then
			chg_Etime = "24:" & Right(chg_Etime,2)
		End If


		nvcDates = chg_date&chg_time&Right("0"&chg_playTime,3)&","
		nvcWeek = ""
		nvcWeek = datepart("w",m_date) &","

		strResult = ""
		strResultcheck = 0

		On Error Resume Next
		sql = " exec PRC_HourMin_Search_ForModify_Insert '" & PiCourseSeq & "', '" & nvcDates & "', "
		sql = sql & " '" & nvcWeek & "','" & iMemberSeq & "','" & iScheduleSeq & "','" & iDailyReportSeq & "',"
		sql = sql & " '" & m_classTB0 & "','" & m_classTC0 & "' , '" & sikorean & "'"


		Set RsResult = dbSelect(sql)

		If Not RsResult.eof then

			If Trim(RsResult(0)&"")="1" Then

				sqlTT="exec PRC_tb_DailyReport_Daynum_sort '" & iScheduleSeq & "','" & iScheduleSeq & "' "
				msg = insertUpdateDB(sqlTT)

				strnewDates = Left(Trim(chg_date&""),4) & "년 " & mid(Trim(chg_date&""),6,2)  & "월 " & right(Trim(chg_date&""),2) & "일 "
				strnewDates = strnewDates & Left(Trim(chg_time&""),2) &"시 " & right(Trim(chg_time&""),2) &"분 "

				strResult = strDates & " 수업을 " & strnewDates & " 으로 변경하였습니다."

				strResultcheck = 1
			Else
				strResult = "수업 변경 실패 " & Trim(RsResult(1)&"")

			End If


		Else
			strResult = "수업 변경 실패! 다시 시도해 주세요."
		End If




If strResultcheck <> 1  Then
	nuseclass = "N||" & strResult
	Response.write nuseclass
	DBClose()
	Response.end
Else
	nuseclass = "Y||" & strResult
	Response.write nuseclass
	DBClose()
	Response.end
End If


Call DBClose()
Response.end
 %>

