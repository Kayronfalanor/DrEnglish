<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = False
'// menu setting
Dim mMenu : mMenu = "1"
Dim sMenu : sMenu = "14"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<% 


	PiCourseSeq = gReqI(gReq("searchiCourseSeq"))
	nowRunTime = gReqI(gReq("searchnowRunTime"))
	searchStartDate = gReqI(gReq("searchStartDate"))
	searchEndDate = gReqI(gReq("searchEndDate"))
	Dailysearchdate = gReqI(gReq("Dailysearchdate"))
	searchStartDateSweek = gReqI(gReq("searchStartDateSweek"))
	searchStartDateEweek = gReqI(gReq("searchStartDateEweek"))
	'iTeacherSeq = gReqI(gReq("s_classteacher"))
	PiCLCourseSeq = gReqI(gReq("m_classCLCourse"))

	s_classDateindex0 = gReqI(gReq("s_classDateindex0"))
	s_classDate0 = gReqI(gReq("s_classDate0"))
	s_classTime0 = gReqI(gReq("s_classTime0"))
	s_classMinute0 = gReqI(gReq("s_classMinute0"))
	m_classTB0 = gReqI(gReq("m_classTB0"))
	m_classTC0 = gReqI(gReq("m_classTC0"))

	s_classDateindex1 = gReqI(gReq("s_classDateindex1"))
	s_classDate1 = gReqI(gReq("s_classDate1"))
	s_classTime1 = gReqI(gReq("s_classTime1"))
	s_classMinute1 = gReqI(gReq("s_classMinute1"))
	m_classTB1 = gReqI(gReq("m_classTB1"))
	m_classTC1 = gReqI(gReq("m_classTC1"))

	s_classDateindex2 = gReqI(gReq("s_classDateindex2"))
	s_classDate2 = gReqI(gReq("s_classDate2"))
	s_classTime2 = gReqI(gReq("s_classTime2"))
	s_classMinute2 = gReqI(gReq("s_classMinute2"))
	m_classTB2 = gReqI(gReq("m_classTB2"))
	m_classTC2 = gReqI(gReq("m_classTC2"))

	s_classDateindex3 = gReqI(gReq("s_classDateindex3"))
	s_classDate3 = gReqI(gReq("s_classDate3"))
	s_classTime3 = gReqI(gReq("s_classTime3"))
	s_classMinute3 = gReqI(gReq("s_classMinute3"))
	m_classTB3 = gReqI(gReq("m_classTB3"))
	m_classTC3 = gReqI(gReq("m_classTC3"))
	

iMemberSeq = sUserSeq

nuseclass = 0		'처리 전

If  PiCourseSeq = "" Or PiCLCourseSeq = "" Or iMemberSeq = "" Or nowRunTime = ""  Then

nuseclass = "N||필수정보가  없습니다.1"	'파라미터 오류
Response.write nuseclass

Call DBClose()
response.end
End If

If searchStartDate = "" Or searchEndDate = "" Or Dailysearchdate = "" Or searchStartDateSweek = "" Then

nuseclass = "N||필수정보가  없습니다.2"	'파라미터 오류
Response.write nuseclass
Call DBClose()
response.end
End If

If s_classDate0 = "" and s_classDate1 = "" and s_classDate2 = "" and s_classDate3 = ""  Then

nuseclass = "N||필수정보가  없습니다.3"	'파라미터 오류
Response.write nuseclass
Call DBClose()
response.end
End If


If Hour(now()) >= 12 Then
	If Trim(s_classDate0&"")=Trim(Left(now(),10)&"")  Then
		
		nuseclass = "N||금일 12시 이후부터는 금일 수업을 선택할 수 없습니다."	'파라미터 오류
		Response.write nuseclass
		Call DBClose()
		response.end

	End If
End If


'Response.write " PiCourseSeq " & PiCourseSeq & "<br>"
'Response.write "	nowRunTime "  & nowRunTime & "<br>"
'Response.write "	searchStartDate "  & searchStartDate & "<br>"
'Response.write "	searchEndDate"  & searchEndDate & "<br>"
'Response.write "	Dailysearchdate"  & Dailysearchdate & "<br>"
'Response.write "	searchStartDateSweek "  &searchStartDateSweek & "<br>"
'Response.write "	searchStartDateEweek "  & searchStartDateEweek & "<br>"
'Response.write "	iTeacherSeq "  & iTeacherSeq & "<br>"
'Response.write " PiCLCourseSeq " & PiCourseSeq & "<br>"

