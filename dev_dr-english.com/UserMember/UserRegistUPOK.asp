<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = false

%>
<!--#include virtual="/commonfiles/DBINCC/Expires.asp"-->
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<% 

Utype		= sqlCheck(trim(replace(request.Form("Utype"),"'","''")))
PName		= sqlCheck(trim(replace(request.Form("PName"),"'","''")))
PPhone_1	= sqlCheck(trim(replace(request.Form("PPhone_1"),"'","''")))
PPhone_2	= sqlCheck(trim(replace(request.Form("PPhone_2"),"'","''")))
PPhone_3	= sqlCheck(trim(replace(request.Form("PPhone_3"),"'","''")))
PEmail1		= sqlCheck(trim(replace(request.Form("PEmail1"),"'","''")))
PEmail2		= sqlCheck(trim(replace(request.Form("PEmail2"),"'","''")))

PPhone = ""	:	PEmail = ""
If Utype = "J" Then
	PPhone		= PPhone_1&"-"&PPhone_2&"-"&PPhone_3
	PEmail		= PEmail1&"@"&PEmail2
End If

'0 : 탈퇴, 1 : 가입, 2 : 대기
If Utype = "J" Then
	UserMflag = "2"
ELSE
	UserMflag = "1"
END IF

UserName	= sqlCheck(trim(replace(request.Form("UserName"),"'","''")))
UserEname	= sqlCheck(trim(replace(request.Form("UserEname"),"'","''")))
UserBirth   = sqlCheck(trim(replace(request.Form("birthday"),"'","''")))
BirthFlag	= sqlCheck(trim(replace(request.Form("birthflag"),"'","''")))
UserID		= sqlCheck(trim(replace(request.Form("UserID"),"'","''")))
UserPW		= sqlCheck(trim(replace(request.Form("UserPW"),"'","''")))

UserPost1	= sqlCheck(trim(replace(request.Form("UserPost1"),"'","''")))
UserPost2	= sqlCheck(trim(replace(request.Form("UserPost2"),"'","''")))

UserAddrs1	= sqlCheck(trim(replace(request.Form("UserAddrs1"),"'","''")))
UserAddrs2	= sqlCheck(trim(replace(request.Form("UserAddrs2"),"'","''")))

UserPost	= UserPost1&"-"&UserPost2

'########################################################## 회원 전화번호
UserPhone1_1= sqlCheck(trim(replace(request.Form("UserPhone1_1"),"'","''")))
UserPhone1_2= sqlCheck(trim(replace(request.Form("UserPhone1_2"),"'","''")))
UserPhone1_3= sqlCheck(trim(replace(request.Form("UserPhone1_3"),"'","''")))
UserPhone1	= UserPhone1_1&"-"&UserPhone1_2&"-"&UserPhone1_3

UserPhone2_1= sqlCheck(trim(replace(request.Form("UserPhone2_1"),"'","''")))
UserPhone2_2= sqlCheck(trim(replace(request.Form("UserPhone2_2"),"'","''")))
UserPhone2_3= sqlCheck(trim(replace(request.Form("UserPhone2_3"),"'","''")))
UserPhone2	= UserPhone2_1&"-"&UserPhone2_2&"-"&UserPhone2_3

UserPhoneSMS= sqlCheck(trim(replace(request.Form("UserPhoneSMS"),"'","''")))
'########################################################## 회원 전화번호

'########################################################## 회원 이메일
UserEmai1	= sqlCheck(trim(replace(request.Form("SearchEmail1"),"'","''")))
UserEmai2	= sqlCheck(trim(replace(request.Form("SearchEmail2"),"'","''")))
UserEmai3	= sqlCheck(trim(replace(request.Form("SearchEmail3"),"'","''")))
'IF UserEmai3 = "00" THEN
	Email2 = UserEmai2
'ELSE
'	Email2 = UserEmai3
'END IF 

UserEmail	= UserEmai1&"@"&Email2

