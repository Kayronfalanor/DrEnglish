<%
''---------------------------------------------------------------------------------------------------
''**
''**	Filename : stringUtil.asp
''**	Comment : ���ڿ� ���� ó�� �Լ� ����
''**	History : 2012/12/27. By ������
''**
''**	@Version : 20121227001
''**	@Author : Copyright(c) 2012. SaehaENS.com. All Rights Reserved
''**
''---------------------------------------------------------------------------------------------------

''**	[�Լ� ����]
''**		NULL ���� ���� ������ ġȯ�Ѵ�.
''**		����Ʈ ��ü������ NULL ���� ���� ó���� ȸ���ϴ� ���� ��Ģ���� ��
''**	[�Ķ����]
''**		strOrgValue : ���� ���ڿ�
''**	[���� ��]
''**		NULL �������� �����Ǿ� ���� ��� NULL�� ������Ų ���鰪�� ����
''**		NULL ���� �������� �ʴ´ٸ� ���� ���ڿ��� �״�� ����

Function GF_CvtNullToEmpty(strOrgValue)

	If IsNull(strOrgValue) Then
		GF_CvtNullToEmpty = ""
	Else
		GF_CvtNullToEmpty = strOrgValue
	End If

End Function


''**	[�Լ� ����]
''**		�Էµ� ���ڿ� �� Ư���� ������ ĳ���͸� HTML �������� �����ϴ� �Լ�
''**		html tag �Է¿� ���� ������ �δ� ��쿡 ���
''**	[�Ķ����]
''**		strOrgValue : ���� ���ڿ�
''**	[���� ��]
''**		���� ���ڿ����� "<", ">" ���ڸ� ġȯ�� ���

Function GF_HtmlSpecialChars(strOrgValue)

	GF_HtmlSpecialChars = Replace(Replace(GF_CvtNullToEmpty(strOrgValue),"<", "&lt;"), ">", "&gt;")

End Function


''**	[�Լ� ����]
''**		�Էµ� ���� ���� �ڸ����� ǥ���Ǵ� ���ڷ� ��ȯ�ϴ� �Լ�
''**		�⺻ ����� ���� ó�� �� ������ ���� ó���� ���� ó��
''**	[�Ķ����]
''**		vntSrcNumber : ���� ����
''**	[���� ��]
''**		���� ó�� ��� : �ڸ��� ǥ���� ���ڿ� ����
''**		���ڰ� �ƴ� ���ڿ��� �Ķ���ͷ� ���� ��� : 0����

Function GF_MakeCurrency(vntSrcNumber)

	If IsNumeric(vntSrcNumber) Then
		GF_MakeCurrency = FormatNumber(vntSrcNumber, 0)
	Else
		GF_MakeCurrency = 0
	End If

End Function


''**	[�Լ� ����]
''**		GF_RoundingEx �Լ��� ������ ����� �Ķ���� ����ȭ�� ����
''**		������ �ø�, ����, �ݿø� ������ �����ϴ� �Լ�
''**	[�Ķ����]
''**		vntSrcNumber : ���� ����
''**		Action Kind [1] : �ø�, [2] : �ݿø�, [3] : ����
''**	[���� ��]
''**		���� ó�� ��� : �ø�, �ݿø�, ���� ���� ó���� ��� ����
''**		���ڰ� �ƴ� ���ڿ��� �Ķ���ͷ� ���� ��� : 0����

Function GF_Rounding(vntSrcNumber, nActionKind)

	''**	���� ó�� �� ��� ���� �����Ѵ�.
	GF_Rounding = GF_RoundingEx(vntSrcNumber, nActionKind, 1, 1)

End Function


