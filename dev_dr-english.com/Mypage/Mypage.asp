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



Dim arrData, objRs, Sql
'Sql = "Prc_tb_Schedule_User_Select_List N'"& SiteCPCode &"', '"& sUserSeq &"', N'', '"& currPage &"', '"& rowSize &"'"

sql = " select tdr.iDailyReportSeq , tdr.nvcDailyReportDate , tdr.nvcScheTime , tdr.iTeacherSeq , tch.nvcTeacherName, "
sql = sql & "  tdr.iScheduleSeq , ts.nvcCPCode , tdr.iSchedetailSeq ,tm.nvcMemberID , Tm.nvcMemberEName, "
sql = sql & "  tdr.iTBtooksToSeq, tb.nvcTBooksName , tb.nvcTBooksImage, isnull(tdr.siAttendance,0) as siAttendance , st.nvcScheTypeCode,  "
sql = sql & "  ssp.nvcScheNumber, cp.iClassConfigSeq as VideoClassConfigSeq, cct.iClassConfigSeq as PhoneClassConfigSeq , tdr.nvcScheTel ,"
sql = sql & " '' as nvcProductName,  ts.siSchePlayTime,tbc.nvcChapterName, tsd.sischeflag,isnull(tsd.nvcScheExpire,'')  as nvcScheExpire, "
sql = sql & " ts.iCourseSeq, ts.iCLCourseSeq, ts.iCallCenterSeq, ts.iTeacherSeq	"
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
sql = sql & "  where tdr.iMemberSeq = '" & sUserSeq & "' "
sql = sql & " and tdr.siAttendance in (0,1,2) and (tsd.sischeflag in (1,2) or (tsd.sischeflag = 3 and isnull(tsd.nvcScheExpire,'') <= '" & Left(now(),10) & "')) "
sql = sql & " and left(tdr.nvcDailyReportDate,7) ='" & Left(searchDate,7) & "'  "
sql = sql & "  and   ts.nvcCPCode=N'" & SiteCPCode & "'"
sql = sql & "  order by tdr.nvcDailyReportDate + ' ' + tdr.nvcScheTime asc "
'Response.write sql
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
oldtbseqs = ""
oldseqs = ""
oldflags = ""
oldplays = ""

'스탠바이 수업수
iStandbycount = 0
ipresentcount = 0
iabsentcount = 0
isooncount = 0

totalcount = 0

iCourseSeq		= ""
iCLCourseSeq	= ""
iCallCenterSeq	= ""
iTeacherSeq		= ""

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


            if trim(arrData(13,ii)&"") = "0" And trim(arrData(1,ii)&"") >= Left(now(),10) then
                iStandbycount = iStandbycount + 1
            elseif trim(arrData(13,ii)&"") = "1" then
                ipresentcount = ipresentcount + 1
            elseif trim(arrData(13,ii)&"") = "2" then
                iabsentcount = iabsentcount + 1
            else
                isooncount = isooncount + 1
            end If

			iCourseSeq		= trim(arrData(24,ii))
			iCLCourseSeq	= trim(arrData(25,ii))
			iCallCenterSeq	= trim(arrData(26,ii))
			iTeacherSeq		= trim(arrData(27,ii))

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


