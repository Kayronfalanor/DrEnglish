<%
	'// 로그인 여부 체크
	If IsLogin Then
		returnUrl = Request.ServerVariables("SCRIPT_NAME") & returnParam
		If Session("UserID") = "" Then		
			
				With Response
					
					.Write "<form action='/UserMember/LoginPage.asp' name='LoginForm' method='post'>"
					.Write "<input type='hidden' name='returnUrl'	value='"& returnUrl &"' />"
					.Write "</form>"

					.Write "<script type='text/javascript'>"
					'.Write "if(self.opener != null) {"
					'.Write "	self.close();"
					'.Write "} else {"
					.Write "	document.LoginForm.submit();"
					'.Write "}"
					''.Write "	top.window.close();"
					.Write "</script>"
					.End
				End With
			
		End If
	End If

	'// 메시지 관련
	Sub chkMessageBack(msg)
		With Response
			.Write "<script type='text/javascript'>"
			.Write "alert('"& msg &"');"
			.Write "history.go(-1);"
			.Write "</script>"
			.End
		End With
	End Sub

	Sub chkMessageClose(msg)
		With Response
			.Write "<script type='text/javascript'>"
			.Write "alert('"& msg &"');"
			.Write "self.close();"
			.Write "</script>"
			.End
		End With
	End Sub

	Sub chkMessageUrl(msg, url)
		With Response
			.Write "<script type='text/javascript'>"
			.Write "alert('"& msg &"');"
			.Write "location.href='"& url &"';"
			.Write "</script>"
			.End
		End With
	End Sub

    ''//필수입력 파라미터 검색
    Sub chkRequestVal(val, msg)

        if isEmpty(val) or isNull(val) or trim(val) = "" Then
        'response.end
            DbClose


%>
    <script type="text/javascript">
        alert('<%=msg%>' );
        history.back();
    </script>
<%
		response.end
        end if
    End Sub


    ''//리스트권한검색
    Sub chkRoll(menu)

        if session("adminmenus") <> "ALL" And instr(session("adminmenus"), menu) = 0 then
            DbClose

%>
    <script type="text/javascript">
        alert('권한이 없습니다.' );
        history.back();
    </script>
<%
		response.end
        end if
    End Sub

    ''//팝업권한검색
    Sub chkRollPop(menu)

        if session("adminmenus") <> "ALL" And instr(session("adminmenus"), menu) = 0 then
            DbClose
%>
    <script type="text/javascript">
        alert('권한이 없습니다.' );
        window.close();
    </script>
<%
		response.end
        end if
    End Sub


''//필수입력 파라미터 검색
    Sub chkRequestValPop(val, msg)

        if isEmpty(val) or isNull(val) or trim(val) = "" then
            DbClose
%>
    <script type="text/javascript">
        alert('<%=msg%>' );
        window.close();
    </script>
<%
		response.end
        end if
    End Sub


    function iif(orgStr, chkStr, returnStr1, returnStr2)

        if orgStr = chkStr then
            iif = returnStr1
        else
            iif = returnStr2
        end if

    end function

    Sub createFolder(fileSaveDir)
        Dim fso, fldr

        Set fso = CreateObject("Scripting.FileSystemObject") '파일시스템 오브젝트 생성

        if Not (fso.FolderExists(fileSaveDir)) Then ' 폴더가 없으면
            Set fldr = fso.CreateFolder(fileSaveDir) '폴더 생성
        END IF

        Set fso = Nothing
        Set fldr = Nothing
    end sub



    function GetUniqueName(strFileName, SaveDir)
        Set fso = CreateObject("Scripting.FileSystemObject")

        '확장자를 제외한 파일명을 얻는다.
        strName = Mid(strFileName, 1, Instr(strFileName, ".") - 1)