UserEmailEMS= sqlCheck(trim(replace(request.Form("UserEmailEMS"),"'","''")))
'########################################################## 회원 이메일

FranCode	= sqlCheck(trim(replace(request.Form("FranCode"),"'","''")))

'##########################################################  레벨테스트 정보
LevelFlag	= sqlCheck(trim(replace(request.form("LevelFlag"),"'","''")))
SL_Cdate1	= sqlCheck(trim(replace(request.form("SL_Cdate1"),"'","''")))
SL_Ctime1	= sqlCheck(replace(trim(request.form("SL_Ctime1")),"'","''"))
SL_Ctime2	= sqlCheck(replace(trim(request.form("SL_Ctime2")),"'","''"))
SL_Ctime	= SL_Ctime1&":"&SL_Ctime2

StudentLeveL	= replace(trim(request.form("StudentLeveL")),"'","''")
UserBalanceSeq	= replace(trim(request.form("UserBalanceSeq")),"'","''")
PhoneChoice = replace(trim(request.form("PhoneChoice")),"'","''")
IF PhoneChoice="P" Then		'// 일반전화 선택
	SL_Phone=UserPhone1
ElseIf PhoneChoice="C" Then '// 휴대전화선택
	SL_Phone=UserPhone2
END IF
'##########################################################  레벨테스트 정보

chkRequestVal SiteCPCode,	"로그인 정보 오류\n관리자에게 문의해 주세요.!"

If Session("UserID") = "" Then
	chkRequestVal UserID,		"회원 ID 정보가 없습니다.!"
End If
chkRequestVal UserPW,		"회원 비밀번호 정보가 없습니다.!"

Dim Week_day
Dim Mon : Mon = "N"
Dim Tue	: Tue = "N"
Dim Wed : Wed = "N"
Dim Thu	: Thu = "N"
Dim Fri : Fri = "N"
Dim Sat	: Sat = "N"
Dim Sun : Sun = "N"
If LevelFlag = "Y" Then '레벨 테스트 신청
	Week_day=Weekday(SL_Cdate1)
	If Week_day=2 Then
		Mon = "Y"
	ElseIf Week_day=3 Then 
		Tue = "Y"
	ElseIf Week_day=4 Then 
		Wed = "Y"
	ElseIf Week_day=5 Then 
		Thu = "Y"
	ElseIf Week_day=6 Then 
		Fri = "Y"
	ElseIf Week_day=7 Then 
		Sat = "Y"
	ElseIf Week_day=1 Then 
		Sun = "Y"
	End If 
End If

