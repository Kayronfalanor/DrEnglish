<%
''---------------------------------------------------------------------------------------------------
''**
''**	Filename : stringUtil.asp
''**	Comment : 문자열 관련 처리 함수 집단
''**	History : 2012/12/27. By 나세형
''**
''**	@Version : 20121227001
''**	@Author : Copyright(c) 2012. SaehaENS.com. All Rights Reserved
''**
''---------------------------------------------------------------------------------------------------

''**	[함수 개요]
''**		NULL 값을 공백 값으로 치환한다.
''**		사이트 전체에서는 NULL 값에 대한 처리를 회피하는 것을 원칙으로 함
''**	[파라미터]
''**		strOrgValue : 원본 문자열
''**	[리턴 값]
''**		NULL 값만으로 구성되어 있을 경우 NULL을 배제시킨 공백값을 리턴
''**		NULL 값이 존재하지 않는다면 원본 문자열을 그대로 리턴

Function GF_CvtNullToEmpty(strOrgValue)

	If IsNull(strOrgValue) Then
		GF_CvtNullToEmpty = ""
	Else
		GF_CvtNullToEmpty = strOrgValue
	End If

End Function


''**	[함수 개요]
''**		입력된 문자열 중 특별히 선정된 캐릭터를 HTML 포맷으로 변경하는 함수
''**		html tag 입력에 대한 제한을 두는 경우에 사용
''**	[파라미터]
''**		strOrgValue : 원본 문자열
''**	[리턴 값]
''**		원본 문자열에서 "<", ">" 문자를 치환한 결과

Function GF_HtmlSpecialChars(strOrgValue)

	GF_HtmlSpecialChars = Replace(Replace(GF_CvtNullToEmpty(strOrgValue),"<", "&lt;"), ">", "&gt;")

End Function


''**	[함수 개요]
''**		입력된 숫자 값을 자리수가 표현되는 숫자로 변환하는 함수
''**		기본 양수에 대한 처리 및 음수에 대한 처리도 병행 처리
''**	[파라미터]
''**		vntSrcNumber : 원본 숫자
''**	[리턴 값]
''**		정상 처리 결과 : 자리수 표현된 문자열 리턴
''**		숫자가 아닌 문자열이 파라미터로 들어온 경우 : 0리턴

Function GF_MakeCurrency(vntSrcNumber)

	If IsNumeric(vntSrcNumber) Then
		GF_MakeCurrency = FormatNumber(vntSrcNumber, 0)
	Else
		GF_MakeCurrency = 0
	End If

End Function


''**	[함수 개요]
''**		GF_RoundingEx 함수가 복잡한 관계로 파라미터 간소화를 통해
''**		정수형 올림, 버림, 반올림 연산을 수행하는 함수
''**	[파라미터]
''**		vntSrcNumber : 원본 숫자
''**		Action Kind [1] : 올림, [2] : 반올림, [3] : 버림
''**	[리턴 값]
''**		정상 처리 결과 : 올림, 반올림, 버림 연산 처리한 결과 리턴
''**		숫자가 아닌 문자열이 파라미터로 들어온 경우 : 0리턴

Function GF_Rounding(vntSrcNumber, nActionKind)

	''**	연산 처리 후 결과 값을 리턴한다.
	GF_Rounding = GF_RoundingEx(vntSrcNumber, nActionKind, 1, 1)

End Function


''**	[함수 개요]
''**		입력된 숫자를 올림, 버림, 반올림을 실행한 후 값을 리턴하는 함수
''**	[파라미터]
''**		vntSrcNumber : 원본 숫자
''**		Action Kind [1] : 올림, [2] : 반올림, [3] : 버림
''**		Digit : 연산 대상이 되는 자릿수 (소숫 자리수)
''**		Rounding Kind [1] : Standard Rounding, [2] : Bankers Rounding
''**	[리턴 값]
''**		정상 처리 결과 : 올림, 반올림, 버림 연산 처리한 결과 리턴
''**		숫자가 아닌 문자열이 파라미터로 들어온 경우 : 0리턴

