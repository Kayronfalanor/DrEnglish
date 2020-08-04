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
Dim strComment	: strComment= sqlCheck(Replace(Request.Form("comment"), "'", "''"))

chkRequestVal SiteCPCode,	"로그인 정보 오류\n관리자에게 문의해 주세요.!"
chkRequestVal bcode,		"게시물 정보가 없습니다.\n다시 이용해 주세요.!"
chkRequestVal Seq,			"게시물 정보가 없습니다.\n다시 이용해 주세요.!"
chkRequestVal strComment,	"코멘트 내용 정보가 없습니다.!"

Dim strResult

DB1.BeginTrans

If Len(Trim(CSeq)) > 0 Then
	Sql = "UPDATE TB_BCOMMENT SET nvcComment = N'"& strComment &"' WHERE iBCommentSeq = '"& CSeq &"' "
Else
	Sql = "INSERT INTO TB_BCOMMENT ( "
	Sql = Sql & "	nvcBoardCode, nvcComment, iWriterSeq, siCommentPRole, iBoardSeq "
	Sql = Sql & ") VALUES ( "
	Sql = Sql & "	N'"& bcode &"', N'"& strComment &"', '"& sUserSeq &"', '"& sUserPRole &"', '"& Seq &"' "
	Sql = Sql & ")"
End If

strResult = insertUpdateDB(Sql)

If strResult <> "Y" Then
	msg = "To My Teacher 댓글 등록 및 수정 도중 오류가 발생하였습니다.\n" & strResult

	RollBackAndHistoryBack DB1, msg
Else
	msg = "To My Teacher 댓글 등록 및 수정이 완료 되었습니다."

	DB1.CommitTrans
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