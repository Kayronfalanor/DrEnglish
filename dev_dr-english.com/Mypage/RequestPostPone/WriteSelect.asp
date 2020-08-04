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
Dim sMenu : sMenu = "5"
%>
<!--#include file="Inc.asp"-->
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
Dim Sql, objRs, arrData

Sql = "Prc_tb_Schedule_User_Select_List N'"& SiteCPCode &"', '"& sUserSeq &"', N'Y', '"& currPage &"', '"& rowSize &"'"
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing	:	Call DBClose()

Dim TotalCount	: TotalCount	= 0
Dim TotalPage	: TotalPage		= 1
If IsArray(arrData) Then
	TotalCount = arrData(10, 0)	:	TotalPage = arrData(11, 0)
End If
%>
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/Commonfiles/Scripts/mypage.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$mypage.PostPone.init.call(this);
});
</script>
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
<form name="Bform" method="post" action="WriteSelect.asp">
<input type="hidden" name="currpage" value="<%=currPage%>" />
<input type="hidden" name="execMode" value="INS" />
<input type="hidden" name="sche_seq" value="" />
</form>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="contents_title"><img src="/img/sub/title_1_05.gif" alt="휴강신청" /></td>
	</tr>
	<tr>
	<td>&nbsp;</td>
	</tr>
	<tr>
		<td><img src="/img/sub/sub01_img09.gif" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
		<td align="center" valign="top" >
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<!-- board_title -->
						<table width="650" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="11"><img src="../../img/board/b_bar1.gif" width="11" height="31" /></td>
								<td width="66" align="center" background="../../img/board/b_bar2.gif"><img src="../../img/board/b_title_name02.gif" alt="회원이름" /></td>
								<td width="76" align="center" background="../../img/board/b_bar2.gif"><img src="../../img/board/b_title_teacher.gif" alt="강사" /></td>
								<td width="192" align="center" background="../../img/board/b_bar2.gif"><img src="../../img/sub/b_title_period.gif" alt="강사" width="50" height="15" /></td>
								<td width="244" align="center" background="../../img/board/b_bar2.gif"><img src="../../img/sub/b_title_process.gif" alt="강사" width="50" height="15" /></td>
								<td width="50" align="center" background="../../img/board/b_bar2.gif"><img src="../../img/board/b_title_check.gif" alt="내용확인" /></td>
								<td width="11"><img src="../../img/board/b_bar3.gif" width="11" height="31" /></td>
							</tr>
						</table>
					<!-- board_title end -->
					</td>
				</tr>
				<tr>
					<td valign="top">
						<table width="650" border="0" cellspacing="0" cellpadding="0" class="notice_style">
						<colgroup><col width="77" /><col width="76" /><col width="196" /><col width="241" /><col width="60" /></colgroup>
<!-- board_list -->
<%
With Response
If IsArray(arrData) Then
'0.iScheDuleSeq,	1.nvcMemberName,	2.nvcTeacherID,		3.nvcScheStartDate,		4.nvcScheEndDate
'5.nvcScheTime,		6.siSchePlayTime,	7.nvcProductName,	8.siScheFlag,			9.RID
'10.TOTALRECORD,	11.TOTALPAGE

	For i = 0 To Ubound(arrData, 2)
		.Write "<tr align='center'>"
		.Write "		<td>"& arrData(1, i) &"</td>"
		.Write "		<td>"& arrData(2, i) &"</td>"
		.Write "	<td>"&Replace(arrData(3, i),"-","")&"~"&Replace(arrData(4, i),"-","")&" / ["&arrData(5, i)&"/"&arrData(6, i)&"]</td>"
		.Write "		<td>"& arrData(7, i) &"</td>"
		.Write "		<td><a class='cssRequest' data-sseq='"& arrData(0, i) &"' style='cursor:pointer;'>휴강신청</a></td>"
		.Write "</tr>"
	Next
Else
	.Write "<tr height='150'><td colspan='5' align='center'>등록된 휴강신청 내역이 없습니다.</td></tr>"
End If
End With
%>							
<!-- board_list end-->
						</table>
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
			<table height="16" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr align="center">
					<td>		
						<!--#include virtual="/include/Paging.asp"-->
					</td>
				</tr>
			</table>
		<!-- btn_page end -->
		</td>
	</tr>
	<tr>
		<td >&nbsp;</td>
	</tr>
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->