''**	[�Լ� ����]
''**		�Էµ� ���ڸ� �ø�, ����, �ݿø��� ������ �� ���� �����ϴ� �Լ�
''**	[�Ķ����]
''**		vntSrcNumber : ���� ����
''**		Action Kind [1] : �ø�, [2] : �ݿø�, [3] : ����
''**		Digit : ���� ����� �Ǵ� �ڸ��� (�Ҽ� �ڸ���)
''**		Rounding Kind [1] : Standard Rounding, [2] : Bankers Rounding
''**	[���� ��]
''**		���� ó�� ��� : �ø�, �ݿø�, ���� ���� ó���� ��� ����
''**		���ڰ� �ƴ� ���ڿ��� �Ķ���ͷ� ���� ��� : 0����

Function GF_RoundingEx(vntSrcNumber, nActionKind, nDigit, nRoundingKind)

	Dim vntReturnValue			''**	���õ� ���� �۾��� �Ϸ��ϰ� ���ϵǴ� ����

	Dim lBasePointer			''**	���� �Ҽ����� �����ϱ� ���� ������ ��
	Dim vntUpperBaseBuffer		''**	������ ���� �Ҽ����� �����ϴ� ����
	Dim vntCvtRtnValue			''**	�űԷ� ������ ���� �Ҽ����� ������

	''**	�Էµ� ���� ���� ���� ���ڰ� �ƴ� ���ڰ� �������� ���� ����
	''**	���� �� ó���� �õ��Ѵ�.
	If IsNumeric(vntSrcNumber) Then

		''**	���� �Ҽ��� ������ ���̱� ���� ���� ���ڸ� �����Ѵ�.
		lBasePointer = (10 ^ (nDigit - 1) )

		''**	���� �Ҽ����� ���δ�.
		vntUpperBaseBuffer = vntSrcNumber * lBasePointer

		''**	������ ���� �Ҽ����� ���� ���� ���Ѵ�.
		vntCvtRtnValue = (Int)(vntUpperBaseBuffer)

		''**	Action Kind ���� ���� ó���Ѵ�.
		Select Case nActionKind

		''**	�ø� ó��
		Case 1 :

			''**	���� ����Ÿ�� ���� �� ���� ũ�ٸ� �ø� �� ����� �ǹǷ�
			''**	���� �ø��� ó���Ѵ�.
			If vntUpperBaseBuffer > vntCvtRtnValue Then
				vntReturnValue = vntCvtRtnValue + 1
			Else
				vntReturnValue = vntCvtRtnValue
			End If

		''**	�ݿø� ó�� (�ݿø� ������ ���� �б� ó���Ѵ�)
		Case 2 :
			If nRoundingKind = 1 Then

				''**	���� �Ҽ����� �� �ܰ� �� ������
				''**	���� ������ ������ ó�� ������ �����Ѵ�.

				If CInt(Right((Int)(vntUpperBaseBuffer*10),1)) >= 5 Then
					vntReturnValue = GF_RoundingEx(vntUpperBaseBuffer, 1, 1, nRoundingKind)
				Else
					vntReturnValue = GF_RoundingEx(vntUpperBaseBuffer, 1, 3, nRoundingKind)
				End If
			Else
				vntReturnValue = Round(vntCvtRtnValue, nDigit - 1)
			End If

		''**	���� ó��
		Case 3 :
			vntReturnValue = vntCvtRtnValue

		End Select

		''**	ó���� �Ϸ�� �� �ø� ���� �ҽ��� ��ŭ ���� ������.
		vntReturnValue = vntReturnValue / lBasePointer

	Else
		''**	���ڰ� �ƴ� ����Ÿ�� �Ѿ�� ����� �׳� 0 ���� ��ȯ�Ѵ�.
		vntReturnValue = 0
	End If

	''**	ó���� ���� ��ȯ�Ѵ�.
	GF_RoundingEx = vntReturnValue

End Function


