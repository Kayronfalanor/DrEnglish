<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = True
%>
<!--#include file="Inc.asp" -->
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
Dim Seq	: Seq= sqlCheck(Replace(Request.Form("Seq"), "'", "''"))

chkRequestVal SiteCPCode,	"로그인 정보 오류\n관리자에게 문의해 주세요.!"
chkRequestVal Seq,			"게시물 정보가 없습니다.\n다시 이용해 주세요.!"

Dim strResult

Dim iWriter, siPRole
Sql = "SELECT iWriterSeq, siWriterPRole FROM TB_BOARD WITH(NOLOCK) WHERE iBoardSeq = '"& Seq &"' "
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	iWriter = objRs(0)	:	siPRole = objRs(1)
End If
objRs.Close	:	Set objRs = Nothing


If CInt(sUserSeq) = iWriter And CInt(sUserPRole) = siPRole Then
	DB1.BeginTrans

	Sql = "DELETE FROM TB_BOARD WHERE iBoardSeq = '"& Seq &"' "
	strResult = insertUpdateDB(Sql)

	If strResult <> "Y" Then
		msg = "영어 일기 삭제 도중 오류가 발생하였습니다.\n" & strResult

		RollBackAndHistoryBack DB1, msg
	Else
		msg = "영어 일기 삭제가 완료 되었습니다."

		DB1.CommitTrans
	End If
Else
	msg = "본인의 게시물만 삭제가 가능합니다."
End If
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp" -->
<FORM action="List.asp" name="Form" method="post">
<input type="hidden" name="bcode" id="bcode" value="<%=bcode%>"/>
</FORM>
<script language="JavaScript">
alert("<%=MSG%>");
document.Form.submit();
</script>