<%@Codepage=65001%>
<%
	Response.CharSet = "utf-8"
    Session.CodePage = 65001

    Response.AddHeader "Pragma","no-cache"
    Response.AddHeader "Expires","0"
%>

<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->

<%
    PiCLCourseSeq = sqlCheck(replace(request("PiCLCourseSeq"),"'","''"))
    PiCourseSeq = sqlCheck(replace(request("PiCourseSeq"),"'","''"))

    sql = "exec PRC_tb_TBooks_SearchValueArea '"&PiCLCourseSeq&"','"&PiCourseSeq&"'"
    Set Rs = dbSelect(sql)

		if Not (Rs.Eof and Rs.Bof) Then
			arrData = Rs.getrows
		end If

    Rs.close
    Set Rs = Nothing
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
			returnVal = returnVal & "<price>" & arrData(2, iFor) & "</price>"
			returnVal = returnVal & "</row>"
		next
	end if

	returnVal = returnVal & "</rows>"
	response.write returnVal
%>


