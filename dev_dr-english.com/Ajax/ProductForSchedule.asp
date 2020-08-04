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
	PiScheTypeSeq = sqlCheck(replace(request("PiScheTypeSeq"),"'","''"))
	PiScheShapeSeq = sqlCheck(replace(request("PiScheShapeSeq"),"'","''"))
	PsiMonth = sqlCheck(replace(request("PsiMonth"),"'","''"))  
    
	If PsiMonth="" Then
		PPsiMonth="1"
	Else
	    PPsiMonth=PsiMonth
	End If
	
    sql = "exec PRC_tb_Product_ForSchedule_SearchValueArea N'"&pnvcCPCode&"',N'"&PnvcProductCode&"','"&PiCLCourseSeq&"','"&PiScheTypeSeq&"','"&PiScheShapeSeq&"','"&PPsiMonth&"'"
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
            returnVal = returnVal & "<name1>" & arrData(1, iFor) & "</name1>"
			returnVal = returnVal & "<name2>" & arrData(2, iFor) & "</name2>"
			returnVal = returnVal & "<name3>" & arrData(3, iFor) & "</name3>"
			returnVal = returnVal & "<name4>" & arrData(4, iFor) & "</name4>"
			returnVal = returnVal & "<name5>" & arrData(5, iFor) & "</name5>"
			returnVal = returnVal & "<name6>" & arrData(6, iFor) & "</name6>"
			returnVal = returnVal & "<name7>" & arrData(7, iFor) & "</name7>"
			returnVal = returnVal & "<name8>" & arrData(8, iFor) & "</name8>"
			returnVal = returnVal & "<name9>" & arrData(9, iFor) & "</name9>"
			returnVal = returnVal & "<name10>" & arrData(10, iFor) & "</name10>"
			returnVal = returnVal & "<name11>" & arrData(11, iFor) & "</name11>"
			returnVal = returnVal & "<name12>" & arrData(12, iFor) & "</name12>"
			returnVal = returnVal & "<name13>" & arrData(13, iFor) & "</name13>"
			returnVal = returnVal & "<name14>" & arrData(14, iFor) & "</name14>"
			returnVal = returnVal & "<name15>" & arrData(15, iFor) & "</name15>"
			returnVal = returnVal & "<name16>" & arrData(16, iFor) & "</name16>"
            returnVal = returnVal & "</row>"
       
        next

    end if

    returnVal = returnVal & "</rows>"

    response.write returnVal
    response.end
%>


