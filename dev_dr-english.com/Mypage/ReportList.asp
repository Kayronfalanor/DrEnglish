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
Dim sMenu : sMenu = "2"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
Dim pageSize	: pageSize	= 10
Dim rowSize		: rowSize	= 20
Dim currPage	: currPage	= sqlCheck(Replace(Request("currpage"), "'", "''"))
If Len(Trim(currPage)) = 0 Then
	currPage = 1
End If
currPage = CInt(currPage)

Dim Sql, objRs, arrData
Sql = "Exec PRC_tb_MonthlyReport_User_Select_List '"& sUserSeq &"', '"& currPage &"', '"& rowSize &"'"

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
	$mypage.report.init.call(this);
});

function fn_monthly(HBTalkID)
{	

	if (HBTalkID !='')
	{	
		window.open("<%=HBMonthly%>" + HBTalkID, "popHBTalk", "width=975,height=700, toolbars=no, resizable=yes, scrollbars=yes, menubars=no");
	}
}


</script>
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
<form name="Bform" action="ReportList.asp" method="post">
<input type="hidden" name="currPage"	value="<%=currpage%>" />
<input type="hidden" name="imr_seq"		value="" />
</form>
	<tr>
		<td>&nbsp;</td>
    </tr>
    <tr>
		<td class="contents_title"><img src="../img/sub/title_1_02.gif" alt="나의성적표" /></td>
    </tr>
    <tr>
		<td>&nbsp;</td>
    </tr>
    <tr>
		<td ><img src="../img/sub/sub01_img06.gif" alt="레벨테스트에서부터학습현황평가서까지원어민성생님의진단" /></td>
    </tr>
    <tr>
		<td >&nbsp;</td>
    </tr>
    <tr>
		<td height="35" align="right" >
			<!--<table width="164" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="right"><img src="../img/board/btn_result02.gif" alt="검색" border="0" style="cursor:pointer;" class="cssRBtns" caption="LEVELTEST" /></td>
					<td width="16">&nbsp;</td>
				</tr>
			</table>
        <!-- search box end -->
		</td>
    </tr>
    <tr>
		<td align="center" valign="top" >      
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<!-- board_title -->
						<table width="650" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="11"><img src="../img/board/b_bar1.gif" width="11" height="31" /></td>
								<td width="94" align="center" background="../img/board/b_bar2.gif"><img src="../img/board/b_title_name02.gif" alt="회원이름" /></td>
								<td width="152" align="center" background="../img/board/b_bar2.gif"><img src="../img/board/b_title_teacher.gif" alt="강사" /></td>
								<td width="165" align="center" background="../img/board/b_bar2.gif"><img src="../img/board/b_title_time.gif" alt="평가기간" /></td>
								<td width="165" align="center" background="../img/board/b_bar2.gif"><img src="../img/board/b_title_book.gif" alt="수업교재" /></td>
								<td width="64" align="center" background="../img/board/b_bar2.gif"><img src="../img/board/b_title_check.gif" alt="내용확인" /></td>
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
						<colgroup><col width="103" /><col width="145" /><col width="163" /><col width="162" /><col width="77" /></colgroup>
<%
With Response
If IsArray(arrData) Then
'0,iMonthlyReportSeq,	1.B.nvcMemberName,	2.nvcTeacherName,			3.nvcMonthlyReportSDate,	4.nvcMonthlyReportEDate
'5.nvcTBooksName,		6.RID,				7.TOTALRECORD,				8.TOTALPAGE
	For i = 0 To Ubound(arrData, 2)
		.Write "<tr align='center'>"
		.Write "	<td>"& arrData(1, i) &"</td>"
		.Write "	<td>"& arrData(2, i) &" </td>"
		.Write "	<td>"& arrData(3, i) &" ~ "& arrData(4, i) &"</td>"
		.Write "	<td>"& arrdata(5, i) &"</td>"
		.Write "	<td><img src='/img/board/btn_view.gif' style='cursor:pointer;' onclick=""javascript:fn_monthly('"& arrData(10, i) &"');"" /></td>"
		.Write "</tr>"
	Next
Else
	.Write "<tr><td colspan='5' heigth='150' align='center'>등록된 평가내역이 없습니다.</td></tr>"
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
					<td><!--#include virtual="/include/Paging.asp"--></td>
				</tr>
			</table>
		<!-- btn_page end -->
		<!-- btn_page end -->
		</td>
	</tr>
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->