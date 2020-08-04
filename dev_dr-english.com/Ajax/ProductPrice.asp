<%@Codepage=65001%>
<%
	Response.CharSet = "utf-8"
    Session.CodePage = 65001
    
    Response.AddHeader "Pragma","no-cache"
    Response.AddHeader "Expires","0"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->

<%

    
	PnvcProductCode = sqlCheck(replace(request("PnvcProductCode"),"'","''"))	
	PsiMonth = sqlCheck(replace(request("PsiMonth"),"'","''"))  
    	pricename=""
	If PsiMonth="" Then
		PPsiMonth="1"
	Else
	    PPsiMonth=PsiMonth
	End If

	pricename="i"&PPsiMonth&"MonthPrice"
	
    sql = "select top 1 nvcProductCode,nvcProductName,"&pricename&" from tb_Product where nvcProductCode=N'"&PnvcProductCode&"' " 
    Set Rs = dbSelect(sql)

    if Not (Rs.Eof and Rs.Bof) then
        arrProductPrice = Rs.getrows
    end if

    Rs.close
    Set Rs = Nothing
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp"-->

<%
    returnVal = "<?xml version=""1.0"" encoding=""utf-8""?>"
    returnVal = returnVal & "<rows>"

    if isArray(arrProductPrice) then
        
        maxLen = ubound(arrProductPrice, 2)


        for iFor = 0 to maxLen            
           
            returnVal = returnVal & "<row>"
            returnVal = returnVal & "<code>" & arrProductPrice(0, iFor) & "</code>"
            returnVal = returnVal & "<name>" & arrProductPrice(1, iFor) & "</name>"
			returnVal = returnVal & "<price>" & arrProductPrice(2, iFor) & "</price>"
            returnVal = returnVal & "</row>"
       
        next

    end if

    returnVal = returnVal & "</rows>"

    response.write returnVal
    response.end
%>


