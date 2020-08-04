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
Dim SL_Cdate1	: SL_Cdate1= sqlCheck(Replace(Request.Form("SL_Cdate1"), "'", "''"))
Dim SL_Ctime1	: SL_Ctime1	= sqlCheck(Replace(Request.Form("SL_Ctime1"), "'", "''"))
Dim SL_Ctime2	: SL_Ctime2= sqlCheck(Replace(Request.Form("SL_Ctime2"), "'", "''"))
Dim SL_Name	: SL_Name= sqlCheck(Replace(Request.Form("SL_Name"), "'", "''"))
Dim SL_Phone	: SL_Phone= sqlCheck(Replace(Request.Form("SL_Phone"), "'", "''"))
Dim nvcReason : nvcReason= sqlCheck(Replace(Request.Form("nvcReason"), "'", "''"))

chkRequestVal SiteCPCode,	"정보 오류\n관리자에게 문의해 주세요.!"
chkRequestVal SL_Cdate1,		"원격지원 날짜 정보가 없습니다.!"
chkRequestVal SL_Ctime1,	"원격지원 시간 정보가 없습니다.!"
chkRequestVal SL_Ctime2,	"원격지원 시간 정보가 없습니다.!"


Dim strResult

DB1.BeginTrans

Sql = "INSERT INTO TB_RequestRemote ( "
Sql = Sql & "	nvcCPCode, iWriterSeq,iWriterPRole, nvcRemoteDate,nvcRemoteTime, nvcReason, nvcPhone "
Sql = Sql & ") VALUES ( "
Sql = Sql & "	N'"& SiteCPCode &"',		'"& sUserSeq &"', "
Sql = Sql & "	'"& sUserPRole &"',	N'"& SL_Cdate1 &"', "
Sql = Sql & "	N'"& SL_Ctime1&":"&SL_Ctime2 &"',	N'"& nvcReason &"', "
Sql = Sql & "	N'"& SL_Phone &"' "
Sql = Sql & ")"
strResult = insertUpdateDB(Sql)

If strResult <> "Y" Then
	msg = "원격지원 신청 등록 도중 오류가 발생하였습니다.\n" & strResult

	RollBackAndHistoryBack DB1, msg
Else
	msg = "원격지원 신청  등록이 완료 되었습니다."

	DB1.CommitTrans
End If
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp" -->
<script language="javascript">
alert('<%=msg%>');
location.href="/SitePage/PCControl.asp";
</script>