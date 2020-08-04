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
Dim sMenu : sMenu = "3"
%>
<!--#include file="Inc.asp"-->
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
chkRequestVal SiteCPCode,	"로그인 정보 오류\n관리자에게 문의해 주세요.!"
chkRequestVal bcode,		"게시판 정보가 없습니다.\n다시 이용해 주세요.!"
chkRequestVal seq,			"게시물 정보가 없습니다.!"

Dim Sql, arrData, arrReview
Dim strCorrect : strCorrect = "[첨삭대기]"
'// 리스트
Sql = "PRC_tb_Board_User_View '"& seq &"'"
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing

Call DBClose()

If Not IsArray(arrData) Then
	chkMessageBack "요청하신 자료가 삭제되었거나 존재하지 않습니다.!"
Else
	iBoardSeq	= arrData(0, 0)
	strTitle	= arrData(1, 0)
	strName		= arrData(2, 0)
	strDate		= Left(arrData(3, 0), 10)
	strContent	= arrData(4, 0)
	strReContent= arrData(5, 0)
	iWriter		= arrData(9, 0)
	siPRole		= arrData(10, 0)
	If IsNull(arrData(12, 0)) Then
		strReDate	= ""
	Else
		strReDate	= arrData(12, 0)
		strCorrect	= "[첨삭완료]"
	End If
End If
%>
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/Commonfiles/Scripts/mypage.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$mypage.diary.init.call(this);
});
</script>
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="contents_title"><img src="/img/sub/title_1_03.gif" alt="묻고답하기" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td ><img src="/img/sub/sub01_img07.gif" /></td>
	</tr>
	<tr>
		<td >&nbsp;</td>
	</tr>
	<tr>
		<td height="30" align="right" ><!-- search box -->          <!-- search box end -->      </td>
	</tr>
	<tr>
		<td align="center" valign="top" >
			<table width="660" border="0" cellpadding="0" cellspacing="0">
			<form method="post" name="Bform">
			<input type="hidden" name="currPage" id="currPage" value="<%=currPage%>"/>
			<input type="hidden" name="sortField" id="sortField" value="<%=sortField%>"/>
            <input type="hidden" name="sortMethod" id="sortMethod" value="<%=sortMethod%>"/>
            <input type="hidden" name="seq" id="seq" value="<%=seq%>"/>
            <input type="hidden" name="bcode" id="bcode" value="<%=bcode%>"/>
			</form>
				<tr>
					<td>
					<!-- title_box end -->
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="11" height="31"><img src="/img/board/b_bar1.gif" width="11" height="31" /></td>
								<td width="58" align="center" background="/img/board/b_bar2.gif"><img src="/img/board/b_title_title.gif" alt="제목" /></td>
								<td width="404" background="/img/board/b_bar2.gif">&nbsp;</td>
								<td width="82" align="center" background="/img/board/b_bar2.gif"><img src="/img/board/b_title_name.gif" alt="작성자"	/></td>
								<td width="84" align="center" background="/img/board/b_bar2.gif"><img src="/img/board/b_title_date.gif" alt="등록일" /></td>
								<td width="84" align="center" background="/img/board/b_bar2.gif"><img src="/img/board/b_title_edit.gif" alt="첨삭여부" /></td>
								<td width="11"><img src="/img/board/b_bar3.gif" width="11" height="31" /></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td height="35" colspan="2" align="left" class="point_b"><img src="/img/sub/bullet_g.gif" /><%=strTitle%></td>
								<td align="center"><%=strName%></td>
								<td align="center"><%=strDate%></td>
								<td align="center"><%=strCorrect%></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					<!-- title_box end -->
					</td>
				</tr>
				<tr> 
					<td align="center">
						<table width="100%" border="0" cellpadding="0" cellspacing="0" >
							<tr>
								<td width="62" align="left"><img src="/img/board/sub01_b_stud.gif" alt="학생" width="62" height="20" /></td>
								<td align="left" bgcolor="#D6ECFF">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
					<!-- txtbox -->
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="notice_t_box">
							<tr>
								<td valign="top" class="LH">
									<!--#include virtual="/include/inc_board_view.asp"-->
									<%=Replace(strContent, Chr(13)&Chr(10), "<br>")%>
								</td>
							</tr>
						</table>
					<!-- txtbox end -->
					</td>
				</tr>
			<%If Len(Trim(strReDate)) > 0 Then%>
				<tr> 
					<td align="center">
						<table width="100%" border="0" cellpadding="0" cellspacing="0" >
							<tr>
								<td width="62" align="left"><img src="/img/board/sub01_b_teach.gif" alt="강사" width="62" height="20" /></td>
								<td align="left" bgcolor="#D6ECFF">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
					<!-- txtbox -->
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="notice_t_box">
							<tr>
								<td valign="top" class="LH">
									<%=Replace(strReContent, Chr(13)&Chr(10), "<br>")%>					
								</td>
							</tr>
						</table>
					<!-- txtbox end -->
					</td>
				</tr>
			<%End If%>
			</table>
		</td>
	</tr>
	<tr>
		<td >&nbsp;</td>
	</tr>
	<tr>
		<td height="30" align="center" >
		<!-- btn_page -->   <!-- btn_page end -->      
			<table width="660" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="333" align="right">&nbsp;</td>         
					<td width="64" align="right">&nbsp;</td>
					<td width="*" align="right">
						<%If Len(Trim(strReDate)) = 0 And (CLng(sUserSeq) = iWriter And CInt(sUserPRole) = siPRole) Then%>
							<!--<img src='/img/board/btn_del.gif' style='border-width:0;cursor:pointer;' class='cssBtns' caption='DELETE'>
							<img src='/img/board/btn_modif.gif' style='border-width:0;cursor:pointer;' class='cssBtns' caption='WRITE'>-->
						<%End If%>
						<img src="/img/board/btn_list.gif" style="cursor:pointer;" border="0" class='cssBtns' caption='LIST' />
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td >&nbsp;</td>
	</tr>
