<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = True
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
Dim sche_seq : sche_seq = sqlCheck(Replace(Request.Form("sche_seq"), "'", "''"))

If Len(Trim(sche_seq)) = 0 Then
	chkMessageClose "잘못된 접근입니다."
End If

Dim Sql, objRs, arrData, strTBooksName

Sql = "PRC_tb_TBooks_User_Select_List '"& sche_seq &"', '"& sUserSeq &"'"
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing

If IsArray(arrData) Then
	strTBooksName = arrData(0, 0)
End If
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp"--> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="/css/Acss.css" rel="stylesheet" type="text/css">
<title><%=TitleName%></title>
<script type="text/javascript" src="/Commonfiles/Scripts/jquery.min.js"></script>
<script type="text/javascript" src="/Commonfiles/Scripts/common.js"></script>
<script type="text/javascript" src="/Commonfiles/Scripts/mypage.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$mypage.study.init.call(this);
});
</script>
</head>
<body style="overflow-y:scroll;">
<!-- ##### // Contents ##### -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"  height="100%">
	<tr>
		<td width="87%"  valign="top"  style="padding-left:10;padding-bottom:10">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
				<tr> 
					<td height="9"><img src="/img/board/ListBokTop_Left.gif" width="9" height="9"></td>
					<td width="100%" background="/img/board/ListBokTop_Bg.gif" height="9"></td>
					<td height="9"><img src="/img/board/ListBokTop_right.gif" width="9" height="9"></td>
				</tr>
				<tr> 
					<td background="/img/board/ListBokLeft_Bg.gif">&nbsp;</td>
					<td align="center" valign="top" style="padding-top:6;padding-bottom:10">
						<table width="98%" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td width="1%"><img src="/img/board/nv.gif" width="3" height="5"></td>
								<td width="99%" height="20"><strong><%=strTBooksName%> 학습</strong></td>
							</tr>
							<tr> 
								<td colspan="2" bgcolor="D8C5A7" height="1"></td>
							</tr>
						</table>

						<table width="98%" border="0" cellspacing="0" cellpadding="0">
							<tr align="right"> 
								<td colspan="15">&nbsp;</td>
							</tr>
							<!--게시물 Title-->
							<tr background='/img/board/ListMenuTitle_Bg.gif'> 
								<td width="2" align="Left"><img src="../../AdminImage/ListMenuTitle_Left.gif" width="2" height="28"></td>
								<td height="20" align="center" width=10%>진도순번</td>
								<td align="center" width=70%>제목</td>
								<td align="center" width=20%>학습하기</td>               
								<td width="12" align="right"><img src="../../AdminImage/ListMenuTitle_right.gif" width="2" height="28"></td>
							</tr>
							<!--게시물 Title-->						
<!--게시물 내용이 있을때-->
<%
With Response
If IsArray(arrData) Then
	For i = 0 To Ubound(arrData, 2)
		.Write "<tr height='20' onmouseover=""this.style.backgroundColor='#F2F2F2';"" onmouseout=""this.style.backgroundColor='#FFFFFF';"" bgcolor='#FFFFFF'>"
		.Write "	<td width='2'></td>"
		.Write "	<td align='center'>"& (i + 1) &"</td>"		
		.Write "	<td>"& arrData(1, i) &"</td>"
		.Write "	<td align='center'><a style='cursor:pointer;' class='cssbook' data-url='"& arrData(2, i) &"'>Click</a></td>"
		.Write "	<td width='12'></td>"
		.Write "</tr>"

		.Write "<tr><td colspan='5' bgcolor='#EEEEEE' height='1'></td></tr>"
	Next
Else
	.Write "<tr align='center'><td height='50' colspan='5'>해당 데이터 내역이 없습니다.</td></tr>"
End If
End With
%>
<!--게시물 페이지 리스트-->
							<tr> 
								<td colspan="15">&nbsp;</td>
							</tr>
						</table>
					</td>
					<td  background="/img/board/ListBokRight_Bg.gif">&nbsp;</td>
				</tr>
				<tr> 
					<td height="9"><img src="/img/board/ListBokbottom_Left.gif" width="9" height="9"></td>
					<td background="/img/board/ListBokbottom_Bg.gif" height="9"></td>
					<td height="9"><img src="/img/board/ListBokbottom_Right.gif" width="9" height="9"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ##### Contents // ##### -->
</body>
</html>