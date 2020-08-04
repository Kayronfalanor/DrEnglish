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
Dim sMenu : sMenu = "14"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<% 

m_hour= sqlCheck(Replace(Request("m_hour"), "'", "''"))
iTeacherSeq= sqlCheck(Replace(Request("iTeacherSeq"), "'", "''"))
PiCourseSeq= sqlCheck(Replace(Request("PiCourseSeq"), "'", "''"))

searchDate = Left(now(),10)

nowdtime =  Right("0"&datepart("h",dateadd("n",3,now())),2) & ":" & Right("0"&datepart("n",dateadd("n",3,now())),2)



If Hour(now()) >= 12 Then

searchStartDate = Left(dateadd("d",1,now()),10)
searchEndDate = Left(dateadd("d",14,now()),10)
Dailysearchdate = Left(dateadd("d",-10,now()),10)
searchlimitdate = searchEndDate


Else

Dailysearchdate = Left(dateadd("d",-10,now()),10)
searchStartDate = Left(dateadd("d",0,now()),10)
searchEndDate = Left(dateadd("d",13,now()),10)
searchlimitdate = searchEndDate

End If

'주초 구하기
searchStartDateSweek = Left(dateadd("d", -(weekday(searchStartDate) - 1),searchStartDate),10)
'주끝 구하기
searchStartDateEweek = Left(dateadd("d",7 - weekday(searchEndDate) ,searchEndDate),10)

'Response.write " searchStartDateSweek " & searchStartDateSweek & "<br>"
'Response.write " searchStartDateEweek " & searchStartDateEweek & "<br>"
'Response.write " Hour(now()) " & Hour(now()) & "<br>"
'Response.write " searchStartDate " & searchStartDate & "<br>"
'Response.write " searchEndDate " & searchEndDate & "<br>"
'Response.write " searchlimitdate " & searchlimitdate & "<br>"

sql = " select top 1 tdr.iDailyReportSeq , tdr.nvcDailyReportDate , tdr.nvcScheTime , tdr.iTeacherSeq , tch.nvcTeacherName, "
sql = sql & "  tdr.iScheduleSeq , ts.nvcCPCode , tdr.iSchedetailSeq ,tm.nvcMemberID , Tm.nvcMemberEName, "
sql = sql & "  tdr.iTBtooksToSeq, tb.nvcTBooksName , tb.nvcTBooksImage, isnull(tdr.siAttendance,0) as siAttendance , st.nvcScheTypeCode,  "
sql = sql & "  ssp.nvcScheNumber, cp.iClassConfigSeq as VideoClassConfigSeq, cct.iClassConfigSeq as PhoneClassConfigSeq , tdr.nvcScheTel ,"
sql = sql & "  ts.siSchePlayTime,tbc.nvcChapterName, tsd.sischeflag,isnull(tsd.nvcScheExpire,'')  as nvcScheExpire, "
sql = sql & " ts.nvcScheEndDate,ts.iCourseSeq,tb.iCLCourseSeq "
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
sql = sql & "  and tdr.nvcDailyReportDate >= '" & Dailysearchdate & "'  "
sql = sql & "  and tdr.iMemberSeq = '" & sUserSeq & "' and ts.nvcCPCode=N'" & SiteCPCode & "'"
sql = sql & "  order by tdr.nvcDailyReportDate + ' ' + tdr.nvcScheTime asc "

Set objRs = dbSelect(Sql)

If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If

objRs.Close
Set objRs = Nothing


'strDates = Left(Trim(arrData(1,0)&""),4) & "년 " & mid(Trim(arrData(1,0)&""),6,2)  & "월 " & right(Trim(arrData(1,0)&""),2) & "일 "
'strDates = strDates & Left(Trim(arrData(2,0)&""),2) &"시 " & right(Trim(arrData(2,0)&""),2) &"분 "


If isArray(arrData) = True Then
	
iDailyReportSeq = Trim(arrData(0,0)&"")
iScheduleSeq = Trim(arrData(5,0)&"")
nowRunTime = Trim(arrData(19,0)&"")
oldiTeacherSeq = Trim(arrData(3,0)&"")
ScheEndDate= Trim(arrData(23,0)&"")
PiCourseSeq = Trim(arrData(24,0)&"")
PiCLCourseSeq = Trim(arrData(25,0)&"")
oldm_Hour = Left(Trim(arrData(2,0)&""),2)

If m_Hour = "" Then
	m_Hour = oldm_Hour
