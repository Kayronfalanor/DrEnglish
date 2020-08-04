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
Dim CSeq		: CSeq		= sqlCheck(Replace(Request.Form("CSeq"), "'", "''"))
Dim strComment	: strComment= sqlCheck(Replace(Request.Form("Comment"), "'", "''"))

chkRequestVal SiteCPCode,	"로그인 정보 오류\n관리자에게 문의해 주세요.!"
chkRequestVal bcode,		"게시물 정보가 없습니다.\n다시 이용해 주세요.!"
chkRequestVal Seq,			"게시물 정보가 없습니다.\n다시 이용해 주세요.!"
chkRequestVal CSeq,			"코멘트 정보가 없습니다.\n다시 이용해 주세요.!"

Dim strResult, iWriter, siPRole

Sql = "SELECT iWriterSeq, siCommentPRole FROM TB_BComment WITH(NOLOCK) WHERE iBCommentSeq = '"& CSeq &"' "
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	iWriter = objRs(0)	:	siPRole = objRs(1)
End If
objRs.Close	:	Set objRs = Nothing

If iWriter = CInt(sUserSeq) And siPRole = CInt(sUserPRole) Then
	DB1.BeginTrans

	Sql = "DELETE FROM TB_BCOMMENT WHERE iBCommentSeq = '"& CSeq &"' "

	strResult = insertUpdateDB(Sql)

	If strResult <> "Y" Then
		msg = "영어일기 댓글 삭제 도중 오류가 발생하였습니다.\n" & strResult

		RollBackAndHistoryBack DB1, msg
	Else
		msg = "영어일기 댓글 삭제가 완료 되었습니다."

		DB1.CommitTrans
	End If
Else
	msg = "글쓴이 본인만 삭제할 수 있습니다."
End If
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp" -->
<FORM action="VIEW.asp" name="Form" method="post">
<input type="hidden" name="currPage" id="currPage" value="<%=currPage%>"/>
<input type="hidden" name="sortField" id="sortField" value="<%=sortField%>"/>
<input type="hidden" name="sortMethod" id="sortMethod" value="<%=sortMethod%>"/>
<input type="hidden" name="seq" id="seq" value="<%=seq%>"/>
<input type="hidden" name="bcode" id="bcode" value="<%=bcode%>"/>
</FORM>
<script language="JavaScript">
alert("<%=MSG%>");
document.Form.submit();
</script>