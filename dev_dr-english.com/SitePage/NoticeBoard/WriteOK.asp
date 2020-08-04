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
Dim strEtcCode	: strEtcCode= sqlCheck(Replace(Request.Form("etccode"), "'", "''"))
Dim strTitle	: strTitle	= sqlCheck(Replace(Request.Form("subject"), "'", "''"))
Dim strContent	: strContent= sqlCheck(Replace(Request.Form("Content1"), "'", "''"))


chkRequestVal SiteCPCode,	"로그인 정보 오류\n관리자에게 문의해 주세요.!"
chkRequestVal bcode,		"게시판 정보가 없습니다.\n다시 이용해 주세요.!"
chkRequestVal strTitle,		"제목 정보가 없습니다.!"
chkRequestVal strContent,	"내용 정보가 없습니다.!"

Dim strResult

DB1.BeginTrans


If seq = "" Then 
	Sql = "INSERT INTO TB_BOARD ( "
	Sql = Sql & "	nvcBoardCode, nvcCPCode, nvcBoardTitle, ntxBoardContent, iWriterSeq, siWriterPRole, nvcEtcCode "
	Sql = Sql & ") VALUES ( "
	Sql = Sql & "	N'"& bcode &"',		N'"& SiteCPCode &"', "
	Sql = Sql & "	N'"& strTitle &"',	N'"& strContent &"', "
	Sql = Sql & "	'"& sUserSeq &"',	'"& sUserPRole &"', "
	Sql = Sql & "	N'"& strEtcCode &"' "
	Sql = Sql & ")"
Else 
	Sql = "update tb_board set"
	Sql = Sql & " nvcBoardTitle= '"& strTitle &"' "
	Sql = Sql & " , ntxBoardContent= '"& strContent &"' "
	Sql = Sql & " where iBoardSeq = '"& seq &"' "
End If 
strResult = insertUpdateDB(Sql)

If strResult <> "Y" Then
	If seq = "" Then 
		msg = "Notice Board 등록 도중 오류가 발생하였습니다.\n" & strResult
	Else 
		msg = "Notice Board 수정 도중 오류가 발생하였습니다.\n" & strResult
	End If 
	RollBackAndHistoryBack DB1, msg
Else
	If seq = "" Then 
		msg = "Notice Board 등록이 완료 되었습니다."
	Else 
		msg = "Notice Board 수정이 완료 되었습니다. "
	End If 

	DB1.CommitTrans
End If
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp" -->
<FORM action="List.asp" name="Form" method="post">
<INPUT TYPE="hidden" name="bcode" value="<%=bcode%>">
</FORM>
<script language="JavaScript">
alert("<%=MSG%>");
document.Form.submit();
</script>