''**	[�Լ� ����]
''**		�پ��ϰ� �䱸�� �� �ִ� ��¥ ���˿� �°� �Էµ� ��¥�� ���� �� ��ȯ�ϴ� �Լ�.
''**		�⺻������ ���Ǵ� ��¥ Format�� YYYY-MM-DD hh:mm:ss�̰�, MS-SQL�������
''**		����� YYYY-MM-DD ����[����] hh:mm:ss Format�� ���� ���� ����.
''**	[�Ķ����]
''**		strOrgDateTime : Format�� �°� ������ ���� ��¥�� ������, �䱸�Ǵ� �⺻ �Ķ���� Format�� YYYY-MM-DD hh:mm:ss
''**		nDateFormat
''**			[1] : YYYY-MM-DD hh:mm:ss Format���� �Էµ� ��¥�� ���� �� ��ȯ
''**			[2] : YYYY-MM-DD Format���� �Էµ� ��¥�� ���� �� ��ȯ
''**			[3] : YYYY.MM.DD hh:mm:ss Format���� �Էµ� ��¥�� ���� �� ��ȯ
''**			[4] : YYYY.MM.DD Format���� �Էµ� ��¥�� ���� �� ��ȯ
''**			[5] : YYYY/MM/DD hh:mm:ss Format���� �Էµ� ��¥�� ���� �� ��ȯ
''**			[6] : YYYY/MM/DD Format���� �Էµ� ��¥�� ���� �� ��ȯ
''**			[7] : YY-MM-DD hh:mm:ss Format���� �Էµ� ��¥�� ���� �� ��ȯ
''**			[8] : YY-MM-DD Format���� �Էµ� ��¥�� ���� �� ��ȯ
''**			[9] : YY.MM.DD hh:mm:ss Format���� �Էµ� ��¥�� ���� �� ��ȯ
''**			[10] : YY.MM.DD Format���� �Էµ� ��¥�� ���� �� ��ȯ
''**			[11] : YY/MM/DD hh:mm:ss Format���� �Էµ� ��¥�� ���� �� ��ȯ
''**			[12] : YY/MM/DD Format���� �Էµ� ��¥�� ���� �� ��ȯ
''**	[���� ��]
''**		Format ������ ���� ������ �Ϸ�Ǹ� nDateFormat ���� ���� Format�� ����� ��¥ �����Ͱ� ���ϵȴ�.

Function GF_MakeDateFormat(strOrgDateTime, nDateFormat)

	''**	���� ��¥ ����Ÿ�� ó���ϱ� ���� �ʿ��� Split ���� �迭 ����
	Dim arrSptDateTime
	Dim arrSptDateInfo		''**	���� DateTime���� Date ���� ����Ÿ ���� �� Split ����� �����ϴ� ����
	Dim arrSptTimeInfo		''**	���� DateTime���� Time ���� ����Ÿ ���� �� Split ����� �����ϴ� ����

	''**	��¥ Format �� ���� �ʴ´ٸ� Format ���ڷ� �����Ѵ�.
	If InStr(strOrgDateTime, ":") = 0 Then
		strOrgDateTime = Trim(strOrgDateTime) & " 00:00:00"
	End If

	''**	���� ����Ÿ���� ��¥�� �ð��� ������.
	arrSptDateTime = Split(strOrgDateTime, " ")

	If UBound(arrSptDateTime) = 1 Then

		''**	��¥�� ���� ������ ���� �Ѵ�.
		arrSptDateInfo = Split(arrSptDateTime(0), "-")

		''**	�ð��� ���� ������ ���� �Ѵ�.
		arrSptTimeInfo = Split(arrSptDateTime(1), ":")

	Else
		''**	��¥�� ���� ������ ���� �Ѵ�,
		arrSptDateInfo = Split(arrSptDateTime(0), "-")

		''**	�ð��� ���� ������ ���� �Ѵ�.
		arrSptTimeInfo = Split(arrSptDateTime(2), ":")

		''**	���� �Ǵ� ���� ���� ����Ÿ�� ������ �����ϴ� �����
		''**	�ʿ��� ��ŭ�� �ð��� �����ش�.
		If arrSptDateTime(1) = "����" And CInt(arrSptTimeInfo(0)) <> 12 Then
			arrSptTimeInfo(0) = CStr(CInt(arrSptTimeInfo(0)) + 12)
		End If
	End If

	Dim cDateDelimiter		''**	Date Type�� Delimiter ���� ����

	''**	DateFormat�� �°� Return DateTime�� �����Ѵ�.
	Select Case CInt(nDateFormat)
		Case 1, 2, 7, 8 : cDateDelimiter = "-"
		Case 3, 4, 9, 10 : cDateDelimiter = "."
		Case 5, 6, 11, 12 : cDateDelimiter = "/"
	End Select

	Dim strRtnDateTime		''**	���� DateTime ���� ����

	''**	Time ����Ÿ�� �����ϴ����� ���� ���θ� �����Ѵ�.
	If (CInt(nDateFormat) Mod 2) = 0 Then
		strRtnDateTime = arrSptDateInfo(0) & cDateDelimiter & arrSptDateInfo(1) & cDateDelimiter & arrSptDateInfo(2)
	Else
		strRtnDateTime = arrSptDateInfo(0) & cDateDelimiter & arrSptDateInfo(1) & cDateDelimiter & arrSptDateInfo(2) & " " & arrSptTimeInfo(0) & ":" & arrSptTimeInfo(1) & ":" & arrSptTimeInfo(2)
	End If

	''**	������ DateTime ���� �����Ѵ�.
	GF_MakeDateFormat = strRtnDateTime

