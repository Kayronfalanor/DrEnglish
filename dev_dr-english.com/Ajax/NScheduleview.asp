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
	iScheduleSeq  = sqlCheck(replace(request("iScheduleSeq"),"'","''"))   
	If InStr(nvcProductCode,"_") > 0 Then		
	nvcProductCode=Mid(nvcProductCode,1,InStr(nvcProductCode,"_")-1)
	End If

   If nvcProductCode <> "" And iScheduleSeq <> "" then
		sql = "exec PRC_tb_Schedule_Select_View '"&iScheduleSeq&"','"&iScheduleSeq&"','',''"

		Set Rs = dbSelect(sql)

		if Not (Rs.Eof and Rs.Bof) then
			arrData = Rs.getrows
		end if

		Rs.close
		Set Rs = Nothing

		
		if isArray(arrData) then
				
				
				nvcScheStartDate	= arrData(5, 0)
				nvcScheEnddate		= arrData(6, 0)
				nvcScheTime			= arrData(7, 0)
				siScheDay			= arrData(8, 0)
				siSchePlayTime		= arrData(9, 0)
				
				siWeek			= arrData(15, 0)
				strPncmon			= arrData(16, 0)
				strPnctue			= arrData(17, 0)
				strPncwed			= arrData(18, 0)
				strPncthu			= arrData(19, 0)
				strPncfri			= arrData(20, 0)
				
				
				weekcheck=""

				If strPncmon="Y" Then
				weekcheck=weekcheck&"2,"				
				End if

				If strPnctue="Y" Then
				weekcheck=weekcheck&"3,"				
				End If

				If strPncwed="Y" Then
				weekcheck=weekcheck&"4,"				
				End If

				If strPncthu="Y" Then
				weekcheck=weekcheck&"5,"				
				End If

				If strPncfri="Y" Then
				weekcheck=weekcheck&"6,"				
				End If


		End If
		
		
        sql = "exec PRC_tb_Product_Select_View N'"&nvcProductCode&"'"
        set rs = dbSelect(sql)

        if not (rs.eof and rs.bof) then
            arrProduct = rs.getRows
        else
		noData="0"
        end if 

        rs.close
        set rs=nothing
		
		if isArray(arrProduct) then			
							
			PMonthPriceCount= arrProduct(28, 0)						
			nvcCPAID		= Trim(arrProduct(31, 0))				
		
		end If
		

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

    if isArray(arrData) And IsArray(arrProduct) then
        
                
			
			
				returnVal = returnVal & "<row>"
				returnVal = returnVal & "<strClassDay1>" & nvcScheStartDate & "</strClassDay1>"
				returnVal = returnVal & "<strClassDay2>" &nvcScheEnddate &"</strClassDay2>"
				returnVal = returnVal & "<strClassTime>" &nvcScheTime &"</strClassTime>"
				returnVal = returnVal & "<strPncmon>" &strPncmon &"</strPncmon>"
				returnVal = returnVal & "<strPnctue>" &strPnctue &"</strPnctue>"
				returnVal = returnVal & "<strPncwed>" &strPncwed &"</strPncwed>"
				returnVal = returnVal & "<strPncthu>" &strPncthu &"</strPncthu>"
				returnVal = returnVal & "<strPncfri>" &strPncfri &"</strPncfri>"
				returnVal = returnVal & "<weekcheck>" &weekcheck &"</weekcheck>"
				returnVal = returnVal & "<nvcCPAID>" &nvcCPAID &"</nvcCPAID>"
				returnVal = returnVal & "<strPlayTime>" &siSchePlayTime &"</strPlayTime>"
				returnVal = returnVal & "<siScheDay>" &siScheDay &"</siScheDay>"
				returnVal = returnVal & "<PMonthPriceCount>" & PMonthPriceCount&"</PMonthPriceCount>"
				returnVal = returnVal & "<siWeek>"&siWeek &"</siWeek>"
				returnVal = returnVal & "</row>"

		
       

    end if

    returnVal = returnVal & "</rows>"

    response.write returnVal
    response.end
%>


