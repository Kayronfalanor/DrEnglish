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
UserPW		= sqlCheck(trim(request("UserPW")))
UserName	= sqlCheck(trim(request("UserName")))
UserEmail01	= sqlCheck(trim(request("UserEmail01")))
UserEmail02	= sqlCheck(trim(request("UserEmail02")))
UserEmail	= UserEmail01&"@"&UserEmail02
UserMflagsau= sqlCheck(trim(request("UserMflagsau")))

chkRequestVal sUserID,		"회원 ID 정보가 없습니다.!"
chkRequestVal UserPW,		"회원 비밀번호 정보가 없습니다.!"
chkRequestVal UserEmail,	"회원 이메일 정보가 없습니다.!"

Dim iCnt : iCnt = 0
Sql = "SELECT IsNULL(COUNT(nvcMemberID), 0) FROM TB_MEMBER WITH(NOLOCK) "
Sql = Sql & "WHERE nvcCPCode = '"& SiteCPCode &"' "
Sql = Sql & "AND nvcMemberID	= N'"& sUserID &"' "
Sql = Sql & "AND nvcMemberPW	= N'"& Base64encode(UserPW) &"' "
Sql = Sql & "AND nvcMemberEmail = N'"& UserEmail &"' "
Sql = Sql & "AND siMemberFlag	= '1' "
Set Rs = dbSelect(Sql)
	iCnt = Rs(0)
Rs.Close	:	Set Rs = Nothing

If iCnt = 0 Then
	Call DbClose()
	chkMessageBack "해당 정보에맞는 회원내역이 없습니다.\n\n다시한번 확인 후 처리하세요~"
End If

Dim strResult, msg

DB1.BeginTrans

Sql = "UPDATE TB_MEMBER SET "
Sql = Sql & "siMemberFlag		= '0' "
Sql = Sql & ", nvcExpireDate	= GETDATE() "
Sql = Sql & ", nvcEtcINfo		= N'"& UserMflagsau &"' "
Sql = Sql & "WHERE nvcCPCode	= '"& SiteCPCode &"' "
Sql = Sql & "AND nvcMemberID	= N'"& sUserID &"' "
strResult = insertUpdateDB(Sql)

If strResult <> "Y" Then
	msg = "회원 등록(수정) 도중 오류가 발생하였습니다.\n" & strResult

	RollBackAndHistoryBack DB1, msg
Else	
	msg = "회원 탈퇴가 정상적으로 완료되었습니다."
	DB1.CommitTrans
End If

Session.Abandon()

chkMessageUrl msg, "/"
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp"--> 