'        strName = Year(Now())&Month(Now())&Day(Now())&hour(Now())&Minute(Now())&Second(Now())
        '확장자를 얻는다.
        strExt = Mid(strFileName, Instr(strFileName, ".") + 1)

        bExist = true

        ' 저장할 파일의 완전한 이름을 만듦
        strFileWholePath = SaveDir & strName & "." & strExt

        '파일이 존재할 경우, 이름 뒤에 붙일 숫자를 세팅함
        countFileName = 0

        Do while bExist
            '같은 이름의 파일이 있을 때
            if (fso.FileExists(strFileWholePath)) Then
                '파일명에 숫자를 붙인 새로운 파일 이름 생성
                countFileName = countFileName + 1
                strFileName = strName & "_" & countFileName & "." & strExt
                strFileWholePath = SaveDir & strFileName '완전한 경로명과 파일명
            else
                bExist = false
            end if
        loop

        Set fso = Nothing

        GetUniqueName = replace(strFileWholePath, SaveDir, "")
    end function

    function deleteFile(strFileName, DeletePath)

        Set fso = CreateObject("Scripting.FileSystemObject")

        if fso.FileExists(DeletePath & strFileName) then

          Set deleteFile = fso.GetFile(DeletePath & strFileName)
          deleteFile.delete
        end if

        Set fso = Nothing
    end function

    ''//필수입력 파라미터 검색
    Sub HistoryBack(msg)
%>
    <script type="text/javascript">
        alert('<%=msg%>' );
        history.back();
    </script>
<%
    End Sub

	''//필수입력 파라미터 검색
    Sub OrderBackPG(msg)
%>
    <script type="text/javascript">
        alert('<%=msg%>' );
        parent.location.href="/OrderPage/Ordererr.asp";
    </script>
<%
    End Sub


	Sub OrderBack(msg)
%>
    <script type="text/javascript">
        alert('<%=msg%>' );
        location.href="/OrderPage/Ordererr.asp";
    </script>
<%
    End Sub

	''//필수입력 파라미터 검색
    Sub DocClose(msg)
%>
    <script type="text/javascript">
        alert('<%=msg%>' );
        window.close();
    </script>
