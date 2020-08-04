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

Sql = "Exec PRC_tb_RequestPostPone_User_Select_List N'"& SiteCPCode &"', '"& sUserSeq &"', '"& currPage &"', '"& rowSize &"'"
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing	:	Call DBClose()

Dim TotalCount	: TotalCount	= 0
Dim TotalPage	: TotalPage		= 1
If IsArray(arrData) Then
	TotalCount = arrData(7, 0)	:	TotalPage = arrData(8, 0)
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
<input type="hidden" name="currpage"	value="<%=currPage%>" />
<input type="hidden" name="execMode"	value="MOD" />
<input type="hidden" name="req_seq"		value="" />
<input type="hidden" name="sche_seq"	value="" />
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
	<tr>
		<td height="30" style="padding-left:15px;"><A href="WriteSelect.asp"><img src="/img/board/btn_record.gif" width="71" height="24" /></A></td>
	<tr>
		<td align="center" valign="top" >
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<!-- board_title -->
						<table width="650" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="11"><img src="../../img/board/b_bar1.gif" width="11" height="31" /></td>
								<td width="56" align="center" background="../../img/board/b_bar2.gif"><img src="../../img/board/b_title_no.gif" alt="번호" /></td>
								<td width="280" align="center" background="../../img/board/b_bar2.gif"><img src="../../img/board/b_title_memo.gif" alt="휴강사유" /></td>
								<td width="113" align="center" background="../../img/board/b_bar2.gif"><img src="../../img/board/b_title_name.gif" alt="작성자" /></td>
								<td width="115" align="center" background="../../img/board/b_bar2.gif"><img src="../../img/board/b_title_date.gif" alt="등록일" /></td>
								<td width="64" align="center" background="../../img/board/b_bar2.gif"><img src="../../img/board/b_title_state.gif" alt="처리여부" /></td>
								<td width="11"><img src="../../img/board/b_bar3.gif" width="11" height="31" /></td>
							</tr>
						</table>
					<!-- board_title end -->
					</td>
				</tr>
				<tr>
					<td valign="top">
						<table width="650" border="0" cellspacing="0" cellpadding="0" class="notice_style">
						<colgroup><col width="67" /><col width="280" /><col width="113" /><col width="115" /><col width="74" /></colgroup>
<!-- board_list -->
<%
With Response
If IsArray(arrData) Then
'Array Info
'0.iPostPoneSeq, 	1.iScheduleSeq,		2.nvcReason,	3.nvcMemberName,	4.dtRegDate,	5.cFlag,	6.RID,	7.TOTALRECORD,	8.TOTALPAGE

	Dim objGF
	Set objGF = New clsGF	

	Dim k : k = TotalCount - (rowSize * (currPage - 1))

	Dim tmpReason, strFlag
	For i = 0 To Ubound(arrData, 2)

		tmpReason = objGF.GF_CropStringByte(arrData(2, i), 35)

		If arrData(5, i) = "Y" Then
			strFlag = "처리완료"
		Else
			strFlag = "접수대기"
		End If

		.Write "<tr align='center'>"
		.Write "		<td>"& k &"</td>"
		.Write "		<td align='left'>"
		If arrData(5, i) = "Y" Then
			.Write tmpReason
		Else
			.Write "<a class='cssRequest' data-rseq='"& arrData(0, i) &"' data-sseq='"& arrData(1, i) &"' style='cursor:pointer;'>"& tmpReason &"</a>"
		End If
		.Write "		</td>"
		.Write "		<td>"& Left(arrData(4, i), 10) &"</td>"
		.Write "		<td>"& arrData(3, i) &"</td>"
		.Write "		<td>"& strFlag &"</td>"
		.Write "</tr>"

		k = k - 1
	Next

	Set objFG = Nothing
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