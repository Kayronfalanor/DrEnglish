<%@Codepage=65001%>
<%
	Response.CharSet = "utf-8"
    Session.CodePage = 65001
    
    Response.AddHeader "Pragma","no-cache"
    Response.AddHeader "Expires","0"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
    TchSeq		= sqlCheck(Trim(replace(request("TchSeq"),"'","''")))
	bcode		= sqlCheck(Trim(replace(request("bcode"),"'","''")))
	nvcCPCode	= sqlCheck(Trim(replace(request("nvcCPCode"),"'","''")))
	
	
	If TchSeq <> "" Then
		
		sql = " SELECT dbo.FUN_ClassCount_Get(" & sUserSeq & "," & TchSeq & ",N'" & bcode & "',N'" & nvcCPCode & "'  ) "
		Set Rs = dbSelect(sql)

		if Not (Rs.Eof and Rs.Bof) then
			totCnt = Trim(Rs(0))
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

<%
	Errornumcheck="0"
	Err.Clear
%>
<%
    response.write totCnt
    response.end
%>


