﻿<%
TitleName="UpsideDown 화상 영어 ::::::::::::::::::::::::::::::::::::::::"
subTitleName="UpsideDown 화상 영어"

AdminMail=""   '//관리자 메일
SMS_Phone1=""
SMS_Phone2=""
SMS_Phone3=""

site___url_real = lcase(request.servervariables("http_host"))
site___url_HAHA = replace(site___url_real,"http://","")
site___url		= replace(site___url_HAHA,"www.","")

SiteCPCode	= Application("CP_Code")				'// cp code
SiteCall    = Application("CP_Call")				'//cp 고객센터 전화번호
sUserID		= session("UserID")						'// 회원 아이디
sUserPW		= session("UserPW")						'// 회원 패스워드
sUserName	= session("UserName")					'// 회원 이름
sUserEName	= session("UserEName")					'// 회원 영문이름
sUserCPCode	= session("UserCPCode")					'// 회원 소속 CP 코드
sUserSeq	= session("UserSeq")					'// 회원 테이블 고유 번호
sUserPRole	= session("UserPRole")					'// 글쓰기 권한
sUserIP		= Request.ServerVariables("REMOTE_ADDR")'// 접속 IP 아이피


'c_agent = Request.ServerVariables("HTTP_USER_AGENT")


'로그인 요청 페이지 URL, Parameters
Dim returnUrl, returnParam

'커뮤니트 게시판 코드
Dim BBS01 : BBS01 = "B01" '//공지사항
Dim BBS02 : BBS02 = "B02" '//강사소개
Dim BBS03 : BBS03 = "B03" '//보도자료
Dim BBS04 : BBS04 = "B04" '//수업후기
Dim BBS05 : BBS05 = "B05" '//QNA
Dim BBS06 : BBS06 = "B06" '//오늘의 영어 한마디
Dim BBS08 : BBS07 = "B07" '//유용한 표현
Dim BBS07 : BBS08 = "B08" '//To My Teacher
Dim BBS09 : BBS09 = "B09" '//영어 일기
Dim BBS10 : BBS10 = "B10" '//FAQ
Dim BBS11 : BBS11 = "B11" '//JollyGo Advance
Dim BBS12 : BBS12 = "B12" '//불만사항
Dim BBS13 : BBS13 = "B13" '//이벤트

'게시판 업파일 저장장소 ==> http 주소
Dim lms_file_url	: lms_file_url	= "http://admin.dr-english.com/uploadfile/"
'게시판 업파일 저장장소 ==> 물리적 주소
Dim lms_file_path	: lms_file_path= "C:\WEBSITE\admin.dr-english.com\uploadFile\"

Dim BBSURL(14)
BBSURL(1)	= lms_file_url & "Board/" & SiteCPCode & "/" & BBS01 & "/"
BBSURL(2)	= lms_file_url & "Board/Commons/"  & BBS02 & "/"
BBSURL(3)	= lms_file_url & "Board/" & SiteCPCode & "/"  & BBS03 & "/"
BBSURL(4)	= lms_file_url & "Board/" & SiteCPCode & "/"  & BBS04 & "/"
BBSURL(5)	= lms_file_url & "Board/" & SiteCPCode & "/"  & BBS05 & "/"
BBSURL(6)	= lms_file_url & "Board/Commons/"  & BBS06 & "/"
BBSURL(7)	= lms_file_url & "Board/Commons/"  & BBS07 & "/"
BBSURL(8)	= lms_file_url & "Board/" & SiteCPCode & "/"  & BBS08 & "/"
BBSURL(10)	= lms_file_url & "Board/" & SiteCPCode & "/" & BBS10 & "/"
BBSURL(11)	= lms_file_url & "Board/Commons/" & BBS11 & "/"
BBSURL(12)	= lms_file_url & "Board/" & SiteCPCode & "/"  & BBS12 & "/"
BBSURL(13)	= lms_file_url & "Board/" & SiteCPCode & "/"  & BBS13 & "/"
BBSURL(14)	= lms_file_url & "Board/" & SiteCPCode & "/" & BBS10 & "/"

Dim BBSPath(14)
BBSPath(1)	= lms_file_path & "Board\" & SiteCPCode & "\" & BBS01 & "\"
BBSPath(2)	= lms_file_path & "Board\Commons\" & BBS02 & "\"
BBSPath(3)	= lms_file_path & "Board\" & SiteCPCode & "\"  & BBS03 & "\"
BBSPath(4)	= lms_file_path & "Board\" & SiteCPCode & "\"  & BBS04 & "\"
BBSPath(5)	= lms_file_path & "Board\" & SiteCPCode & "\"  & BBS05 & "\"
BBSPath(6)	= lms_file_path & "Board\Commons\" & BBS06 & "\"
BBSPath(7)	= lms_file_path & "Board\Commons\" & BBS07 & "\"
BBSPath(8)	= lms_file_path & "Board\" & SiteCPCode & "\"  & BBS08 & "\"
BBSPath(9)	= lms_file_path & "Board\" & SiteCPCode & "\"  & BBS09 & "\"
BBSPath(10)	= lms_file_path & "Board\" & SiteCPCode & "\" & BBS10 & "\"
BBSPath(11)	= lms_file_path & "Board\Commons\" & BBS11 & "\"
BBSPath(12)	= lms_file_path & "Board\" & SiteCPCode & "\"  & BBS12 & "\"
BBSPath(13)	= lms_file_path & "Board\" & SiteCPCode & "\"  & BBS13 & "\"
BBSPath(14)	= lms_file_path & "Board\" & SiteCPCode & "\" & BBS10 & "\"

'수강신청시 신청개월
Dim MinMonth	:	MinMonth = "1"
Dim MaxMonth	:	MaxMonth = "1"
Dim strShortYN  :   strShortYN="N"
Dim PGPlatform : PGPlatform="test"

'화상연결 url
Dim VideoClassURL : VideoClassURL="http://admin.dr-english.com/ClassConfig/VideoLink.asp"

Dim MobileVideoClassURL : MobileVideoClassURL="http://admin.dr-english.com/ClassConfig/VideoLink.asp"

'화상녹화파일 url
Dim VideoDownloadURL : VideoDownloadURL="http://admin.dr-english.com/ClassConfig/VideoDownLoad.asp"

'전화녹화파일 url
Dim PhoneDownloadURL : PhoneDownloadURL="http://admin.dr-english.com/ClassConfig/PhoneDownLoad.asp"

Dim VideoClassFile : VideoClassFile=""



ClassFilepath    =  lms_file_path & "TextBook\"
ClassFileUrl    =  lms_file_url & "TextBook/"


%>
<!--#include virtual="/commonfiles/DBINCC/Base64.asp" -->


<%
	pthispage= REQUEST.SERVERVARIABLES("URL")



	If instr(UCASE(pthispage),"/MYPAGE/")  > 0  Or instr(UCASE(pthispage),"/SITEPAGE/")  > 0  Or instr(UCASE(pthispage),"/USERMEMBER/")  > 0  THEN

%>
<!--#include virtual="/include/inc_SiteConfig.asp" -->
<%


	End If


%>
