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


iDailySeq= gReqI(gReq("iDailySeq"))
m_hour = gReqI(gReq("m_hour"))
m_hourmin = gReqI(gReq("m_hourmin"))
m_date = gReqI(gReq("m_date"))
iTeacherSeq = gReqI(gReq("iTeacherSeq"))
m_classTB0 = gReqI(gReq("m_classTB0"))
m_classTC0 = gReqI(gReq("m_classTC0"))


searchDate = Left(now(),10)

nowdtime =  Right("0"&datepart("h",dateadd("n",3,now())),2) & ":" & Right("0"&datepart("n",dateadd("n",3,now())),2)

'searchStartDate = Left(dateadd("d",1,now()),10)
'searchEndDate = Left(dateadd("d",-1,Left(dateadd("m",1,now()),7)&"-01"),10)

'searchlimitdate = Left(dateadd("d",-4,searchEndDate),10)


If Hour(now()) >= 12 Then

searchStartDate = Left(dateadd("d",1,now()),10)
searchEndDate = Left(dateadd("d",14,now()),10)
Dailysearchdate = Left(dateadd("d",-7,now()),10)
searchlimitdate = searchEndDate

Else

Dailysearchdate = Left(dateadd("d",-7,now()),10)
searchStartDate = Left(dateadd("d",0,now()),10)
searchEndDate = Left(dateadd("d",13,now()),10)
searchlimitdate = searchEndDate

End If


sql = " select top 1 tdr.iDailyReportSeq , tdr.nvcDailyReportDate , tdr.nvcScheTime , tdr.iTeacherSeq , tch.nvcTeacherName, "
sql = sql & "  tdr.iScheduleSeq , ts.nvcCPCode , tdr.iSchedetailSeq ,tm.nvcMemberID , Tm.nvcMemberEName, "
sql = sql & "  tdr.iTBtooksToSeq, tb.nvcTBooksName , tb.nvcTBooksImage, isnull(tdr.siAttendance,0) as siAttendance , st.nvcScheTypeCode,  "
sql = sql & "  ssp.nvcScheNumber, cp.iClassConfigSeq as VideoClassConfigSeq, cct.iClassConfigSeq as PhoneClassConfigSeq , tdr.nvcScheTel ,"
sql = sql & " '' as nvcProductName,  ts.siSchePlayTime,tbc.nvcChapterName, tsd.sischeflag,isnull(tsd.nvcScheExpire,'')  as nvcScheExpire, "
sql = sql & " ts.nvcScheEndDate,ts.iCourseSeq, isnull(ts.iclcourseseq,0) as iCLCourseseq ,isnull(tdr.itbchapterToSeq,0) as itbchapterToseq "
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
sql = sql & "  where tdr.iMemberSeq = '" & sUserSeq & "' and tdr.siAttendance in (0) and tsd.sischeflag in (1,2,3) and tdr.iDailyReportSeq ='" & iDailySeq & "' "
sql = sql & "  and tdr.nvcDailyReportDate >= '" & searchStartDate & "' and tdr.nvcDailyReportDate <= '" & searchEndDate & "'  "
sql = sql & "  and  ts.nvcCPCode=N'" & SiteCPCode & "'"
sql = sql & "  order by tdr.nvcDailyReportDate + ' ' + tdr.nvcScheTime asc "

Set objRs = dbSelect(Sql)

If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If

objRs.Close
Set objRs = Nothing


If isArray(arrData) = False Then
%>
<script language="javascript">
	alert("변경할 수업이 없습니다.");
	opener.fn_goRefresh(this);
	window.close();
</script>

<%

Call DBClose()
response.end
End If


'strDates = Left(Trim(arrData(1,0)&""),4) & "년 " & mid(Trim(arrData(1,0)&""),6,2)  & "월 " & right(Trim(arrData(1,0)&""),2) & "일 "
'strDates = strDates & Left(Trim(arrData(2,0)&""),2) &"시 " & right(Trim(arrData(2,0)&""),2) &"분 "

