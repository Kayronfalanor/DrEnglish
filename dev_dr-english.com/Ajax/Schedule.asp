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
    PiScheTypeSeq= sqlCheck(replace(request("PiScheTypeSeq"),"'","''"))   
	PiScheShapeSeq= sqlCheck(replace(request("PiScheShapeSeq"),"'","''")) 
	PiCourseSeq= sqlCheck(replace(request("PiCourseSeq"),"'","''"))   
	PiCLCourseSeq= sqlCheck(replace(request("PiCLCourseSeq"),"'","''"))   
	PnvcProductCode= sqlCheck(replace(request("PnvcProductCode"),"'","''"))   
	PsiScheType= sqlCheck(replace(request("PsiScheType"),"'","''"))   

    sql = "exec PRC_tb_Schedule_SearchValueArea '"&PiCourseSeq&"','"&PiCLCourseSeq&"',N'"& PnvcCPCode &"', N'"& PnvcProductCode &"','"&PiScheTypeSeq&"','"&PiScheShapeSeq&"','"&PsiScheType&"'"

    Set Rs = dbSelect(sql)

    if Not (Rs.Eof and Rs.Bof) then
        arrData = Rs.getrows
    end if

    Rs.close
    Set Rs = Nothing
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
            returnVal = returnVal & "<row>"
            returnVal = returnVal & "<code>" & trim(arrData(0, iFor)) & "</code>"
            returnVal = returnVal & "<name>" & arrData(1, iFor) & "</name>"
            returnVal = returnVal & "</row>"
        next

    end if

    returnVal = returnVal & "</rows>"

    response.write returnVal
    response.end
%>