<!-- // 게시글 코멘트 -->
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<form name="commFrm" method="POST">
			<input type="hidden" name="currPage" id="currPage" value="<%=currPage%>"/>
			<input type="hidden" name="sortField" id="sortField" value="<%=sortField%>"/>
            <input type="hidden" name="sortMethod" id="sortMethod" value="<%=sortMethod%>"/>
            <input type="hidden" name="seq" id="seq" value="<%=seq%>"/>
            <input type="hidden" name="bcode" id="bcode" value="<%=bcode%>"/>
			<input type="hidden" name="btype" id="btype" value="<%=btype%>"/>
			<input type="hidden" name="cseq" id="cseq" value="" />
				<tr>
					<td width="15"><img src="/img/board/gbox_lt.gif" width="15" height="15" /></td>
					<td background="/img/board/gbox_tbg.gif"></td>
					<td width="15"><img src="/img/board/gbox_rt.gif" width="15" height="15" /></td>
				</tr>
				<tr>
					<td background="/img/board/gbox_lbg.gif">&nbsp;</td>
					<td align="left" bgcolor="#FFFFFF">
					<!-- input boxs end -->
						<table width="100%" border="0" cellspacing="1" cellpadding="5" class="t_style02">
<%
Dim strTypeImg
With Response
If IsArray(arrData) Then
	Dim j : j = 0
	For i = 0 To Ubound(arrData, 2)
		If arrData(6, i) = "COM" Then

			strTypeImg = "stud"
			If arrData(10, i) <> 4 Then
				strTypeImg = "teach"
			End If

			.Write "<tr>"
			.Write "	<td align='center' colspan='3'>"
			.Write "		<table width='100%' border='0' cellpadding='0' cellspacing='0'>"
			.Write "			<tr>"
			.Write "				<td width='62' align='left'><img src='/img/board/sub01_b_"& strTypeImg &".gif' width='62' height='20' /></td>"
			.Write "				<td align='left' bgcolor='#D6ECFF'>&nbsp;</td>"
			.Write "			</tr>"
			.Write "		</table>"
			.Write "	</td>"
			.Write "</tr>"

			.Write "<tr align='center'>"
			.Write "<td width='100'>"& arrData(2, i) &"</td>"
			.Write "<td style='text-align:left;padding:10px 0 10px 0;'>"& Replace(arrData(4, i), Chr(13)&Chr(10), "<br>") &"</td>"
			.Write "<td width='120' valign='top'>"
			.Write		Left(arrData(3, i), 10) 

			If CInt(sUserSeq) = arrData(9, i) And CInt(sUserPRole) = arrData(10, i) Then
				.Write "<br /><img src='/img/board/btn_del.gif' style='border-width:0;cursor:pointer;' class='cssBtns' caption='COMMDEL' data-cseq='"& arrData(0, i) &"'>"
				.Write "<img src='/img/board/btn_modif.gif' style='border-width:0;cursor:pointer;' class='cssBtns' caption='COMMMOD' data-cseq='"& arrData(0, i) &"' data-comment='"& arrData(4, i) &"'>"
			End If

			.Write "</td>"
			.Write "</tr>"

			If j < Ubound(arrData, 2) - 1 Then
				.Write "<tr><td height='1' colspan='3' align='left' background='/img/dot.gif'></td></tr>"
			End If

			j = j + 1
		End If
	Next
End If
End With
%>
							<tr><td height="1" colspan="3" align="left" background="/img/dot.gif"></td></tr>
							<tr> 
								<th width="100" align="left" bgcolor="#F8F3ED">내용</th>
								<td colspan="2"><textarea name="comment" id="comment" cols="72" rows="10" class="textarea"></textarea></td>
							</tr>
							<tr>
								<td colspan="3" align="right" style="padding-top:5px;">
									<img src="/img/board/btn_record.gif" style="border-width:0;cursor:pointer;" id="btnComment" class="cssBtns"	caption="COMMREG">
								</td>
							</tr>
						</table>
					</td>
					<td background="/img/board/gbox_rbg.gif">&nbsp;</td>
				</tr>
				<tr>
					<td width="15"><img src="/img//board/gbox_lb.gif" width="15" height="15" /></td>
					<td background="/img/board/gbox_bbg.gif"></td>
					<td width="15"><img src="/img/board/gbox_rb.gif" width="15" height="15" /></td>
				</tr>
			<input type="hidden" name="strcomment" id="strcomment" value="<%=strComment%>" />
			</form>
			</table>
		</td>
	</tr>
<!-- 게시글 코멘트 // -->
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->