<%
    End Sub

    ''//RollBack, DBClose 후 HistoryBack

	Sub RollBackAndOrderBackPG(dbConn, msg)
        dbConn.RollbackTrans

        DbClose
        OrderBackPG msg

        response.end
    End Sub


	Sub RollBackAndOrderBack(dbConn, msg)
        dbConn.RollbackTrans

        DbClose
        OrderBack msg

        response.end
    End Sub

    Sub RollBackAndHistoryBack(dbConn, msg)
        dbConn.RollbackTrans

        DbClose
        HistoryBack msg

        response.end
    End Sub

	''//RollBack, DBClose 후 Close
    Sub RollBackAndClose(dbConn, msg)
        dbConn.RollbackTrans

        DbClose
        DocClose msg

        response.end
    End Sub

    ''//DBClose 후 HistoryBack
    Sub DBCloseAndHistoryBack(msg)
        DbClose
        HistoryBack msg
        response.end
    End Sub

    ''//기본 옵션
    function setOption(arrList, selectedVal)
        dim strOption
        strOption = ""

        strOption = strOption & "<option value=''> ++ 선택 ++ </option>"

        if isArray(arrList) then
            maxLen = ubound(arrList, 2)

            for iFor = 0 to maxLen
                strOption = strOption & "<option value='"& trim(arrList(0, iFor))&"' "&iif(trim(arrList(0, iFor))&"", selectedVal&"", "selected","")&">"&arrList(1, iFor)&"</option>"
            next
        end if


        setOption = strOption
    end function

    ''//영문 기본 옵션
    function setOptionE(arrList, selectedVal)
        dim strOption
        strOption = ""

        strOption = strOption & "<option value=''> ++ Select ++ </option>"

        if isArray(arrList) then
            maxLen = ubound(arrList, 2)

            for iFor = 0 to maxLen
                strOption = strOption & "<option value='"& trim(arrList(0, iFor))&"' "&iif(trim(arrList(0, iFor))&"", selectedVal&"", "selected","")&">"&arrList(1, iFor)&"</option>"
            next
        end if


        setOptionE = strOption
    end function

	''//선택한 값만 보여주기
	''//선택한 값만 보여주기
	function setValue(arrList, selectedVal,RTYPE)
        dim strOption
        strOption = ""

        if isArray(arrList) then
            maxLen = ubound(arrList, 2)

            for iFor = 0 to maxLen
                If strOption="" And arrList(0,iFor)=selectedVal Then
					If RTYPE="1" Then
					strOption=arrList(0,iFor)
					ELSE
					strOption=arrList(1,iFor)
					End IF
				End if
            next
        end if

        setValue = strOption
    end function

    ''//선택값이 없는 옵션
    function setOptionNotDefault(arrList, selectedVal)
        dim strOption
        strOption = ""

        if isArray(arrList) then
            maxLen = ubound(arrList, 2)

            for iFor = 0 to maxLen
                strOption = strOption & "<option value='"& arrList(0, iFor)&"' "&iif(arrList(0, iFor)&"", selectedVal&"", "selected","")&">"&arrList(1, iFor)&"</option>"
            next
        end if


        setOptionNotDefault = strOption
    end function

    ''//사용 중  옵션
    function setOptionUseValue(arrList, selectedVal)
        dim strOption
        strOption = ""
        strOption = strOption & "<option value=''> ++ 선택 ++ </option>"

        if isArray(arrList) then
            maxLen = ubound(arrList, 2)

            for iFor = 0 to maxLen
                if instr(arrList(1, iFor), "중지")> 0 then
                    strOption = strOption
                else
                    strOption = strOption & "<option value='"& arrList(0, iFor)&"' "&iif(arrList(0, iFor)&"", selectedVal&"", "selected","")&">"&arrList(1, iFor)&"</option>"
                end if
            next
        end if

        setOptionUseValue = strOption
    end function

    ''//사용 중  옵션
    function setOptionUseValueE(arrList, selectedVal)
        dim strOption
        strOption = ""
        strOption = strOption & "<option value=''> ++ select ++ </option>"

        if isArray(arrList) then
            maxLen = ubound(arrList, 2)

            for iFor = 0 to maxLen
                if instr(arrList(1, iFor), "중지") > 0 then
                    strOption = strOption
                else
                    strOption = strOption & "<option value='"& arrList(0, iFor)&"' "&iif(arrList(0, iFor)&"", selectedVal&"", "selected","")&">"&arrList(1, iFor)&"</option>"
                end if
            next
        end if

        setOptionUseValueE = strOption
    end function

    function ceil(val1, val2)
        dim tempVal , arrTemp, returnVal

        if val2&"" = "" then
            returnVal = "0"
        else
            tempVal = (clng(val1) / clng(val2))&""

            arrTemp = split(tempVal, ".")

            if isArray(arrTemp) then
                returnVal = arrTemp(0)
            else
                returnVal = tempVal
            end if
        end if

        ceil = returnVal
    end function

    function ceil01(val1, val2)
        dim tempVal , arrTemp, returnVal

        if val2&"" = "" then
            returnVal = "0"
        else
            tempVal = (clng(val1-1) / clng(val2))&""

            arrTemp = split(tempVal, ".")

            if isArray(arrTemp) then
                returnVal = arrTemp(0)
            else
                returnVal = tempVal
            end if
        end if

        ceil01 = returnVal
    end function

    ''//값을 비교하여 checked값 리턴
    function compareValAndChecked(orgVal, compareVal)
        dim returnVal
        returnVal = ""

        if instr(orgVal, compareVal) > 0  then
            returnVal = "checked"
        end if


        compareValAndChecked = returnVal
    end function

    ''//값을 비교하여 checked값 리턴
    function compareValAndCheckedAllEqual(orgVal, compareVal)
        dim returnVal
        returnVal = ""

        if orgVal= compareVal then
            returnVal = "checked"
        end if


        compareValAndCheckedAllEqual = returnVal
    end function

    function formatNumberic(val)
        dim returnVal, tempStr
        dim iForm, iTo, strLen, cnt

        tempStr = replace(val, " ", "")
        returnVal = ""

        if  tempStr = "" then
            returnVal = tempStr
        else
            strLen = len(tempStr)

            if strLen > 3 then
                cnt = 0
                for iForm = strLen to 1 Step -1

                    if cnt <> 0 And cnt Mod 3 = 0 then
                        returnVal = Mid(tempStr, iForm, 1) & returnVal
                    else
                        returnVal = Mid(tempStr, iForm, 1) & "," & returnVal
                    end if

                    cnt = cnt + 1
                next
            end if
        end if

        formatNumberic = returnVal
    end function

    sub sqlWrite (sql)
        response.write sql
    end sub

    function BoardFaqType(val)
    dim returnVal
        returnVal = ""

        if val&"" <> "" then

            select case cint(val)
            case 1 : returnVal = "사이트관련"
            case 2 : returnVal = "수강관련"
            case 3 : returnVal = "결제"
            case 4 : returnVal = "시스템"
            case 5 : returnVal = "기타"
            case 0 : returnVal = "없음"
            case 6 : returnVal = "공통문의"
            case 7 : returnVal = "수강업체문의"
            end select
        end if

        BoardFaqType = returnVal
    end function

    function viewTMenuText(val, arrList)
        dim returnVal, arrLen
        returnVal = ""
        cnt = 0
        if isArray(arrList) then

            arrLen = ubound(arrList, 2)

            if val = "0" then ''전체표시