End If 

If iTeacherSeq = "" Then
	iTeacherSeq = oldiTeacherSeq
End If 

''Call DBClose()
''response.end
End If


If PiCourseSeq ="" Or PiCourseSeq="0" Then
	PiCourseSeq = "1"
End If 

	
%>

<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript">

$(document).ready(function() {

});


function goChangeHour(){
	$("#m_hour").val($("#hourTime").val());
	$("#m_min").val($("#minTime").val());

	var obj = document.frmSearch;
	
	obj.action = "MypageClassOrder.asp";
	obj.submit();
}

function goChangeTeacher(at){
	$("#iTeacherSeq").val(at);
	$("#m_hour").val("");
	$("#m_min").val("");

	var obj = document.frmSearch;
	
	obj.action = "MypageClassOrder.asp";
	obj.submit();
}

function goSelectClass(chdate,chtime,chrtime)
{
	//alert(chdate + ' '+ chtime + ' '+ chrtime);
	
		$("#m_classDate0").val(chdate);		
		$("#m_classTime0").val(chtime);	
		$("#m_classMinute0").val(chrtime);	

	
	if ($("#iTeacherSeq").val() =="")
	{
		alert("강사를 선택하세요.");
		return;
	}


	if ($("#iMemberSeq").val() =="")
	{
		alert("회원을 선택하세요.");
		return;
	}

	if ($("#m_classDate0").val() =="" || $("#m_classTime0").val() =="" || $("#m_classMinute0").val() =="")
	{
		alert("수업일 및 시간을 선택하세요.");
		return;
	}
	
	
	if(confirm($("#m_classDate0").val() + " " + $("#m_classTime0").val() + " 으로 변경하시겠습니까?"))
	{
		document.frmSearch.action="MypageClassOrder_ok.asp";
		document.frmSearch.submit();
	}
		
}