End Function

''**	[�Լ� ����]
''**		���ڿ��� ���ԵǾ� �ִ� Quote ���ڸ� ó���ϴ� �Լ�
''**	[�Ķ����]
''**		strSrcString : ���� ���ڿ�
''**		nActionKind [1] : Quote ���ڸ� ��� ����, [2] : Single Quote�� Double Quote ���ڷ� ����
''**	[���� ��]
''**		Quote�� ���� �ǰų�, Double Quote�� ������ ���ڿ� ����

Function GF_QuoteManager(strSrcString, nActionKind)

	If nActionKind = 1 Then
		GF_QuoteManager = Replace(strSrcString, "'", "")
	Else
		GF_QuoteManager = Replace(strSrcString, "'", "''")
	End If

End Function

''**	[�Լ� ����]
''**		���ڿ��� ���ԵǾ� �ִ� Carrige Return ���� <br>�� ��ȯ ó���ϴ� �Լ�
''**	[�Ķ����]
''**		strSrcString : ���� ���ڿ�
''**	[���� ��]
''**		Carrige Return ���� <br>�� ó���� ���ڿ��� ����

Function GF_CRManager(strSrcString)

	GF_CRManager = Replace(strSrcString, Chr(13), "<br />")

End Function

''**	[�Լ� ����]
''**		GET, POST�� �ѱ� �Ķ���� ���� ���� �޴� �Լ�
''**	[�Ķ����]
''**		strParamKey : GET, POST �Ķ���� �̸�
''**	[���� ��]
''**		�Ķ���� �̸��� �ش��ϴ� ���� ���� (SQL Injection ��� �Լ� ���� �� ��� ��)''**

Function GF_GetParamValue(strParamKey)

	''**	���� Object�� �����Ѵ�.
	With Request

		''**	HTTP Method ��Ŀ� ���� �Ķ���� ���� ���� ���� ������ �����Ѵ�.
		''**	SQL Injection ��� �Լ� (GF_MakeStringShield) ���� �� ��� ���� �����Ѵ�.
		If .QueryString(strParamKey) = "" Then
			GF_GetParamValue = GF_MakeStringShield(.Form(strParamKey))
		Else
			GF_GetParamValue = GF_MakeStringShield(.QueryString(strParamKey))
		End If

	End With

End Function

''**	[�Լ� ����]
''**		SQL Injection�� �õ��ϱ� ���� �ʿ��� ���ڸ� Replace�ϴ� �Լ�
''**	[�Ķ����]
''**		strOrgString : ���� ���ڿ�
''**	[���� ��]
''**		�������� ó���� �Ǹ�, strOrgString���� ���ԵǾ� �ִ� ";", "'" ���ڴ�
''**		�� �� &#59;, &#39;�� ġȯ ó�� �� ���ڿ��� ��ȯ�Ѵ�.