iDailyReportSeq = Trim(arrData(0,0)&"")
iScheduleSeq = Trim(arrData(5,0)&"")
nowRunTime = Trim(arrData(20,0)&"")
oldiTeacherSeq = Trim(arrData(3,0)&"")
ScheEndDate= Trim(arrData(24,0)&"")
PiCourseSeq = Trim(arrData(25,0)&"")
oldm_Hour = Trim(arrData(2,0)&"")

PiCLCourseSeq = Trim(arrData(26,0)&"")
olditbookstoseq = Trim(arrData(10,0)&"")
olditbchaptertoseq = Trim(arrData(27,0)&"")

strDates = Trim(arrData(1,0)&"") & " " & Trim(arrData(2,0)&"") &  " (" & nowRunTime & " min) / " & Trim(arrData(4,0)&"") & " / "
strDates = strDates & Trim(arrData(11,0)&"") & " ( " & Trim(arrData(21,0)&"") & " )"

If m_classTB0 = "" Or m_classTB0 = "0" Then
	m_classTB0 = olditbookstoseq
End If

If m_classTC0 = "" Or m_classTC0 = "0" Then
	m_classTC0 = olditbchaptertoseq
End If


If m_Hour = "" Then
	m_Hour = oldm_Hour
End If 

If iTeacherSeq = "" Then
	iTeacherSeq = oldiTeacherSeq
End If 

If searchEndDate > ScheEndDate Then
	searchEndDate = ScheEndDate
End If



''//교재
If PiCourseSeq <>"" And PiCourseSeq <> "0" And PiCLCourseSeq <> "" And PiCLCourseSeq <> "0" Then 
sql = "exec PRC_tb_TBooks_SearchValueArea '"&PiCLCourseSeq&"','"&PiCourseSeq&"'"
Set Rs = dbSelect(sql)

if Not(Rs.Eof And Rs.Bof) then
	arrTBooks = Rs.GetRows
End if

Rs.close
Set Rs = Nothing

End If 

''//교재
If isArray(arrTBooks) = true And olditbookstoseq <> "" And olditbookstoseq <> "0" Then 
    sql = "exec PRC_tb_TBChapter_SearchValueArea '" & olditbookstoseq & "'"
	Set Rs = dbSelect(sql)

	if Not (Rs.Eof and Rs.Bof) then
		arrTBchapter = Rs.getrows
	end if

	Rs.close
	Set Rs = Nothing

End If 


'#####  휴무일 가져오기
Sql = "PRC_tb_Holiday_Select_List N'"& SiteCPCode &"', N'"& searchStartDate &"', N'"& searchEndDate &"', ''"
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrHDay = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing


strHoliday ="" 
If isArray(arrHDay) Then
	maxLenHoli = ubound(arrHDay, 2)
	For iForr = 0 To maxLenHoli
		strHoliday=strHoliday & " " &  arrHDay(0, iForr)						
	Next 
End If 

nvcWeek="2,3,4,5,6,"

strParamdate=""




For iForr = 0 To 30
	'datepart("w",dateadd("d",0,strSdate))
	weeknum=""
	weeknum = datepart("w",dateadd("d",iForr,searchStartDate))
	If InStr(nvcWeek,Trim(weeknum&"")) And InStr(strHoliday,dateadd("d",iForr,searchStartDate)) <= 0 Then
		If Trim(dateadd("d",iForr,searchStartDate)&"") <= Trim(searchlimitdate&"") Then 
			strParamdate = strParamdate & dateadd("d",iForr,searchStartDate) & ","
		End If

	end If

	
Next


If InStr(strParamdate,",") > 0 Then
	arrParamdate = Split(strParamdate,",")
End If
		
'Response.write " strParamdate : " & strParamdate & "<br>"
'Response.write " iDailyReportSeq " & iDailyReportSeq & "<br>"
'Response.write " iScheduleSeq " & iScheduleSeq & "<br>"
'Response.write " nowRunTime " & nowRunTime & "<br>"
'Response.write " iTeacherSeq " & iTeacherSeq & "<br>"
'Response.write " searchlimitdate " & searchlimitdate & "<br>"
'Response.write " ScheEndDate " & ScheEndDate

strCDates = ""