Function GF_RoundingEx(vntSrcNumber, nActionKind, nDigit, nRoundingKind)

	Dim vntReturnValue			''**	선택된 연산 작업을 완료하고 리턴되는 변수

	Dim lBasePointer			''**	기준 소수점을 조정하기 위한 포인터 값
	Dim vntUpperBaseBuffer		''**	조정된 기준 소수점을 저장하는 변수
	Dim vntCvtRtnValue			''**	신규로 생성된 기준 소수점의 정수부

	''**	입력된 원본 숫자 값에 숫자가 아닌 문자가 존재하지 않을 때만
	''**	숫자 값 처리를 시도한다.
	If IsNumeric(vntSrcNumber) Then

		''**	기준 소수점 수준을 높이기 위한 기준 숫자를 생성한다.
		lBasePointer = (10 ^ (nDigit - 1) )

		''**	기준 소수점을 높인다.
		vntUpperBaseBuffer = vntSrcNumber * lBasePointer

		''**	생성된 기준 소수점의 절대 값을 구한다.
		vntCvtRtnValue = (Int)(vntUpperBaseBuffer)

		''**	Action Kind 값에 따라 처리한다.
		Select Case nActionKind

		''**	올림 처리
		Case 1 :

			''**	원본 데이타가 절대 값 보다 크다면 올림 수 대상이 되므로
			''**	별도 올림을 처리한다.
			If vntUpperBaseBuffer > vntCvtRtnValue Then
				vntReturnValue = vntCvtRtnValue + 1
			Else
				vntReturnValue = vntCvtRtnValue
			End If

		''**	반올림 처리 (반올림 종류에 따라 분기 처리한다)
		Case 2 :
			If nRoundingKind = 1 Then

				''**	기준 소수점을 한 단계 더 높여서
				''**	가장 마지막 숫자의 처리 기준을 생성한다.

				If CInt(Right((Int)(vntUpperBaseBuffer*10),1)) >= 5 Then
					vntReturnValue = GF_RoundingEx(vntUpperBaseBuffer, 1, 1, nRoundingKind)
				Else
					vntReturnValue = GF_RoundingEx(vntUpperBaseBuffer, 1, 3, nRoundingKind)
				End If
			Else
				vntReturnValue = Round(vntCvtRtnValue, nDigit - 1)
			End If

		''**	버림 처리
		Case 3 :
			vntReturnValue = vntCvtRtnValue

		End Select

		''**	처리가 완료된 후 올린 기준 소스점 만큼 값을 내린다.
		vntReturnValue = vntReturnValue / lBasePointer

	Else
		''**	숫자가 아닌 데이타가 넘어온 관계로 그냥 0 값만 반환한다.
		vntReturnValue = 0
	End If

	''**	처리된 값을 반환한다.
	GF_RoundingEx = vntReturnValue

End Function


''**	[함수 개요]
''**		다양하게 요구될 수 있는 날짜 포맷에 맞게 입력된 날짜를 수정 후 반환하는 함수.
''**		기본적으로 허용되는 날짜 Format은 YYYY-MM-DD hh:mm:ss이고, MS-SQL기반으로
''**		추출된 YYYY-MM-DD 오전[오후] hh:mm:ss Format도 정상 변경 가능.
''**	[파라미터]
''**		strOrgDateTime : Format에 맞게 수정할 원본 날짜의 데이터, 요구되는 기본 파라미터 Format은 YYYY-MM-DD hh:mm:ss
''**		nDateFormat
''**			[1] : YYYY-MM-DD hh:mm:ss Format으로 입력된 날짜를 수정 후 반환
''**			[2] : YYYY-MM-DD Format으로 입력된 날짜를 수정 후 반환
''**			[3] : YYYY.MM.DD hh:mm:ss Format으로 입력된 날짜를 수정 후 반환
''**			[4] : YYYY.MM.DD Format으로 입력된 날짜를 수정 후 반환
''**			[5] : YYYY/MM/DD hh:mm:ss Format으로 입력된 날짜를 수정 후 반환
''**			[6] : YYYY/MM/DD Format으로 입력된 날짜를 수정 후 반환
''**			[7] : YY-MM-DD hh:mm:ss Format으로 입력된 날짜를 수정 후 반환
''**			[8] : YY-MM-DD Format으로 입력된 날짜를 수정 후 반환
''**			[9] : YY.MM.DD hh:mm:ss Format으로 입력된 날짜를 수정 후 반환
''**			[10] : YY.MM.DD Format으로 입력된 날짜를 수정 후 반환
''**			[11] : YY/MM/DD hh:mm:ss Format으로 입력된 날짜를 수정 후 반환
''**			[12] : YY/MM/DD Format으로 입력된 날짜를 수정 후 반환
''**	[리턴 값]
''**		Format 변경이 정상 적으로 완료되면 nDateFormat 값에 따라 Format이 변경된 날짜 데이터가 리턴된다.

