<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = True
'// menu setting
Dim mMenu : mMenu = "6"
Dim sMenu : sMenu = "6"
%>
<!--#include file="Inc.asp" -->
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
chkRequestVal SiteCPCode,	"로그인 정보 오류\n관리자에게 문의해 주세요.!"
chkRequestVal bcode,		"게시판 정보가 없습니다.\n다시 이용해 주세요.!"
chkRequestVal seq,			"게시물 정보가 없습니다.!"

Dim Sql, arrData
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
	strTitle	= arrData(1, 0)
	strName		= arrData(2, 0)
	strDate		= Left(arrData(3, 0), 10)
	strContent	= arrData(4, 0)
	strReContent= arrData(5, 0)
End If
%>
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/Commonfiles/Scripts/sitepage.js"></script>
<script type="text/javascript">
//$(document).ready(function() { $site.qna.init.call(this); });

function fn_CommentWrite()
{	
	
	if ($("#comment").val().trim() =='')
	{
		alert("코멘트내용을 입력해주세요.");
		$("#comment").focus();
		return;
	}

	$("FORM[name='commFrm']").attr("action", "commentOK.asp").submit();
	

	
}

function fn_List()
{	
	
	$("FORM[name='formdboard']").attr("action", "List.asp").submit();
	
}

</script>
	<style>
.wirte_okbtn{ width:70px; height:40px; line-height: 40px;margin-top: 20px; float: right;text-align: center;background-color: #3d3d3d; color:#fff; font-size: 14px;}
		.wirte_okbtn:hover{cursor: pointer;}
	</style>

<div class="contents_right">
	<div><img src="/img/subimg/title_4.png" alt="화상영어가이드 "/></div>
	
	  <table class="type07">
		  <form method="post" action="WriteOK.asp" name="formdboard" id="formdboard">
          <input type="hidden" name="currPage" id="currPage" value="<%=currPage%>"/>
          <input type="hidden" name="sortField" id="sortField" value="<%=sortField%>"/>
          <input type="hidden" name="sortMethod" id="sortMethod" value="<%=sortMethod%>"/>
          <input type="hidden" name="seq" id="seq" value="<%=seq%>"/>
          <input type="hidden" name="bcode" id="bcode" value="<%=bcode%>"/>
          <input type="hidden" name="btype" id="btype" value="<%=btype%>"/>
           <tbody>
           <tr>
               <th style="border-top: 1px solid #ccc;width:150px;">제목</th>
               <td style="border-top: 1px solid #ccc;"><%=strTitle%></td>
           </tr>
		   <tr>
               <th style="border-top: 1px solid #ccc;">작성자</th>
               <td style="border-top: 1px solid #ccc;"><%=strName%></td>
           </tr>
		  <tr>
               <th style="border-top: 1px solid #ccc;">등록일</th>
               <td style="border-top: 1px solid #ccc;"><%=strDate%></td>
           </tr>
			   <tr>
               <th style="border-top: 1px solid #ccc;">내용</th>
               <td style="border-top: 1px solid #ccc;"><%=strContent%></td>
           </tr>

		      <tr>
               <th style="border-top: 1px solid #ccc;">답변 내용</th>
               <td style="border-top: 1px solid #ccc;"><%=strReContent%></td>
           </tr>
           </tbody>
       </table>
	
	  <a href="javascript:fn_List();"><div class="wirte_okbtn">목록</div></a>

</form>

<br><br><br><br>

			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
			<form name="commFrm" method="POST" id="commFrm">
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

			

			.Write "<tr>"
			.Write "	<td align='center' colspan='3'>"
			.Write "		<table width='100%' border='0' cellpadding='0' cellspacing='0'>"
			.Write "			<tr>"	
			.Write "				<td align='left' bgcolor='#D6ECFF'>&nbsp;</td>"
			.Write "			</tr>"
			.Write "		</table>"
			.Write "	</td>"
			.Write "</tr>"

			.Write "<tr align='center'>"
			.Write "<td width='150'>"& arrData(2, i) &"</td>"
			.Write "<td style='text-align:left;padding:10px 0 10px 0;'>"& Replace(arrData(4, i), Chr(13)&Chr(10), "<br>") &"</td>"
			.Write "<td width='100' valign='middle'>"
			.Write		Left(arrData(3, i), 10) 

			
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
								<th width="100" align="left" bgcolor="#F8F3ED">코멘트</th>
								<td colspan="2"><textarea name="comment" id="comment" cols="72" rows="10" class="textarea" style="padding:4px 4px;"></textarea></td>
							</tr>
							<tr>
								<td colspan="3" align="right" style="padding-top:5px;">
									<a href="javascript:fn_CommentWrite();"><p style="float: left;padding:8px 10px;background-color:#ff402f;color:#fff;fontsize:14px;cursor:pointer;"  >코멘트등록</p></a>
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
			<tr><td colspan="3" height="100%"></td></tr>
			</table>
		
<!-- 게시글 코멘트 // -->

</div>



<!--#include virtual="/include/inc_footer.asp"-->