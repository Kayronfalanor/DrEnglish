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
    nvcProductCode = sqlCheck(replace(request("nvcProductCode"),"'","''"))   
	siClassMaxNum  = sqlCheck(replace(request("siClassMaxNum"),"'","''"))   
	If InStr(nvcProductCode,"_") > 0 Then		
	nvcProductCode=Mid(nvcProductCode,1,InStr(nvcProductCode,"_")-1)
	End If

   If nvcProductCode <> "" then
		sql = "exec PRC_tb_Schedule_Move_List N'" & nvcProductCode & "', 0,0 "

		Set Rs = dbSelect(sql)

		if Not (Rs.Eof and Rs.Bof) then
			arrData = Rs.getrows
		end if

		Rs.close
		Set Rs = Nothing
	End if
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

    if isArray(arrData) then
        
        maxLen = ubound(arrData, 2)

        for iFor = 0 to maxLen
			
			If arrData(2, iFor)&"" <> siClassMaxNum&"" then
			
				returnVal = returnVal & "<row>"
				returnVal = returnVal & "<code>" & trim(arrData(0, iFor)) & "</code>"
				returnVal = returnVal & "<name>" & "[수업번호:"&trim(arrData(0, iFor))&"] ["&arrData(1, iFor)&"] [수강자수:"&arrData(2, iFor)&" / "&siClassMaxNum& "]</name>"
				returnVal = returnVal & "</row>"

			End if
        next

    end if

    returnVal = returnVal & "</rows>"

    response.write returnVal
    response.end
%>