</script>
	
	<style>
	 table.calendar {
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5;
		
      }
      
      table.calendar thead th {
          padding: 10px ;
          font-weight: bold;
          text-align: center;
          border-bottom: 2px solid #ffa800;
          background: #eee;
      }
      
      table.calendar td {
          width: 350px;
          padding: 10px 0;
          vertical-align: top;
          border-bottom: 1px solid #ccc;
      }
		
		.calendar_title{height:50px;}
		.holiday{display: block; padding:3px 5px; background-color: #fa0; font-size: 12px; color:#fff; margin-bottom: 10px;}
		.month_title{font-size: 30px; margin: 0 0 10px 10px; font-weight: bold;float: left;}
		.arrow_two{float: right;}
		.arrow_detail{display:inline-block; border-radius: 50px; background-color: #333; color:#fa0; width:30px; height:30px; text-align: center; line-height: 30px;cursor: pointer;position: relative; top:5px;}
	</style>
<div class="contents">


	
	
  <div class="contents_right"> 

    <div><img src="/img/subimg/title_14.png" alt="수강신청"/></div>

	<!--table구간-->
  <div class="usetalking_ing">
    <table class="type07" style="width:100%;">
           <tbody>
           <tr>
               <th style="border-top: 1px solid #ccc;width:200px;">최근 수업 정보 / 레벨</th>
               <td style="border-top: 1px solid #ccc;"></td>
			  
           </tr>
           </tbody>
       </table>
	  
	  <div class="text_list">
		 <ul><br>
		 <li class="text_style5">｜강사를 클릭한 후, 시간대를 변경하셔서 검색하세요.</li><br>
		 <li></li><br>
		 <li class="text_style5">｜달력에 표시된 시간을 클릭하여 선택하세요.</li> </ul>

		
	 
	</div>
	   		
	  
	</div>
	
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
        Sql = "PRC_tb_Holiday_Select_List N'"& SiteCPCode &"', N'"& startDate &"', N'"& endDate &"', ''"
		
        Set objRs = dbSelect(Sql)
        If Not objRs.Eof Then
	        arrHDay = objRs.GetRows()
        End If
        objRs.Close	:	Set objRs = Nothing
		

		strSQL = " EXEC PRC_Front_tb_Teacher_Select_All '" & iPCourseSeq & "' "
		arrRst = GF_ExecuteSQL(strSQL)
		

		Dim tchseq
		If isArray(arrRst)  Then	
			If iTeacherSeq = "" Or iTeacherSeq = "0" Then 
			tchseq = arrRst(0,0)
			Else 
			tchseq = iTeacherSeq
			End If 
		End If 
		
		Hourcheck = 0

	 %>

	<!--달력 영역-->

	
	<div style="margin-left: 10px;width:900px;float:left;margin-bottom:30px;">

		<div style="margin-top: 50px;width:200px;float:left;margin-right:10px;height:100%;">
				<div class="text_list">
				 <ul>
				 <li style=" line-height:1.7; font-weight:bold;padding: 10px;text-align:center; vertical-align: middle; border-bottom: 2px solid #ffa800; background: #eee;">
				 강사선택</li>
				 
				 <% If IsArray(arrRst) Then %>
						<% For idx=0 To UBound(arrRst, 2) %>
								<%If Trim(arrRst(0,idx)&"")=Trim(tchseq&"") then%>
								    <a href="javascript:goChangeTeacher('<%=Trim(arrRst(0,idx)&"")%>');">
									<li style=" line-height:1.4; font-weight:bold;padding: 10px ;margin-top:2px;text-align:center; vertical-align: middle;  background: orange;">
									<%=Trim(arrRst(10,idx)&"")%></li>
									</a>
								<% 
								Hourcheck = 1
								Else %>
									<a href="javascript:goChangeTeacher('<%=Trim(arrRst(0,idx)&"")%>');">
									<li style=" line-height:1.0; padding: 10px ;margin-top:2px;text-align:center; vertical-align: middle;  background: #eee;" >
									<%=Trim(arrRst(10,idx)&"")%></li>
									</a>
								<% End If %>
				 
				
						<% Next %>
				 <% End If %>

			 </ul>
			</div>
		
		</div>
		<%
		If Hourcheck = 0 Then
			tchseq = ""
			iTeacherSeq = ""
		Else
				
				
				clTime = nowRunTime
				

								
				tot_classday=""

				
							
				if iTeacherSeq <> "" Then

					sql = "EXEC PRC_tb_Teacher_Select_View '" & iTeacherSeq & "'"
					set rs = dbSelect(sql)
					if not (rs.eof and rs.bof) then
						arrTeacher = rs.getRows
					end if

					rs.close
					set rs=Nothing	
					
				end If

								
				If iTeacherSeq <>"" then
					sql = "SELECT bt.sBreakTime as startTime,bt.eBreakTime as endTime,isnull(bbWeek,'0') as bbWeek FROM tb_Teacher te INNER JOIN tb_BreakTime bt ON bt.iTeacherSeq = te.iTeacherSeq where te.iTeacherSeq='"&iTeacherSeq&"' "
					'response.write sql
					set rs = dbSelect(sql)

					If Not (rs.eof and rs.bof) Then 
						arrBreak = rs.getRows
					End If 

					rs.close
					Set rs = Nothing
					
					
				End If 


				If iTeacherSeq <>"" Then 
					sql = "SELECT aa.siScheFlag  "
					sql = sql & ",bb.nvcDailyReportDate  "
					sql = sql & ",cc.nvcTeacherName  "
					sql = sql & ",bb.nvcScheTime, aa.siSchePlayTime , "
					sql = sql & " (right('0'+convert(nvarchar,datepart(hour,(dateadd(mi,aa.siSchePlayTime,bb.nvcScheTime)))),2) + ':' + right('0'+convert(nvarchar,datepart(minute,(dateadd(mi,aa.siSchePlayTime,bb.nvcScheTime)))),2)) "
					sql = sql & " as nvcScheETime  "
					sql = sql & "FROM tb_Schedule aa   "
					sql = sql & "LEFT OUTER JOIN tb_DailyReport bb   "
					sql = sql & "ON bb.iScheduleSeq = aa.iScheduleSeq  "
					sql = sql & "LEFT OUTER JOIN tb_Teacher cc "
					sql = sql & "ON cc.iTeacherSeq = bb.iTeacherSeq  "
					sql = sql & "WHERE bb.iTeacherSeq='"&iTeacherSeq&"'  "
					'sql = sql & "AND aa.siScheFlag <> '3' and aa.siScheFlag <> '2'  "		'수업취소 또는 수업종료(완료)가 아닌경우
					sql = sql & " AND bb.siAttendance <> '3' and bb.siAttendance <> '4' "
					sql = sql & "AND bb.nvcDailyReportDate >= '" & Left(now(),10) & "' AND bb.nvcDailyReportDate <='" & searchEndDate & "'  "	
					Set rs = dbSelect(sql)

					If Not (rs.eof And rs.bof) Then 
						arr_ClTime = rs.getRows
					End If 

					rs.close
					Set rs = Nothing	

					'Response.write sql
				End If 

				If m_hour = "" Then
					If isArray(arrTeacher) then
						If arrTeacher(5,0) <> "" Then	
							Dim arrCTime : arrCTime  = Split(arrTeacher(5,0),",")		

							For idx=0 To ubound(arrCTime)	'시간이 14시부터 23시까지
								If arrCTime(idx) > 13 And arrCTime(idx) < 24 Then

									m_hour = arrCTime(idx)
									Exit For 
								End If				
							Next	
							
						End If
					End if
				End If
				
				
				
				sqlMinute = "SELECT right(siStartTime,2) from tb_StartTime where siflag=1 and left(siStartTime,CHARINDEX(':',siStartTime)-1) = '"& m_hour &"' and RunTime = '"& nowRunTime &"' order by convert(int, left(siStartTime,CHARINDEX(':',siStartTime)-1)), convert(int, right(siStartTime,2)) asc"	
				Set rs = dbSelect(sqlMinute)
				If Not (rs.eof And rs.bof) Then 
					arrMinute = rs.getRows
				End If 

				rs.close
				Set rs = Nothing
				

				sqlHour = "SELECT left(siStartTime,CHARINDEX(':',siStartTime)-1) from tb_StartTime Where siflag=1 and RunTime = '"& nowRunTime &"' "
				sqlHour = sqlHour & " group by left(siStartTime,CHARINDEX(':',siStartTime)-1) order by convert(int, left(siStartTime,CHARINDEX(':',siStartTime)-1)) asc"
				set rs = dbSelect(sqlHour)
				If Not (rs.eof And rs.bof) Then 
					arrHour = rs.getRows
				End If 

				rs.close
				Set rs = Nothing


				
								
				BalClassStime0=""
				BalClassStime1=""
				BalClassStime2=""
				BalClassStime3=""
				BalClassStime4=""
				BalClassStime5=""

				'Response.write "m_hour="&m_hour&"<br>"
				
				 
				If m_hour <> "" then
					If isArray(arrMinute) Then 
						'For itt = 0 To 5
						For itt = 0 To UBound(arrMinute ,2)
							
							nowStime = ""
						'	nowStime = DateAdd("n", (itt * clTime) , m_hour &":"& m_min)
							nowStime = m_hour &":"& arrMinute(0, itt)
							'Response.write nowstime & "<br>"
							'oldStime = ""
							If itt = 0 And arrTeacher(5,0) <> ""  Then

								BalClassStime0 = Right("0"&Hour(nowStime),2) & ":" & Right("0"&minute(nowStime),2)
								
								If InStr(arrTeacher(5,0),Right("0"&Hour(nowStime),2)) <= 0 Then
									BalClassStime0=""				
								End If 
							End If
							
							If itt = 1 And arrTeacher(5,0) <> "" Then
								BalClassStime1 = Right("0"&Hour(nowStime),2) & ":"&	Right("0"&minute(nowStime),2)	
								If InStr(arrTeacher(5,0),Right("0"&Hour(nowStime),2)) <= 0 Then
										BalClassStime1=""				
									End If
							End If 

							If itt = 2 And arrTeacher(5,0) <> "" Then
								BalClassStime2 = Right("0"&Hour(nowStime),2) & ":"&	Right("0"&minute(nowStime),2)
								If InStr(arrTeacher(5,0),Right("0"&Hour(nowStime),2)) <= 0 Then
									BalClassStime2=""				
								End If
							End If 

							If itt = 3 And arrTeacher(5,0) <> "" Then
								BalClassStime3 = Right("0"&Hour(nowStime),2) & ":"&	Right("0"&minute(nowStime),2)	
								If InStr(arrTeacher(5,0),Right("0"&Hour(nowStime),2)) <= 0 Then
									BalClassStime3=""				
								End If
							End If 

							If itt = 4 And arrTeacher(5,0) <> "" Then
								BalClassStime4 = Right("0"&Hour(nowStime),2) & ":"&	Right("0"&minute(nowStime),2)	
								If InStr(arrTeacher(5,0),Right("0"&Hour(nowStime),2)) <= 0 Then
									BalClassStime4=""				
								End If
							End If 

							If itt = 5 And arrTeacher(5,0) <> "" Then
								BalClassStime5 = Right("0"&Hour(nowStime),2) & ":"&	Right("0"&minute(nowStime),2)	
								If InStr(arrTeacher(5,0),Right("0"&Hour(nowStime),2)) <= 0 Then
									BalClassStime5=""				
								End If
							End If 

							If CInt(m_hour) <> Hour(nowStime) Then
							itt = 6
							End If 
						
						Next
					End If 
					
				End If 

		End If
		

		If iTeacherSeq <>"" Then
					
			For i = 0 To 40
				If Weekday(DateAdd("d",i,searchStartDate)) <> 1 And Weekday(DateAdd("d",i,searchStartDate)) <> 7 Then
					If Left(DateAdd("d",i,searchStartDate),10) <= searchEndDate Then 
						tot_classday = tot_classday & DateAdd("d",i,searchStartDate) &","
					End If
				End If 
			Next 
		End If

		Dim BalTime
		If tot_classday <> "" Then
			If Right(tot_classday,1) = "," Then
				tot_classday = Left(tot_classday,Len(tot_classday)-1)
			End If 

			BalTime = tot_classday
		End If
		

		'Response.write " BalClassStime0 " & BalClassStime0 & "<br>"
		'Response.write " BalClassStime1 " & BalClassStime1 & "<br>"
		'Response.write " BalClassStime2 " & BalClassStime2 & "<br>"
		'Response.write " BalClassStime3 " & BalClassStime3 & "<br>"
		'Response.write " BalClassStime4 " & BalClassStime4 & "<br>"
		%>
		
		<div class="calendar_title" style="margin-top: 20px;">
		  <ul>
		   <li class="month_title"><%=to_month%>. <%=Year(searchDate)%></li>	
		   <li class="arrow_two" style="padding-top:10px;margin-right:10px;">
			시간 : <select style="font-size:12pt;height:30px;width:100px;background-color:#eee;" id="hourTime" name="hourTime" onchange="javascript:goChangeHour();">
				
					<%
						If isArray(arrHour) And Hourcheck = 1 Then 
							For hi = 0 To UBound(arrHour, 2)
					%>
							<option value="<%=arrHour(0, hi)%>" <% If m_hour = arrHour(0, hi) Then %> selected <% End If %>><%=arrHour(0, hi)%>시 구간</option>
					<%
							Next 
						Else 
						
					%>
							<option>++select++</option>
					<%
						End If 
					%>
					</select>
		 
		   
		   </li>	
		  </ul>
		</div>
		<!--전,후 달 볼수있는 화살표 끝-->
		<!--달력 form-->
		<table class="calendar">
            <thead>
            <tr>
                <th scope="cols">일</th>
                <th scope="cols">월</th>
                <th scope="cols">화</th>
                <th scope="cols">수</th>
                <th scope="cols">목</th>
                <th scope="cols">금</th>
                <th scope="cols">토</th>
            </tr>
            </thead>
            <tbody>
            <tr >
				 <%
				 Dim tmpDate, printDate, intWeek, Fcolor
				
				For i = 0 To intDay - 1
					
							tmpDate = CDate(DateAdd("d", i, startDate))
							intWeek	  = WeekDay(tmpDate)
							to_week = intWeek
						
							printDate =  Day(tmpDate)
							
							TableCBG = ""
							If Trim(tmpDate&"") = Trim(Left(Now(),10)&"") Then 
								TableCBG = "#EFEFEF"
							End If
							
							If searchStartDateSweek <= Trim(tmpDate&"") And searchStartDateEweek >= Trim(tmpDate&"") Then 
							%>
						<td height="80" bgcolor="<%=TableCBG%>"><span style="padding-left:6px;"><%=Month(tmpDate)&"/"&printDate%></span>
						
						<%
						holidaycheck = 0

						'##### 해당 년, 월에 센터 휴일 표시 #####
						If IsArray(arrHDay) Then
							For j = 0 To Ubound(arrHDay, 2)
								If tmpDate = CDate(arrHDay(0, j)) Then	
								
									Response.Write "<p class=""holiday"">" & arrHDay(2, j) & "</p> "
									holidaycheck = 1
								End If
							Next
						End If

						If holidaycheck = 0 then
							
							'Response.write " BalTime " & BalTime & "__"& tmpDate & "<br>"
							'Response.write " tmpDate " & tmpDate & "__<br>"

							If instr(BalTime,tmpDate) > 0 And Trim(tmpdate&"") <= Trim(searchlimitdate&"") Then 
							
								If BalClassStime0 <> "" Then %>
																					
									<% If chk(arrBreak,BalClassStime0,to_week) And chk2(arr_ClTime,tmpDate,BalClassStime0)  And to_week <> 1 And to_week <> 7 And CDate(tmpDate) > Date() Then %>	
									<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime0%>','<%=clTime%>');" >
									<p class="clander_text1" style="text-align:center;"><%=BalClassStime0%></p>
								
									<%End If 
												
								End If


								If BalClassStime1 <> "" Then %>
											

									<% If chk(arrBreak,BalClassStime1,to_week) And chk2(arr_ClTime,tmpDate,BalClassStime1)  And to_week <> 1 And to_week <> 7 And CDate(tmpDate) > Date() Then %>	
									<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime1%>','<%=clTime%>');" >
									<p class="clander_text1" style="text-align:center;"><%=BalClassStime1%></p>
								
									<%End If 
												
								End If

								
								If BalClassStime2 <> "" Then %>
											

									<% If chk(arrBreak,BalClassStime2,to_week) And chk2(arr_ClTime,tmpDate,BalClassStime2)  And to_week <> 1 And to_week <> 7 And CDate(tmpDate) > Date() Then %>	
									<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime2%>','<%=clTime%>');" >
									<p class="clander_text1" style="text-align:center;"><%=BalClassStime2%></p>
								
									<%End If 
												
								End If


								If BalClassStime3 <> "" Then %>
											

									<% If chk(arrBreak,BalClassStime3,to_week) And chk2(arr_ClTime,tmpDate,BalClassStime3)  And to_week <> 1 And to_week <> 7 And CDate(tmpDate) > Date() Then %>	
									<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime3%>','<%=clTime%>');" >
									<p class="clander_text1" style="text-align:center;"><%=BalClassStime3%></p>
								
									<%End If 
												
								End If

								If BalClassStime4 <> "" Then %>
											

									<% If chk(arrBreak,BalClassStime4,to_week) And chk2(arr_ClTime,tmpDate,BalClassStime4)  And to_week <> 1 And to_week <> 7 And CDate(tmpDate) > Date() Then %>	
									<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime4%>','<%=clTime%>');" >
									<p class="clander_text1" style="text-align:center;"><%=BalClassStime4%></p>
								
									<%End If 
												
								End If

								If BalClassStime5 <> "" Then %>
											

									<% If chk(arrBreak,BalClassStime5,to_week) And chk2(arr_ClTime,tmpDate,BalClassStime5)  And to_week <> 1 And to_week <> 7 And CDate(tmpDate) > Date() Then %>	
									<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime5%>','<%=clTime%>');" >
									<p class="clander_text1" style="text-align:center;"><%=BalClassStime5%></p>
								
									<%End If 
												
								End If




							 End If 

						End If
						
						%>
						
						</td>
						<%
						Response.Write "</td>" & vbCrlf

					If ((i+1) Mod 7) = 0 Then
						Response.Write "</tr><tr>"
					End If

					End If 
				Next
				%>

            </tr>


				
            </tbody>
        </table>
	     <!--달력 form 끝-->
	
		
		</div>
	    <!--달력영역끝-->
	
	</div>
	
<form name="frmSearch" method="post" action="">	
		<input type="hidden" id="iTeacherSeq" name="iTeacherSeq" value="<%=iTeacherSeq%>">	
		<input type="hidden" id="m_hour" name="m_hour" value="<%=m_hour%>">	
		<input type="hidden" id="m_min" name="m_min" value="<%=m_min%>">	
		<input type="hidden" id="iDailySeq" name="iDailySeq" value="<%=iDailySeq%>">					
		<input type="hidden" id="iMemberSeq" name="iMemberSeq" value="<%=sUserSeq%>">		
		<input type="hidden" id="m_classDate0" name="m_classDate0" value=''>	<!--저장날짜1-->		
		<input type="hidden" id="m_classTime0" name="m_classTime0" value=''>	<!--저장시간1-->
		<input type="hidden" id="m_classMinute0" name="m_classMinute0" value=''>	<!--저장시간1-->					
		<input type="hidden" id="StrOrderMonth" name="StrOrderMonth" value='1'>	<!--반배정 갯수-->						
		<input type="hidden" id="strCPCode" name="strCPCode" value='<%=SiteCPCode%>'>							
		<input type="hidden" id="PiCourseSeq" name="PiCourseSeq" value='<%=PiCourseSeq%>'>	
		<input type="hidden" id="iScheduleSeq" name="iScheduleSeq" value='<%=iScheduleSeq%>'>			
		<input type="hidden" id="nowRunTime" name="nowRunTime" value='<%=nowRunTime%>'>
		<input type="hidden" id="strDates" name="strDates" value='<%=strDates%>'>
				
	</form>
<%




Function chk(arrBreak,ctime,toweek)				'
	'Response.write "++++"&time&"</br>"
	
	eTime = Right("0"&Hour(DateAdd("n",clTime-1,ctime))&"",2) & ":" & Right("0"&minute(DateAdd("n",clTime-1,ctime))&"",2)
	cstime = CInt(Replace(ctime,":",""))
	eTime = CInt(Replace(eTime,":",""))
	'Response.write "++++"&eTime&"</br>"
	brFlag = True
	'Response.write time&" : "&eTime&"</br>"
	If isArray(arrBreak) Then
		for iForr = 0 to ubound(arrBreak, 2)	
		
			If InStr(arrTeacher(5,0),LEFT(eTime,2)) <= 0 Then 
				brFlag = False 
				Exit For 
			Else
			
				If (Trim(arrBreak(2,iForr)&"") = Trim(toweek&"")) Then 

					If (cstime < CInt(Replace(arrBreak(0,iForr), ":", "")) And CInt(Replace(arrBreak(0,iForr), ":", "")) <= eTime)  Then		'시작시간이 수업시간안에 들어와 있을경우
						'Response.write CInt(Replace(arrBreak(0,iForr), ":", ""))&" : "&CInt(Replace(arrBreak(1,iForr), ":", ""))
						'Response.write "=====1"
						brFlag = False 				
						Exit For 
					End If 			

					If (cstime < CInt(Replace(arrBreak(1,iForr), ":", "")) And CInt(Replace(arrBreak(1,iForr), ":", "")) <= eTime) Then		'종료시간이 수업시간안에 들어와있을 경우
						'Response.write CInt(Replace(arrBreak(0,iForr), ":", ""))&" : "&CInt(Replace(arrBreak(1,iForr), ":", ""))
						'Response.write "======2"
						brFlag = False 				
						Exit For 
					End If 			

					If (cstime <= CInt(Replace(arrBreak(0,iForr), ":", "")) And CInt(Replace(arrBreak(1,iForr), ":", "")) <= eTime) Then
						'Response.write CInt(Replace(arrBreak(0,iForr), ":", ""))&" : "&CInt(Replace(arrBreak(1,iForr), ":", ""))
						'Response.write "=======3"
						brFlag = False 				
						Exit For 
					End If 			
					If (CInt(Replace(arrBreak(0,iForr), ":", "")) <= cstime And eTime <= CInt(Replace(arrBreak(1,iForr), ":", ""))) Then
						'Response.write CInt(Replace(arrBreak(0,iForr), ":", ""))&" : "&CInt(Replace(arrBreak(1,iForr), ":", ""))
						'Response.write "=======4"
						brFlag = False 				
						Exit For 
					End If 	

				End If

			End If
		Next
	End If 
	'Response.write brFlag&"</br>"
	chk = brFlag
End Function

Function chk4(arrBreak,ctime)				'
	'Response.write "++++"&time&"</br>"
	
	eTime = Right("0"&Hour(DateAdd("n",clTime-1,ctime))&"",2) & ":" & Right("0"&minute(DateAdd("n",clTime-1,ctime))&"",2)
	cstime = CInt(Replace(ctime,":",""))
	eTime = CInt(Replace(eTime,":",""))
	'Response.write "++++"&eTime&"</br>"
	brFlag = True
	'Response.write time&" : "&eTime&"</br>"
	If isArray(arrBreak) Then
		for iForr = 0 to ubound(arrBreak, 2)		
			If (cstime < CInt(Replace(arrBreak(0,iForr), ":", "")) And CInt(Replace(arrBreak(0,iForr), ":", "")) <= eTime)  Then		'시작시간이 수업시간안에 들어와 있을경우
				'Response.write CInt(Replace(arrBreak(0,iForr), ":", ""))&" : "&CInt(Replace(arrBreak(1,iForr), ":", ""))
				'Response.write "=====1"
				brFlag = False 				
				Exit For 
			End If 			

			If (cstime < CInt(Replace(arrBreak(1,iForr), ":", "")) And CInt(Replace(arrBreak(1,iForr), ":", "")) <= eTime) Then		'종료시간이 수업시간안에 들어와있을 경우
				'Response.write CInt(Replace(arrBreak(0,iForr), ":", ""))&" : "&CInt(Replace(arrBreak(1,iForr), ":", ""))
				'Response.write "======2"
				brFlag = False 				
				Exit For 
			End If 			

			If (cstime <= CInt(Replace(arrBreak(0,iForr), ":", "")) And CInt(Replace(arrBreak(1,iForr), ":", "")) <= eTime) Then
				'Response.write CInt(Replace(arrBreak(0,iForr), ":", ""))&" : "&CInt(Replace(arrBreak(1,iForr), ":", ""))
				'Response.write "=======3"
				brFlag = False 				
				Exit For 
			End If 			
			If (CInt(Replace(arrBreak(0,iForr), ":", "")) <= cstime And eTime <= CInt(Replace(arrBreak(1,iForr), ":", ""))) Then
				'Response.write CInt(Replace(arrBreak(0,iForr), ":", ""))&" : "&CInt(Replace(arrBreak(1,iForr), ":", "")) 
				'Response.write "=======4"
				brFlag = False 				
				Exit For 
			End If 			
		Next
	End If 
	'Response.write brFlag&"</br>"
	chk4 = brFlag
End Function

Function chk2(arr_ClTime,print_time,ctime)
'Response.write "print_time : "&print_time
	brFlag1 = True	

	eTime = Right("0"&Hour(DateAdd("n",clTime-1,ctime))&"",2) & ":" & Right("0"&minute(DateAdd("n",clTime-1,ctime))&"",2)
	cstime = CInt(Replace(ctime,":",""))
	eTime = CInt(Replace(eTime,":",""))

	If isArray(arr_ClTime) Then
		for iForr = 0 to ubound(arr_ClTime, 2)	
		'Response.write arr_ClTime(1,iForr)&" : "&time &"<br>"
		'Response.write "******" & print_time
		'Response.write "**"&arr_ClTime(3,iForr)
			If Trim(print_time) = Trim(arr_ClTime(1,iForr)) Then
			
			'If print_time = "2014-06-21" Then
				'Response.write "1 : "&CInt(Replace(arr_ClTime(3,iForr), ":", ""))&"</br>"
				'Response.write "2 : "&time&"</br>"
				'Response.write "3 : "&eTime&"</br>"
				'Response.write "==========="&(Replace(arr_ClTime(3,iForr), ":", ""))&"</br>"
				'Response.write "==========="&CInt(Replace(arr_ClTime(3,iForr), ":", ""))+19&"</br>"
			
				If (cstime < CInt(Replace(arr_ClTime(3,iForr), ":", "")) And CInt(Replace(arr_ClTime(3,iForr), ":", "")) <= eTime)  Then
					'Response.write CInt(Replace(arr_ClTime(0,iForr), ":", ""))&" : "&CInt(Replace(arr_ClTime(1,iForr), ":", ""))
					'Response.write "=====1"
					brFlag1 = False 				
					Exit For 
				End If 			

				If (cstime < CInt(Replace(arr_ClTime(5,iForr), ":", "")) And CInt(Replace(arr_ClTime(5,iForr), ":", "")) <= eTime) Then
					'Response.write CInt(Replace(arr_ClTime(0,iForr), ":", ""))&" : "&CInt(Replace(arr_ClTime(1,iForr), ":", ""))
					'Response.write "======2"
					brFlag1 = False 				
					Exit For 
				End If 			

				If (cstime =< CInt(Replace(arr_ClTime(3,iForr), ":", "")) And CInt(Replace(arr_ClTime(5,iForr), ":", ""))<=eTime) Then
					'Response.write CInt(Replace(arr_ClTime(0,iForr), ":", ""))&" : "&CInt(Replace(arr_ClTime(1,iForr), ":", ""))
					'Response.write "=======3"
					brFlag1 = False 				
					Exit For 
				End If 			
				If (CInt(Replace(arr_ClTime(3,iForr), ":", "")) <= cstime And eTime<=CInt(Replace(arr_ClTime(5,iForr), ":", ""))) Then
					'Response.write CInt(Replace(arr_ClTime(3,iForr), ":", ""))&" : "&time&" : "&eTime
					'Response.write "=======4"
					brFlag1 = False 				
					Exit For 
				End If 
			End If 				
		Next
	End If 

	'Response.write brFlag1
	chk2 = brFlag1
End Function



Call DBClose()
 %>

<!--#include virtual="/include/inc_footer.asp"-->
	