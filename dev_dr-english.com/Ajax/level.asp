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
	iCLCourseSeq = sqlCheck(replace(request("iCLCourseSeq"),"'","''"))

	strSQL	= "EXEC PRC_tb_Level_SearchValueArea '" & iCLCourseSeq & "'"
	arrData = GF_ExecuteSQL(strSQL)
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp"-->
<%
    returnVal = "<?xml version=""1.0"" encoding=""utf-8""?>"
    returnVal = returnVal & "<rows>"

    if isArray(arrData) then

        maxLen = ubound(arrData, 2)

        for iFor = 0 to maxLen
            returnVal = returnVal & "<row>"
            returnVal = returnVal & "<code>" & arrData(0, iFor) & "</code>"
            returnVal = returnVal & "<name>" & arrData(1, iFor) & "</name>"
            returnVal = returnVal & "</row>"
        next

    end if

    returnVal = returnVal & "</rows>"

    response.write returnVal
    response.end
%>