'Response.write "	s_classDateindex0 "  &s_classDateindex0 & "<br>"
'Response.write "	s_classDate0 "  &s_classDate0 & "<br>"
'Response.write "	s_classTime0 "  &s_classTime0 & "<br>"
'Response.write "	s_classMinute0 "  &s_classMinute0 & "<br>"

'Response.write "	s_classDateindex1 "  &s_classDateindex1 & "<br>"
'Response.write "	s_classDate1 "  &s_classDate1 & "<br>"
'Response.write "	s_classTime1 "  &s_classTime1 & "<br>"
'Response.write "	s_classMinute1 "  &s_classMinute1 & "<br>"

'Response.write "	s_classDateindex2 "  &s_classDateindex2 & "<br>"
'Response.write "	s_classDate2 "  &s_classDate2 & "<br>"
'Response.write "	s_classTime2 "  &s_classTime2 & "<br>"
'Response.write "	s_classMinute2 "  &s_classMinute2 & "<br>"

'Response.write "	s_classDateindex3 "  &s_classDateindex3 & "<br>"
'Response.write "	s_classDate3 "  &s_classDate3 & "<br>"
'Response.write "	s_classTime3 "  &s_classTime3 & "<br>"
'Response.write "	s_classMinute3 "  & s_classMinute3 & "<br>"
'dbclose

'Response.end

sql = " select tdr.iDailyReportSeq , tdr.nvcDailyReportDate , tdr.nvcScheTime , tdr.iTeacherSeq , tch.nvcTeacherName, "
sql = sql & "  tdr.iScheduleSeq , ts.nvcCPCode , tdr.iSchedetailSeq ,tm.nvcMemberID , Tm.nvcMemberEName, "
sql = sql & "  tdr.iTBtooksToSeq,isnull(tdr.siAttendance,0) as siAttendance , tdr.nvcScheTel,  "
sql = sql & "  ts.siSchePlayTime, tsd.sischeflag,ts.nvcScheEndDate "
sql = sql & " from tb_dailyreport as tdr with(nolock) inner join tb_Schedule as ts with(nolock) on tdr.iScheduleSeq = ts.iScheduleSeq " 
sql = sql & "  inner join tb_Schedetail as tsd with(nolock) on tdr.ischedetailSeq = tsd.iSchedetailSeq  "
sql = sql & "  inner join tb_Member as tm with(nolock) on tdr.iMemberSeq = tm.iMemberSeq "
sql = sql & "  inner join tb_Teacher as tch with(nolock) on tdr.iTeacherSeq = tch.iTeacherSeq "
sql = sql & "  where ts.iCourseSeq='" & PiCourseSeq & "' and  tdr.siAttendance in (0,1,2) and "
sql = sql & " (tsd.sischeflag in (1,2,3) and tdr.nvcDailyReportDate <= '" & searchStartDateEweek & "') "
sql = sql & "  and tdr.nvcDailyReportDate >= '" & searchStartDateSweek & "'   "
sql = sql & "  and tdr.iMemberSeq = '" & sUserSeq & "' and ts.nvcCPCode=N'" & SiteCPCode & "' and isnull(tdr.siScheType,0)  = 1 "
sql = sql & "  order by tdr.nvcDailyReportDate + ' ' + tdr.nvcScheTime asc "

Set objRs = dbSelect(Sql)

If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If

objRs.Close
Set objRs = Nothing

'1주차 검색일
searchStartDateSweek1 = searchStartDateSweek 
searchStartDateEweek1 = Trim(dateadd("d",6,searchStartDateSweek)&"")
searchStartDateSweek1oldcount = 0
searchStartDateSweek1newcount = 0

searchStartDateSweek2 = Trim(dateadd("d",7,searchStartDateSweek)&"")
searchStartDateEweek2 = Trim(dateadd("d",13,searchStartDateSweek)&"")
searchStartDateSweek2oldcount = 0
searchStartDateSweek2newcount = 0

searchStartDateSweek3 = Trim(dateadd("d",14,searchStartDateSweek)&"")
searchStartDateEweek3 = Trim(dateadd("d",20,searchStartDateSweek)&"")
searchStartDateSweek3oldcount = 0
searchStartDateSweek3newcount = 0