Function GF_MakeStringShield(strOrgString)

	''**	SQL�� �ҹ������� �����ϱ� ���� �ʿ��� �ʼ� ���ڸ�
	''**	���� �ȵǵ��� ��� ĳ���ͷ� ��ȯ�Ѵ�.
	''**	���� ����� �ʿ䰡 �ִ� ���ڰ� ����� �߰�...
	'strOrgString = Replace(strOrgString, ";", "��")
	'strOrgString = Replace(strOrgString, "'", "��")
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

	''**	ó���� ����� �����Ѵ�.
	GF_MakeStringShield = Trim(strOrgString)

End Function

''**	[�Լ� ����]
''**		Master, Slave Split ���ڸ� ������� ���ڿ��� �迭�� �����ϴ� �Լ�
''**	[�Ķ����]
''**		�⺻ ���ڿ�, Master Split ����, Slave Split ����,
''**	[���� ��]
''**		���� ����Ÿ�� Split �� 2���� �迭�� �����Ѵ�.
''**		�迭 ������ �Ʒ��� ����.
''**		arrBuf(N,0) = [�ʵ� 1], arrBuf(N,1) = [�ʵ� 2], .., arrBuf(N,N) = [�ʵ� N]
''**		.
''**		.
''**		arrBuf(N+M,0) = [�ʵ� 1], arrBuf(N+M,1) = [�ʵ� 2], .., arrBuf(N+M,N) = [�ʵ� N]

Function GF_MagicStringSpt(strMagicString, strMasterDiv, strSlaveDiv, nFieldSize)

	''**	���ڿ� ó������ NULL���� Ȯ���ϰ� NULL�̸� ���� ������ ��ü�Ѵ�.
	strMagicString = GF_CvtNullToEmpty(strMagicString)

	''**	ó�� �ʿ� ������ �����Ѵ�.
	Dim arrBufFirstStep, arrBufFinalStep, nFirstLoopCnt, nSecondLoopCnt

	''**	Master ������ ������ Split �Ѵ�.
	''**	�Է� ���� Null ���� ���� ��� ���� NULL ���� ���� ������ ��ü�Ѵ�.
	arrBufFirstStep = Split(strMagicString, strMasterDiv)

	If strMagicString <> "" And UBound(arrBufFirstStep) <> -1 Then

		''**	���� �� ������ ������ �����Ѵ�.
		Redim arrReturnBuf(UBound(arrBufFirstStep),nFieldSize - 1)

		For nFirstLoopCnt = 0 To UBound(arrBufFirstStep) Step 1

			''**	Slave ������ Slave ��������  Split �Ѵ�.
			arrBufFinalStep = Split(arrBufFirstStep(nFirstLoopCnt), strSlaveDiv)

			''**	Slave ������ Split�� �ʵ庰�� �����Ѵ�.
			For nSecondLoopCnt = 0 To (nFieldSize - 1) Step 1
				arrReturnBuf(nFirstLoopCnt,nSecondLoopCnt) = arrBufFinalStep(nSecondLoopCnt)
			Next
		Next

		''**	ó���� ����� �����Ѵ�.
		GF_MagicStringSpt = arrReturnBuf
	Else
		''**	�⺻ ����Ÿ ������ �������� �ʾҰų�, ���� ���� �Էµ� ����̹Ƿ�
		''**	���� ���� �����Ѵ�.�� �ߴٰ�.
		''**	���� ���� �ؼ� ���� ���� �� �ִ� �迭�� �����Ѵ�.

		''**	���� �� ������ ������ �����Ѵ�.
		Redim arrReturnBuf(0,nFieldSize - 1)

		''**	���ֱ��� �迭�� �����Ѵ�.
		GF_MagicStringSpt = arrReturnBuf
	End If