Function GF_MakeDateFormat(strOrgDateTime, nDateFormat)

	''**	원본 날짜 데이타를 처리하기 위해 필요한 Split 저장 배열 변수
	Dim arrSptDateTime
	Dim arrSptDateInfo		''**	원본 DateTime에서 Date 관련 데이타 추출 후 Split 결과를 저장하는 변수
	Dim arrSptTimeInfo		''**	원본 DateTime에서 Time 관련 데이타 추출 후 Split 결과를 저장하는 변수

	''**	날짜 Format 이 맞지 않는다면 Format 문자로 변경한다.
	If InStr(strOrgDateTime, ":") = 0 Then
		strOrgDateTime = Trim(strOrgDateTime) & " 00:00:00"
	End If

	''**	원본 데이타에서 날짜와 시간을 나눈다.
	arrSptDateTime = Split(strOrgDateTime, " ")

	If UBound(arrSptDateTime) = 1 Then

		''**	날짜를 원소 단위로 분할 한다.
		arrSptDateInfo = Split(arrSptDateTime(0), "-")

		''**	시간을 원소 단위로 분할 한다.
		arrSptTimeInfo = Split(arrSptDateTime(1), ":")

	Else
		''**	날짜를 원소 단위로 분할 한다,
		arrSptDateInfo = Split(arrSptDateTime(0), "-")

		''**	시간을 원소 단위로 분할 한다.
		arrSptTimeInfo = Split(arrSptDateTime(2), ":")

		''**	오전 또는 오후 구분 데이타가 별도로 존재하는 관계로
		''**	필요한 만큼의 시간을 더해준다.
		If arrSptDateTime(1) = "오후" And CInt(arrSptTimeInfo(0)) <> 12 Then
			arrSptTimeInfo(0) = CStr(CInt(arrSptTimeInfo(0)) + 12)
		End If
	End If

	Dim cDateDelimiter		''**	Date Type의 Delimiter 저장 변수

	''**	DateFormat에 맞게 Return DateTime을 생성한다.
	Select Case CInt(nDateFormat)
		Case 1, 2, 7, 8 : cDateDelimiter = "-"
		Case 3, 4, 9, 10 : cDateDelimiter = "."
		Case 5, 6, 11, 12 : cDateDelimiter = "/"
	End Select

	Dim strRtnDateTime		''**	리턴 DateTime 저장 변수

	''**	Time 데이타를 리턴하는지에 대한 여부를 결정한다.
	If (CInt(nDateFormat) Mod 2) = 0 Then
		strRtnDateTime = arrSptDateInfo(0) & cDateDelimiter & arrSptDateInfo(1) & cDateDelimiter & arrSptDateInfo(2)
	Else
		strRtnDateTime = arrSptDateInfo(0) & cDateDelimiter & arrSptDateInfo(1) & cDateDelimiter & arrSptDateInfo(2) & " " & arrSptTimeInfo(0) & ":" & arrSptTimeInfo(1) & ":" & arrSptTimeInfo(2)
	End If

	''**	생성된 DateTime 값을 리턴한다.
	GF_MakeDateFormat = strRtnDateTime