'Response.write "	searchStartDateSweek1 "  & searchStartDateSweek1 & "<br>"
'Response.write "	searchStartDateEweek1 "  & searchStartDateEweek1 & "<br>"
'Response.write "	searchStartDateSweek2 "  & searchStartDateSweek2 & "<br>"
'Response.write "	searchStartDateEweek2 "  & searchStartDateEweek2 & "<br>"
'Response.write "	searchStartDateSweek3 "  & searchStartDateSweek3 & "<br>"
'Response.write "	searchStartDateEweek2 "  & searchStartDateEweek3 & "<br>"



ncMon = "N"
ncTue = "N"
ncWed = "N"
ncThu = "N"
ncFri = "N"
ncSat = "N"
ncSun = "N"

Dim arrClassData()
Dim item_count, idx
item_count = 0

strCdates = ""
strTbooks = ""
strTbchapters = ""

For idx=0 To 14
	If gReqI(gReq("s_classDate"&CStr(idx))) <> "" then		'수업날짜1 
		ReDim Preserve arrClassData(5,item_count)
		arrClassData(0,item_count) = gReqI(gReq("s_classDate"&CStr(idx)))	'수업날짜
		arrClassData(1,item_count) = gReqI(gReq("s_classTime"&CStr(idx)))	'수업시간			
		arrClassData(2,item_count) = gReqI(gReq("s_classMinute"&CStr(idx)))	'수업진행시간(분)1


		arrClassData(3,item_count) = Right("0" & Hour(DateAdd("n",arrClassData(2,item_count),arrClassData(1,item_count))),2) &":"&	Right("0" & Minute(DateAdd("n",arrClassData(2,item_count),arrClassData(1,item_count))),2) '수업시간
		
		arrClassData(4,item_count) = gReqI(gReq("m_classTB"&CStr(idx)))	'교재
		arrClassData(5,item_count) = gReqI(gReq("m_classTC"&CStr(idx)))	'unit
		
		strCdates = strCdates & arrClassData(0,item_count) & Right("0" & arrClassData(1,item_count),5)&Right("00" & arrClassData(2,item_count),3) & ","
		strTbooks = strTbooks & arrClassData(4,item_count) & ","
		strTbchapters = strTbchapters & arrClassData(5,item_count) & ","

		If weekday(arrClassData(0,item_count)) = 1 Then
			ncSun = "Y"
		End If

		If weekday(arrClassData(0,item_count)) = 2 Then
			ncMon = "Y"
		End If

		If weekday(arrClassData(0,item_count)) = 3 Then
			ncTue = "Y"
		End If

		If weekday(arrClassData(0,item_count)) = 4 Then
			ncWed = "Y"
		End If

		If weekday(arrClassData(0,item_count)) = 5 Then
			ncThu = "Y"
		End If

		If weekday(arrClassData(0,item_count)) = 6 Then
			ncFri = "Y"
		End If

		If weekday(arrClassData(0,item_count)) = 7 Then
			ncSat = "Y"
		End If

		If Trim(arrClassData(0,item_count)&"") >= searchStartDateSweek1 And Trim(arrClassData(0,item_count)&"") <= searchStartDateEweek1 Then
			searchStartDateSweek1newcount = searchStartDateSweek1newcount + 1
		End If

		If Trim(arrClassData(0,item_count)&"") >= searchStartDateSweek2 And Trim(arrClassData(0,item_count)&"") <= searchStartDateEweek2 Then
			searchStartDateSweek2newcount = searchStartDateSweek2newcount + 1
		End If

		If Trim(arrClassData(0,item_count)&"") >= searchStartDateSweek3 And Trim(arrClassData(0,item_count)&"") <= searchStartDateEweek3 Then
			searchStartDateSweek3newcount = searchStartDateSweek3newcount + 1
		End If


		'Response.write " searchStartDateSweek1newcount : " & searchStartDateSweek1newcount & "**"
		'Response.write " searchStartDateSweek2newcount : " & searchStartDateSweek2newcount & "**"
		'Response.write " searchStartDateSweek3newcount : " & searchStartDateSweek3newcount & "**"
		
		'Response.write " arrClassData(0,item_count) : " & arrClassData(0,item_count) & "**"
		'Response.write " arrClassData(1,item_count) : " & arrClassData(1,item_count) & "**"
		'Response.write " arrClassData(2,item_count) : " & arrClassData(2,item_count) & "**"
		'Response.write " arrClassData(3,item_count) : " & arrClassData(3,item_count) & "**"
			
		'Response.write arrClassData(0,idx)&" ** "
		'Response.write arrClassData(1,idx)&" ** "
		'Response.write arrClassData(2,idx)&" ** "
		'Response.write arrClassData(3,idx)&" ** "
		'Response.write arrClassData(4,idx)&" ** "
		'Response.write arrClassData(5,idx)&" ** ""</br>"
		
		item_count = item_count + 1		
		
	End If 