''//                for iLoop = 0 to arrLen
''//                    if cnt <> 0 And cnt Mod 20 = 0 then
''//                        returnVal = returnVal & "<br/>"
''//                    end if
''//                    returnVal = returnVal & trim(arrList(0, iLoop)) & ", "
''//
''//                   cnt = cnt + 1
''//                next
                returnVal = "ALL"
            else
                for iLoop = 0 to arrLen
                    if instr(val, trim(arrList(0, iLoop))) > 0 then
                        if cnt <> 0 And cnt Mod 20 = 0 then
                            returnVal = returnVal & "<br/>"
                        end if
                        returnVal = returnVal & trim(arrList(1, iLoop)) & ", "

                        cnt = cnt + 1
                    end if
                next
            end if

            if returnVal <> "" and  returnVal <> "ALL" then
                returnVal = mid(returnVal, 1, len(returnVal) - 2)
            end if
        end if

        viewTMenuText = returnVal
    end function

    function writerRole(val)
        dim returnVal
        returnVal = ""

        if val&"" = "" then val="0"

        select case cint(val)
        case 1  : returnVal = "관리자"
        case 2  : returnVal = "콜센터"
        case 3  : returnVal = "강사"
        case 4  : returnVal = "회원"
        end select

        writerRole = returnVal
    end Function

	'##### 수강 기수방 수업 상태
	Function getScheTypeText(ByRef sType)
		Dim returnVal : returnVal = ""

		Select Case CInt(sType)
			Case 0	: returnVal = "수업대기"
			Case 1	: returnVal = "<font color='blue'>수업중</font>"
			Case 2	: returnVal = "수업종료(완료)"
			Case 3	: returnVal = "수업해지"
		End Select

		getScheTypeText = returnVal

	End Function

	'##### 공용코드 Application("Common_코드")
	Function getCommCode(ByVal code, ByVal bcode, ByVal bArray)
		Dim strRtnVal : strRtnVal = ""
		
		If IsArray(Application("Common_"& code)) Then
			If bArray Then
				strRtnVal = Application("Common_"& code)
			Else
				For k = 0 To Ubound(Application("Common_"& code), 2)
					If Trim(bcode) = Trim(Application("Common_"& code)(0, k)) Then

						strRtnVal = Application("Common_"& code)(1, k)

						Exit For
					End If
				Next			
			End If
		End If

		getCommCode = strRtnVal
	End Function

	'##### 지역번호 및 핸드폰 통신사
	Sub setPhoneHtml(ByRef pType, ByRef value)
		Dim html
		'P : 일반 전화, C : 핸드폰
		Dim arrP(22), arrC(5)
		arrP(0)		= "02"		:	arrC(0) = "010"
		arrP(1)		= "031"		:	arrC(1) = "011"
		arrP(2)		= "032"		:	arrC(2)	= "016"
		arrP(3)		= "033"		:	arrC(3) = "017"
		arrP(4)		= "041"		:	arrC(4) = "018"
		arrP(5)		= "042"		:	arrC(5) = "019"
		arrP(6)		= "043"
		arrP(7)		= "051"
		arrP(8)		= "052"	
		arrP(9)		= "053"
		arrP(10)	= "054"
		arrP(11)	= "055"
		arrP(12)	= "061"
		arrP(13)	= "062"
		arrP(14)	= "063"
		arrP(15)	= "064"
		arrP(16)	= "070"
		arrP(17)	= "0130"
		arrP(18)	= "0303"
		arrP(19)	= "0502"
		arrP(20)	= "0504"
		arrP(21)	= "0505"
		arrP(22)	= "0506"

		html = "<option value=''>선택</option>" & vbCrlf

		If pType = "P" then
			For i = 0 To Ubound(arrP)			
				html = html & "<option value='"& arrP(i) &"' "
				If value = arrP(i) Then
					html = html & "selected"
				End If
				html = html & ">"& arrP(i) &"</option>" & vbCrlf
			Next
		ElseIf pType = "C" Then
			For i = 0 To Ubound(arrC)
				html = html & "<option value='"& arrC(i) &"' "
				If value = arrC(i) Then
					html = html & "selected"
				End If
				html = html & ">"& arrC(i) &"</option>" & vbCrlf
			Next
		End If

		Response.Write html
	End Sub

	'##### 영어일기, To My Teacher 수강 배정 클래스 강사 정보 가져오기
	Function getMyScheduleTeacher(ByRef tSeq)

		Dim strHtml  : strHtml = ""

		Dim arrData, objRs
		Sql = "PRC_tb_Schedule_User_Teacher_List1 N'"& SiteCPCode &"', '"& sUserSeq &"',N'B09' "
		Set objRs = dbSelect(Sql)
		If Not objRs.Eof Then
			arrData = objRs.GetRows()
		End If
		objRs.Close	:	Set objRs = Nothing

		If IsArray(arrData) Then
		'B.iTeacherSeq, C.nvcTeacherName, B.nvcScheStartDate, B.nvcScheEndDate,ncMon, ncTue, ncWed, ncThu, ncFri, ncSat, ncSun

			'Dim strMon, strThe, strWed, strThu, strFri, strSat, strSun
			For i = 0 To Ubound(arrData, 2)
				
				'strMon = ""	:	strThe = ""	:	strWed = ""
				'strThu = ""	:	strFri = ""	:	strSat = ""	:	strSun = ""

				'If arrData(4, i) = "Y"  Then strMon = "월" End If
				'If arrData(5, i) = "Y"  Then strThe = "화" End If
				'If arrData(6, i) = "Y"  Then strWed = "수" End If
				'If arrData(7, i) = "Y"  Then strThu = "목" End If
				'If arrData(8, i) = "Y"  Then strFri = "금" End If
				'If arrData(9, i) = "Y"  Then strSat = "토" End If
				'If arrData(10, i) = "Y" Then strSun = "일" End If

				strHtml = strHtml & "<option value='"& arrData(0, i) &"' "
				If CInt(tSeq) = arrData(0, i) Then
					strHtml = strHtml & "selected"
				End If
				strHtml = strHtml & ">"& arrData(1, i) &" ["& arrData(2, i) &" ~ "& arrData(3, i) &" : "& arrData(4, i) &"분]</option>" & vbCrlf
			Next
		Else
			strHtml = "<option value=''>전송 가능한 강사가 없어 작성하실 수 없습니다.</option>"
		End If

		getMyScheduleTeacher = strHtml

	End Function

	'###### 해당 CP 자유방식 수강에 따른 레벨테스트 일정 설정, 해당 년, 월, 일 + 2주 산정
	Function getDateLastDay(ByVal nYear, ByVal nMonth)

		Dim intDate
		Dim intDay : intDay = 1
		
		intDate = DateSerial(nYear, nMonth, intDay)
		intDate = DateAdd("m", 1, intDate)
		intDate = DateAdd("d", -1, intDate)

		getDateLastDay = Day(intDate)
	End Function

	Function getLevelTestDate(ByVal siOrder)
		Dim nDate : nDate = ""
		Dim iDate
		Dim strHtml : strHtml = ""

		If siOrder = "1" Then	'기간제 방식
			SQL = "SELECT A.iBalanceCourseSeq, C.iBalanceLevelTestSeq, C.nvcLevelTestDay, C.nvcLevelTestShour, "
			SQL = SQL & "C.nvcLevelTestEHour, C.dtCreateDate FROM TB_BALANCECOURSE AS A WITH(NOLOCK) "
			SQL = SQL & "INNER JOIN TB_BALANCE AS B WITH(NOLOCK) ON(A.iBalanceCourseSeq = B.iBalanceCourseSeq) "
			SQL = SQL & "INNER JOIN TB_BALANCELEVELTEST AS C WITH(NOLOCK) ON(B.iBalanceSeq = C.iBalanceSeq) "
			SQL = SQL & "WHERE nvcCPCode = N'"& SiteCPCode &"' AND siFlag = 1 "
			SQL = SQL & "AND CONVERT(VARCHAR(10), GETDATE(), 120) BETWEEN B.nvcBalanceLevelSdate AND B.nvcBalanceLevelEdate "
			SQL = SQL & "AND C.nvcLevelTestDay >= CONVERT(VARCHAR(10), GETDATE(), 120) "
			Set Rs = dbSelect(SQL)
			If Not Rs.Eof Then
				arrTest = Rs.GetRows()
			End If
			Rs.Close	:	Set Rs = Nothing

			If IsArray(arrTest) Then
				strHtml = "<option value=''>선택</option>"
				For i = 0 To Ubound(arrTest, 2)
					strHtml = strHtml & "<option value='"& arrTest(2, i) &"' sHour='"& arrTest(3, i) &"' eHour='"& arrTest(4, i) &"' seq='"& arrTest(0, 0) &"'>"& arrTest(2, i) &"("& weekdayname(weekday(arrTest(2, i)), true) &")</option>" & vbCrlf
				Next
			Else
				strHtml = "<option value='' sHour='' eHour=''>수업이 존재 하지 않습니다.</option>" & vbCrlf
			End If
		Else					'자유방식
			'현재 일에서 2주 기준으로 설정
			strHtml = "<option value=''>선택</option>"
			Dim nHour
			For i = 0 To 14
				nDate = DateAdd("d", i, Date())
				iDate = WeekDay(nDate)

				'오늘 날짜 선택시 2시간 이후 시간 설정
				If CDate(nDate) = Date() Then
					If CInt(Minute(now)) >= 30 Then
						nHour = Hour(now) + 3
					Else
						nHour = Hour(now) + 2
					End If
				Else 
					nHour = 14
				End If

				'토, 일 제외 출력
				If InStr("2,3,4,5,6", CStr(iDate)) > 0 Then
				strHtml = strHtml & "<option value='"& nDate &"' sHour='"& nHour &"' eHour='22' seq=''>"& nDate & "("& WeekDayName(WeekDay(nDate), true) &")</option>" & vbCrlf
				End If
			Next
		End If

		getLevelTestDate = strHtml
	End Function

	''#####################==#########################
	    
    Function chkIsNull(val)		''//null 체크 true:not null ,false:null 반환
		Dim chk : chk = True  
        if isEmpty(val) or isNull(val) or trim(val) = "" Then
			chk = False 
		Else 
			chk = True
        End If
		chkIsNull = chk

    End Function 

	''#####################==#########################



	''##### 전역으로 쓰이는 클래스 함수모음 by.waitplz 2013-02-07
	Class clsGF
		Public Function GF_SelectCPList(ByRef CPCode)		''CP리스트 가져오기
			Dim strSQL, RS
			strSQL = " EXEC PRC_tb_CP_SearchValueArea "

			If SESSION("CPPermission") = False Then
				strSQL = strSQL & " '" & CPCode & "' "
			End If
			Set RS = dbSelect(strSQL)

			If Not RS.Eof And Not RS.Bof then
				GF_SelectCPList = RS.getRows
			End If
		End Function

		Public Function GF_SelectBalanceCourseList(ByRef CPCode)		''기수과정리스트 가져오기
			Dim strSQL, RS
			strSQL =	" SELECT iBalanceCourseSeq, nvcBalanceCourseDate " &_
						" FROM tb_BalanceCourse " &_
						" WHERE siFlag = 1 "

			If SESSION("CPPermission") = False Then						''CP관리자는 해당 CP만
				strSQL = strSQL & " AND nvcCPCode = '" & CPCode & "' "
			End If

			strSQL = strSQL & " ORDER BY nvcBalanceCourseDate DESC "

			Set RS = dbSelect(strSQL)

			If Not RS.Eof And Not RS.Bof then
				GF_SelectBalanceCourseList = RS.getRows
			End If
		End Function

		Public Function GF_SelectSubjectList()							''과목 리스트 가져오기
			Dim strSQL, RS
			strSQL = " EXEC PRC_tb_Course_SearchValueArea "
			Set RS = dbSelect(strSQL)

			If Not RS.Eof And Not RS.Bof then
				GF_SelectSubjectList = RS.getRows
			End If
		End Function

		Public Function GF_SelectCategoryList()							''수강카테고리 리스트 가져오기
			Dim strSQL, RS
			strSQL = " EXEC PRC_tb_CLLevel_SearchValueArea "
			Set RS = dbSelect(strSQL)

			If Not RS.Eof And Not RS.Bof then
				GF_SelectCategoryList = RS.getRows
			End If
		End Function

		Public Function GF_GetCPName(ByRef CPCode)		''CPCode로 CPName 가져오기
			Dim strSQL, RS, returnValue
			strSQL = " Select nvcCpName From tb_CP Where nvcCpCode = '" & CPCode & "' "
			Set RS = dbSelect(strSQL)

			if not Rs.eof then
				returnValue = Rs("nvcCPName")
			Else
				returnValue = ""
			End If

			GF_GetCPName = returnValue
		End Function

		Public Function GF_GetTMenuCodes(ByRef Permission)
			Select Case Permission
				Case 0				'사용CP는 설정메뉴 제외
					addWhere = " WHERE nvcTMenuCode NOT IN ('M03')"
				Case 1				'메인CP는 전체
					addWhere = ""
				Case Else			'그 이외에는 아무것도
					addWhere = " WHERE 1 <> 1"
			End Select

			Dim strSQL, arrRst, rtnVal
			strSQL = "SELECT nvcTMenuCode FROM tb_TMenu " & addWhere
			arrRst = GF_ExecuteSQL(strSQL)

			If IsArray(arrRst) Then
				For ix = 0 To UBound(arrRst, 2)
					If ix = 0 Then rtnVal = arrRst(0, ix) Else rtnVal = rtnVal & ", " & arrRst(0, ix)
				Next
			End If

			GF_GetTMenuCodes = rtnVal
		End Function
		
		' *****************************************************************************
		' *	글자 String 을 Byte 단위로 잘라서 원하는 Byte 만큼 글자를 줄인다.
		' *****************************************************************************
		Public Function GF_CropStringByte(ByVal strValue, ByVal nByteSize)

			Dim nTmpByte, StartCnt, strTmpValue

			If IsNull(strValue) Then Exit Function

			nTmpByte = 0

			For StartCnt = 1 TO Len(strValue) STEP 1

				strTmpValue = Mid(strValue, StartCnt, 1)

				If ASC(strTmpValue) > 0 Then
					nTmpByte = nTmpByte + 1
				Else
					nTmpByte = nTmpByte + 2
				End If

				If nByteSize >= nTmpByte Then 	GF_CropStringByte = GF_CropStringByte & strTmpValue

			Next

			If Len(strValue) > Len(GF_CropStringByte) Then 	 GF_CropStringByte = Left(GF_CropStringByte, Len(GF_CropStringByte) - 1) & " .."

		End Function
	End Class



	'Request.Get
	''''''''''''''''''''''''''''''''''
	Function gReq(name)
		gReq = Trim(Request(name))
	End Function

	''''''''''''''''''''''''''''''''''
	'Request.Form
	''''''''''''''''''''''''''''''''''
	Function gReqF(name)
		gReqF = Trim(Request.Form(name))
	End Function

	''''''''''''''''''''''''''''''''''
	'Request.QueryString
	''''''''''''''''''''''''''''''''''
	Function gReqQ(name)
		gReqQ = Trim(Request.QueryString(name))
	End Function

	''''''''''''''''''''''''''''''''''
	'	Req 함수의 SQL 인젝션 방어형
	''''''''''''''''''''''''''''''''''
	Function gReqI(name)
		gReqI = Replace(name, "<","&lt;")
		gReqI = Replace(gReqI, ">","&gt;")
		gReqI = Replace(gReqI, """","&quot;")
		gReqI = Replace(gReqI, "'","''")
	End Function

	' chr13 -> <br> 바꾸기
	Function gChr13Tobr(str)
		str = Replace(str, Chr(13), "<br>")
		gChr13Tobr = str
	End Function

%>