If Trim(m_date&"") <> "" And Trim(PiCourseSeq&"") <> "" And Trim(iDailyReportSeq&"") <> "" And Trim(iScheduleSeq&"") <> "" And Trim(nowRunTime&"") <> "" Then 
		'수업 가능 시간 선택
		On Error Resume Next
		sql="select iStartTimeSeq,right('0'+siStartTime,5) from tb_starttime where RunTime='" & nowRunTime & "' and siflag = '1' "
		sql = sql & " order by right('0'+siStartTime,5) asc "
		Set Rs = dbSelect(sql)
		If Not Rs.eof Then
			arrStartTime = Rs.GetRows()
		End If
		Rs.close
		Set Rs = Nothing
		
		If isArray(arrStartTime) Then
			
			For ii=0 To ubound(arrStartTime,2)
				strCDates = strCDates & Trim(m_date&"")&Trim(arrStartTime(1,ii)&"")& Right("0" & nowRunTime,3) & ","								
			Next

		End If

End if

'Response.write " ScheEndDate " & ScheEndDate
'Response.write " ScheEndDate " & ScheEndDate
'Response.write " ScheEndDate " & ScheEndDate
'Response.write " ScheEndDate " & ScheEndDate
'Response.write " ScheEndDate " & ScheEndDate
'Response.write " ScheEndDate " & ScheEndDate

'Response.write " strCDates " & strCDates

arrhourmin = ""
plasthourmin = ""

If strCDates <> "" Then
	
	'sql = "exec PRC_HourMin_Search_ForModify_Search '" & Trim(PiCourseSeq&"") & "','" & Trim(strCDates&"") & "',''"
	sql = "exec PRC_HourMin_Search_ForRegist_Search '" & Trim(PiCourseSeq&"") & "','" & Trim(strCDates&"") & "',''"
	Set Rs = dbSelect(sql)
	If Not Rs.eof Then
		arrhourmin = Rs.GetRows()
	End If
	Rs.close
	Set Rs = Nothing
	


	If isArray(arrStartTime) = True And isArray(arrhourmin) = True Then
		
		For ii=0 To ubound(arrStartTime,2)
			If Trim(arrStartTime(1,ii)&"") <> "" Then
				If Trim(arrhourmin(ii,0)&"") > 0  Then
					If m_date <>"" And Left(now(),10) = m_date Then 
							'금일 날짜는 현재 시간 및 12시 이전을 검사한다.
							If Hour(now()) > 12 Then 
								plasthourmin = ""
								ii =  ubound(arrStartTime,2) + 1
							Else
								'If CLng(Replace(Trim(arrStartTime(1,ii)&""),":","")&"") > CLng("1200") Then
								If CLng(Replace(Trim(arrStartTime(1,ii)&""),":","")&"") > CLng(CStr(Hour(dateadd("h",2,now()))&"00")) Then
								 

									plasthourmin = plasthourmin & Trim(arrStartTime(1,ii)&"")&","
								End If
							End If 
					else
				
						plasthourmin = plasthourmin & Trim(arrStartTime(1,ii)&"")&","
					End If
				End If
			End If

		Next 

	End If

	'response.write sql

End If 



If InStr(plasthourmin,",") > 0 Then
	
	arrHourmin = Split(plasthourmin,",")
Else
	arrHourmin = ""

End If

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=TitleName%></title>
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<script type="text/javascript" src="/commonfiles/scripts/common.js"></script>
<script type="text/javascript" src="/commonfiles/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/commonfiles/scripts/jquery.flash.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	// F5 새로고침 방지
	$common.refresh.init.call(this);

	
});
</script>
	<!--달력-->
	<link href='/css/fullcalendar.min.css' rel='stylesheet' />
<link href='/css/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='/commonfiles/scripts/moment.min.js'></script>
<script src='/commonfiles/scripts/jquery.min.js'></script>
<script src='/commonfiles/scripts/fullcalendar.min.js'></script>
	<!--달력//-->
</head>
<body>
	<meta charset="utf-8"> 
<script type="text/javascript" src="/Commonfiles/Scripts/mypage.js"></script>
<script type="text/javascript">

