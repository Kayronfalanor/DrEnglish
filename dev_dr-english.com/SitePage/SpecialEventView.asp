<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = False
'// menu setting
Dim mMenu : mMenu = "6"
Dim sMenu : sMenu = "3"
%>
<!--#include file="SpecialEventInc.asp" -->
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
chkRequestVal SiteCPCode,	"로그인 정보 오류\n관리자에게 문의해 주세요.!"
chkRequestVal bcode,		"게시판 정보가 없습니다.\n다시 이용해 주세요.!"
chkRequestVal seq,			"게시물 정보가 없습니다.!"

Dim Sql, arrData, arrReview
'// 게시글 보기
Sql = "PRC_tb_Board_User_View '"& seq &"'"
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If
objRs.Close

'// 이전, 다음 글 보기
Sql = "Prc_tb_Board_User_ReView N'"& bcode &"', N'"& SiteCPCode &"', '"& seq &"'"
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrReview = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing
Call DBClose()

If Not IsArray(arrData) Then
	chkMessageBack "요청하신 자료가 삭제되었거나 존재하지 않습니다.!"
Else
	strTitle	= arrData(1, 0)
	strName		= arrData(2, 0)
	strDate		= Left(arrData(3, 0), 10)
	strContent	= arrData(4, 0)
	strReContent= arrData(5, 0)
	sFile1		= arrData(7, 0)
	sFile2		= arrData(8, 0)
End If
%>
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/Commonfiles/Scripts/sitepage.js"></script>
<script type="text/javascript">
$(document).ready(function() { $site.Event.init.call(this); });
</script>
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
<form name="Bform" method="post">
<input type="hidden" name="currPage"	id="currPage"	value="<%=currPage%>"/>
<input type="hidden" name="searchStr"	id="searchStr"	value="<%=searchStr%>"/>
<input type="hidden" name="strColumn"	id="strColumn"	value="<%=strColumn%>"/>
<input type="hidden" name="seq"			id="seq"		value="<%=seq%>"/>
<input type="hidden" name="bcode"		id="bcode"		value="<%=bcode%>"/>
<input type="hidden" name="btype"		id="btype"		value="<%=btype%>"/>
</form>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td class="contents_title"><img src="../img/sub/title_6_03.gif" alt="Special event" /></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
	</tr>
	<tr>
	  <td ><img src="../img/sub/sub06_img06.gif" alt="이벤트" /></td>
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
								<td width="11"><img src="/img/board/b_bar3.gif" width="11" height="31" /></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td height="35" colspan="2" align="left" class="point_b"><img src="/img/sub/bullet_g.gif" /><%=strTitle%></td>
								<td align="center"><%=strName%></td>
								<td align="center"><%=strDate%></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					<!-- title_box end -->
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
			</table>
		</td>
	</tr>
	<tr>
		<td>
		<!-- // prev, next data -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="befor_txt">
<%
With Response
Dim tmpImg
If IsArray(arrReview) Then
	For i = 0 To Ubound(arrReview, 2)
%>
<tr>
	<th width="15%"><img src="/img/board/th_<%=arrReview(2, i)%>_list.gif" /></th>
	<td width="85%"><a class="csshref" style="cursor:pointer;" data-seq="<%=arrReview(0, i)%>"><%=arrReview(1, i)%></a></td>
</tr>
<%
	Next
Else
End If
End With
%>
			</table>
		<!-- prev, next data // -->
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
					<td width="533" align="right">&nbsp;</td>         <td width="64" align="right">&nbsp;</td>
					<td width="63" align="right"><img src="/img/board/btn_list.gif" alt="목록" style="cursor:pointer;" border="0" id="btnList" caption="LIST" /></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td >&nbsp;</td>
	</tr>
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->