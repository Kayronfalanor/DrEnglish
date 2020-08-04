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

otergubun = sqlCheck(Replace(Request("otergubun"), "'", "''"))

'response.write "otergubun : " & otergubun

If InStr(Request.ServerVariables("HTTP_USER_AGENT"),"iPod") Or InStr(Request.ServerVariables("HTTP_USER_AGENT"),"iPhone") Or InStr(Request.ServerVariables("HTTP_USER_AGENT"),"iPad") Or InStr(Request.ServerVariables("HTTP_USER_AGENT"),"Macintosh")  Then 
		BrowseFlag="IOS"
		MobileFlag="IOS"
 End If

 If InStr(Request.ServerVariables("HTTP_USER_AGENT"),"Android")  Then 
		BrowseFlag="Android"
		MobileFlag=""
End If

Dim pageSize: pageSize= 10
Dim rowSize	: rowSize = 20
Dim currPage: currPage= sqlCheck(Replace(Request("currPage"), "'", "''"))
If Len(currPage) = 0 Then
	currPage = 1
End If
currPage = CInt(currPage)

Dim arrData, objRs, Sql
Sql = "Prc_tb_Schedule_User_Select_List N'"& SiteCPCode &"', '"& sUserSeq &"', N'', '"& currPage &"', '"& rowSize &"'"
Set objRs = dbSelect(Sql)
'Response.write Sql
If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing
Call DBClose()

Dim TotalCount	: TotalCount	= 0
Dim TotalPage	: TotalPage		= 1
If IsArray(arrData) Then
	TotalCount = arrData(12, 0)	:	TotalPage = arrData(13, 0)
End If

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


<% if (otergubun = "1") then %>

			var wopentt = window.open("/include/VideoDownloadAI.asp","aipopup","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=560,height=600,top=100,left=100");
			wopentt.focus();
	
<% end If %>



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
	<tr>
		<td ><img src="../img/sub/sub01_img01.gif" alt="출결및학습현황을 한눈에체크" /></td>
	</tr>
	<tr>
		<td >&nbsp;</td>
	</tr>
	<% If BrowseFlag = "" Then %>
	<tr>
		<td width=681>
		<TABLE CELLPADDING=0 cellspacing=0 border=0 width=681>
		<tr>
			<td height=30 width=420 ><b>* 화상 프로그램 이 설치되시지 않은 분은 버튼을 클릭하여 설치하세요.</td>
			<td width=110><input type="button" value="화상 프로그램 다운로드" onclick="javascript:goProDown();" style="width:200px;height:80px;background:red;font-size:17px;color:#FFFFFF;"></td>
		</tr>
		</table>
		
		</td>
	</tr>	
	<tr>
		<td >&nbsp;</td>
	</tr>
	<% End If %>
	<tr>
		<td align="center" valign="top" > 
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<!-- board_title -->
						<table width="650" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="11"><img src="../img/board/b_bar1.gif" width="11" height="31" /></td>
								<td width="66" align="center" background="../img/board/b_bar2.gif"><img src="../img/board/b_title_name02.gif" alt="회원이름" /></td>
								<td width="76" align="center" background="../img/board/b_bar2.gif"><img src="../img/board/b_title_teacher.gif" alt="강사" /></td>
								<td width="192" align="center" background="../img/board/b_bar2.gif"><img src="../img/sub/b_title_period.gif" alt="강사" width="50" height="15" /></td>
								<td width="244" align="center" background="../img/board/b_bar2.gif"><img src="../img/sub/b_title_process.gif" alt="강사" width="50" height="15" /></td>
								<td width="50" align="center" background="../img/board/b_bar2.gif"><img src="../img/board/b_title_check.gif" alt="내용확인" /></td>
								<td width="11"><img src="../img/board/b_bar3.gif" width="11" height="31" /></td>
							</tr>
						</table>
					<!-- board_title end -->
					</td>
				</tr>
				<tr>
					<td>
					<!-- board_list -->
						<table width="650" border="0" cellspacing="0" cellpadding="0" class="notice_style">
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<form method="post" Action="mypage.asp" name="Bform">
<input type="hidden" name="currPage" id="currPage" value="<%=currPage%>"/>
<input type="hidden" name="sche_seq" id="sche_seq" value="" />
<%
With Response
If IsArray(arrData) Then
'0.iScheDuleSeq,	1.nvcMemberName,	2.nvcTeacherID,		3.nvcScheStartDate,		4.nvcScheEndDate
'5.nvcScheTime,		6.siSchePlayTime,	7.nvcProductName,	8.siScheFlag,			9.RID
'10 . siScheType    11.TOTALRECORD,	12.TOTALPAGE

	Dim strFlag
	For i = 0 To Ubound(arrData, 2)

		If arrData(8, i) = "0" Then
			strFlag = "N"
		Else
			strFlag = "Y"
		End If

		.Write "<tr align='center' height='28'>"
		.Write "	<td width='77'>"& arrData(1, i) &"</td>"
		.Write "	<td width='76'>"& arrData(11, i) &"</td>"
		'.Write "	<td width='196'>"&Replace(arrData(3, i),"-","")&"~"&Replace(arrData(4, i),"-","")&" / ["&arrData(5, i)&"/"&arrData(6, i)&"]</td>"
		.Write "	<td width='196'>"&arrData(3, i)&" ~ "&arrData(4, i)&"</td>"
		.Write "	<td width='241'>"&iif(arrData(10,i)&"","0","<font color=blue>[보강]</font>","")& arrData(7, i) &"["& getScheTypeText(arrData(8, i)) &"]</td>"
		.Write "	<td width='60'><img src='/img/board/btn_view.gif' style='border:0;cursor:pointer;' class='cssBtns' data-seq='"& arrData(0, i) &"' data-flag='"& strFlag &"' caption='REPORT' /></td>"
		.Write "</tr>"

		.Write "<tr><td colspan='6' height='1' style='background-color:#e0e0e0;'></td></tr>"
	Next
Else
	.Write "<tr><td align='center' colspan='6' height='150'>수강신청 내역이 없습니다.</td></tr>" & vbCrlf
End If
End With
%>
						</table>
					<!-- board_list end-->
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td >&nbsp;</td>
	</tr>
	<tr>
		<td height="30" align="center" >
		<!-- btn_page -->
		<!-- btn_page -->
			<table height="16" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr align="center">
					<td> <!--#include virtual="/include/Paging.asp"--> </td>
				</tr>
			</table>
		<!-- btn_page end -->
		<!-- btn_page end -->
		<br />
		<br />
		</td>
	</tr>
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->