$(document).ready(function() {
		

		$("#pm_date").bind('change', function() {	
			
			goChangeDate($("#pm_date").val());
        });

		$("#pm_hourmin").bind('change', function() {	
			
			goChangeHourTime($("#pm_hourmin").val());
        });

		$("#s_classTB0").bind('change', function() {				
			setTBChapter($("#s_classTB0").val());
        });

		

});



function setTBooks() {

        var innerHtml = '';
        innerHtml += '<option value=""> ++ 선택 ++ </option>';

        $.ajax({
            url: "/ajax/tbooks.asp?PiCourseSeq="+$("#PiCourseSeq").val()+"&PiCLCourseSeq="+$("#PiCLCourseSeq").val(),
            type: 'GET',
            async: false,
            dataType: 'xml',
            success: function(xml) {

                if($(xml).find("row").length > 0){
                    $(xml).find("row").each(function(i){

                        innerHtml += '<option value="'+$(this).find("code").text()+'">'+$(this).find("name").text()+'</option>';
                    });
                }
            },
            error: function(x) {

            }
        });

		$("#s_classTB0").html(innerHtml);		

    }

	
function setTBChapter(tav) {

        var innerHtml = '';
        innerHtml += '<option value=""> ++ 선택 ++ </option>';
			
			$.ajax({
				url: "/ajax/TBChapter.asp?PiTBooksSeq="+tav,
				type: 'GET',
				async: false,
				dataType: 'xml',
				success: function(xml) {

					if($(xml).find("row").length > 0){
						$(xml).find("row").each(function(i){

							innerHtml += '<option value="'+$(this).find("code").text()+'">'+$(this).find("name").text()+'</option>';
						});
					}
				},
				error: function(x) {

				}
			});
			
			$("#s_classTC0").html(innerHtml);
				
    }



function goChangeHour(){
	$("#m_hour").val($("#hourTime").val());
	$("#m_min").val($("#minTime").val());

	var obj = document.frmSearch;
	
	obj.action = "MypageClassModify.asp";
	obj.submit();
}


function goChangeHourTime(at){
	$("#m_hourmin").val(at);
	
	//var obj = document.frmSearch;
	
	//obj.action = "MypageClassModify.asp";
	//obj.submit();
}


function goChangeDate(at){
	
	var obj = document.frmSearch;
	$("#m_date").val(at);
	$("#m_hourmin").val("");

	obj.action = "MypageClassModify.asp";
	obj.submit();
}

function goChangeTeacher(at){
	$("#iTeacherSeq").val(at);
	$("#m_hour").val("");
	$("#m_min").val("");

	var obj = document.frmSearch;
	
	obj.action = "MypageClassModify.asp";
	obj.submit();
}

function goSelectClass(chdate,chtime,chrtime)
{

	if ($("#iDailySeq").val() =="" || $("#iScheduleSeq").val() =="")
	{
		alert("수업정보를 선택하세요.");
		return;
	}

	if ($("#iMemberSeq").val() =="")
	{
		alert("회원을 선택하세요.");
		return;
	}

	if ($("#m_date").val() =="" || $("#m_hourmin").val() =="" )
	{
		alert("수업일 및 시간을 선택하세요.");
		return;
	}

	if ($("#s_classTB0").val() ==""  )
	{
		alert("레벨 및 진도를 선택하세요.");
		$("#s_classTB0").focus();
		return;
	}

	if ($("#s_classTC0").val() =="" )
	{
		alert("레벨 및 진도를 선택하세요.");
		$("#s_classTB0").focus();
		return;
	}

	$("#m_classTB0").val($("#s_classTB0").val());
	$("#m_classTC0").val($("#s_classTC0").val());
	

	
	if(confirm($("#m_date").val() + " " + $("#m_hourmin").val() + " 으로 변경하시겠습니까?"))
	{
		//document.frmSearch.action="MypageClassModify_ok.asp";
		//document.frmSearch.submit();
		var param;					
			param = $("#frmSearch").serialize();

		$.ajax({
				type: "post",
				url: "./MypageClassModify_ok.asp?"+param,
				success: function (msg) {
					if (msg.indexOf("Y||") > -1)
					{
						alert("정상적으로 변경되었습니다.");
						fn_goRefresh();
					}
					else
					{
						 alert("변경 실패! \n\n"+msg.replace(/N\|\|/g,"") );
						 //location.reload();
						  fn_Refresh();
					}
					
					
				},
				 error: function(x) {
				 alert("변경 실패 ! \n\n다시 시도해주세요.\n\n"+ x.responseText);
				  fn_Refresh();

				}
			 });

	}
	

		
}