'sql = " select tdr.iTeacherSeq , tch.nvcTeacherName, tdr.iTBtooksToSeq, tb.nvcTBooksName  "
sql = " select tdr.iTBtooksToSeq, tb.nvcTBooksName, tdr.itbchapterToSeq, tbc.nvcChapterName   "
sql = sql & " from tb_dailyreport as tdr with(nolock) inner join tb_Schedule as ts with(nolock) on tdr.iScheduleSeq = ts.iScheduleSeq "
sql = sql & "  inner join tb_Schedetail as tsd with(nolock) on tdr.ischedetailSeq = tsd.iSchedetailSeq  "
sql = sql & "  inner join tb_Member as tm with(nolock) on tdr.iMemberSeq = tm.iMemberSeq "
'sql = sql & "  inner join tb_Teacher as tch with(nolock) on tdr.iTeacherSeq = tch.iTeacherSeq "
sql = sql & " inner join tb_TBooks as tb with(nolock) on tdr.iTBtooksToSeq = tb.itbooksSeq "
sql = sql & "  left outer join tb_TBChapter as tbc with(nolock) on tdr.iTBChapterToSeq = tbc.itbchapterseq "
sql = sql & "  where tdr.iMemberSeq = '" & sUserSeq & "' "
sql = sql & " and tdr.siAttendance in (0,1,2) and tsd.sischeflag in (1,2,3)  "
sql = sql & " and left(tdr.nvcDailyReportDate,7) ='" & Left(searchDate,7) & "'  "
sql = sql & "  and   ts.nvcCPCode=N'" & SiteCPCode & "'"
sql = sql & "  group by  tdr.iTBtooksToSeq, tb.nvcTBooksName, tdr.itbchapterToSeq, tbc.nvcChapterName "
sql = sql & "  order by tdr.iTBtooksToSeq asc,  tdr.itbchapterToSeq asc  "
Set objRs = dbSelect(Sql)

If Not objRs.Eof Then
	arrTHTB = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing



'##### // 메인팝업 #####
strSQL = "Exec PRC_tb_Popup_CP_Select_List N'"& SiteCPCode &"'"
Set Rs = dbSelect(strSQL)
If Not (Rs.Eof And Rs.Bof) Then
	arrPop = Rs.GetRows
End If
Rs.Close	:	Set Rs = Nothing
'##### 메인팝업 // #####



%>
<!--#include virtual="/include/inc_top.asp"-->


<!-- popup start -->
<!--#include virtual="/popup/init.asp"-->
<!-- popup start -->

	<meta charset="utf-8">
<script type="text/javascript" src="/Commonfiles/Scripts/mypage.js"></script>
<script type="text/javascript">

$(document).ready(function() {

	$mypage.study.init.call(this);
});



function fn_goRefresh(selwin)
{

	selwin.close();
	window.location.reload();
}


