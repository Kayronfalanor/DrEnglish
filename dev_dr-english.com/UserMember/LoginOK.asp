<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = False

'// Parameters
Dim uid : uid = sqlCheck(Replace(Request.Form("id"),		"'", "''"))
Dim upw : upw = sqlCheck(Replace(Request.Form("password"),	"'", "''"))
ReturnUrl	  = sqlCheck(Replace(Request.Form("returnUrl"), "'", "''"))

uid = replace (uid,"<%","&lt;%")
uid = replace (uid,"%\>","%&gt;")
uid = replace (uid,"|","")
'uid = replace (uid,"(","")
'uid = replace (uid,")","")
uid = replace (uid,"&","")
uid = replace (uid,"'","")
uid = replace (uid,"+","")
uid = replace (uid,",","")
uid = replace (uid,"\","")

upw = replace (upw,"<%","&lt;%")
upw= replace (upw,"%\>","%&gt;")
upw = replace (upw,"|","")
'upw = replace (upw,"(","")
'upw = replace (upw,")","")
upw = replace (upw,"&","")
upw = replace (upw,"'","")
upw = replace (upw,"+","")
upw = replace (upw,",","")
upw = replace (upw,"\","")
%>
<!--#include virtual="/commonfiles/DBINCC/Expires.asp"-->
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
chkRequestVal SiteCPCode,	"로그인 정보 오류\n관리자에게 문의해 주세요.!"
chkRequestVal uid,			"로그인 정보가 없습니다.!"
chkRequestVal upw,			"로그인 정보가 없습니다.!"

Dim Sql, objRs
Dim bLogin : bLogin = False
Sql = "PRC_tb_Member_User_Select_View N'"& SiteCPCode &"', N'"& uid &"'"
Set objRs = dbSelect(Sql)

If Not (objRs.Eof And objRs.Bof) Then
	If Trim(Base64decode(objRs("nvcMemberPW"))) = Trim(upw) Then
		bLogin = True

		session("UserID")		= objRs("nvcMemberID")		'// 회원 아이디
		session("UserPW")		= objRs("nvcMemberPW")		'// 회원 패스워드
		session("UserName")		= objRs("nvcMemberName")	'// 회원 이름
		session("UserEName")	= objRs("nvcMemberEName")	'// 회원 영문이름
		session("UserCPCode")	= objRs("nvcCPCode")		'// 회원 소속 CP 코드
		session("UserPhone")	= objRs("nvcMemberCTN")	'// 회원 휴대 전화
		session("UserSeq")		= objRs("iMemberSeq")		'// 회원 테이블 고유 번호
		session("UserPRole")	= "4"					'// 글쓰기 권한
	End If
End If
objRs.Close	:	Set objRs = Nothing

Dim strUrl : strUrl = "/mypage/mypage.asp"
If Len(Trim(ReturnUrl)) > 0 Then
	strUrl = ReturnUrl
End If

If bLogin Then
	Response.Redirect strUrl
Else
	chkMessageUrl "로그인 실패.", "/UserMember/LoginPage.asp"
End If
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp" -->