function fn_Refresh()
{
	document.frmSearch.action="MypageClassModify.asp";
	document.frmSearch.m_date.value="";
   document.frmSearch.m_hourmin.value="";
	document.frmSearch.m_hour.value="";
	 document.frmSearch.m_min.value="";
	document.frmSearch.m_classDate0.value="";
	document.frmSearch.m_classTime0.value="";
	document.frmSearch.m_classMinute0.value="";	
	document.frmSearch.strDates.value="";
	document.frmSearch.strCDates.value="";
	document.frmSearch.iTeacherSeq.value="";
	document.frmSearch.m_classTB0.value="";
	document.frmSearch.m_classTC0.value="";
	document.frmSearch.submit();
}

function fn_goRefresh()
{
	opener.fn_goRefresh(this);
	window.close();
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
          width: 250px;
          padding: 10px 0;
          vertical-align: top;
          border-bottom: 1px solid #ccc;
      }
		
		.calendar_title{height:30px;}
		.holiday{display: block; padding:3px 5px; background-color: #fa0; font-size: 12px; color:#fff; margin-bottom: 10px;}
		.month_title{font-size: 30px; margin: 0 0 10px 10px; font-weight: bold;float: left;}
		.arrow_two{float: right;}
		.arrow_detail{display:inline-block; border-radius: 50px; background-color: #333; color:#fa0; width:30px; height:30px; text-align: center; line-height: 30px;cursor: pointer;position: relative; top:5px;}
	</style>
	
	
<div class="contents">
  <div class="contents_right"> 
  <p style="font-size:18px;"></span> 수업 변경</p>
	
	<!--table구간-->
  <div class="usetalking_ing">
		<table class="type07" style="width:100%;">
			   <tbody>
			   <tr>
				   <th style="border-top: 1px solid #ccc;width:200px;">변경할 수업일</th>
				   <td style="border-top: 1px solid #ccc;"><%=strDates%></td>
				  
			   </tr>
			   </tbody>
		   </table>
	  
		  <div class="text_list">
			 <!--<ul><br>
			 <li class="text_style5">｜강사를 클릭한 후, 시간대를 변경하셔서 검색하세요.</li><br>
			 <li></li><br>
			 <li class="text_style5">｜달력에 표시된 시간을 클릭하시면 변경 완료됩니다.</li> </ul>-->
			<ul>	
			 <li > 1) 수업일을 선택하시면 가능한 수업시간이 표시됩니다.</li>
			 <li > 2) 수업시간이 표시되지 않으면, 해당 수업일에는 수업가능한 시간대가 없는 것이므로 수업일을 다시 선택하세요.</li>
			 <li > 3) 표시된 수업시간을 선택한 후, <font color="red"><b>변경</b></font> 버튼을 클릭해주세요.</li>
			</ul>		 
		</div>
	   		
	 <table class="mypage_tablelist" border="1">
	   <tbody>
		  <tr>
               <th scope="row">수업일</th>
               <th scope="row">수업시간/분</th>             
               <th scope="row">변경</th>
           </tr> 
		   

		   <tr>
		       <td width="40%">
			   <select name="pm_date" id="pm_date" style="height:28px;width:120px;font-size:16px;">
				<option value="">++ 선택 ++</option>
				<% If isArray(arrParamdate) Then 
					For iii=0 To ubound(arrParamdate)
						If Trim(arrParamdate(iii)&"") <> "" Then 
					%>
						<option value="<%=Trim(arrParamdate(iii)&"")%>" <%=iif(Trim(arrParamdate(iii)&""),Trim(m_date&""),"selected","")%> ><%=Trim(arrParamdate(iii)&"")%></option>

				<%		End If
					next
					End If %>
			   </select>
			   </td>
			   <td width="40%"> 
			  
			   <% If Trim(m_date&"") <> "" Then %>
			   <select name="pm_hourmin" id="pm_hourmin" style="height:28px;width:110px;font-size:16px;">
				<option value="">++ 선택 ++</option>
				<% If isArray(arrHourmin) Then 
					For iii=0 To ubound(arrHourmin)
						If Trim(arrHourmin(iii)&"") <> "" Then 
					%>
						<option value="<%=Trim(arrHourmin(iii)&"")%>" <%=iif(Trim(arrHourmin(iii)&""),Trim(m_hourmin&""),"selected","")%> ><%=Trim(arrHourmin(iii)&"")%></option>

				<%		End If
					next
					End If %>
					
			   </select>
			   <% End If %>
			   / <%=nowRunTime%> min</td>
			 
			   <td rowspan="3">
			
				<a href="javascript:goSelectClass();">
					<span style="display: block; background-color: red;width:50px;height:30px; line-height: 30px;margin:0 auto;">변경</span>
					</a>
			
			   </td>
		   </tr>
			
			<tr>
               <th scope="row">레벨</th>
               <th scope="row">진도 </th>             
              
           </tr> 
		   
		  <tr>
		       <td width="40%">
			  <select name="s_classTB0" id="s_classTB0" style="width:80%;height:24px;font-size:14px;" >
				<%=setOption(arrTBooks, m_classTB0)%>
				</select>
			   </td>
			   <td width="40%"> 			  
			   <select name="s_classTC0" id="s_classTC0" style="width:80%;height:24px;font-size:14px;" >
						<%=setOption(arrTBChapter, m_classTC0)%>
						</select>
			  </td>
			 
		   </tr>

		   
	   </tbody>
	  </table>



	</div>
	