End Function

''**	[�Լ� ����]
''**		5�� ���� �� ���� ������ ���� ���� ���ڸ� ������ �� ���� �����ϴ� �Լ�
''**		�� ���� Ŭ���̾�Ʈ�� �� �� �� ������������ ��ġ�� ������ �Ǵ� ��Ȳ������ ����ϴ�
''**		������ Unique Random ���� ���� �Լ�
''**	[�Ķ����]
''**		����
''**	[���� ��]
''**		������ Unique Random ����

Function GF_MakeRandomVars()

	GF_MakeRandomVars = CInt((10) * Rnd) & CInt((10) * Rnd) & CInt((10) * Rnd) & CInt((10) * Rnd) & CInt((10) * Rnd) & Year(now) & Month(now) & Day(now) & Hour(now) & Minute(now) & Second(now)

End Function

''**	[�Լ� ����]
''**		���ڿ��� �ִ� ���˹��ڰ� ����
''**	[�Ķ����]
''**		Ư������ ������ ���ڿ�
''**	[���� ��]
''**		Ư�����ڸ� ������ ���ڿ�

Function GF_StringFilter(strOrgString)

	''**	Ư�� ���� ó�� �� ����� �����ϴ� ����
	Dim strReturnValue : strReturnValue = ""


	''**	Null �� �ƴ� ��쿡�� �ش� ���μ����� ����
    If Not IsNull(strOrgString) Then

		''**	Ư�� ���� ���͸� ó���ϱ� ���� �ʿ��� �⺻ ���� ����
		Dim cCurrentValue, nFilterCnt


        For nFilterCnt = 1 To Len(strOrgString)

            cCurrentValue = Mid(strOrgString, nFilterCnt, 1)

            Select Case Trim(cCurrentValue)

			''**	���� ��� ���ڴ� �������� �ʰ� �׳� Skip
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

			''**	���� ��� ���ڰ� �ƴ� ��쿡�� �ش� ���ڸ� ����
            strReturnValue = strReturnValue & cCurrentValue

            End Select
        Next
    End If

	''**	Filtering �� ���ڿ��� �����Ѵ�.
    GF_StringFilter = strReturnValue

End Function


' ***********************************************************
' MSSQL �Է½� ��������ǥ ó��
Function GF_SingleQuote(strString)
	GF_SingleQuote	= Replace(strString, "'", "''")
End Function
' ***********************************************************



' ***********************************************************
' HTML ��½� ����ǥ ó��
Function GF_HtmlQuote(strString)
	strString	= Replace(strString, "'", "&#039;")
	strString	= Replace(strString, chr(34), "&quot;")
	GF_HtmlQuote	= strString
End Function
' ***********************************************************



' ***********************************************************
' ���� �ִ��� Ȯ��
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
' YYYYMMDD ������ DATE�� YYYY-MM-DD�� ���·� ����
Function GF_Date8To10(dateVar)
	GF_Date8To10	= DateSerial(Left(dateVar, 4), Mid(dateVar, 5, 2), Right(dateVar, 2))
End Function
' ***********************************************************



' ***********************************************************
' ��¥�� ���Ϸ� ��ȯ		ko:�Ͽ�ȭ������� / en:SunMonTueWedThuFriSat
Function GF_Weekday(ByRef dateVar, ByRef Language)
	rtnVar = WeekDayName(Weekday(dateVar), True)

	If UCase(Language) = "EN" Then
		Select Case rtnVar
			Case "��"
				rtnVar = "Sun"
			Case "��"
				rtnVar = "Mon"
			Case "ȭ"
				rtnVar = "Tue"
			Case "��"
				rtnVar = "Wed"
			Case "��"
				rtnVar = "Thu"
			Case "��"
				rtnVar = "Fri"
			Case "��"
				rtnVar = "Sat"
			Case Else
				rtnVar = ""
		End Select
	End If

	GF_Weekday = rtnVar
End Function
' ***********************************************************
%>