function ClassStart(sdatetime,sscindex, ssuser,ssconfig,ssplaytime){

	<% If (BrowseFlag = "Android" Or BrowseFlag = "IOS") Then %>
	document.videofrom.stime.value = sdatetime;
	document.videofrom.playtime.value = ssplaytime;
	document.videofrom.maxuser.value = ssuser;
	document.videofrom.cindex.value = sscindex;
	document.videofrom.ClassConfigSeq.value = ssconfig;
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
			window.open('<%=VideoDownloadURL%>?iScheduleSeq='+iScheduleSeq+'&iScheDetailSeq='+iScheDetailSeq+'&attendate='+attendate+'&iClassConfigSeq='+videoclassconfigseq+'&CompanyCode='+CompanyCode+'&nvcScheTel='+nvcScheTel+'&ncScheTypeCode='+ncScheTypeCode,'FileRecord','width=500 ,height=500 , top=10,left=10 ,scrollbars=YES ,status=NO');
		}

		if (ncScheTypeCode=="PE")
		{
			window.open('<%=PhoneDownloadURL%>?iScheduleSeq='+iScheduleSeq+'&iScheDetailSeq='+iScheDetailSeq+'&attendate='+attendate+'&iClassConfigSeq='+phoneclassconfigseq+'&CompanyCode='+CompanyCode+'&nvcScheTel='+nvcScheTel+'&ncScheTypeCode='+ncScheTypeCode,'FileRecord','width=500 ,height=500 , top=10,left=10 ,scrollbars=YES ,status=NO');
		}

	}

	function DailyComment(iScheduleSeq,iSchedetailSeq,attendate,iDailyReportSeq)
	{
		var dcpop = window.open('/include/DailyComment.asp?iScheduleSeq='+iScheduleSeq+'&iScheDetailSeq='+iSchedetailSeq+'&attendate='+attendate+'&iDailyReportSeq='+iDailyReportSeq,'DailyComment','width=800 ,height=700 , top=10,left=10 ,scrollbars=YES ,status=NO');
	}

	function MonthlyComment()
	{
		var dcpop = window.open('/include/MonthlyComment.asp?iMemberSeq=<%=sUserSeq%>&searchDate=<%=searchDate%>&iCourseSeq=<%=iCourseSeq%>&iCLCourseSeq=<%=iCLCourseSeq%>&iCallCenterSeq=<%=iCallCenterSeq%>&iTeacherSeq=<%=iTeacherSeq%>','MonthlyComment','width=900 ,height=700 , top=10,left=10 ,scrollbars=YES ,status=NO');
	}

	function fn_classmodify(idaseq)
	{
		var mdpop = window.open('/MyPage/MypageClassModify.asp?idailySeq='+idaseq,'DailyModify','width=800 ,height=460 , top=10,left=10 ,scrollbars=YES ,status=NO');
	}

	function fn_textbook(tbseq, tbcseq)
	{
		var tbpop = window.open('/MyPage/MypageClassTextBook.asp?iTbcSeq='+tbcseq+'&iTbSeq='+tbseq +'&Searchdate=<%=searchDate%>','textbook','width=800 ,height=460 , top=10,left=10 ,scrollbars=YES ,status=NO');
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

<div class="contents_right">

    <div><img src="/img/sub/title_1.png" alt="학습현황"/></div>

	<!--현재나의진도현황 시작-->
	  <table class="my_study_ing">
         <tbody>
           <tr >
               <th colspan="4" style="background-color: #ffa800; color:#fff;">현재 나의 진도</th>
           </tr>
           <tr>
               <td colspan="" rowspan="3" style="text-align: center; font-size: 30px; background-color: #3d3d3d; color:#fff;font-weight: 300;letter-spacing: -1px;">출석률 : <% if ipresentcount > 0 then  %>
			   <span style="color:#ffa800;"><%=FormatNumber((ipresentcount / totalcount) * 100, 1) %>%</span>
			   <% else %>
				<span style="color:#ffa800;">0%</span>
			   <% End If %>
			   </td>
			   <th><span style="font-size: 5px;">●</span> 출결석 현황</th>
			   <td>출석:<%=ipresentcount%> / 결석:<%=iabsentcount%> / 취소:<%=isooncount%></td>
           </tr>
           <tr>
               <th scope="row"><span style="font-size: 5px;">●</span> 잔여학습기간</th>
               <td><%=iStandbycount%>회</td>
           </tr>
		  <tr>
               <th scope="row" ><span style="font-size: 5px;">●</span> 총 강의수</th>
               <td><%=totalcount%>회</td>
           </tr>
         </tbody>
     </table>
	  <!--현재나의진도현황 끝-->


	<!--table구간-->
  <div class="usetalking_ing">
    <table class="type07">
           <tbody>
		   <%
		   If isarray(arrTHTB) Then

			For itb = 0 To ubound(arrTHTB,2)
		   %>
           <tr>
               <th style="border-top: 1px solid #ccc;">TextBook</th>
               <td style="border-top: 1px solid #ccc;"><%=Trim(arrTHTB(1,itb)&"")%> </td>
			   <th style="border-top: 1px solid #ccc;">Lesson File</th>
               <td style="border-top: 1px solid #ccc;"><a href="javascript:fn_textbook('<%=Trim(arrTHTB(0,itb)&"")%>','<%=Trim(arrTHTB(2,itb)&"")%>');">
			   <p style="text-align:center;display: block; background-color: #8ee5e5;width:150px;height:30px; line-height: 30px;"><%=Trim(arrTHTB(3,itb)&"")%> 다운로드</p>
			   </a></td>
           </tr>
		   <%

			   next
		   End If

		   %>
           </tbody>
       </table>

	  <div class="text_list">
	 <ul>
		 <li class="text_style5">｜수업일과 수업시간을 꼭 확인하시고, 아래 수업목록에서 <span class="usetalking_start_btn"><img src="/img/subimg/start_btn.png" alt="화상 프로그램 다운로드"/></span> 버튼을 클릭하여 수업입장하세요.</li><br>

		 <li></li><br>
		 <li></li><br>
		 <li></li><br>
		 <li class="text_style5">｜수업일 및 시간 변경은 다음날(당일수업 16시 이전) 수업부터 가능합니다.  아래 수업목록에서 <span class="usetalking_start_btn"><img src="/img/modifyicon.jpg"></span> 버튼을 클릭하세요.</li><br>




	 </ul>
	</div>
	  <br><br>
	  <table class="mypage_tablelist">
	   <tbody>
		  <tr>
               <th scope="row">수업일</th>
               <th scope="row">수업시간/분</th>
               <th scope="row">레벨/진도</th>
               <th scope="row">수업참여</th>
           </tr>
<%'=datediff("h",now(),FormatDateTime("2020-01-13 18:45"))%>
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
		       <td colspan=""><%=arrData(1, jj)%>


			   <% If  Trim(arrData(1, jj)&"") >= Trim(searchStartDate&"") And Trim(arrData(1, jj)&"") <= Trim(searchEndDate&"")  Then %>
					<% If Trim(arrData(13,jj)&"") = "0" Then %>
					<a href="javascript:fn_classmodify('<%=arrData(0, jj)%>');">
					<span style="display: block; background-color: red;width:50px;height:30px; line-height: 30px;margin:0 auto;">변경</span>
					<% End If %>
					</a>
			   <% End If %>

			   </td>
			   <td><%=arrData(2, jj)%> / <%=arrData(20, jj)%>min</td>
			   <td>[<%=arrData(11, jj)%>]<%=arrData(21, jj)%></td>
			   <td>
				<% If Trim(Left(now(),10)) = Trim(arrData(1, jj)) Then %>
					<% If CLng(replace(scheEndTime,":","")&"") < CLng(replace(Trim(nowdtime&""),":","")&"") Then %>
						<%If Trim(arrData(13, jj)&"") = "0" Then %>
							<p style="display: block; background-color: #ccc;width:50px;height:30px; line-height: 30px;margin:0 auto;">대기</p>
						<% ElseIf Trim(arrData(13, jj)&"") = "1" Then %>
							<p style="display: block; background-color: #ffa800;width:50px;height:30px; line-height: 30px;margin:0 auto;">출석</p>
						<% ElseIf Trim(arrData(13, jj)&"") = "2" Then %>
							<p style="display: block; background-color: #3d3d3d; color:#fff;width:50px;height:30px; line-height: 30px;margin:0 auto;">결석</p>
						<% ElseIf Trim(arrData(13, jj)&"") = "3" Then %>
							<p style="display: block; background-color: #3eb100; color:#fff;width:50px;height:30px; line-height: 30px;margin:0 auto;">연기</p>
						<% ElseIf Trim(arrData(13, jj)&"") = "4" Then %>
						   <p style="display: block; background-color: #ff3f3f; color:#fff;width:50px;height:30px; line-height: 30px;margin:0 auto;">취소</p>
						<% End If %>
					<%Else %>
						  <% If arrData(14, jj) = "VE" Then %>
								 <a href="javascript:ClassStart('<%=sdatetime%>','<%=sscindex%>','<%=arrData(15, jj)%>','<%=arrData(16, jj) %>','<%=arrData(20, jj)%>');">
								<img src="/img/subimg/start_btn.png" alt="화상 프로그램 Start" border="0" />
								</a>

						  <% ElseIf arrData(14, jj) = "PE" Then %>
								<p style="display: block; background-color: #ccc;width:50px;height:30px; line-height: 30px;margin:0 auto;">Phone</p>

						  <% else %>
							    <p style="display: block; background-color: #ccc;width:50px;height:30px; line-height: 30px;margin:0 auto;">None</p>
						  <% End If %>
					<% End If %>


				<% else %>
						<%If Trim(arrData(13, jj)&"") = "0" Then %>
							<p style="display: block; background-color: #ccc;width:50px;height:30px; line-height: 30px;margin:0 auto;">대기</p>
						<% ElseIf Trim(arrData(13, jj)&"") = "1" Then %>
							<p style="display: block; background-color: #ffa800;width:50px;height:30px; line-height: 30px;margin:0 auto;">출석</p>
						<% ElseIf Trim(arrData(13, jj)&"") = "2" Then %>
							<p style="display: block; background-color: #3d3d3d; color:#fff;width:50px;height:30px; line-height: 30px;margin:0 auto;">결석</p>
						<% ElseIf Trim(arrData(13, jj)&"") = "3" Then %>
							<p style="display: block; background-color: #3eb100; color:#fff;width:50px;height:30px; line-height: 30px;margin:0 auto;">연기</p>
						<% ElseIf Trim(arrData(13, jj)&"") = "4" Then %>
						   <p style="display: block; background-color: #ff3f3f; color:#fff;width:50px;height:30px; line-height: 30px;margin:0 auto;">취소</p>
						<% End If %>



				<% End If %>
			   </td>
		   </tr>



		   <%
			Next
			%>
			<% else%>
				 <tr>
		       <td colspan="4"><%=left(searchdate,4)%>년 <%=mid(searchdate,6,2) %>월 수업은 없습니다.</td>

		   </tr>

			<%
				End If
			%>

	   </tbody>
	  </table>


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
        Sql = "PRC_tb_Holiday_Select_List N'"& SiteCPCode &"', N'"& startDate &"', N'"& endDate &"', '4'"
        Set objRs = dbSelect(Sql)
        If Not objRs.Eof Then
	        arrHDay = objRs.GetRows()
        End If
        objRs.Close	:	Set objRs = Nothing

	 %>


	<div style="text-align:center;">
		<br /><br />
		<button onclick="MonthlyComment();" style="display:inline-block;font-size:20px; padding:5px; width:250px; cursor:pointer; background-color: #ffa800;">Report in <%=to_month%>. <%=Year(searchDate)%></button>
	</div>

	<!--달력 영역-->

	<div style="margin: 40px 0;">
		<!--전,후 달 볼수있는 화살표-->
		<div class="calendar_title">
		  <ul>
		   <li class="month_title">
				<%=to_month%>. <%=Year(searchDate)%>
			</li>
		   <li class="arrow_two">
		   <a href="MyPage.asp?searchDate=<%=DateAdd("m", -1, searchDate)%>"><span class="arrow_detail">◀</span></a>
		   &nbsp;&nbsp;&nbsp;
		   <a href="MyPage.asp?searchDate=<%=DateAdd("m", 1, searchDate)%>"> <span class="arrow_detail">▶</span></a>
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


							printDate =  Day(tmpDate)

							TableCBG = ""
							If Trim(tmpDate&"") = Trim(Left(Now(),10)&"") Then
								TableCBG = "#EFEFEF"
							End If

							%>
						<td height="80" bgcolor="<%=TableCBG%>"><span style="padding-left:6px;"><%=printDate%></span>

						<%
						'##### 해당 년, 월에 센터 휴일 표시 #####
						If IsArray(arrHDay) Then
							For j = 0 To Ubound(arrHDay, 2)
								If tmpDate = CDate(arrHDay(0, j)) Then

									Response.Write "<p class=""holiday"">" & arrHDay(2, j) & "</p> "

								End If
							Next
						End If

						todaystudy=""
						todaypostpone=""
						%>

						<%
						 '##### 학생 출결 정보 표시 #####
						If IsArray(arrData) Then
							strViewImg = ""
							For j = 0 To Ubound(arrData, 2)
								If tmpDate = CDate(arrData(1, j)) Then

									If Trim(tmpDate&"") <= Trim(Left(Now(),10)&"") Then
									todaystudy="&nbsp;<img src='/img/subimg/usetalking_calendar_sicon1.png' style=""cursor:pointer;"" onclick=""javascript:DailyComment('" & Trim(arrData(5, j)&"") & "','" & arrData(7, j) & "','" & arrData(1, j) & "','" & arrData(0, j) & "');"">"
									End if

									Select Case CInt(arrData(13, j)&"")
										Case 1 : strViewImg = "<p class=""clander_text1"" style=""padding-left:6px;"">출석</p>"
										Case 2 : strViewImg = "<p class=""clander_text2"" style=""padding-left:6px;"">결석</p>"
										Case 3 : strViewImg = "<p class=""clander_text4"" style=""padding-left:6px;"">연기</p>"
										Case 4 : strViewImg = "<p class=""clander_text3"" style=""padding-left:6px;"">취소</p>"
										Case 5 : strViewImg = ""
										Case 0 : strViewImg = "<p class=""clander_text3"" style=""padding-left:6px;"">대기</p>"
									End Select

									'녹화/녹취파일 다운로드 추가
									strDownload=""
									If arrData(13, j)="1" then
										strDownload="&nbsp;<img src=""/img/subimg/usetalking_calendar_sicon2.png"" style=""cursor:pointer;"" onclick=""javascript:FileRecordDownload('"&arrData(14, j)&"','"& arrData(5, j) & "_" & Replace(arrData(2, j),":","") &"','"&arrData(7, j)&"','" & arrData(1, j) &"','"&arrData(16,j)&"','2','" & SiteCPCode  &"','"&Trim(arrData(18, j))&"');"">"
									End if

									Response.Write strViewImg & todaystudy & strDownload & vbCrlf

								End If
							Next
						End If
						%>


						<%
						Response.Write "</td>" & vbCrlf

					If ((i+1) Mod 7) = 0 Then
						Response.Write "</tr><tr>"
					End If
				Next
				%>

            </tr>



            </tbody>
        </table>
	     <!--달력 form 끝-->

		<!--아이콘설명-->
		<div style="margin: 10px 0 50px 0; float: right;">
		  <img src="/img/sub/usetalking_calendar_icon1.png"/>
		  <img src="/img/sub/usetalking_calendar_icon2.png"/>
		</div>

		</div>
	    <!--달력영역끝-->

	</div>

<%
' 모바일용
If  (BrowseFlag = "Android" Or BrowseFlag = "IOS") Then %>
<form name="videofrom" id="videofrom" action="<%=VideoClassURL%>" method="post" target="_Blank">
<input type="hidden" name="CompanyCode" id="CompanyCode" value="<%=SiteCPCode%>">
<input type="hidden" name="id" id="id" value="<%=sUserID%>">
<input type="hidden" name="Name" id="Name" value="<%=iif(sUserEName&"","",sUserName,sUserEName)%>">
<input type="hidden" name="state" id="state" value="2">
<input type="hidden" name="title" id="title" value="UseTalking Video Class">
<input type="hidden" name="cindex" id="cindex" value="">
<input type="hidden" name="playtime"	value="" />
<input type="hidden" name="maxuser"		value="" />
<input type="hidden" name="stime"		value="" />  <!-- hhmm -->
<input type="hidden" name="ClassConfigSeq"		value="" />  <!-- tb_cp에 연결된 iClassConfigSeq -->
<input type="hidden" name="MobileFlag" value="<%=MobileFlag%>">
<input type="hidden" name="version" id="version" value="<%=siteconfigversion%>">
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
<input type="hidden" name="version" id="version" value="<%=siteconfigversion%>">
</form>
<%
End If
' 모바일용
%>

<%

Call DBClose()
 %>
<!--#include virtual="/include/inc_footer.asp"-->
