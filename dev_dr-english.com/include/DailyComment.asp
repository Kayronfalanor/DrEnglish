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
	'chkRollPop "M07"



	iScheduleSeq=sqlcheck(Replace(Trim(request("iScheduleSeq")),"'","''"))
	iSchedetailSeq=sqlcheck(Replace(Trim(request("iSchedetailSeq")),"'","''"))
	AttenDate=sqlcheck(Replace(Trim(request("AttenDate")),"'","''"))
	iDailyReportSeq=sqlcheck(Replace(Trim(request("iDailyReportSeq")),"'","''"))



	chkRequestValPop iScheduleSeq&"", "Wrong Information 1.!"
	chkRequestValPop iSchedetailSeq&"", "Wrong Information 2.!"
	chkRequestValPop AttenDate&"", "Wrong Information 3.!"
	chkRequestValPop iDailyReportSeq&"", "Wrong Information 4.!"

	gopage="writing.asp"
	'수업정보

       sql = "SELECT top 1 a.nvcDailyReportDate,a.siAttendance, a.nvcScheTel,a.nvcTitleContent1,a.nvcTitleContent2,"
	   sql = sql & " 			e.nvcMemberID,e.nvcMemberName,e.nvcMemberEName,a.nvcScheTime "
  	   sql = sql & " 			,a.siTitlePoint1,a.siTitlePoint2,a.siTitlePoint3,a.siTitlePoint4 "
   	   sql = sql & " 			,a.siTitlePoint5,a.siTitlePoint6,a.siTitlePoint7,a.siTitlePoint8 "
	   sql = sql & " 			from tb_DailyReport a left outer join tb_Schedetail d "
	   sql = sql & "		on a.ischeduleSeq=isnull(d.iScheduleSeq,0) and a.iScheDetailSeq=d.iScheDetailSeq "
	   sql = sql & "			left outer join tb_Member e "
	   sql = sql & "			on d.iMemberSeq=e.iMemberSeq  "
	   sql = sql & "			where a.iDailyReportSeq='"&iDailyReportSeq&"' and a.iScheduleSeq='"&iScheduleSeq&"' and a.iScheDetailSeq='"&iSchedetailSeq&"'	"

        set rs = dbSelect(sql)

        if not rs.eof  then
           siAttendance=Trim(Rs(1))
		   nvcScheTel=Trim(Rs(2))
		   nvcTitleContent1=Trim(Rs(3))
		   nvcMemberName=Trim(Rs(6))
		   nvcMemberEName=Trim(Rs(7))

		   nvcScheTime=Trim(Rs(8))
		   nvcPoint1 = Trim(Rs(9))
		   nvcPoint2 = Trim(Rs(10))
		   nvcPoint3 = Trim(Rs(11))
		   nvcPoint4 = Trim(Rs(12))
		   nvcPoint5 = Trim(Rs(13))
		   nvcPoint6 = Trim(Rs(14))
		   nvcPoint7 = Trim(Rs(15))
		   nvcPoint8 = Trim(Rs(16))


           if siAttendance <> "0" then

		       If nvcPoint1="" Or nvcPoint1="0" Then
			    nvcPoint1="6"
		       End If

		       If nvcPoint2="" Or nvcPoint2="0" Then
			    nvcPoint2="6"
		       End If

		       If nvcPoint3="" Or nvcPoint3="0" Then
			    nvcPoint3="6"
		       End If

		       If nvcPoint4="" Or nvcPoint4="0" Then
			    nvcPoint4="6"
		       End If

		       If nvcPoint5="" Or nvcPoint5="0" Then
			    nvcPoint5="6"
		       End If

		       If nvcPoint6="" Or nvcPoint6="0" Then
			    nvcPoint6="6"
		       End If

		       If nvcPoint7="" Or nvcPoint7="0" Then
			    nvcPoint7="6"
		       End If

		       If nvcPoint8="" Or nvcPoint8="0" Then
			    nvcPoint8="6"
		       End if
            end If

        end if

        rs.close
        set rs=nothing


     Call DBClose()

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title><%=subTitleName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

	<link rel="stylesheet" href="/Commonfiles/Scripts/billboardJs/billboard.css">
	<link href="/css/main.css" rel="stylesheet" type="text/css" />

	<script src="/Commonfiles/Scripts/jquery-3.4.1.min.js"></script>
	<script src="/Commonfiles/Scripts/billboardJs/d3.v5.min.js"></script>
	<script src="/Commonfiles/Scripts/billboardJs/billboard.js"></script>

	<style>
		.ptit{height: 45px; background-color: #3369c3; font-size: 18px; font-family: 'Malgun Gothic','맑은 고딕'; color: #fff; padding-top: 15px; padding-left: 30px;}
		.tbl_basic{border-top: 1px solid #42b085; border-bottom: 1px solid #42b085;}
		.tbl_basic th{
			background-color: #f5fefa;
			border-right: 1px solid #42b085;
			border-top: 1px solid #42b085;
			font-size: 14px;
			font-family: 'Malgun Gothic','맑은 고딕';
			color: #444;
			font-weight: normal;
			text-align: center;
			height: 45px;
		}
		.tbl_basic td{
			border-top: 1px solid #42b085;
			padding-left: 20px;
			color: #444;
			font-size: 14px;
			font-family: 'Malgun Gothic','맑은 고딕';
		}
		.btn_popblock {text-align:center;}
		.btn_popblock a{
			background-color: #555;
			width: 90px;
			height: 23px;
			padding-top: 2px;
			display: inline-block;
			font-size: 14px;
			font-family: 'Malgun Gothic','맑은 고딕';
			color: #fff;
			font-weight: bold;
			text-decoration: none;text-align: center;
		}
		.Chart_dataLabel{font-size:14px;}
		.Chart_tick{font-size:14px;}
	</style>

	<script type="text/javascript">

		$(document).ready(function(){

			var tick1 = parseInt("<%=nvcPoint1%>", 10);
			var tick2 = parseInt("<%=nvcPoint2%>", 10);
			var tick3 = parseInt("<%=nvcPoint3%>", 10);
			var tick4 = parseInt("<%=nvcPoint4%>", 10);
			var tick5 = parseInt("<%=nvcPoint5%>", 10);
			var tick6 = parseInt("<%=nvcPoint6%>", 10);


			var chart1 = bb.generate({
				data: {
					columns: [
						["<%=nvcMemberEName%>", tick1, tick2, tick3, tick4, tick5, tick6]
					],
					types: {
						"<%=nvcMemberEName%>": "bar"
					},
					labels: {
						format: function(v, id) {
							return Math.abs(v);
						}
					}
				},
				axis: {
					rotated: true,
					x: {
						type: "category",
						categories: ["Speaking (말하기)", "Pronunciation (발음)", "Grammar (문법)", "Vocabulary (단어)", "Listening (듣기)", "Overall (종합)"],
						tick: {
							multiline: false,
							text:{show:false},
						},

					},
					y: {
						max : 10,
						tick: {
							show: true,
							values: [0, 2, 4, 6, 8, 10]
						}
					},
				},
				tooltip: {
					show: false
				},
				bindto: "#chart"
			});
			chart1.legend.hide("<%=nvcMemberEName%>");

			d3.selectAll(".bb-text").attr("class", "Chart_dataLabel");
			d3.selectAll(".tick text tspan").attr("class", "Chart_tick");

		});



	</script>

</head>

<body style="padding:0px; margin:0px;">

	<h2 class="ptit">Daily Report<span></span></h2>

	<div style="padding:10px 30px;">
		<div class="tbl_basic">

			<table width="100%" style="border-spacing: 0; border-collapse: collapse;">
				<colgroup>
				<col width="18%" />
				<col width="32%" />
				<col width="18%" />
				<col width="32%" />
				</colgroup>
				<tr>
					<th>Student’s Name</th>
					<td colspan="3"><%=nvcMemberEName&" ["&nvcMemberName&"] "%></td>
				</tr>
				<tr>
					<th>Class date</th>
					<td><%=attenDate%></td>
					<th>Class Time</th>
					<td><%=nvcScheTime%></td>
				</tr>
			</table>

		</div>
		<br />
		<div class="tbl_grp">

			<table border="0">
				<tr>
					<td style="position:relative; width:120px;">
						<div style="position:absolute; left:0px; top:7px; width:150px; text-align:right; line-height:49px; border:0px solid #ff0000;">
							Speaking (말하기)
							<br />
							Pronunciation (발음)
							<br />
							Grammar (문법)
							<br />
							Vocabulary (단어)
							<br />
							Listening (듣기)
							<br />
							Overall (종합)
						</div>
					</td>
					<td style="position:relative;">
						<div id="chart" style="float:left; width:600px; height:350px; border:0px solid #ff0000;"></div>
					</td>
				</tr>
			</table>

			<br />

			<table class="tbl_basic" width="100%" summary="테스트 정보" style="border-spacing: 0; border-collapse: collapse;">
				<colgroup>
				<col width="18%" />
				<col width="82%" />
				</colgroup>
				<tr>
					<th>Comment</th>
					<td>
						<pre style="font-family: 'Malgun Gothic','맑은 고딕';"><%=nvcTitleContent1%></pre>
					</td>
				</tr>
			</table>

			<br />

			<div class="btn_popblock">
				<a href="javascript:print()" class="btn_pop">프린트</a>
				&nbsp;&nbsp;
				<a href="javascript:window.close()" class="btn_pop">닫기</a>
			</div>

		</div>
	</div>

	<br /><br />

</body>
</html>

