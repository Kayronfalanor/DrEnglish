<%@Codepage=65001%>
<%
	Response.CharSet = "utf-8"
    Session.CodePage = 65001
    
    Response.AddHeader "Pragma","no-cache"
    Response.AddHeader "Expires","0"
%>
<!--#include virtual="/commonfiles/Session/Admin_Session/AdminSessionClose.asp" -->
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<!--#include virtual="/commonfiles/DBINCC/commFunction.asp" -->
<%

    PnvcCPCode = sqlCheck(replace(request("PnvcCPCode"),"'","''"))
	PStartDate = sqlCheck(replace(request("PStartDate"),"'","''"))
	PsiMonth = sqlCheck(replace(request("PsiMonth"),"'","''"))
	PsiWeek = sqlCheck(replace(request("PsiWeek"),"'","''"))
	PncMon = sqlCheck(replace(request("PncMon"),"'","''"))
	PncTue = sqlCheck(replace(request("PncTue"),"'","''"))
	PncWed = sqlCheck(replace(request("PncWed"),"'","''"))
	PncThu = sqlCheck(replace(request("PncThu"),"'","''"))
	PncFri = sqlCheck(replace(request("PncFri"),"'","''"))
	PncSat = sqlCheck(replace(request("PncSat"),"'","''"))
	PncSun = sqlCheck(replace(request("PncSun"),"'","''"))
	strClassday = sqlCheck(replace(request("strClassday"),"'","''"))
	PiCallCenterSeq = sqlCheck(replace(request("PiCallCenterSeq"),"'","''"))

    
	If PsiMonth="" Then
		PPsiMonth="1"
	Else
	    PPsiMonth=PsiMonth
	End If

	If pnvcCPCode <> "" And PStartDate <> "" And (PncMon ="Y" Or PncTue = "Y" Or PncWed = "Y" Or PncThu = "Y" Or PncFri = "Y" Or PncSat = "Y" Or PncSun = "Y" ) And strClassday <> "" And strClassday <> "0" And PsiWeek <> "" And PsiWeek <> "0" And PsiMonth <> "" And PsiMonth <> "0" Then
	
		'휴강일 구하기
		sql = "exec PRC_tb_Holiday_Select_List N'"&pnvcCPCode&"',N'"&PStartDate&"',N'','"&PiCallCenterSeq&"'"
		Set Rs = dbSelect(sql)
	
		if Not (Rs.Eof and Rs.Bof) then
			arrHoliday = Rs.getrows
		end if

		Rs.close
		Set Rs = Nothing

		tot_Holiday=""
		if isArray(arrHoliday) Then				
			maxLenHoli = ubound(arrHoliday, 2) 
			for iForr = 0 to maxLenHoli
				tot_Holiday=tot_Holiday & "," & arrHoliday(0, iForr) 				
			next		
		End If
			

		''요일 구하기		
		allweek=""	
		If PncMon="Y" then		
			allweek=allweek&"2,"		
		End If
		If PncTue="Y" then		
			allweek=allweek&"3,"		
		End If
		If PncWed="Y" then		
			allweek=allweek&"4,"		
		End If
		If PncThu="Y" then		
			allweek=allweek&"5,"		
		End If
		If PncFri="Y" then	
			allweek=allweek&"6,"	
		End If				
		
		If PncSat="Y" then	
			allweek=allweek&"7,"		
		End If
		
		If Pncsun="Y" then	
			allweek=allweek&"1,"		
		End If
		
		'시작일 교정하기
		strSuccess="0"
		For idnum=0 to	20
			If strSuccess="0" then
				If InStr(allweek,weekday(dateadd("d",idnum,PStartDate))) > 0 Then						
					If InStr(tot_Holiday,","&dateadd("d",idnum,PStartDate)) <= 0 Then
						strSuccess="1"
						PStartDate=dateadd("d",idnum,PStartDate)&""
						idnum=20
					End if
				End If
			End if

		Next
		
		

		''종료일 구하기
		'strClassday
		aaa=""
		strTClassday=0
		strSuccess="0"
		For idnum=0 to	400		
			If strSuccess="0" then
				If InStr(allweek,weekday(dateadd("d",idnum,PStartDate))) > 0 Then		
					If InStr(tot_Holiday,","&dateadd("d",idnum,PStartDate)) <= 0 Then
						strTClassday=strTClassday+1						
						If CInt(strClassday&"")*CInt(PsiMonth&"")=CInt(strTClassday&"") Then
							strSuccess="1"
							PEndDate=dateadd("d",idnum,PStartDate)
							idnum=401
						End if
					End if			
					
				End If
			end if
			
		next


	End If
	
	

%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp"-->
<%
If Err.Number <> 0 Then
	
	Errornumcheck="1"
	OMSService_type="LM16"
	OMSRESULT_STATUS="2"  ' 1:성공 2: 실패 
	OMSRESULT_CODE="LMS500" '0:성공   LMS400 , LMS401 , LMS403 은 따로 처리
	Else
	Errornumcheck="1"
	OMSService_type="LM16"
	OMSRESULT_STATUS="1"  ' 1:성공 2: 실패 
	OMSRESULT_CODE="0" '0:성공   LMS400 , LMS401 , LMS403 은 따로 처리
	End IF

%>
<!--#include virtual="/adminclass/Etcincc/OMS_Log.asp"-->
<%
	Errornumcheck="0"
	Err.Clear
%>
<%
    returnVal = "<?xml version=""1.0"" encoding=""utf-8""?>"
    returnVal = returnVal & "<rows>"

   If pnvcCPCode <> "" And PStartDate <> "" And (PncMon = "Y" Or PncTue = "Y" Or PncWed = "Y" Or PncThu = "Y" Or PncFri = "Y" Or PncSat = "Y" Or PncSun = "Y" ) And strClassday <> "" And strClassday <> "0" And PsiWeek <> "" And PsiWeek <> "0" Then      
           
            returnVal = returnVal & "<row>"
            returnVal = returnVal & "<code>" & PStartDate & "</code>"
            returnVal = returnVal & "<name>" & PEndDate & "</name>"			
            returnVal = returnVal & "</row>"
      

    end if

    returnVal = returnVal & "</rows>"

    response.write returnVal
    response.end
%>


