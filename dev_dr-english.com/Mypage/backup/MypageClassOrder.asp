﻿<%@Codepage=65001%>
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

m_hour = gReqI(gReq("m_hour"))
'iTeacherSeq = gReqI(gReq("iTeacherSeq"))
PiCourseSeq = gReqI(gReq("PiCourseSeq"))
iTBooksSeq = gReqI(gReq("iTBooksSeq"))
iTBChapterSeq = gReqI(gReq("iTBChapterSeq"))
nowRunTime = gReqI(gReq("nowRunTime"))

searchDate = Left(now(),10)

nowdtime =  Right("0"&datepart("h",dateadd("n",3,now())),2) & ":" & Right("0"&datepart("n",dateadd("n",3,now())),2)


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

sql = " select top 10 tdr.iDailyReportSeq , tdr.nvcDailyReportDate , tdr.nvcScheTime , tdr.iTeacherSeq , tch.nvcTeacherName, "
sql = sql & "  tdr.iScheduleSeq , ts.nvcCPCode , tdr.iSchedetailSeq ,tm.nvcMemberID , Tm.nvcMemberEName, "
sql = sql & "  tdr.iTBtooksToSeq, tb.nvcTBooksName , tb.nvcTBooksImage, isnull(tdr.siAttendance,0) as siAttendance , st.nvcScheTypeCode,  "
sql = sql & "  ssp.nvcScheNumber, cp.iClassConfigSeq as VideoClassConfigSeq, cct.iClassConfigSeq as PhoneClassConfigSeq , tdr.nvcScheTel ,"
sql = sql & "  ts.siSchePlayTime,tbc.nvcChapterName, tsd.sischeflag,isnull(tsd.nvcScheExpire,'')  as nvcScheExpire, "
sql = sql & " ts.nvcScheEndDate,ts.iCourseSeq,ts.iCLCourseSeq,isnull(tdr.iTBChapterToSeq,0) as iTBChapterToSeq,isnull(tdr.siScheType,0) as siScheType "
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
sql = sql & "  where tdr.siAttendance in (0,1,2) and (tsd.sischeflag in (1,2,3) and tdr.nvcDailyReportDate <= '" & searchEndDate & "') "
sql = sql & "  and tdr.nvcDailyReportDate >= '" & Dailysearchdate & "'  "
sql = sql & "  and tdr.iMemberSeq = '" & sUserSeq & "' and ts.nvcCPCode=N'" & SiteCPCode & "'"
sql = sql & "  order by tdr.nvcDailyReportDate + ' ' + tdr.nvcScheTime desc "

Set objRs = dbSelect(Sql)

If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If

objRs.Close
Set objRs = Nothing


strsearchStartDate = Left(Trim(searchStartDate&""),4) & "년 " & mid(Trim(searchStartDate&""),6,2)  & "월 " & right(Trim(searchStartDate&""),2) & "일 "
strsearchEndDate = Left(Trim(searchEndDate&""),4) & "년 " & mid(Trim(searchEndDate&""),6,2)  & "월 " & right(Trim(searchEndDate&""),2) & "일 "
'strDates = strDates & Left(Trim(arrData(2,0)&""),2) &"시 " & right(Trim(arrData(2,0)&""),2) &"분 "

'Response.write searchStartDateSweek
'Response.write dateadd("d",6,searchStartDateSweek)

'Response.write dateadd("d",7,searchStartDateSweek)
'Response.write dateadd("d",13,searchStartDateSweek)

If isArray(arrData) = True Then
	
iDailyReportSeq = Trim(arrData(0,0)&"")
iScheduleSeq = Trim(arrData(5,0)&"")

If nowRunTime ="" Or nowRunTime ="0" Then 
	nowRunTime = Trim(arrData(19,0)&"")
End If

'oldiTeacherSeq = Trim(arrData(3,0)&"")

'If iTeacherSeq = "" Or iTeacherSeq ="0" Then
'	iTeacherSeq = Trim(arrData(3,0)&"")
'End If


PiCourseSeq = Trim(arrData(24,0)&"")
PiCLCourseSeq = Trim(arrData(25,0)&"")
oldm_Hour = Left(Trim(arrData(2,0)&""),2)

'iTBooksSeq = Trim(arrData(10,0)&"")
'iTBChapterSeq = Trim(arrData(26,0)&"")

If m_Hour = "" Then
	m_Hour = oldm_Hour
End If 


''Call DBClose()
''response.end
End If


If PiCourseSeq ="" Or PiCourseSeq="0" Then
	PiCourseSeq = "1"
End If 

''//수강과정
sql = "select iclcourseseq, nvcclcoursename from tb_clcourse "
sql = sql & " where nvcCPCode = N'"&SiteCPCode&"' and iCourseSeq = '"&PiCourseSeq&"' and isnull(siCLCourseFlag,0) = 1 "
Set Rs = dbSelect(sql)

if Not(Rs.Eof And Rs.Bof) then
	arrCLCourse = Rs.GetRows
End if

Rs.close
Set Rs = Nothing


''//교재
If PiCLCourseSeq <> "" And PiCLCourseSeq <> "0" Then 
sql = "exec PRC_tb_TBooks_SearchValueArea '"&PiCLCourseSeq&"','"&PiCourseSeq&"'"
Set Rs = dbSelect(sql)

if Not(Rs.Eof And Rs.Bof) then
	arrTBooks = Rs.GetRows
End if

Rs.close
Set Rs = Nothing

End If 



m_classTB0=gReqI(gReq("m_classTB0"))	
m_classTB1=gReqI(gReq("m_classTB1"))	
m_classTB2=gReqI(gReq("m_classTB2"))	
m_classTB3=gReqI(gReq("m_classTB3"))	
m_classTB4=gReqI(gReq("m_classTB4"))	
m_classTB5=gReqI(gReq("m_classTB5"))	
m_classTB6=gReqI(gReq("m_classTB6"))	
m_classTB7=gReqI(gReq("m_classTB7"))	
m_classTB8=gReqI(gReq("m_classTB8"))	
m_classTB9=gReqI(gReq("m_classTB9"))	
m_classTB10=gReqI(gReq("m_classTB10"))
m_classTB11=gReqI(gReq("m_classTB11"))
m_classTB12=gReqI(gReq("m_classTB12"))
m_classTB13=gReqI(gReq("m_classTB13"))
m_classTB14=gReqI(gReq("m_classTB14"))

m_classTC0=gReqI(gReq("m_classTC0"))	
m_classTC1=gReqI(gReq("m_classTC1"))	
m_classTC2=gReqI(gReq("m_classTC2"))	
m_classTC3=gReqI(gReq("m_classTC3"))	
m_classTC4=gReqI(gReq("m_classTC4"))	
m_classTC5=gReqI(gReq("m_classTC5"))	
m_classTC6=gReqI(gReq("m_classTC6"))	
m_classTC7=gReqI(gReq("m_classTC7"))	
m_classTC8=gReqI(gReq("m_classTC8"))	
m_classTC9=gReqI(gReq("m_classTC9"))	
m_classTC10=gReqI(gReq("m_classTC10"))
m_classTC11=gReqI(gReq("m_classTC11"))
m_classTC12=gReqI(gReq("m_classTC12"))
m_classTC13=gReqI(gReq("m_classTC13"))
m_classTC14=gReqI(gReq("m_classTC14"))


Dim arr_classTB(15)
arr_classTB(0) = m_classTB0
arr_classTB(1) = m_classTB1
arr_classTB(2) = m_classTB2
arr_classTB(3) = m_classTB3
arr_classTB(4) = m_classTB4
arr_classTB(5) = m_classTB5
arr_classTB(6) = m_classTB6
arr_classTB(7) = m_classTB7
arr_classTB(8) = m_classTB8
arr_classTB(9) = m_classTB9
arr_classTB(10) = m_classTB10
arr_classTB(11) = m_classTB11
arr_classTB(12) = m_classTB12
arr_classTB(13) = m_classTB13
arr_classTB(14) = m_classTB14

Dim arr_classTC(15)
arr_classTC(0) = m_classTC0
arr_classTC(1) = m_classTC1
arr_classTC(2) = m_classTC2
arr_classTC(3) = m_classTC3
arr_classTC(4) = m_classTC4
arr_classTC(5) = m_classTC5
arr_classTC(6) = m_classTC6
arr_classTC(7) = m_classTC7
arr_classTC(8) = m_classTC8
arr_classTC(9) = m_classTC9
arr_classTC(10) = m_classTC10
arr_classTC(11) = m_classTC11
arr_classTC(12) = m_classTC12
arr_classTC(13) = m_classTC13
arr_classTC(14) = m_classTC14

nowRunTime="0"

sql = "select top 1 isnull(siRunTime,0) as runtime from tb_CP where nvcCPCode='" & SiteCPCode & "'"