End Function

''**	[함수 개요]
''**		문자열에 포함되어 있는 Quote 문자를 처리하는 함수
''**	[파라미터]
''**		strSrcString : 원본 문자열
''**		nActionKind [1] : Quote 문자를 모두 삭제, [2] : Single Quote를 Double Quote 문자로 변경
''**	[리턴 값]
''**		Quote가 삭제 되거나, Double Quote로 수정된 문자열 리턴

Function GF_QuoteManager(strSrcString, nActionKind)

	If nActionKind = 1 Then
		GF_QuoteManager = Replace(strSrcString, "'", "")
	Else
		GF_QuoteManager = Replace(strSrcString, "'", "''")
	End If

End Function

''**	[함수 개요]
''**		문자열에 포함되어 있는 Carrige Return 값을 <br>로 변환 처리하는 함수
''**	[파라미터]
''**		strSrcString : 원본 문자열
''**	[리턴 값]
''**		Carrige Return 값을 <br>로 처리한 문자열을 리턴

Function GF_CRManager(strSrcString)

	GF_CRManager = Replace(strSrcString, Chr(13), "<br />")

End Function

''**	[함수 개요]
''**		GET, POST로 넘긴 파라미터 값을 리턴 받는 함수
''**	[파라미터]
''**		strParamKey : GET, POST 파라미터 이름
''**	[리턴 값]
''**		파라미터 이름에 해당하는 값을 리턴 (SQL Injection 방어 함수 실행 후 결과 값)''**

Function GF_GetParamValue(strParamKey)

	''**	공용 Object를 선언한다.
	With Request

		''**	HTTP Method 방식에 따라 파라미터 변수 값을 리턴 변수에 저장한다.
		''**	SQL Injection 방어 함수 (GF_MakeStringShield) 실행 후 결과 값을 리턴한다.
		If .QueryString(strParamKey) = "" Then
			GF_GetParamValue = GF_MakeStringShield(.Form(strParamKey))
		Else
			GF_GetParamValue = GF_MakeStringShield(.QueryString(strParamKey))
		End If

	End With

End Function

''**	[함수 개요]
''**		SQL Injection을 시도하기 위해 필요한 문자를 Replace하는 함수
''**	[파라미터]
''**		strOrgString : 원본 문자열
''**	[리턴 값]
''**		정상적인 처리가 되면, strOrgString값에 포함되어 있는 ";", "'" 문자는
''**		각 각 &#59;, &#39;로 치환 처리 후 문자열을 반환한다.

Function GF_MakeStringShield(strOrgString)

	''**	SQL를 불법적으로 조합하기 위해 필요한 필수 문자를
	''**	실행 안되도록 방어 캐릭터로 변환한다.
	''**	향후 방어할 필요가 있는 문자가 생기면 추가...
	'strOrgString = Replace(strOrgString, ";", "；")
	'strOrgString = Replace(strOrgString, "'", "′")
	'strOrgString = Replace(strOrgString, ":", "#!A")
	strOrgString = Replace(strOrgString, "[null]", "#!B")
	strOrgString = Replace(strOrgString, "[return]", "#!C")
	strOrgString = Replace(strOrgString, "[space]", "#!I")
	'strOrgString = Replace(strOrgString, "..", "#!J")
	strOrgString = Replace(strOrgString, "'", "''")
	strOrgString = Replace(strOrgString, "--", "")
	strOrgString = Replace(strOrgString, "+", "")
	strOrgString = Replace(strOrgString, "@@variable", "")
	strOrgString = Replace(strOrgString, "PRINT", "")
	strOrgString = Replace(strOrgString, "SET", "")
	strOrgString = Replace(strOrgString, "%", "")
	strOrgString = Replace(strOrgString, "..OR 1=1", "")
	strOrgString = Replace(strOrgString, "UNION", "")
	strOrgString = Replace(strOrgString, "INSERT", "")
	strOrgString = Replace(strOrgString, "PRINT", "")
	strOrgString = Replace(strOrgString, "DELETE", "")
	strOrgString = Replace(strOrgString, "TRUNCATE", "")
	 strOrgString = Replace(strOrgString, "xp_", "")
	 strOrgString = Replace(strOrgString, "cmd", "")

	''**	처리된 결과를 리턴한다.
	GF_MakeStringShield = Trim(strOrgString)