Next 



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

'Response.write " searchStartDateSweek1newcount : " & searchStartDateSweek1newcount & "<br>"
'Response.write " searchStartDateSweek2newcount : " & searchStartDateSweek2newcount & "<br>"
'Response.write " searchStartDateSweek3newcount : " & searchStartDateSweek3newcount & "<br>"
'Response.write " searchStartDateSweek1oldcount : " & searchStartDateSweek1oldcount & "<br>"
'Response.write " searchStartDateSweek2oldcount : " & searchStartDateSweek2oldcount & "<br>"
'Response.write " searchStartDateSweek3oldcount : " & searchStartDateSweek3oldcount & "<br>"


If searchStartDateSweek1newcount > 0 Then
	If (searchStartDateSweek1newcount + searchStartDateSweek1oldcount ) > 2 Then
			nuseclass = "N||1주일에 2회까지 수업가능합니다."
			Response.write nuseclass
			Call DBClose()
			response.end
	End If

End If

If searchStartDateSweek2newcount > 0 Then
	If (searchStartDateSweek2newcount + searchStartDateSweek2oldcount ) > 2 Then
			nuseclass = "N||1주일에 2회까지 수업가능합니다."
			Response.write nuseclass
			Call DBClose()
			response.end
	End If

End If

If searchStartDateSweek3newcount > 0 Then
	If (searchStartDateSweek3newcount + searchStartDateSweek3oldcount ) > 2 Then
			nuseclass = "N||1주일에 2회까지 수업가능합니다."
			Response.write nuseclass
			Call DBClose()
			response.end
	End If

End If


'Response.write "  strCdates : " &  strCdates & "<br>"
'Response.write "  strTbooks : " &  strTbooks & "<br>"
'Response.write "  strTbchapters : " &  strTbchapters & "<br>"
'Response.write "  PiCLCourseSeq : " &  PiCLCourseSeq & "<br>"
'Response.write "  imemberseq : " &  sUserseq & "<br>"


		 



sql = "select top 1 (case when len(nvcMemberCTN) < 9 then nvcMemberTel else nvcMemberCTN END) AS MEMBERTEL FROM tb_member "
sql = sql & " where iMemberseq = '" & sUserSeq & "'"
Set Rs = DB1.execute(sql)

If Not Rs.eof Then
	nvcScheTel = Trim(Rs(0))
End If
Rs.close
Set Rs = Nothing


SQL = "SELECT TOP 1 isnull(iCallCenterSeq,0) FROM TB_Teacher where iTeacherSeq = '" & iTeacherSeq & "' "
Set Rs = DB1.execute(sql)

If Not Rs.eof Then
	iCallCenterSeq = Trim(Rs(0))
End If
Rs.close
Set Rs = Nothing


siMonth			=	"0"
siMembers		=	"0"
siAttenType="1"
StrOrderMonth = item_count


Dim sql

sql = ""
sql = "exec PRC_Teacher_Search_Auto_Insert '" & SiteCPCode & "','" & PiCourseSeq & "','" & strCdates & "','','" & PiCLCourseSeq & "',"
sql = sql & " '" & sUserSeq & "','" & strTbooks & "','" & strTbchapters & "'"

'Response.write sql
'dbclose
'Response.end
result = dbSelectError(sql)

If Instr(Left(result,1),"Y") < 1 Then
	nuseclass = "N||" & result
	Response.write nuseclass
	DBClose()
	Response.end
Else
	nuseclass = "Y||정상적으로 수강신청되었습니다." 
	Response.write nuseclass
	DBClose()
	Response.end
End If

Call DBClose()
Response.end
 %>

	