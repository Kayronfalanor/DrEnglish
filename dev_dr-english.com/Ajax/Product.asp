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
	PnvcProductCode = sqlCheck(replace(request("PnvcProductCode"),"'","''"))
	PiCLCourseSeq = sqlCheck(replace(request("PiCLCourseSeq"),"'","''"))
	PiWeekSeq = sqlCheck(replace(request("PiWeekSeq"),"'","''"))
	PiScheTypeSeq = sqlCheck(replace(request("PiScheTypeSeq"),"'","''"))
	PiScheShapeSeq = sqlCheck(replace(request("PiScheShapeSeq"),"'","''"))
    PiRunTimeSeq = sqlCheck(replace(request("PiRunTimeSeq"),"'","''"))  
	PsiMonth = sqlCheck(replace(request("PsiMonth"),"'","''"))  
    
	If PsiMonth="" Then
		PPsiMonth="1"
	Else
	    PPsiMonth=PsiMonth
	End If
	
    sql = "exec PRC_tb_Product_SearchValueArea N'"&pnvcCPCode&"',N'','"&PiCLCourseSeq&"','"&PiWeekSeq&"','"&PiScheTypeSeq&"','"&PiScheShapeSeq&"','"&PiRunTimeSeq&"','"&PPsiMonth&"'"
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
            returnVal = returnVal & "<code>" & arrData(0, iFor) & "</code>"
            returnVal = returnVal & "<name>" & arrData(1, iFor) & "</name>"
			returnVal = returnVal & "<price>" & arrData(2, iFor) & "</price>"
            returnVal = returnVal & "</row>"
       
        next

    end if

    returnVal = returnVal & "</rows>"

    response.write returnVal
    response.end
%>


