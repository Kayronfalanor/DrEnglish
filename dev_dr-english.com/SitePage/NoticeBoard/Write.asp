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
Dim sMenu : sMenu = "9"
%>
<!--#include file="Inc.asp" -->
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%



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

If strName = "" Then 
	strName = sUserName
Else
	strName = strName
End If 

Dim arrQtype : arrQtype = getCommCode("QNA", bcode, True)
%>
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/Commonfiles/Scripts/sitepage.js"></script>
<script type="text/javascript">
$(document).ready(function() { $site.qna.init.call(this); });
</script>
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
<form method="post" action="WriteOK.asp" name="formdboard">
<input type="hidden" name="currPage" id="currPage" value="<%=currPage%>"/>
<input type="hidden" name="sortField" id="sortField" value="<%=sortField%>"/>
<input type="hidden" name="sortMethod" id="sortMethod" value="<%=sortMethod%>"/>
<input type="hidden" name="seq" id="seq" value="<%=seq%>"/>
<input type="hidden" name="bcode" id="bcode" value="<%=bcode%>"/>
<input type="hidden" name="btype" id="btype" value="<%=btype%>"/>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="contents_title"><img src="/img/sub/title_6_066.gif" alt="묻고답하기" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td ><img src="/img/sub/sub06_img04.gif" /></td>
	</tr>
	<tr>
		<td >&nbsp;</td>
	</tr>
	<tr>
		<td height="30" align="right" >
		<!-- search box -->          <!-- search box end -->      
		</td>
	</tr>
	<tr>
		<td align="center" valign="top" >
			<table width="650" border="0" cellspacing="0" cellpadding="0">
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
							<tr> 
								<td height="1" colspan="2" align="left" background="/img/dot.gif"></td>
							</tr>
							<tr> 
								<th width="100" align="left" bgcolor="#F8F3ED">작성자</th>
								<td><input name="Name" type="text" class="input cssinput" id="name" size="20" value="<%=strName%>" readonly caption="이름"></td>
							</tr>
							<tr> 
								<td height="1" colspan="2" align="left" background="/img/dot.gif"></td>
							</tr>
							
							<tr> 
								<th width="100" align="left" bgcolor="#F8F3ED">제목</th>
								<td><input name="Subject" type="text" class="input cssinput" id="Subject" size="80" caption="제목" value="<%=strTitle%>"/></td>
							</tr>
							<tr> 
								<td height="1" colspan="2" align="left" background="/img/dot.gif"></td>
							</tr>
							<tr> 
								<th width="100" align="left" bgcolor="#F8F3ED">내용</th>
								<td><textarea name="Content1" cols="60" rows="15" class="textarea cssinput" id="textfield6" caption="내용"><%=strContent%></textarea></td>
							</tr>
						</table>
					<!-- input boxs end -->
					</td>
					<td background="/img/board/gbox_rbg.gif">&nbsp;</td>
				</tr>
				<tr>
					<td width="15"><img src="/img//board/gbox_lb.gif" width="15" height="15" /></td>
					<td background="/img/board/gbox_bbg.gif"></td>
					<td width="15"><img src="/img/board/gbox_rb.gif" width="15" height="15" /></td>
				</tr>
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
					<td width="533" align="right">&nbsp;</td>
					<td width="64" align="right">&nbsp;</td>         
					<td width="63" align="right"><img src="/img/board/btn_record.gif" width="71" height="24" style="border-width:0;cursor:pointer;" id="btnRegist" caption="REGIST"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td >&nbsp;</td>
	</tr>
</form>
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->