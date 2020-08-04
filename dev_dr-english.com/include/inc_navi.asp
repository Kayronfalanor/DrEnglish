<%
'##### 페이지 네비 설정
Dim pageSubNavi
Select Case(mMenu)
	Case "0"	:
		pageSubNavi = "회원정보"
		Select Case(sMenu)
			Case "0"	: pageSubNavi = "로그인"
			Case "1"	: pageSubNavi = pageSubNavi & " > 회원가입"
			Case "2"	: pageSubNavi = pageSubNavi & " > ID/PW찾기"
			Case "3"	: pageSubNavi = pageSubNavi & " > 회원정보수정"
			Case "4"	: pageSubNavi = pageSubNavi & " > 이용약관"
			Case "5"	: pageSubNavi = pageSubNavi & " > 개인정보보호정책"
			Case "6"	: pageSubNavi = pageSubNavi & " > 회원탈퇴"

			'회원 가입 경로
			Case "11"	: pageSubNavi = pageSubNavi & " > 회원가입 > 약관동의 및 실명확인 "
			Case "12"	: pageSubNavi = pageSubNavi & " > 회원가입 > 정보입력"
			Case "13"	: pageSubNavi = pageSubNavi & " > 회원가입 > 가입완료"
		End Select
	Case "1"	:
		pageSubNavi = "마이노트"
		Select Case(sMenu)
			Case "1"	: pageSubNavi = pageSubNavi & " > 학습현황"
			Case "2"	: pageSubNavi = pageSubNavi & " > 나의 성적표"
			Case "3"	: pageSubNavi = pageSubNavi & " > 영어일기"
			Case "4"	: pageSubNavi = pageSubNavi & " > To, My teacher"
			'Case "5"	: pageSubNavi = pageSubNavi & " > 휴강신청"
		End Select
	Case "2"	:	
		pageSubNavi = "학습시스템"
		Select Case(sMenu)
			Case "1"	: pageSubNavi = pageSubNavi & " > 사이트소개"
			Case "2"	: pageSubNavi = pageSubNavi & " > 프로그램구성"
			Case "3"	: pageSubNavi = pageSubNavi & " > 강사소개"
			Case "4"	: pageSubNavi = pageSubNavi & " > 프로그램구성 > 원어민 Speaking 과정"
			Case "5"	: pageSubNavi = pageSubNavi & " > 프로그램구성 > 원어민 Writing 과정"
		End Select
	Case "3"	:
		pageSubNavi = "수강신청"
		Select Case(sMenu)
			Case "1"	: pageSubNavi = pageSubNavi & " > 수강안내"
			Case "2"	: pageSubNavi = pageSubNavi & " > 수강신청"
			Case "3"	: pageSubNavi = pageSubNavi & " > 수강신청내역"
			Case "4"	: pageSubNavi = pageSubNavi & " > 무료레벨테스트"
		End Select
	Case "4"	:
		pageSubNavi = "콘텐츠"
		Select Case(sMenu)
			Case "1"	: pageSubNavi = pageSubNavi & " > 오늘의 영어 한마디"
			Case "2"	: pageSubNavi = pageSubNavi & " > 유용한 표현"
			Case "3"	: pageSubNavi = pageSubNavi & " > JollyGo Advance"
		End Select
	Case "5"	:
		pageSubNavi = "커뮤니티"
		Select Case(sMenu)
			Case "1"	: pageSubNavi = pageSubNavi & " > 수업후기"
			Case "2"	: pageSubNavi = pageSubNavi & " > 영어끝말잇기"
			Case "3"	: pageSubNavi = pageSubNavi & " > 영어수다떨기"
		End Select
	Case "6"	:
		pageSubNavi = "고객지원"
		Select Case(sMenu)
			'Case "0"	: pageSubNavi = pageSubNavi & " > 사이트맵"
			Case "1"	: pageSubNavi = pageSubNavi & " > 화상영어가이드"
			'Case "2"	: pageSubNavi = pageSubNavi & " > 공지사항"
			'Case "3"	: pageSubNavi = pageSubNavi & " > Special Event"
			'Case "4"	: pageSubNavi = pageSubNavi & " > 보도자료"
			Case "5"	: pageSubNavi = pageSubNavi & " > 자주묻는 질문"
			'Case "6"	: pageSubNavi = pageSubNavi & " > 묻고 답하기"
			Case "7"	: pageSubNavi = pageSubNavi & " > 프로그램 다운로드"
			Case "8"	: pageSubNavi = pageSubNavi & " > 원격지원센터"
		End Select
End Select
%>