</div>
	
</div>

<form name="frmSearch" id="frmSearch" method="post" action="MypageClassModify.asp">
		<input type="hidden" id="m_date" name="m_date" value="<%=m_date%>">	
		<input type="hidden" id="m_hourmin" name="m_hourmin" value="<%=m_hourmin%>">	
		<input type="hidden" id="m_hour" name="m_hour" value="<%=m_hour%>">	
		<input type="hidden" id="m_min" name="m_min" value="<%=m_min%>">	
		<input type="hidden" id="iDailySeq" name="iDailySeq" value="<%=iDailySeq%>">					
		<input type="hidden" id="iMemberSeq" name="iMemberSeq" value="<%=sUserSeq%>">		
		<input type="hidden" id="m_classDate0" name="m_classDate0" value=''>	<!--저장날짜1-->		
		<input type="hidden" id="m_classTime0" name="m_classTime0" value=''>	<!--저장시간1-->
		<input type="hidden" id="m_classMinute0" name="m_classMinute0" value='<%=nowRunTime%>'>	<!--저장시간1-->					
		<input type="hidden" id="StrOrderMonth" name="StrOrderMonth" value='1'>	<!--반배정 갯수-->						
		<input type="hidden" id="strCPCode" name="strCPCode" value='<%=SiteCPCode%>'>							
		<input type="hidden" id="PiCourseSeq" name="PiCourseSeq" value='<%=PiCourseSeq%>'>	
		<input type="hidden" id="iScheduleSeq" name="iScheduleSeq" value='<%=iScheduleSeq%>'>			
		<input type="hidden" id="nowRunTime" name="nowRunTime" value='<%=nowRunTime%>'>
		<input type="hidden" id="strDates" name="strDates" value='<%=strDates%>'>
		<input type="hidden" id="strCDates" name="strCDates" value='<%=strCDates%>'>
		<input type="hidden" id="PiCLCourseSeq" name="PiCLCourseSeq" value='<%=PiCLCourseSeq%>'>	
		<input type="hidden" id="iTeacherSeq" name="iTeacherSeq" value='<%=iTeacherSeq%>'>			
		<input type="hidden" id="m_classTB0" name="m_classTB0" value='<%=m_classTB0%>'>	<!--저장시간1-->					
		<input type="hidden" id="m_classTC0" name="m_classTC0" value='<%=m_classTC0%>'>	<!--저장시간1-->
	</form>

<%
Call DBClose()
 %>
<!--#include virtual="/include/inc_footer.asp"-->
	