End Function

''**	[함수 개요]
''**		Master, Slave Split 문자를 기반으로 문자열을 배열로 리턴하는 함수
''**	[파라미터]
''**		기본 문자열, Master Split 문자, Slave Split 문자,
''**	[리턴 값]
''**		기준 데이타로 Split 후 2차원 배열을 리턴한다.
''**		배열 포맷은 아래와 같다.
''**		arrBuf(N,0) = [필드 1], arrBuf(N,1) = [필드 2], .., arrBuf(N,N) = [필드 N]
''**		.
''**		.
''**		arrBuf(N+M,0) = [필드 1], arrBuf(N+M,1) = [필드 2], .., arrBuf(N+M,N) = [필드 N]

Function GF_MagicStringSpt(strMagicString, strMasterDiv, strSlaveDiv, nFieldSize)

	''**	문자열 처리전에 NULL인지 확인하고 NULL이면 공백 값으로 대체한다.
	strMagicString = GF_CvtNullToEmpty(strMagicString)

	''**	처리 필요 변수를 선언한다.
	Dim arrBufFirstStep, arrBufFinalStep, nFirstLoopCnt, nSecondLoopCnt

	''**	Master 단위별 정보를 Split 한다.
	''**	입력 값은 Null 값에 대한 대비를 위해 NULL 값을 공백 값으로 대체한다.
	arrBufFirstStep = Split(strMagicString, strMasterDiv)

	If strMagicString <> "" And UBound(arrBufFirstStep) <> -1 Then

		''**	리턴 값 저장할 변수를 선언한다.
		Redim arrReturnBuf(UBound(arrBufFirstStep),nFieldSize - 1)

		For nFirstLoopCnt = 0 To UBound(arrBufFirstStep) Step 1

			''**	Slave 정보를 Slave 단위별로  Split 한다.
			arrBufFinalStep = Split(arrBufFirstStep(nFirstLoopCnt), strSlaveDiv)

			''**	Slave 정보를 Split된 필드별로 저장한다.
			For nSecondLoopCnt = 0 To (nFieldSize - 1) Step 1
				arrReturnBuf(nFirstLoopCnt,nSecondLoopCnt) = arrBufFinalStep(nSecondLoopCnt)
			Next
		Next

		''**	처리된 결과를 리턴한다.
		GF_MagicStringSpt = arrReturnBuf
	Else
		''**	기본 데이타 포맷이 지켜지지 않았거나, 공백 값이 입력된 경우이므로
		''**	공백 값을 리턴한다.고 했다가.
		''**	버전 업을 해서 공백 값만 들어가 있는 배열로 리턴한다.

		''**	리턴 값 저장할 변수를 선언한다.
		Redim arrReturnBuf(0,nFieldSize - 1)

		''**	멍텅구리 배열을 리턴한다.
		GF_MagicStringSpt = arrReturnBuf
	End If

End Function

''**	[함수 개요]
''**		5개 난수 및 날자 조합을 통해 랜덤 숫자를 조합한 후 값을 리턴하는 함수
''**		한 명의 클라이언트의 한 개 웹 페이지에서만 겹치지 않으면 되는 상황에서만 사용하는
''**		저수준 Unique Random 숫자 생성 함수
''**	[파라미터]
''**		없음
''**	[리턴 값]
''**		생성된 Unique Random 숫자

Function GF_MakeRandomVars()

	GF_MakeRandomVars = CInt((10) * Rnd) & CInt((10) * Rnd) & CInt((10) * Rnd) & CInt((10) * Rnd) & CInt((10) * Rnd) & Year(now) & Month(now) & Day(now) & Hour(now) & Minute(now) & Second(now)

End Function