Set RS = dbSelect(sql)
If Not Rs.eof Then
	nowRunTime = Trim(Rs(0)&"")
End If
Rs.close
Set Rs = nothing


%>

<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript">

$(document).ready(function() {
		
		$("#m_classCLCourse").bind('change', function() {		
			setTBooks();
			setTBChapter('');
        });

});


function setTBooks() {

        var innerHtml = '';
        innerHtml += '<option value=""> ++ 선택 ++ </option>';

        $.ajax({
            url: "/ajax/tbooks.asp?PiCourseSeq="+$("#PiCourseSeq").val()+"&PiCLCourseSeq="+$("#m_classCLCourse").val(),
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

		$("#m_classTB0").html(innerHtml);
		$("#m_classTB1").html(innerHtml);
		$("#m_classTB2").html(innerHtml);
		$("#m_classTB3").html(innerHtml);


    }

	
function setTBChapter(tbv) {

        var innerHtml = '';
        innerHtml += '<option value=""> ++ 선택 ++ </option>';
		
		if (tbv != '')
		{
		
			$.ajax({
				url: "/ajax/TBChapter.asp?PiTBooksSeq="+$("#m_classTB"+tbv+"").val(),
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

			$("#m_classTC"+tbv+"").html(innerHtml);
		}
		else
		{
			$("#m_classTC0").html(innerHtml);
			$("#m_classTC1").html(innerHtml);
			$("#m_classTC2").html(innerHtml);
			$("#m_classTC3").html(innerHtml);
		}
		

    }

function goChangeHour(){
	$("#m_hour").val($("#hourTime").val());
	$("#m_min").val($("#minTime").val());
	$("#nowRunTime").val($("#strnowRunTime").val());

	var obj = document.frmSearch;
	
	obj.action = "MypageClassOrder.asp";
	obj.submit();
}

function goChangeTeacher(at){
	
	$("#m_hour").val("");
	$("#m_min").val("");
	$("#nowRunTime").val("");

	var obj = document.frmSearch;
	
	obj.action = "MypageClassOrder.asp";
	obj.submit();
}

function goSelectClass(chdate,chtime,chrtime,obj)
{
	//alert(chdate + ' '+ chtime + ' '+ chrtime);

		if (obj.length > 0 )
		{		
			if ($("#span_"+obj).html() =="선택")
			{		
					
					if ($("#s_classDate0").val() != "" && $("#s_classDate1").val() != "" && $("#s_classDate2").val() != "" && $("#s_classDate3").val() != "")
					{	
						alert("수강신청시 신청횟수는 1주당 2회까지(기존 수업 횟수 포함)  입니다.");
						//$("#s_classDateindex0").val();			
						return;
					}
				
					if ($("#s_classDate0").val() == chdate && $("#s_classTime0").val() == chtime )
					{
						alert("이미 선택한 수업일/시간입니다.");
						return;
					}
				
					if ($("#s_classDate1").val() == chdate && $("#s_classTime1").val() == chtime )
					{
						alert("이미 선택한 수업일/시간입니다.");
						return;
					}
				
					if ($("#s_classDate2").val() == chdate && $("#s_classTime2").val() == chtime )
					{
						alert("이미 선택한 수업일/시간입니다.");
						return;
					}
					
					if ($("#s_classDate3").val() == chdate && $("#s_classTime3").val() == chtime )
					{
						alert("이미 선택한 수업일/시간입니다.");
						return;
					}
				
					if ($("#s_classDate0").val() == "" )
					{	
						$("#s_classDateindex0").val(obj);			
						$("#s_classDate0").val(chdate);		
						$("#s_classTime0").val(chtime);	
						$("#s_classMinute0").val(chrtime);	

						$("#td1_"+obj).css("background","orange");					
						$("#span_"+obj).css("background","orange");
						$("#span_"+obj).html("선택취소");
														
						fn_selClassalign();
				
						return;
					}

					if ($("#s_classDate1").val() == "" )
					{	
						$("#s_classDateindex1").val(obj);			
						$("#s_classDate1").val(chdate);		
						$("#s_classTime1").val(chtime);	
						$("#s_classMinute1").val(chrtime);	

						$("#td1_"+obj).css("background","orange");					
						$("#span_"+obj).css("background","orange");
						$("#span_"+obj).html("선택취소");
						
						fn_selClassalign();

						return;
					}

					if ($("#s_classDate2").val() == "" )
					{	
						$("#s_classDateindex2").val(obj);			
						$("#s_classDate2").val(chdate);		
						$("#s_classTime2").val(chtime);	
						$("#s_classMinute2").val(chrtime);	

						$("#td1_"+obj).css("background","orange");					
						$("#span_"+obj).css("background","orange");
						$("#span_"+obj).html("선택취소");
						
						fn_selClassalign();

						return;
					}

					if ($("#s_classDate3").val() == "" )
					{	
						$("#s_classDateindex3").val(obj);			
						$("#s_classDate3").val(chdate);		
						$("#s_classTime3").val(chtime);	
						$("#s_classMinute3").val(chrtime);	

						$("#td1_"+obj).css("background","orange");					
						$("#span_"+obj).css("background","orange");
						$("#span_"+obj).html("선택취소");
						
						fn_selClassalign();

						return;
					}

					
			}
			else
			{
				
					if ($("#s_classDateindex0").val() == obj )
					{	
						$("#s_classDateindex0").val("");			
						$("#s_classDate0").val("");		
						$("#s_classTime0").val("");	
						$("#s_classMinute0").val("");	

						$("#td1_"+obj).css("background","#ffffff");					
						$("#span_"+obj).css("background","red");
						$("#span_"+obj).html("선택");
						
						fn_selClassalign();

						return;
					}

					if ($("#s_classDateindex1").val() == obj )
					{	
						$("#s_classDateindex1").val("");			
						$("#s_classDate1").val("");		
						$("#s_classTime1").val("");	
						$("#s_classMinute1").val("");	

						$("#td1_"+obj).css("background","#ffffff");					
						$("#span_"+obj).css("background","red");
						$("#span_"+obj).html("선택");
						
						fn_selClassalign();

						return;
					}

					if ($("#s_classDateindex2").val() == obj )
					{	
						$("#s_classDateindex2").val("");			
						$("#s_classDate2").val("");		
						$("#s_classTime2").val("");	
						$("#s_classMinute2").val("");	

						$("#td1_"+obj).css("background","#ffffff");					
						$("#span_"+obj).css("background","red");
						$("#span_"+obj).html("선택");
						
						fn_selClassalign();

						return;
					}

					if ($("#s_classDateindex3").val() == obj )
					{	
						$("#s_classDateindex3").val("");			
						$("#s_classDate3").val("");		
						$("#s_classTime3").val("");	
						$("#s_classMinute3").val("");	

						$("#td1_"+obj).css("background","#ffffff");					
						$("#span_"+obj).css("background","red");
						$("#span_"+obj).html("선택");
						
						fn_selClassalign();

						return;
					}
					
			}

		}
		else
		{	
			alert("선택 버튼을 눌러주세요.");
			return;
		}

}


function fn_selClassalign()
{
	
	
	var arrchgdate = new Array("","","","");
	var arrchgtime = new Array("","","","");
	var arrchgrtime = new Array("","","","");
	var arrchgindex = new Array("","","","");
	var arrseltb = new Array("","","","");
	var arrseltc = new Array("","","","");
	
	var inum = -1;
		
	for(var i=0;i<4;i++){		
		
		if ($("#s_classDateindex"+i+'').val() != "")
		{
			 if (arrchgindex[0] == "")
			{
				arrchgindex[0] = $("#s_classDateindex"+i+'').val();
				arrchgdate[0] = $("#s_classDate"+i+'').val();
				arrchgtime[0]	= $("#s_classTime"+i+'').val();
				arrchgrtime[0] = $("#s_classMinute"+i+'').val();
				arrseltb[0] = $("#m_classTB"+i+'').val();
				//arrseltc[0] = $("#m_classTC"+i+'').val();
				inum = i;
			}
			else if (arrchgindex[1] == "")
			{	
				arrchgindex[1] = $("#s_classDateindex"+i+'').val();

				if (parseInt(arrchgindex[0]) > parseInt(arrchgindex[1]) )
				{	
					arrchgindex[1] = arrchgindex[0];
					arrchgdate[1] = arrchgdate[0];
					arrchgtime[1]	= arrchgtime[0];
					arrchgrtime[1] = arrchgrtime[0];
					arrseltb[1] = arrseltb[0];
					//arrseltc[1] = arrseltc[0];

					arrchgindex[0] = $("#s_classDateindex"+i+'').val();
					arrchgdate[0] = $("#s_classDate"+i+'').val();
					arrchgtime[0]	= $("#s_classTime"+i+'').val();
					arrchgrtime[0] = $("#s_classMinute"+i+'').val();
					arrseltb[0] = $("#m_classTB"+i+'').val();
					//arrseltc[0] = $("#m_classTC"+i+'').val();

				} 
				else
				{
					arrchgindex[1] = $("#s_classDateindex"+i+'').val();
					arrchgdate[1] = $("#s_classDate"+i+'').val();
					arrchgtime[1]	= $("#s_classTime"+i+'').val();
					arrchgrtime[1] = $("#s_classMinute"+i+'').val();
					arrseltb[1] = $("#m_classTB"+i+'').val();
					//arrseltc[1] = $("#m_classTC"+i+'').val();
				}

				inum = i;
				
			}
			else if (arrchgindex[2] == "")
			{	
				arrchgindex[2] = $("#s_classDateindex"+i+'').val();

				if (parseInt(arrchgindex[1]) >parseInt(arrchgindex[2]) )
				{
					if (parseInt(arrchgindex[0]) >parseInt(arrchgindex[2]) )
					{	
						arrchgindex[2] = arrchgindex[1];
						arrchgdate[2] = arrchgdate[1];
						arrchgtime[2]	= arrchgtime[1];
						arrchgrtime[2] = arrchgrtime[1];
						arrseltb[2] = arrseltb[1];
						//arrseltc[2] = arrseltc[1];

						arrchgindex[1] = arrchgindex[0];
						arrchgdate[1] = arrchgdate[0];
						arrchgtime[1]	= arrchgtime[0];
						arrchgrtime[1] = arrchgrtime[0];
						arrseltb[1] = arrseltb[0];
						//arrseltc[1] = arrseltc[0];

						arrchgindex[0] = $("#s_classDateindex"+i+'').val();
						arrchgdate[0] = $("#s_classDate"+i+'').val();
						arrchgtime[0]	= $("#s_classTime"+i+'').val();
						arrchgrtime[0] = $("#s_classMinute"+i+'').val();
						arrseltb[0] = $("#m_classTB"+i+'').val();
						//arrseltc[0] = $("#m_classTC"+i+'').val();
					} 
					else
					{
						arrchgindex[2] = arrchgindex[1];
						arrchgdate[2] = arrchgdate[1];
						arrchgtime[2]	= arrchgtime[1];
						arrchgrtime[2] = arrchgrtime[1];
						arrseltb[2] = arrseltb[1];
						//arrseltc[2] = arrseltc[1];

						arrchgindex[1] = $("#s_classDateindex"+i+'').val();
						arrchgdate[1] = $("#s_classDate"+i+'').val();
						arrchgtime[1]	= $("#s_classTime"+i+'').val();
						arrchgrtime[1] = $("#s_classMinute"+i+'').val();
						arrseltb[1] = $("#m_classTB"+i+'').val();
						//arrseltc[1] = $("#m_classTC"+i+'').val();
										
					}

				}
				else
				{
						arrchgindex[2] = $("#s_classDateindex"+i+'').val();
						arrchgdate[2] = $("#s_classDate"+i+'').val();
						arrchgtime[2]	= $("#s_classTime"+i+'').val();
						arrchgrtime[2] = $("#s_classMinute"+i+'').val();
						arrseltb[2] = $("#m_classTB"+i+'').val();
						//arrseltc[2] = $("#m_classTC"+i+'').val();
				}

				inum = i;
			}
			else if (arrchgindex[3] == "")
			{	
					arrchgindex[3] = $("#s_classDateindex"+i+'').val();

					if (parseInt(arrchgindex[2]) >parseInt(arrchgindex[3]) )
					{
							if (parseInt(arrchgindex[1]) > parseInt(arrchgindex[3]) )
							{
								if (parseInt(arrchgindex[0]) >parseInt(arrchgindex[3]) )
								{	
										arrchgindex[3] = arrchgindex[2];
										arrchgdate[3] = arrchgdate[2];
										arrchgtime[3]	= arrchgtime[2];
										arrchgrtime[3] = arrchgrtime[2];
										arrseltb[3] = arrseltb[2];
										//arrseltc[3] = arrseltc[2];

										arrchgindex[2] = arrchgindex[1];
										arrchgdate[2] = arrchgdate[1];
										arrchgtime[2]	= arrchgtime[1];
										arrchgrtime[2] = arrchgrtime[1];
										arrseltb[2] = arrseltb[1];
										//arrseltc[2] = arrseltc[1];

										arrchgindex[1] = arrchgindex[0];
										arrchgdate[1] = arrchgdate[0];
										arrchgtime[1]	= arrchgtime[0];
										arrchgrtime[1] = arrchgrtime[0];
										arrseltb[1] = arrseltb[0];
										//arrseltc[1] = arrseltc[0];	

										arrchgindex[0] = $("#s_classDateindex"+i+'').val();
										arrchgdate[0] = $("#s_classDate"+i+'').val();
										arrchgtime[0]	= $("#s_classTime"+i+'').val();
										arrchgrtime[0] = $("#s_classMinute"+i+'').val();
										arrseltb[0] = $("#m_classTB"+i+'').val();
										//arrseltc[0] = $("#m_classTC"+i+'').val();	

								}
								else
								{
										arrchgindex[3] = arrchgindex[2];
										arrchgdate[3] = arrchgdate[2];
										arrchgtime[3]	= arrchgtime[2];
										arrchgrtime[3] = arrchgrtime[2];
										arrseltb[3] = arrseltb[2];
										//arrseltc[3] = arrseltc[2];

										arrchgindex[2] = arrchgindex[1];
										arrchgdate[2] = arrchgdate[1];
										arrchgtime[2]	= arrchgtime[1];
										arrchgrtime[2] = arrchgrtime[1];
										arrseltb[2] = arrseltb[1];
										//arrseltc[2] = arrseltc[1];

										arrchgindex[1] = $("#s_classDateindex"+i+'').val();
										arrchgdate[1] = $("#s_classDate"+i+'').val();
										arrchgtime[1]	= $("#s_classTime"+i+'').val();
										arrchgrtime[1] = $("#s_classMinute"+i+'').val();
										arrseltb[1] = $("#m_classTB"+i+'').val();
										//arrseltc[1] = $("#m_classTC"+i+'').val();	
								}

							}
							else
							{
										arrchgindex[3] = arrchgindex[2];
										arrchgdate[3] = arrchgdate[2];
										arrchgtime[3]	= arrchgtime[2];
										arrchgrtime[3] = arrchgrtime[2];
										arrseltb[3] = arrseltb[2];
										//arrseltc[3] = arrseltc[2];

										arrchgindex[2] = $("#s_classDateindex"+i+'').val();
										arrchgdate[2] = $("#s_classDate"+i+'').val();
										arrchgtime[2]	= $("#s_classTime"+i+'').val();
										arrchgrtime[2] = $("#s_classMinute"+i+'').val();
										arrseltb[2] = $("#m_classTB"+i+'').val();
										//arrseltc[2] = $("#m_classTC"+i+'').val();	
						
							}

					}
					else
					{
						arrchgindex[3] = $("#s_classDateindex"+i+'').val();
						arrchgdate[3] = $("#s_classDate"+i+'').val();
						arrchgtime[3]	= $("#s_classTime"+i+'').val();
						arrchgrtime[3] = $("#s_classMinute"+i+'').val();
						arrseltb[3] = $("#m_classTB"+i+'').val();
						//arrseltc[3] = $("#m_classTC"+i+'').val();	
					}
				inum = i;
			}

		}
	}
	
	$("#seltd_1").html("");
	$("#seltd_2").html("");
	$("#seltd_3").html("");
	$("#seltd_4").html("");
	
	setTBooks();
	setTBChapter('');

    if (arrchgindex[0] != "")
    {
		$("#seltd_1").html(arrchgdate[0] + " " +arrchgtime[0] + " (" +arrchgrtime[0]+ " min) " );
			
		$("#s_classDateindex0").val(arrchgindex[0]);			
		$("#s_classDate0").val(arrchgdate[0]);		
		$("#s_classTime0").val(arrchgtime[0]);	
		$("#s_classMinute0").val(arrchgrtime[0]);	
		$("#m_classTB0").val(arrseltb[0]);
		setTBChapter('0');
		$("#m_classTC0").val(arrseltc[0]);
		
    }
	else
	{
		$("#s_classDateindex0").val("");			
		$("#s_classDate0").val("");		
		$("#s_classTime0").val("");	
		$("#s_classMinute0").val("");	
		$("#m_classTB0").val("");
		$("#m_classTC0").val("");
		$("#m_classTB0").val("");		
		$("#m_classTC0").val("");

		$("#s_classDateindex1").val("");			
		$("#s_classDate1").val("");		
		$("#s_classTime1").val("");	
		$("#s_classMinute1").val("");
		$("#m_classTB1").val("");
		$("#m_classTC1").val("");

		$("#s_classDateindex2").val("");			
		$("#s_classDate2").val("");		
		$("#s_classTime2").val("");	
		$("#s_classMinute2").val("");
		$("#m_classTB2").val("");
		$("#m_classTC2").val("");

		$("#s_classDateindex3").val("");			
		$("#s_classDate3").val("");		
		$("#s_classTime3").val("");	
		$("#s_classMinute3").val("");
		$("#m_classTB3").val("");
		$("#m_classTC3").val("");
	}

	 if (arrchgindex[1] != "")
    {
		$("#seltd_2").html(arrchgdate[1] + " " +arrchgtime[1] + " (" +arrchgrtime[1]+ " min) " );
			
		$("#s_classDateindex1").val(arrchgindex[1]);			
		$("#s_classDate1").val(arrchgdate[1]);		
		$("#s_classTime1").val(arrchgtime[1]);	
		$("#s_classMinute1").val(arrchgrtime[1]);	
		$("#m_classTB1").val(arrseltb[1]);
		setTBChapter('1');
		$("#m_classTC1").val(arrseltc[1]);
    }
	else
	{
		
		$("#s_classDateindex1").val("");			
		$("#s_classDate1").val("");		
		$("#s_classTime1").val("");	
		$("#s_classMinute1").val("");
		$("#m_classTB1").val("");
		$("#m_classTC1").val("");

		$("#s_classDateindex2").val("");			
		$("#s_classDate2").val("");		
		$("#s_classTime2").val("");	
		$("#s_classMinute2").val("");
		$("#m_classTB2").val("");
		$("#m_classTC2").val("");

		$("#s_classDateindex3").val("");			
		$("#s_classDate3").val("");		
		$("#s_classTime3").val("");	
		$("#s_classMinute3").val("");
		$("#m_classTB3").val("");
		$("#m_classTC3").val("");
	}

	 if (arrchgindex[2] != "")
    {
		$("#seltd_3").html(arrchgdate[2] + " " +arrchgtime[2] + " (" +arrchgrtime[2]+ " min) " );
			
		$("#s_classDateindex2").val(arrchgindex[2]);			
		$("#s_classDate2").val(arrchgdate[2]);		
		$("#s_classTime2").val(arrchgtime[2]);	
		$("#s_classMinute2").val(arrchgrtime[2]);	
		$("#m_classTB2").val(arrseltb[2]);
		setTBChapter('2');
		$("#m_classTC2").val(arrseltc[2]);
    }
	else
	{		
		
		$("#s_classDateindex2").val("");			
		$("#s_classDate2").val("");		
		$("#s_classTime2").val("");	
		$("#s_classMinute2").val("");
		$("#m_classTB2").val("");
		$("#m_classTC2").val("");

		$("#s_classDateindex3").val("");			
		$("#s_classDate3").val("");		
		$("#s_classTime3").val("");	
		$("#s_classMinute3").val("");
		$("#m_classTB3").val("");
		$("#m_classTC3").val("");
	}
			
	 if (arrchgindex[3] != "")
    {
		$("#seltd_4").html(arrchgdate[3] + " " +arrchgtime[3] + " (" +arrchgrtime[3]+ " min) " );
			
		$("#s_classDateindex3").val(arrchgindex[3]);			
		$("#s_classDate3").val(arrchgdate[3]);		
		$("#s_classTime3").val(arrchgtime[3]);	
		$("#s_classMinute3").val(arrchgrtime[3]);	
		$("#m_classTB3").val(arrseltb[3]);
		setTBChapter('3');
		$("#m_classTC3").val(arrseltc[3]);
    }
	else
	{		
		
		$("#s_classDateindex3").val("");			
		$("#s_classDate3").val("");		
		$("#s_classTime3").val("");	
		$("#s_classMinute3").val("");
		$("#m_classTB3").val("");
		$("#m_classTC3").val("");
	}

}

function fn_goRegistClass()
{
			
	if ($("#searchiCourseSeq").val() =="" )
	{
		alert("과목 정보가 정확하지 않습니다.");
		return;
	}

	if ($("#m_classCLCourse").val() =="" )
	{		
		alert("수강과정을 선택하세요.");
		$("#m_classCLCourse").focus();	
		return;
	}
	

	if ( $("#searchnowRunTime").val() =="")
	{
		alert("플레이타임 정보가 정확하지 않습니다.");
		return;
	}

	if ($("#searchStartDate").val() =="" || $("#searchEndDate").val() =="" || $("#Dailysearchdate").val() =="" ||$("#searchStartDateSweek").val() =="" ||$("#searchStartDateEweek").val() =="" )
	{
		alert("검색 날짜 정보가 정확하지 않습니다.");
		return;
	}


	if ($("#s_classDate0").val() =="" && $("#s_classDate1").val() =="" && $("#s_classDate2").val() =="" && $("#s_classDate3").val() =="")
	{
		alert("수강신청할 수업일 및 시간을 선택하세요.");
		return;
	}
	
	var orderclassnum;
	orderclassnum = 0;

	for(var ii=0;ii<4;ii++)
	{
		if ($("#s_classDate"+ii+"").val() !="" && ( $("#m_classTB"+ii+"").val() == "" || $("#m_classTC"+ii+"").val() =="" ) )
		{
			alert("선택한 수업일의 레벨 및 진도를 선택하세요.");
			$("#m_classTB"+ii+"").focus();
			return;
		}

		if ($("#s_classDate"+ii+"").val() !="" &&  $("#m_classTB"+ii+"").val() != "" && $("#m_classTC"+ii+"").val() !=""  )
		{
			orderclassnum++;
		}
		

	}

	if (orderclassnum > 0 )
	{	
		if(confirm("총 " + orderclassnum + " 회의 수업을 신청하시겠습니까?"))
		{
			//document.frmselclass.target="_Blank";
			//document.frmselclass.submit();

			var param;
			
			param = $("#frmselclass").serialize();
			
			//$("#frmselclass").target="_blank";
			//$("#frmselclass").submit();
			
			$.ajax({
				type: "post",
				url: "MypageClassOrder_ok.asp?"+param,
				success: function (msg) {
					if (msg.indexOf("Y||") > -1)
					{
						alert("정상적으로 수강신청되었습니다.");
						 location.href="/Mypage/Mypage.asp";
					}
					else
					{
						 alert("수강신청 실패! \n\n다시 시도해주세요.\n\n"+msg.replace(/N\|\|/g,"") );
						  location.href="/Mypage/MypageClassOrder.asp";
					}
					
					
				},
				 error: function(x) {
				 alert("수강신청 실패 ! \n\n다시 시도해주세요.\n\n"+ x.responseText);
				 location.href="/Mypage/MypageClassOrder.asp";
				}
			 });
			
		}
	
	}
	else
	{
		alert("선택한 수업이 없습니다. \n\n다시 시도해 주세요.");
		location.href="/Mypage/MypageClassOrder.asp";
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
          padding: 8px ;
          font-weight: bold;
          text-align: center;
          border-bottom: 2px solid #ffa800;
          background: #eee;
      }
      
      table.calendar td {
          width: 270px;
          padding: 2px 0;
          vertical-align: top;
          border-bottom: 1px solid #ccc;
		  text-align:center;
      }
		
		.calendar_title{height:50px;}
		.holiday{display: block; padding:3px 5px; background-color: #efefef; font-size: 12px; color:#000; margin-bottom: 10px;}
		.month_title{font-size: 24px; margin: 0 0 10px 50px; font-weight: bold;text-align:center;}
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
		   <%
				If isArray(arrData) Then 

				For ioldclass = 0 To ubound(arrData,2)
				
				If iTBooksSeq = "" Or iTBooksSeq = "0" Or iTBChapterSeq = "" Or iTBChapterSeq = "" Then 
					If Trim(arrData(10,ioldclass)&"") <> "" And Trim(arrData(10,ioldclass)&"") <> "0" And Trim(arrData(26,ioldclass)&"") <> "" And Trim(arrData(26,ioldclass)&"") <> "0" Then 
					iTBooksSeq = Trim(arrData(10,ioldclass)&"")
					iTBChapterSeq = Trim(arrData(26,ioldclass)&"")
					End iF
				End IF

		   %>
           <tr>
               <th style="border-top: 1px solid #ccc;width:200px;">최근 수업일시 / 강사 / 레벨</th>
               <td style="border-top: 1px solid #ccc;"><%=iif(arrData(27,ioldclass)&"","1","","<font color='meganta'>[보강]</font>")%><%=arrData(1,ioldclass) & " " & arrData(2,ioldclass)& " ("&arrData(19,ioldclass)&" min)"%> / 
			   <%=arrData(4,ioldclass)%> / <%=arrData(11,ioldclass) & " (" &arrData(20,ioldclass)& ")"%></td>
			  
           </tr>
		   <% 
				next
		   Else %>
			<tr>
               <th style="border-top: 1px solid #ccc;width:200px;">최근 수업 / 레벨</th>
               <td style="border-top: 1px solid #ccc;">없음</td>
			  
           </tr>
		   <% End If %>
           </tbody>
       </table>
	  
	  <div class="text_list">
		 <ul><br>
		 <li class="text_style5">｜시간대를 변경하셔서 검색하세요.</li><br>
		 <li></li><br>
		 <li class="text_style5">｜목록에 표시된 선택 버튼을 클릭한 후, 하단의 수강신청 버튼을 클릭해주세요.</li> <br>
		 <li></li><br>
		 <li class="text_style5">｜수강신청 기간은 2주 후 까지 신청가능합니다.</li><br>
		 <li></li><br>
		 <li class="text_style5">｜수강신청 횟수는 기존 수업수를 포함하여 1주당 2회까지, 총 4회 신청가능합니다.</li>
		 </ul>	 
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
        end Select
       
	 Function fn_strweek(weeknum)	
		 weekstr = ""
		  select case weeknum
				case 1	:	weekstr="Sun"
				case 2	:	weekstr="Mon"
				case 3	:	weekstr="Tue"
				case 4	:	weekstr="Wed"
				case 5	:	weekstr="Thu"
				case 6	:	weekstr="Fri"
				case 7	:	weekstr="Sat"	      
			end Select
		
		fn_strweek = weekstr

		End Function


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
        Sql = "PRC_tb_Holiday_Select_List N'"& SiteCPCode &"', N'"& searchStartDate &"', N'"& searchEndDate &"', ''"
		
        Set objRs = dbSelect(Sql)
        If Not objRs.Eof Then
	        arrHDay = objRs.GetRows()
        End If
        objRs.Close	:	Set objRs = Nothing
		


	 %>

	<!--달력 영역-->

	
	<div style="margin-left: 10px;width:800px;float:left;margin-bottom:30px;">

		
		<%
		If nowRunTime <> "0" And nowRunTime <> "" Then
		
				
				
				clTime = nowRunTime
				
								
				tot_classday=""
				

				sqlHour = "SELECT left(siStartTime,CHARINDEX(':',siStartTime)-1) from tb_StartTime Where siflag=1 and RunTime = '"& nowRunTime &"' "
				sqlHour = sqlHour & " group by left(siStartTime,CHARINDEX(':',siStartTime)-1) order by convert(int, left(siStartTime,CHARINDEX(':',siStartTime)-1)) asc"
				set rs = dbSelect(sqlHour)
				If Not (rs.eof And rs.bof) Then 
					arrHour = rs.getRows
				End If 

				rs.close
				Set rs = Nothing

				
				
				sqlMinute = "SELECT right(siStartTime,2) from tb_StartTime where siflag=1 and left(siStartTime,CHARINDEX(':',siStartTime)-1) = '"& m_hour &"' and RunTime = '"& nowRunTime &"' order by convert(int, left(siStartTime,CHARINDEX(':',siStartTime)-1)), convert(int, right(siStartTime,2)) asc"	
				Set rs = dbSelect(sqlMinute)
				If Not (rs.eof And rs.bof) Then 
					arrMinute = rs.getRows
				End If 

				rs.close
				Set rs = Nothing
				
				If isArray(arrHour) = True and isArray(arrMinute) = False Then
					
					m_hour = arrHour(0,0)

					sqlMinute = "SELECT right(siStartTime,2) from tb_StartTime where siflag=1 and left(siStartTime,CHARINDEX(':',siStartTime)-1) = '"& m_hour &"' and RunTime = '"& nowRunTime &"' order by convert(int, left(siStartTime,CHARINDEX(':',siStartTime)-1)), convert(int, right(siStartTime,2)) asc"	
					Set rs = dbSelect(sqlMinute)
					If Not (rs.eof And rs.bof) Then 
						arrMinute = rs.getRows
					End If 

					rs.close
					Set rs = Nothing

				End If 
				
				If m_hour <> "" And isArray(arrHour) = True Then
						
					sqltime = "SELECT istarttimeseq , right('0' + convert(nvarchar(5),siStartTime),5) from tb_StartTime "
					sqltime = sqltime & " where siflag=1 and left(siStartTime,CHARINDEX(':',siStartTime)-1) = '" & m_hour & "' and RunTime = '"& nowRunTime &"' "
					sqltime = sqltime & " order by convert(int, left(siStartTime,CHARINDEX(':',siStartTime)-1)), convert(int, right(siStartTime,2)) asc "
					
					Set rs = dbSelect(sqltime)
					If Not (rs.eof And rs.bof) Then 
						arrHourTime = rs.getRows
					End If 

					rs.close
					Set rs = Nothing

				End If
	
			
				
				
								
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
							If itt = 0   Then

								BalClassStime0 = Right("0"&Hour(nowStime),2) & ":" & Right("0"&minute(nowStime),2)										
								
							End If
							
							If itt = 1  Then
								BalClassStime1 = Right("0"&Hour(nowStime),2) & ":"&	Right("0"&minute(nowStime),2)	
								
							End If 

							If itt = 2  Then
								BalClassStime2 = Right("0"&Hour(nowStime),2) & ":"&	Right("0"&minute(nowStime),2)
								
							End If 

							If itt = 3  Then
								BalClassStime3 = Right("0"&Hour(nowStime),2) & ":"&	Right("0"&minute(nowStime),2)	
								
							End If 

							If itt = 4  Then
								BalClassStime4 = Right("0"&Hour(nowStime),2) & ":"&	Right("0"&minute(nowStime),2)	
							
							End If 

							If itt = 5  Then
								BalClassStime5 = Right("0"&Hour(nowStime),2) & ":"&	Right("0"&minute(nowStime),2)	
								
							End If 

							If CInt(m_hour) <> Hour(nowStime) Then
							itt = 6
							End If 
						
						Next
					End If 
					
				End If 

		End If
		
		tot_holiday = ""

		strcdates = ""

		If IsArray(arrHDay) Then
				For j = 0 To Ubound(arrHDay, 2)
					tot_holiday = tot_holiday & arrHDay(0,j) & ","
				Next
		End If
					
		For i = 0 To 40
			If Weekday(DateAdd("d",i,searchStartDate)) <> 1 And Weekday(DateAdd("d",i,searchStartDate)) <> 7 Then
				If Left(DateAdd("d",i,searchStartDate),10) <= searchEndDate And InStr(tot_holiday,Left(DateAdd("d",i,searchStartDate),10)&"") <= 0 Then 
					tot_classday = tot_classday & DateAdd("d",i,searchStartDate) &","
					
					For ih = 0 To ubound(arrHourTime,2)

						strcdates = strcdates & DateAdd("d",i,searchStartDate) & arrHourTime(1,ih) & Right("00" & nowRunTime  ,3) & ","

					next

				End If
			End If 
		Next 

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
		'Response.write " BalClassStime5 " & BalClassStime5 & "<br>"
		
		

		'Response.write strcdates 
		%>
		
		<div class="calendar_title" style="margin-top: 20px;">
		  <ul>
		   <li class="month_title"><%=strsearchStartDate%> ~ <%=strsearchEndDate%></li>	
		   
		  </ul>
		</div>
		
		<!--전,후 달 볼수있는 화살표 끝-->
		<!--달력 form-->
		<table class="calendar">
		 <thead>
            <tr >
                <th scope="cols" colspan="3" style="background-color:#ffffff;text-align:left;">플레이타임  : <%=nowRunTime%> min
				<input type="hidden" id="strnowRunTime" name="strnowRunTime" value="<%=nowRunTime%>">
				
					</th>
                <th scope="cols" colspan="3" style="background-color:#ffffff;">시간 : <select style="font-size:12pt;height:30px;width:100px;background-color:#eee;" id="hourTime" name="hourTime" onchange="javascript:goChangeHour();">
				
					<%
						If isArray(arrHour)  Then 
							For hi = 0 To UBound(arrHour, 2)
					%>
							<option value="<%=arrHour(0, hi)%>" <% If CInt(m_hour&"") = CInt(arrHour(0, hi)&"") Then %> selected <% End If %>><%=arrHour(0, hi)%>시 구간</option>
					<%
							Next 
						Else 
						
					%>
							<option>++select++</option>
					<%
						End If 
					%>
					</select>
					</th>

            </tr>
            </thead>
            <thead>
            <tr>
                <th scope="cols" colspan="2">Date</th>
                <th scope="cols" colspan="2">Time</th>
                <th scope="cols" colspan="2">선택</th>
               
            </tr>
            </thead>			
            <tbody>
			
            
			 <%
				 Dim tmpDate, printDate, intWeek, Fcolor
				tdnum = 0
				arrCDatesRs = ""

				If nowRunTime <> "" And m_Hour <> "" and Len(strcdates&"") > 10 Then

					sql = "exec PRC_HourMin_Search_ForRegist_Search '" & PiCourseSeq & "','" & Trim(strcdates&"") & "'"	
					Set Rs = dbSelect(sql)
					If Not Rs.eof Then
						arrCDatesRs = Rs.getRows
					End If
					Rs.close
					Set Rs = nothing
					
				End If
				
				'Response.write " searchStartDate " & searchStartDate & " // searchEndDate " &  searchEndDate & "// nowRunTime : " &nowRunTime & " //m_hour : " & m_hour
				For i = 0 To intDay - 1
							
							tmpDate = CDate(DateAdd("d", i, searchStartDate))
							intWeek	  = WeekDay(tmpDate)
							to_week = intWeek
						
							printDate =  Day(tmpDate)
							
							TableCBG = ""
							If Trim(tmpDate&"") = Trim(Left(Now(),10)&"") Then 
								TableCBG = "#EFEFEF"
							End If
							
							'Response.write Trim(tmpDate&"") & "<br>"

							 If Trim(searchStartDate&"") <= Trim(tmpDate&"") And Trim(searchEndDate&"") >= Trim(tmpDate&"") And nowRunTime <> "" And m_Hour <> ""  Then
							
							

						holidaycheck = 0

						'##### 해당 년, 월에 센터 휴일 표시 #####
						If IsArray(arrHDay) Then
							'For j = 0 To Ubound(arrHDay, 2)
								If InStr(tot_holiday,Trim(tmpDate&"")) > 0  Then	
								'	Response.write "<tr><td colspan=""2""><span style=""padding-left:6px;"">" & Month(tmpDate) &"월 " & printDate & "일 (" & fn_strweek(weekday(trim(tmpDate&""))) & ")</span></td>"
								'	Response.write "<td colspan=""2"">-</td>"
								'	Response.Write "<td colspan=""2""><p class=""holiday"">" & arrHDay(2, j) & "</p> </td>"
								'	Response.write "</tr>"
									holidaycheck = 1
								End If
							'Next
						End If

						If holidaycheck = 0 then
							
							
							'Response.write " BalTime " & BalTime & "__"& tmpDate & "<br>"
							'Response.write " tmpDate " & tmpDate & "__<br>"
							
							'Response.write " BalTime " & BalTime & "__" & searchlimitdate & " 1111111<br>"		
							If  to_week <> 1 And to_week <> 7 And  instr(BalTime,tmpDate) > 0 And Trim(tmpdate&"") <= Trim(searchlimitdate&"") And Len(strcdates&"") > 15  Then 
								'Response.write " BalTime " & BalTime & "__" & searchlimitdate & " 2222222<br>"		
										RowspannumAll = 1
										Rowspannum0 = 0
										Rowspannum1 = 0
										Rowspannum2 = 0
										Rowspannum3 = 0
										Rowspannum4 = 0
										Rowspannum5 = 0
										StartRowsNum = -1
										
										'Response.write trim(tmpDate&"") & BalClassStime0 & Right("00" & nowRunTime,3) & "//"
										'Response.write trim(tmpDate&"") & BalClassStime1 & Right("00" & nowRunTime,3) & "//"
										'Response.write trim(tmpDate&"") & BalClassStime2 & Right("00" & nowRunTime,3) & "//"
										'Response.write trim(tmpDate&"") & BalClassStime3 & Right("00" & nowRunTime,3) & "//"
										'Response.write trim(tmpDate&"") & BalClassStime4 & Right("00" & nowRunTime,3) & "//"
										'Response.write trim(tmpDate&"") & BalClassStime5 & Right("00" & nowRunTime,3) & "<br>"

										If BalClassStime0 <> "" And isarray(arrCDatesRs) = True  Then 
																		
											 If fn_classDateyn(strcdates,arrCDatesRs,trim(tmpDate&"") & BalClassStime0 & Right("00" & nowRunTime,3)) = True  And trim(tmpDate&"") >= searchStartDate Then 

													If Trim(tmpDate&"") <> Trim(Left(now(),10)&"") Then 
														Rowspannum0 = 1
													Else
															If Hour(now()) < 12  Then 																
																If CLng(CStr(Hour(dateadd("h",2,now()))&"00")) < CLng(Replace(BalClassStime0,":","")) then
																	Rowspannum0 = 1
																End If 
															End iF
													End If

											End If 
											'Response.write  trim(tmpDate&"") & BalClassStime0 & Right("00" & nowRunTime,3) & "<br>"
											
									
										End If

										If BalClassStime1 <> "" And isarray(arrCDatesRs) = True Then 
																		
											 If fn_classDateyn(strcdates,arrCDatesRs,trim(tmpDate&"") & BalClassStime1 & Right("00" & nowRunTime,3)) = True  And trim(tmpDate&"") >= searchStartDate Then 
													If Trim(tmpDate&"") <> Trim(Left(now(),10)&"") Then 
														Rowspannum1 = 1
													Else
															If Hour(now()) < 12  Then 																
																If CLng(CStr(Hour(dateadd("h",2,now()))&"00")) < CLng(Replace(BalClassStime1,":","")) then
																	Rowspannum1 = 1
																End If 
															End iF
													End If
											End If 
																				
										End If

										If BalClassStime2 <> "" And isarray(arrCDatesRs) = True Then 
																		
											 If fn_classDateyn(strcdates,arrCDatesRs,trim(tmpDate&"") & BalClassStime2 & Right("00" & nowRunTime,3)) = True  And trim(tmpDate&"") >= searchStartDate Then 
													If Trim(tmpDate&"") <> Trim(Left(now(),10)&"") Then 
														Rowspannum2 = 1
													Else
															If Hour(now()) < 12  Then 																
																If CLng(CStr(Hour(dateadd("h",2,now()))&"00")) < CLng(Replace(BalClassStime2,":","")) then
																	Rowspannum2 = 1
																End If 
															End iF
													End If
											End If 
									
										End If

										If BalClassStime3 <> "" And isarray(arrCDatesRs) = True Then 
																		
											 If fn_classDateyn(strcdates,arrCDatesRs,trim(tmpDate&"") & BalClassStime3 & Right("00" & nowRunTime,3)) = True  And trim(tmpDate&"") >= searchStartDate Then 
													If Trim(tmpDate&"") <> Trim(Left(now(),10)&"") Then 
														Rowspannum3 = 1
													Else
															If Hour(now()) < 12  Then 																
																If CLng(CStr(Hour(dateadd("h",2,now()))&"00")) < CLng(Replace(BalClassStime3,":","")) then
																	Rowspannum3 = 1
																End If 
															End iF
													End If
											End If 
									
										End If

										If BalClassStime4 <> "" And isarray(arrCDatesRs) = True Then 
																		
											 If fn_classDateyn(strcdates,arrCDatesRs,trim(tmpDate&"") & BalClassStime4 & Right("00" & nowRunTime,3)) = True  And trim(tmpDate&"") >= searchStartDate Then 
													If Trim(tmpDate&"") <> Trim(Left(now(),10)&"") Then 
														Rowspannum4 = 1
													Else
															If Hour(now()) < 12  Then 																
																If CLng(CStr(Hour(dateadd("h",2,now()))&"00")) < CLng(Replace(BalClassStime4,":","")) then
																	Rowspannum4 = 1
																End If 
															End iF
													End If
											End If 
									
										End If

										If BalClassStime5 <> "" And isarray(arrCDatesRs) = True Then 
											'Response.write " strcdates : "	& strcdates & " //" 								
											 If fn_classDateyn(strcdates,arrCDatesRs,trim(tmpDate&"") & BalClassStime5 & Right("00" & nowRunTime,3)) = True  And trim(tmpDate&"") >= searchStartDate Then 
													If Trim(tmpDate&"") <> Trim(Left(now(),10)&"") Then 
														Rowspannum5 = 1
													Else
															If Hour(now()) < 12  Then 																
																If CLng(CStr(Hour(dateadd("h",2,now()))&"00")) < CLng(Replace(BalClassStime5,":","")) then
																	Rowspannum5 = 1
																End If 
															End iF
													End If
											End If 
											'Response.write  trim(tmpDate&"") & BalClassStime5 & Right("00" & nowRunTime,3) & "<br>"
										End If
										
										RowspannumAll = RowspannumAll + Rowspannum0 + Rowspannum1+ Rowspannum2+ Rowspannum3+ Rowspannum4+ Rowspannum5 

									%>
									<% If RowspannumAll > 1 Then 
										tdnum = tdnum + 1
									%>
									<tr >
									<td height="20"  rowspan="<%=RowspannumAll-1%>" colspan="2">
									<span style="padding-left:6px;"><%=Month(tmpDate)&"월 "&printDate&"일 (" & fn_strweek(weekday(trim(tmpDate&""))) & ") "%></span>
									</td>		

									<% If Rowspannum0 > 0 Then %>
												
											<td id="td1_<%=tdnum%>"><%=BalClassStime0%>
											</td>
											<td  colspan="2" id="td2_<%=tdnum%>">
											<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime0%>','<%=clTime%>','<%=tdnum%>');" >
											<span id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
											</a>
											</td>											
											</tr>
									<% 
											StartRowsNum = 1
										Else
												If Rowspannum1 > 0 Then %>
												
											<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime1%>
											</td>
											<td  colspan="2" id="td2_<%=tdnum%>">
											<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime1%>','<%=clTime%>','<%=tdnum%>');" >
											<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
											</a>
											</td>											
											</tr>
												<% 
													StartRowsNum = 2
												Else
														If Rowspannum2 > 0 Then %>

													<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime2%>
													</td>
													<td  colspan="2" id="td2_<%=tdnum%>">
													<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime2%>','<%=clTime%>','<%=tdnum%>');" >
													<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
													</a>
													</td>													
													</tr>
														<% 
															StartRowsNum = 3
														Else
															If Rowspannum3 > 0 Then %>

															<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime3%>
															</td>
															<td  colspan="2" id="td2_<%=tdnum%>">
															<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime3%>','<%=clTime%>','<%=tdnum%>');" >
															<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
															</a>
															</td>														
															</tr>
																<% 
																	StartRowsNum = 4
																Else
																			IF Rowspannum4 > 0 Then %>

																			<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime4%>
																			</td>
																			<td  colspan="2" id="td2_<%=tdnum%>">
																			<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime4%>','<%=clTime%>','<%=tdnum%>');" >
																			<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
																			</a>
																			</td>																		
																			</tr>
																				<% 
																					StartRowsNum = 5
																				Else
																						If Rowspannum5 > 0 Then %>

																							<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime5%>
																							</td>
																							<td  colspan="2" id="td2_<%=tdnum%>">
																							<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime5%>','<%=clTime%>','<%=tdnum%>');" >
																							<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
																							</a>
																							</td>																							
																							</tr>
								<%		
																							StartRowsNum = 6
																						end If
																			 End If
																End If
														End If
												End If
													
										End iF
									
									%>

									<%If StartRowsNum = 1 Then %>
											<% If Rowspannum1 > 0 Then 
											tdnum = tdnum + 1
											%>
												<tr>	
												<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime1%>
												</td>
												<td  colspan="2" id="td2_<%=tdnum%>">
												<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime1%>','<%=clTime%>','<%=tdnum%>');" >
												<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
												</a>
												</td>												
												</tr> 
											<% End If %>

											<% If Rowspannum2 > 0 Then 
											tdnum = tdnum + 1
											%>
												<tr>	
												<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime2%>
												</td>
												<td  colspan="2" id="td2_<%=tdnum%>">
												<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime2%>','<%=clTime%>','<%=tdnum%>');" >
												<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
												</a>
												</td>												
												</tr> 
											<% End If %>

											<% If Rowspannum3 > 0 Then 
												tdnum = tdnum + 1
											%>
												<tr>	
												<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime3%>
												</td>
												<td  colspan="2" id="td2_<%=tdnum%>">
												<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime3%>','<%=clTime%>','<%=tdnum%>');" >
												<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
												</a>
												</td>											
												</tr> 
											<% End If %>

											<% If Rowspannum4 > 0 Then 
												tdnum = tdnum + 1
											%>
												<tr>	
												<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime4%>
												</td>
												<td  colspan="2" id="td2_<%=tdnum%>">
												<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime4%>','<%=clTime%>','<%=tdnum%>');" >
												<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
												</a>
												</td>												
												</tr> 
											<% End If %>
											
											<% If Rowspannum5 > 0 Then 
												tdnum = tdnum + 1
											%>
												<tr>	
												<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime5%>
												</td>
												<td  colspan="2" id="td2_<%=tdnum%>">
												<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime5%>','<%=clTime%>','<%=tdnum%>');" >
												<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
												</a>
												</td>												
												</tr> 
											<% End If %>

										<% End If %>

										<%If StartRowsNum = 2 Then %>
											
													<% If Rowspannum2 > 0 Then 
													tdnum = tdnum + 1
													%>
														<tr>	
														<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime2%>
														</td>
														<td  colspan="2" id="td2_<%=tdnum%>">
														<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime2%>','<%=clTime%>','<%=tdnum%>');" >
														<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
														</a>
														</td>												
														</tr> 
													<% End If %>

													<% If Rowspannum3 > 0 Then 
														tdnum = tdnum + 1
													%>
														<tr>	
														<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime3%>
														</td>
														<td  colspan="2" id="td2_<%=tdnum%>">
														<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime3%>','<%=clTime%>','<%=tdnum%>');" >
														<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
														</a>
														</td>											
														</tr> 
													<% End If %>

													<% If Rowspannum4 > 0 Then 
														tdnum = tdnum + 1
													%>
														<tr>	
														<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime4%>
														</td>
														<td  colspan="2" id="td2_<%=tdnum%>">
														<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime4%>','<%=clTime%>','<%=tdnum%>');" >
														<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
														</a>
														</td>												
														</tr> 
													<% End If %>

													<% If Rowspannum5 > 0 Then 
														tdnum = tdnum + 1
													%>
														<tr>	
														<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime5%>
														</td>
														<td  colspan="2" id="td2_<%=tdnum%>">
														<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime5%>','<%=clTime%>','<%=tdnum%>');" >
														<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
														</a>
														</td>												
														</tr> 
													<% End If %>

										<% End If %>

										<%If StartRowsNum = 3 Then %>
											
											<% If Rowspannum3 > 0 Then 
														tdnum = tdnum + 1
													%>
														<tr>	
														<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime3%>
														</td>
														<td  colspan="2" id="td2_<%=tdnum%>">
														<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime3%>','<%=clTime%>','<%=tdnum%>');" >
														<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
														</a>
														</td>											
														</tr> 
													<% End If %>

													<% If Rowspannum4 > 0 Then 
														tdnum = tdnum + 1
													%>
														<tr>	
														<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime4%>
														</td>
														<td  colspan="2" id="td2_<%=tdnum%>">
														<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime4%>','<%=clTime%>','<%=tdnum%>');" >
														<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
														</a>
														</td>												
														</tr> 
													<% End If %>

													<% If Rowspannum5 > 0 Then 
														tdnum = tdnum + 1
													%>
														<tr>	
														<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime5%>
														</td>
														<td  colspan="2" id="td2_<%=tdnum%>">
														<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime5%>','<%=clTime%>','<%=tdnum%>');" >
														<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
														</a>
														</td>												
														</tr> 
													<% End If %>

										<% End If %>

										<%If StartRowsNum = 4 Then %>
											<% If Rowspannum4 > 0 Then 
														tdnum = tdnum + 1
													%>
														<tr>	
														<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime4%>
														</td>
														<td  colspan="2" id="td2_<%=tdnum%>">
														<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime4%>','<%=clTime%>','<%=tdnum%>');" >
														<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
														</a>
														</td>												
														</tr> 
													<% End If %>

													<% If Rowspannum5 > 0 Then 
														tdnum = tdnum + 1
													%>
														<tr>	
														<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime5%>
														</td>
														<td  colspan="2" id="td2_<%=tdnum%>">
														<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime5%>','<%=clTime%>','<%=tdnum%>');" >
														<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
														</a>
														</td>												
														</tr> 
													<% End If %>

										<% End If %>

										<%If StartRowsNum = 5 Then %>
										
											<% If Rowspannum5 > 0 Then 
														tdnum = tdnum + 1
													%>
														<tr>	
														<td  colspan="2" id="td1_<%=tdnum%>"><%=BalClassStime5%>
														</td>
														<td  colspan="2" id="td2_<%=tdnum%>">
														<a href="javascript:goSelectClass('<%=tmpDate%>','<%=BalClassStime5%>','<%=clTime%>','<%=tdnum%>');" >
														<span  id="span_<%=tdnum%>" style="display: block; background-color: red;width:100px;height:30px; line-height: 30px;margin:0 auto;text-align:center;">선택</span>
														</a>
														</td>												
														</tr> 
													<% End If %>

										<% End If %>
									
									<%
									End If

								
							 End If 

						End If
				
				%>
				</tr>
				<%
				End If
				
				Next
				%>
						
            <% If tdnum <= 0 Then %>
				<tr>	
				<td  colspan="2" id="td1_">
				</td>
				<td  colspan="2" id="td2_">
				선택가능한 날짜 및 시간이 없습니다.				
				</td>		
				<td  colspan="2" id="td1_">
				</td>
				</tr> 

			<% End If %>			
            </tbody>	

        </table>
	     <!--달력 form 끝-->
		
		<br><br>
		
				<form name="frmselclass" id ="frmselclass" method="post" action="/MyPage/MypageClassOrder_ok.asp">			
	
						<div class="usetalking_ing">
							<table class="type07" style="width:100%;" border=1>
							   <tbody>
							 
							    <tr>
								   <th style="border-top: 1px solid #ccc;width:200px;">선택한 수강과정  </th>
								   <td style="border-top: 1px solid #ccc;" colspan="2">
								   <select name="m_classCLCourse" id="m_classCLCourse" style="width:250px;height:24px;font-size:14px;">
									<%=setOption(arrCLCourse, PiCLCourseseq)%>
									</select>
									
								   </td>			  
							   </tr>

							   <tr>
								   <th style="border-top: 1px solid #ccc;width:200px;">1. 선택한 수업일 / 시간 / 진도</th>
								   <td style="border-top: 1px solid #ccc;width:180px;" id="seltd_1"></td>			  
								    <td style="border-top: 1px solid #ccc;">
									
									레벨 : <select name="m_classTB0" id="m_classTB0" style="width:80%;height:24px;font-size:14px;" onchange="setTBChapter('0');">
									<%=setOption(arrTBooks, arr_classTB(0))%>
									</select>
									<br><br>
									진도 :  <select name="m_classTC0" id="m_classTC0" style="width:80%;height:24px;font-size:14px;" >
									<%=setOption(arrTBChapter, arr_classTC(0))%>
									</select>
									
									</td>			  
							   </tr>

							   <tr>
								   <th style="border-top: 1px solid #ccc;width:200px;">2. 선택한 수업일 / 시간 / 진도</th>
								   <td style="border-top: 1px solid #ccc;"  id="seltd_2"></td>	
								   <td style="border-top: 1px solid #ccc;" >
								   레벨 : <select name="m_classTB1" id="m_classTB1" style="width:80%;height:24px;font-size:14px;" onchange="setTBChapter('1');">
								   <%=setOption(arrTBooks, arr_classTB(1))%>
									</select>
									<br><br>
									진도 :  <select name="m_classTC1" id="m_classTC1" style="width:80%;height:24px;font-size:14px;" >
									<%=setOption(arrTBChapter, arr_classTC(1))%>
									</select>
								   </td>		
							   </tr>

							   <tr>
								   <th style="border-top: 1px solid #ccc;width:200px;">3. 선택한 수업일 / 시간 / 진도</th>
								   <td style="border-top: 1px solid #ccc;"  id="seltd_3"></td>	
								   <td style="border-top: 1px solid #ccc;" >
								   레벨 : <select name="m_classTB2" id="m_classTB2" style="width:80%;height:24px;font-size:14px;" onchange="setTBChapter('2');">
								   <%=setOption(arrTBooks, arr_classTB(2))%>
									</select>
									<br><br>
									진도 :  <select name="m_classTC2" id="m_classTC2" style="width:80%;height:24px;font-size:14px;" >
									<%=setOption(arrTBChapter, arr_classTC(2))%>
									</select>
								   </td>		
							   </tr>

							   <tr>
								   <th style="border-top: 1px solid #ccc;width:200px;">4. 선택한 수업일 / 시간 / 진도</th>
								   <td style="border-top: 1px solid #ccc;"  id="seltd_4"></td>	
								   <td style="border-top: 1px solid #ccc;" >
								   레벨 : <select name="m_classTB3" id="m_classTB3" style="width:80%;height:24px;font-size:14px;" onchange="setTBChapter('3');">
								   <%=setOption(arrTBooks, arr_classTB(3))%>
									</select>
									<br><br>
									진도 :  <select name="m_classTC3" id="m_classTC3" style="width:80%;height:24px;font-size:14px;" >
									<%=setOption(arrTBChapter, arr_classTC(3))%>
									</select>
								   </td>		
							   </tr>
							  
								
							   </tbody>
						   </table>	
						 
						</div>
		
		<br>

		 <% If tdnum > 0 Then %>
		<table width="100%" cellpadding=0 cellspacing=0 border=0 style="padding:10px;">
		

		<tr><td >
		<a href="javascript:fn_goRegistClass();"><span  style="display: block; background-color:#29a5e0;width:150px;height:40px; line-height: 40px;margin:0 auto;text-align:center;font-size:20px;color:#ffffff;text-decoration:none;">
		수강신청</span></a>
		</td></tr>			
		</table>
		<% End If %>
		<br>
		
		<input type="hidden" id="searchiCourseSeq" name="searchiCourseSeq" value='<%=PiCourseSeq%>'>	
		<input type="hidden" id="searchnowRunTime" name="searchnowRunTime" value='<%=nowRunTime%>'>	
		
		<input type="hidden" id="searchStartDate" name="searchStartDate" value='<%=searchStartDate%>'>
		<input type="hidden" id="searchEndDate" name="searchEndDate" value='<%=searchEndDate%>'>
		<input type="hidden" id="Dailysearchdate" name="Dailysearchdate" value='<%=Dailysearchdate%>'>
		<input type="hidden" id="searchStartDateSweek" name="searchStartDateSweek" value='<%=searchStartDateSweek%>'>
		<input type="hidden" id="searchStartDateEweek" name="searchStartDateEweek" value='<%=searchStartDateEweek%>'>

		<input type="hidden" id="s_classteacher" name="s_classteacher" value='<%=iTeacherSeq%>'>	<!--저장시간1-->
		
		<input type="hidden" id="s_classDateindex0" name="s_classDateindex0" value=''>	<!--number id-->		
		<input type="hidden" id="s_classDate0" name="s_classDate0" value=''>	<!--저장날짜1-->		
		<input type="hidden" id="s_classTime0" name="s_classTime0" value=''>	<!--저장시간1-->
		<input type="hidden" id="s_classMinute0" name="s_classMinute0" value=''>	<!--저장시간1-->
		
		<input type="hidden" id="s_classDateindex1" name="s_classDateindex1" value=''>	<!--number id-->		
		<input type="hidden" id="s_classDate1" name="s_classDate1" value=''>	<!--저장날짜1-->		
		<input type="hidden" id="s_classTime1" name="s_classTime1" value=''>	<!--저장시간1-->
		<input type="hidden" id="s_classMinute1" name="s_classMinute1" value=''>	<!--저장시간1-->		
		
		<input type="hidden" id="s_classDateindex2" name="s_classDateindex2" value=''>	<!--number id-->		
		<input type="hidden" id="s_classDate2" name="s_classDate2" value=''>	<!--저장날짜1-->		
		<input type="hidden" id="s_classTime2" name="s_classTime2" value=''>	<!--저장시간1-->
		<input type="hidden" id="s_classMinute2" name="s_classMinute2" value=''>	<!--저장시간1-->		
		
		<input type="hidden" id="s_classDateindex3" name="s_classDateindex3" value=''>	<!--number id-->		
		<input type="hidden" id="s_classDate3" name="s_classDate3" value=''>	<!--저장날짜1-->		
		<input type="hidden" id="s_classTime3" name="s_classTime3" value=''>	<!--저장시간1-->
		<input type="hidden" id="s_classMinute3" name="s_classMinute3" value=''>	<!--저장시간1-->	

		</form>

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
	eTimestr=""
	eTime = Right("0"&Hour(DateAdd("n",clTime-1,ctime))&"",2) & ":" & Right("0"&minute(DateAdd("n",clTime-1,ctime))&"",2)
	'Response.write "++++"&eTime&"</br>"
	eTimestr = Left(eTime,2)
	cstime = CInt(Replace(ctime,":",""))
	eTime = CInt(Replace(eTime,":",""))
	'Response.write "++++"&eTime&"</br>"
	brFlag = True
	'Response.write time&" : "&eTime&"</br>"
	If isArray(arrBreak) Then
		for iForr = 0 to ubound(arrBreak, 2)	
		
			If InStr(arrTeacher(5,0),LEFT(eTimestr,2)) <= 0 Then 
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


Function fn_classDateyn(fncdates,arrrsdates,nowdates)
	
	If Len(nowdates&"") > 15 And fncdates <> "" And isArray(arrrsdates) = True Then
			If InStr(fncdates,nowdates) > 0 then
			arrnowdates = ""
			arrnowdates = Split(fncdates,",")

			For ifn=0 To ubound(arrnowdates)
				If Trim(arrnowdates(ifn)&"") = nowdates Then
					'db와 검사한다.
					If arrrsdates(ifn,0) > 0  Then
						fn_classDateyn = true
					Else
						fn_classDateyn = false
					End If

					ifn = 1000

				End If

			Next 

			'fn_classDateyn = true

		Else
			fn_classDateyn = false
		End If

		
		'fn_classDateyn = true
	Else
	
		fn_classDateyn = false
	End If

End Function


Call DBClose()
 %>

<!--#include virtual="/include/inc_footer.asp"-->
	