'#################################################################################################################### 
'1. 회원 정보 DB 입력
'2. 레벨 테스트 정보 스케줄 입력
'#################################################################################################################### 
Dim strResult, go_Url
If Session("UserID") = "" Then 

	'##########################################################  요청 아이디 가입 중복 체크
	Dim iCount : iCount = 0
	sql = ""
	Sql = "SELECT ISNULL(COUNT(nvcMemberID), 0) FROM TB_MEMBER WITH(READUNCOMMITTED) WHERE nvcMemberID = '"& UserID &"' "

	Set Rs = dbSelect(Sql)
	iCount = Rs(0)
	Rs.Close	:	Set Rs = Nothing

	If iCount > 0 Then	
		Call DBClose()
		chkMessageBack "등록하신 아이디는 이미 가입된 아이디 입니다.\n\n다시 확인 후 가입해 주십시요."
		Response.End
	End If
	'##########################################################  요청 아이디 가입 중복 체크
		
	go_Url = "/"

	DB1.BeginTrans

	sql = ""
	sql = "INSERT INTO TB_MEMBER ( "
	sql = sql & "nvcMemberID "
	sql = sql & ", nvcMemberName "
	sql = sql & ", nvcMemberEName "
	sql = sql & ", nvcMemberTel "
	sql = sql & ", nvcMemberEmail "
	sql = sql & ", ncMemberEmailYN "
	sql = sql & ", siMemberFlag "
	sql = sql & ", nvcMemberRDate "
	sql = sql & ", ncMemberSMSYN "
	sql = sql & ", nvcMemberCTN "
	sql = sql & ", dtCreateDate "
	sql = sql & ", nvcMemberPW "
	sql = sql & ", nvcCPCode "
	sql = sql & ", nvcBirth "
	sql = sql & ", nvcZipCode "
	sql = sql & ", nvcAddress1 "
	sql = sql & ", nvcAddress2 "
	sql = sql & ", nvcParentsName "
	sql = sql & ", nvcParentsPhone "
	sql = sql & ", nvcParentsEmail "
	sql = sql & ", siBirthType "
	sql = sql & ") VALUES ( "
	sql = sql & "N'"& UserID &"' "
	sql = sql & ", N'"& UserName &"' "
	sql = sql & ", N'"& UserEName &"' "
	sql = sql & ", N'"& UserPhone1 &"' "
	sql = sql & ", N'"& UserEmail &"' "
	sql = sql & ", N'"& UserEmailEMS &"' "
	sql = sql & ", '"& UserMflag &"' "
	sql = sql & ", N'"& Date() &"' "
	sql = sql & ", N'"& UserPhoneSMS &"' "
	sql = sql & ", N'"& UserPhone2 &"' "
	sql = sql & ", GETDATE() "
	sql = sql & ", N'"& Base64encode(UserPW) &"' "
	sql = sql & ", N'"& SiteCPCode &"' "
	sql = sql & ", N'"& UserBirth &"' "
	sql = sql & ", N'"& UserPost &"' "
	sql = sql & ", N'"& UserAddrs1 &"' "
	sql = sql & ", N'"& UserAddrs2 &"' "
	sql = sql & ", N'"& PName &"' "
	sql = sql & ", N'"& PPhone &"' "
	sql = sql & ", N'"& PEmail &"' "
	sql = sql & ", '"& BirthFlag &"' "
	sql = sql & "); "
	strResult = insertUpdateDB(sql)
Else
'##########################################################  회원 정보 DB 수정
	go_Url = "UserModify.asp"

	DB1.BeginTrans

	sql = ""
	sql = "UPDATE TB_MEMBER SET "	
	sql = sql & "nvcMemberEName		= N'"& UserEName &"' "
	sql = sql & ", nvcMemberPW		= N'"& Base64encode(UserPW) &"' "
	sql = sql & ", nvcZipCode		= N'"& UserPost &"' "
	sql = sql & ", nvcAddress1		= N'"& UserAddrs1 &"' "
	sql = sql & ", nvcAddress2		= N'"& UserAddrs2 &"' "
	sql = sql & ", nvcMemberTel		= N'"& UserPhone1 &"' "
	sql = sql & ", nvcMemberCTN		= N'"& UserPhone2 &"' "
	sql = sql & ", ncMemberSMSYN	= N'"& UserPhoneSMS &"' "
	sql = sql & ", nvcMemberEmail	= N'"& UserEmail &"' "
	sql = sql & ", ncMemberEmailYN	= N'"& UserEmailEMS &"' "
	'sql = sql & ", siBirthType		= '"& BirthFlag &"' "
	sql = sql & "WHERE nvcCPCode = N'"& SiteCPCode &"' AND nvcMemberID = N'"& Session("UserID") &"' "

	strResult = insertUpdateDB(sql)
End If

If strResult <> "Y" Then 
	msg = "회원 등록(수정) 도중 오류가 발생하였습니다.\n" & strResult
       
	'/*********************************/
    RollBackAndHistoryBack DB1, msg
    '/*********************************/
Else
	'/*************************************/
    DB1.CommitTrans
	'/*************************************/
	
		msg = "회원 등록(수정)이 완료 되었습니다."
	
End If 