''**	[함수 개요]
''**		문자열에 있는 포맷문자값 제거
''**	[파라미터]
''**		특수문자 제거할 문자열
''**	[리턴 값]
''**		특수문자를 제거한 문자열

Function GF_StringFilter(strOrgString)

	''**	특수 문자 처리 후 결과를 리턴하는 변수
	Dim strReturnValue : strReturnValue = ""


	''**	Null 이 아닐 경우에만 해당 프로세스를 진행
    If Not IsNull(strOrgString) Then

		''**	특수 문자 필터를 처리하기 위해 필요한 기본 변수 선언
		Dim cCurrentValue, nFilterCnt


        For nFilterCnt = 1 To Len(strOrgString)

            cCurrentValue = Mid(strOrgString, nFilterCnt, 1)

            Select Case Trim(cCurrentValue)

			''**	필터 대상 문자는 저장하지 않고 그냥 Skip
            Case chr(34)  '"
			Case chr(35)  '#
            Case chr(36)  '$
            Case chr(37)  '%
            Case chr(38)  '&
            Case chr(39)  ''
            Case chr(40)  '(
            Case chr(41)  ')
            Case chr(42)  '*
            Case chr(43)  '+
            Case chr(44)  ',
            Case chr(45)  '-
            Case chr(46)  '.
            Case chr(47)  '/
            Case chr(58)  ':
            Case chr(59)  ';
            Case chr(60)  '<
            Case chr(61)  '=
            Case chr(62)  '>
            Case chr(64)  '@

            Case chr(91)  '[
            Case chr(92)  '\
            Case chr(93)  ']
            Case chr(94)  '^
            Case chr(95)  '_
            Case chr(96)  '`

            Case chr(123) '{
            Case chr(125) '}
            Case chr(126) '~
            Case Else

			''**	필터 대상 문자가 아닐 경우에만 해당 문자를 저장
            strReturnValue = strReturnValue & cCurrentValue

            End Select
        Next
    End If

	''**	Filtering 된 문자열을 리턴한다.
    GF_StringFilter = strReturnValue

End Function


' ***********************************************************
' MSSQL 입력시 작은따옴표 처리
Function GF_SingleQuote(strString)
	GF_SingleQuote	= Replace(strString, "'", "''")
End Function
' ***********************************************************



' ***********************************************************
' HTML 출력시 따옴표 처리
Function GF_HtmlQuote(strString)
	strString	= Replace(strString, "'", "&#039;")
	strString	= Replace(strString, chr(34), "&quot;")
	GF_HtmlQuote	= strString
End Function
' ***********************************************************



' ***********************************************************
' 값이 있는지 확인
Function GF_IsValue(strVar)
	strVar	= CStr(strVar)

	If strVar = "" Or strVar = "0" Or strVar = "undefined" Then
		GF_IsValue = False
	Else
		GF_IsValue = True
	End If
End Function
' ***********************************************************



' ***********************************************************
' YYYYMMDD 형식의 DATE를 YYYY-MM-DD의 형태로 리턴
Function GF_Date8To10(dateVar)
	GF_Date8To10	= DateSerial(Left(dateVar, 4), Mid(dateVar, 5, 2), Right(dateVar, 2))
End Function
' ***********************************************************



' ***********************************************************
' 날짜를 요일로 반환		ko:일월화수목금토 / en:SunMonTueWedThuFriSat
Function GF_Weekday(ByRef dateVar, ByRef Language)
	rtnVar = WeekDayName(Weekday(dateVar), True)

	If UCase(Language) = "EN" Then
		Select Case rtnVar
			Case "일"
				rtnVar = "Sun"
			Case "월"
				rtnVar = "Mon"
			Case "화"
				rtnVar = "Tue"
			Case "수"
				rtnVar = "Wed"
			Case "목"
				rtnVar = "Thu"
			Case "금"
				rtnVar = "Fri"
			Case "토"
				rtnVar = "Sat"
			Case Else
				rtnVar = ""
		End Select
	End If

	GF_Weekday = rtnVar
End Function
' ***********************************************************
%>