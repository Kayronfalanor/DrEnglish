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
Dim strTitle	: strTitle	= sqlCheck(Replace(Request.Form("Subject"), "'", "''"))
Dim strContent	: strContent= sqlCheck(Replace(Request.Form("Content1"), "'", "''"))
Dim strReWriter	: strReWriter	= sqlCheck(Replace(Request.Form("rewriter"), "'", "''"))

chkRequestVal SiteCPCode,	"로그인 정보 오류\n관리자에게 문의해 주세요.!"
chkRequestVal bcode,		"게시판 정보가 없습니다.\n다시 이용해 주세요.!"
chkRequestVal strTitle,		"제목 정보가 없습니다.!"
chkRequestVal strContent,	"내용 정보가 없습니다.!"
chkRequestVal strReWriter,	"전송 강사 정보가 없습니다.!"

Dim strResult

If Len(seq) > 0 And IsNumeric(seq) Then

	Dim iWriter, siPRole

	Sql = "SELECT iWriterSeq, siWriterPRole FROM TB_BOARD WITH(NOLOCK) WHERE iBoardSeq = '"& seq &"'"
	Set objRs = dbSelect(Sql)
	If Not objRs.Eof Then
		iWriter = objRs(0)	:	siPRole = objRs(1)
	End If
	objRs.Close	:	Set objRs = Nothing

	If CInt(sUserSeq) = iWriter And CInt(sUserPRole) = siPRole Then
		DB1.BeginTrans

		Sql = "UPDATE TB_BOARD SET nvcBoardTitle = N'"& strTitle &"', "
		Sql = Sql & "nvcEtcCode			= N'"& etcCode &"', "
		Sql = Sql & "ntxBoardContent	= N'"& strContent &"' "
		Sql = Sql & "WHERE iBoardSeq = '"& seq &"'"
	Else
		Call DBClose()

		chkRequestVal "", "본인 글만 수정할 수 있습니다.!"
	End If
Else

	DB1.BeginTrans

	Sql = "INSERT INTO TB_BOARD ( "
	Sql = Sql & " nvcBoardCode, nvcCPCode, nvcBoardTitle, ntxBoardContent, iWriterSeq, siWriterPRole, iReWriterSeq, siReWriterPRole "
	Sql = Sql & ") VALUES ( "
	Sql = Sql & " N'"& bcode &"', N'"& SiteCPCode &"', N'"& strTitle &"', N'"& strContent &"', '"& sUserSeq &"', '"& sUserPRole &"', N'"& strReWriter &"', '2' "
	Sql = Sql & ") "
End If

strResult = insertUpdateDB(Sql)

If strResult <> "Y" Then
	msg = "영어 일기 등록(수정) 도중 오류가 발생하였습니다.\n" & strResult

	RollBackAndHistoryBack DB1, msg
Else
	msg = "영어 일기 등록(수정)이 완료 되었습니다."

	DB1.CommitTrans

	sql="select top 1 iBoardSeq from tb_Board where nvcBoardCode=N'"& bcode &"' and nvcCPCode=N'"& SiteCPCode &"' and iWriterSeq='"& sUserSeq &"'"
	sql = sql & " order by iBoardSeq desc "
	Set objRs=dbSelect(sql)
	If Not objRs.Eof Then
		iBoardSeq = objRs(0)
	End If
	objRs.Close	:	Set objRs = Nothing
	

End If
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp" -->

<%
If Len(seq) > 0 And IsNumeric(seq) Then
	aaa="Update"
else
	If strResult = "Y" Then

	%>
	<iframe name="GetData" id="GetData" width="0" height="0"></iframe>
	<FORM action="<%=HBGateway%>" name="hbform" method="post" target="GetData">
	<input type="hidden" name="GubnCode" id="GubnCode" value="A4"/>
	<input type="hidden" name="UserID" id="UserID" value="<%=sUserID%>"/>
	<input type="hidden" name="WriteDate" id="WriteDate" value="<%=Left(now(),10)%>"/>
	<input type="hidden" name="Diary" id="Diary" value="<%=Server.urlencode(Replace(strContent,"''","'"))%>"/>
	<input type="hidden" name="iBoardSeq" id="iBoardSeq" value="<%=iBoardSeq%>"/>
	</FORM>
	<script language="JavaScript">
		document.hbform.submit();
	</script>
	<%
	End If
End If
%>

<FORM action="List.asp" name="Form" method="post">
<input type="hidden" name="currPage" id="currPage" value="<%=currPage%>"/>
<input type="hidden" name="sortField" id="sortField" value="<%=sortField%>"/>
<input type="hidden" name="sortMethod" id="sortMethod" value="<%=sortMethod%>"/>
<input type="hidden" name="seq" id="seq" value="<%=seq%>"/>
<input type="hidden" name="bcode" id="bcode" value="<%=bcode%>"/>
</FORM>
<script language="JavaScript">
setTimeout('fn_return()',2000);

function fn_return(){
alert("<%=MSG%>");
document.Form.submit();
}
</script>