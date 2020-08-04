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
	siOrder=""
    If PnvcCPCode <> "" then
		sql = "SELECT top 1 isnull(siOrder,0) FROM tb_CP where nvcCPCode=N'"&pnvcCPCode&"'"
		Set Rs = dbSelect(sql)

		if Not (Rs.Eof and Rs.Bof) then
			siOrder=Trim(Rs(0))
		Else
			siOrder="0"
		end if

		Rs.close
		Set Rs = Nothing
	End if
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp"-->
<%
    returnVal = "<?xml version=""1.0"" encoding=""utf-8""?>"
    returnVal = returnVal & "<rows>"

    if siOrder <> "" then

            returnVal = returnVal & "<row>"
            returnVal = returnVal & "<code>" & siOrder & "</code>"
            returnVal = returnVal & "<name>" & siOrder & "</name>"
            returnVal = returnVal & "</row>"
      

    end if

    returnVal = returnVal & "</rows>"

    response.write returnVal
    response.end
%>