'###########################################################################################
'회원 가입시 레벨 테스트 신청과 회원가입이 정상적으로 이뤄진 경우 
'###########################################################################################
If LevelFlag = "Y" And Session("UserID") = "" And strResult = "Y" Then 

	Dim iMemberSeq
	sql = ""
	Sql = "SELECT iMemberSeq FROM TB_MEMBER WITH(NOLOCK) WHERE nvcMemberID = N'"& UserID &"'"
	Set Rs			 = dbSelect(Sql) 
	If Not Rs.Eof Then
		iMemberSeq = Rs(0)
	End If
	Rs.Close	:	Set Rs = Nothing


	'DB1.BeginTrans

	sql = ""
	sql = "INSERT INTO TB_LEVELTEST ( "
	sql = sql & "nvcCPCode "
	sql = sql & ", nvcLevelTestDay "
	sql = sql & ", nvcLevelTestTime "
	sql = sql & ", nvcWishTime1 "
	sql = sql & ", ncLevelTestYN "
	sql = sql & ", iCourseSeq "
	sql = sql & ", iMemberSeq "
	sql = sql & ", dtCreateDate "
	sql = sql & ", ncCCheckYN "
	sql = sql & ", ncTCheckYN "
	sql = sql & ", iScheTypeSeq "
	sql = sql & ", iCLCourseSeq "
	sql = sql & ", iBalanceCourseSeq "
	sql = sql & ", siPlayTime "
	sql = sql & ", ncMon "
	sql = sql & ", ncTue "
	sql = sql & ", ncWed "
	sql = sql & ", ncThu "				
	sql = sql & ", ncFri "
	sql = sql & ", ncSat "
	sql = sql & ", ncSun "
	sql = sql & ", nvcScheTel "
	sql = sql & ") VALUES ( "
	sql = sql & "N'"& SiteCPCode &"' "
	sql = sql & ", N'"& SL_Cdate1 &"' "
	sql = sql & ", N'"& SL_Ctime &"' "
	sql = sql & ", N'"& SL_Ctime &"' "
	sql = sql & ", N'N' "
	sql = sql & ", '1' "	'과목 설정 값 1 : English로 설정
	sql = sql & ", '"& iMemberSeq &"' "	
	sql = sql & ", GETDATE() "
	sql = sql & ", N'N' "
	sql = sql & ", N'N' "
	sql = sql & ", '2' "	'수업 방식 전화 방식으로 설정
	sql = sql & ", '"& StudentLeveL &"' "
	sql = sql & ", '"& UserBalanceSeq &"' "
	sql = sql & ", '10' "	'레벨테스트는 10분 수업 설정
	sql = sql & ", N'"& Mon &"' "
	sql = sql & ", N'"& Tue &"' "
	sql = sql & ", N'"& Wed &"' "
	sql = sql & ", N'"& Thu &"' "
	sql = sql & ", N'"& Fri &"' "
	sql = sql & ", N'"& Sat &"' "
	sql = sql & ", N'"& Sun &"' "
	sql = sql & ", N'"& SL_Phone &"' "
	sql = sql & ") "				
	'strResult = insertUpdateDB(sql)

	'If strResult <> "Y" Then 
	'	msg = "회원가입시 신청한 레벨테스트 등록 중 오류가 발생하였습니다.\n" & strResult
		   
		'/*********************************/
	'	RollBackAndHistoryBack DB1, msg
		'/*********************************/
	'Else
	'   msg = "회원 등록 및 레벨테스트 신청이 완료 되었습니다."

		'/*************************************/
	'	DB1.CommitTrans
		'/*************************************/
	'End If 
End If
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp"--> 
<FORM action="<%=go_Url%>" name="Form" method="post">
<INPUT TYPE="hidden" name="LevelFlag" value="<%=LevelFlag%>">
</FORM>
<script language="JavaScript">
alert("<%=MSG%>");
document.Form.submit();
</script>