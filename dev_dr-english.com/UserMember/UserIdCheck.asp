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
UserID	= sqlCheck(trim(replace(request("UserID"),"'","''")))

Dim bUseID : bUseID = True
If Len(UserID) > 0 Then
	strSQL = "SELECT nvcMemberID FROM TB_Member WITH(READUNCOMMITTED) WHERE nvcMemberID = N'"& UserID &"' "
	Set Rs = dbSelect(strSQL)
	If Not Rs.Eof Then
		bUseID = False
	End If
	Rs.Close	:	Set Rs = Nothing
End If
%>
<!--#include virtual="/commonfiles/DBINCC/DBClose1.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title><%=TitleName%></title>
<link href="../css/popup.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/commonfiles/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/commonfiles/scripts/jquery.alphanumeric.pack.js"></script>
<script type="text/javascript" src="/commonfiles/scripts/common.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#UserID").alphanumeric();
	$("#UserID").css("ime-mode", "disabled");
	// 크롬에서의 한글 써지는 문제 추가 적용
	$common.keyPermit.call($("#UserID"), "ENUM");

	if($("#btnCheck").length > 0) {
		$("#btnCheck").bind("click", function() {
			if($("#UserID").val().trim() == "") {
				alert("아이디를 검색 후 입력하세요.");
				$("#UserID").focus();
				return;
			}
			if($("#UserID").val().trim().length < 6) {
				alert("아이디는 6~12자의 연속된 영문 소문자와 숫자만 사용할 수 있습니다.");
				$("#UserID").focus();
				return;
			}
			if($("#UserID").val().trim().charAt(0) == '_') {
				alert("아이디의 첫문자는 '_'로 시작할수 없습니다.");
				$("#UserID").focus();
				return;
			}

			$("FORM[id='Uform']").submit();
		});
	}

	if($("#btnUseID").length > 0) {
		$("#btnUseID").bind("click", function() {
			var obj = self.opener;
			if(typeof(obj) != "undefined") {
				obj.Uform.UserID.value = $(this).data("value");
				self.close();
			} else {
				alert("잘못된 접근입니다.\n정상적인 경로로 다시 이용해 주세요.!");
				self.close();
			}
		});
	}
});
</script>
<body style="background-color:#F8F3E8;">
<!-- ##### // Contents ##### -->
<table width="300" border="0" cellspacing="0" cellpadding="0">
	<tr> 
		<td><img src="../img/popup/pop_title_idcheck.gif" alt="아이디중복확인" /></td>
	</tr>
	<tr> 
		<td align="center" background="../img/popup/pop_boxbg.gif"> 
			<table width="91%" border="0" cellspacing="0" cellpadding="0">
				<tr> 
					<td height="50" align="center" class="text">
						<%If Len(UserID) = 0 Then%>
							<span class="name">*</span> 6~12자 입력, 한글/특수문자 입력불가
						<%Else%>
							<strong><font color="#009999"><%=UserID%></font></strong>
							<%If bUseID Then%>
								은(는) 사용하실 수 있습니다.<br />
								<img src="../img/board/btn_idok.gif" width="87" height="22" border="0" id="btnUseID" data-value="<%=UserID%>" style="cursor:pointer;" />
							<%Else%>
								은(는) 현재 사용중인 아이디 입니다.<br />
					            아이디를 다시 조회해 주십시요.
							<%End IF%>							
						<%End If%>
					</td>
				</tr>
				<tr> 
					<td align="center"> 
						<table width="269" border="0" cellspacing="0" cellpadding="0">
						<form action="UserIdCheck.asp" method="post" name="Uform" id="Uform">
							<tr> 
								<td height="1" colspan="4" bgcolor="cccccc"></td>
							</tr>
							<tr> 
								<td width="20" height="40"><img src="../img/sub/bullet02.gif" width="19" height="12" /></td>
								<td width="63" height="40" align="center" class="point2">아이디</td>
								<td width="119" height="40" align="center"><input name="UserID" type="text" class="input" id="UserID" size="20" maxlength="12" style="width:120px;height:20px;font-size:15px;" /></td>
								<td width="73" height="40" align="center"><img style="border-width:0;cursor:pointer" src="../img/board/btn_research.gif" id="btnCheck" />
								</td>
							</tr>
							<tr> 
								<td height="1" colspan="4" bgcolor="cccccc"></td>
							</tr>
						</form>
						</table>
					</td>
				</tr>
				<tr> 
					<td>&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr> 
		<td><img src="../img/popup/pop_bot_bg.gif" width="300" height="24" /></td>
	</tr>
</table>
<!-- ##### Contents // ##### -->
</body>
</html>
