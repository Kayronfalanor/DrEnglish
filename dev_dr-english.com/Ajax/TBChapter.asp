﻿<%@Codepage=65001%>
<%
	Response.CharSet = "utf-8"
    Session.CodePage = 65001
    
    Response.AddHeader "Pragma","no-cache"
    Response.AddHeader "Expires","0"
%>

<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->

<%
    PiTBooksSeq = sqlCheck(replace(request("PiTBooksSeq"),"'","''"))

    sql = "exec PRC_tb_TBChapter_SearchValueArea '" & PiTBooksSeq & "'"

    Set Rs = dbSelect(sql)

    if Not (Rs.Eof and Rs.Bof) then
        arrData = Rs.getrows
    end if

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
            returnVal = returnVal & "</row>"
        next

    end if

    returnVal = returnVal & "</rows>"

    response.write returnVal
    response.end
%>


