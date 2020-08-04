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


iTbcSeq= gReqI(gReq("iTbcSeq"))
iTbSeq= gReqI(gReq("iTbSeq"))
Searchdate= gReqI(gReq("Searchdate"))

If iTbcSeq = "" Or iTbcSeq="0" Or iTbSeq="" Or iTbSeq="0" Or Searchdate = "" Then
%>
<script language="javascript">
	alert("교재(레벨)정보가 없습니다.1");
	opener.fn_goRefresh(this);
	window.close();
</script>

<%

Call DBClose()
response.end
End If


'searchDate = Left(now(),10)

nowdtime =  Right("0"&datepart("h",dateadd("n",3,now())),2) & ":" & Right("0"&datepart("n",dateadd("n",3,now())),2)

searchStartDate = Left(dateadd("d",-7,now()),10)
searchEndDate = Left(dateadd("d",7,now()),10)


sql = " select (isnull(tb.nvcTBooksName,'') + ' / ' + isnull(tbc.nvcChapterName,'')) as TeacherTbName "
sql = sql & " , tdr.iTBtooksToSeq, tdr.iTBchaptertoSeq  "
sql = sql & " from tb_dailyreport as tdr with(nolock) inner join tb_Schedule as ts with(nolock) on tdr.iScheduleSeq = ts.iScheduleSeq "
sql = sql & "  inner join tb_Schedetail as tsd with(nolock) on tdr.ischedetailSeq = tsd.iSchedetailSeq  "
sql = sql & "  inner join tb_Member as tm with(nolock) on tdr.iMemberSeq = tm.iMemberSeq "
'sql = sql & "  inner join tb_Teacher as tch with(nolock) on tdr.iTeacherSeq = tch.iTeacherSeq "
sql = sql & " inner join tb_TBooks as tb with(nolock) on tdr.iTBtooksToSeq = tb.itbooksSeq "
sql = sql & "  left outer join tb_TBChapter as tbc with(nolock) on tdr.iTBChapterToSeq = tbc.itbchapterseq "
sql = sql & "  where  tdr.iMemberSeq = '" & sUserSeq & "' "
sql = sql & " and tdr.siAttendance in (0,1,2) and tsd.sischeflag in (1,2,3)  "
sql = sql & "  and left(tdr.nvcDailyReportDate,7) = '" & Left(Searchdate,7) & "'  "
sql = sql & "  and ts.nvcCPCode=N'" & SiteCPCode & "' and isnull(tdr.iTBtooksToSeq,0) > 0 and isnull(tdr.iTBchaptertoSeq,0) > 0 "
sql = sql & " and isnull(tdr.iTBtooksToSeq,0) = '" & iTbSeq & "'  and isnull(tdr.iTBchaptertoSeq,0) = '" & iTbcSeq & "' "
sql = sql & "  group by  tdr.iTBtooksToSeq,  tdr.iTBchaptertoSeq, isnull(tb.nvcTBooksName,'') + ' / ' + isnull(tbc.nvcChapterName,'')  "

Set objRs = dbSelect(Sql)

If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If

objRs.Close
Set objRs = Nothing



If isArray(arrData) = False Then
%>
<script language="javascript">
	alert("교재(레벨)정보가 없습니다.2");
	opener.fn_goRefresh(this);
	window.close();
</script>

<%

Call DBClose()
response.end
End If

nowtbchapterseq = ""
nowtbooksseq = ""

nowteacherbookstr = Trim(arrData(0,0)&"")
nowtbooksseq = Trim(arrData(1,0)&"")
nowtbchapterseq = Trim(arrData(2,0)&"")








''//교재
If nowtbchapterseq <>""  And nowtbchapterseq <> "0" And nowtbooksseq <> "" And nowtbooksseq <> "0" Then

	sql = "exec PRC_tb_TBChapter_TextBook_List '"&nowtbooksseq&"','"&nowtbchapterseq&"'"
	Set Rs = dbSelect(sql)

	if Not(Rs.Eof And Rs.Bof) then
		arrTBooks = Rs.GetRows
	End if

	Rs.close
	Set Rs = Nothing

End If




'Response.write " iTeacherTbSeq : " & iTeacherTbSeq & "<br>"
'Response.write " sql " & sql & "<br>"
'Response.write " nowteacherseq " & nowteacherseq & "<br>"
'Response.write " nowtbooksseq " & nowtbooksseq & "<br>"
'Response.write " iTeacherSeq " & iTeacherSeq & "<br>"
'Response.write " searchlimitdate " & searchlimitdate & "<br>"
'Response.write " ScheEndDate " & ScheEndDate





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
	//$common.refresh.init.call(this);


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


		$("#iTeacherTbSeq").bind('change', function() {
			goChangeTeacher();
        });


});


function goChangeTeacher(){

	var obj = document.frmSearch;
	obj.action = "MypageClassTextBook.asp";
	obj.submit();
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
          width: 150px;
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
  <p style="font-size:18px;"></span> 텍스트북 다운로드</p>

	<!--table구간-->
  <div class="usetalking_ing">
		<table class="type07" style="width:100%;">
		<form name="frmSearch" method="post" action="MypageClassTextBook.asp">
			   <tbody>
			   <tr>
				   <th style="border-top: 1px solid #ccc;width:200px;">교재(레벨)</th>
				   <td style="border-top: 1px solid #ccc;"> <%=nowteacherbookstr%>



				   </td>

			   </tr>
			   </tbody>
			  </form>
		   </table>

		  <div class="text_list">

			<ul>
			 <li > 1) 나열된 텍스트북 파일을 클릭하면 다운로드 하실 수 있습니다. </li>
			</ul>
		</div>

	 <table class="mypage_tablelist" border="1">
	   <tbody>

		<tr>
               <th scope="row">No</th>
			   <th >텍스트북 파일</th>
           </tr>
		   <%
		   If isarray(arrTBooks) Then

		   For iFile = 0 To ubound(arrTBooks,2)
		   %>
		  <tr>
				 <td width="10%">
					<%=ifile+1%>
			   </td>
		       <td style="text-align:left;padding-left:10px;">
					<a href="<%=ClassFileUrl%><%=arrTBooks(1,iFile)%>" target="_blank"><%=arrTBooks(1,iFile)%></a>
			   </td>

		   </tr>
		   <%
		   next
		   Else %>
			<tr>
				 <td width="10%">

			   </td>
		       <td >
				등록된 텍스트북 파일이 없습니다.
			   </td>

		   </tr>
		<% End If %>

	   </tbody>
	  </table>



	</div>

</div>

</div>

<%
Call DBClose()
 %>
<!--#nclude virtual="/include/inc_footer.asp"-->
