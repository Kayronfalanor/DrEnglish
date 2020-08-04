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
	iMemberSeq = sqlCheck(replace(request("iMemberSeq"),"'","''"))
    gubun = sqlCheck(replace(request("gubun"),"'","''"))  ''//--구분 화면구분 1: 상품등록
	
	nowdate = Left(Now(),10)
	'nowdate="2013-01-01"

    If nvcProductCode <> "" and iMemberSeq <> "" And gubun="1" then
    sql = "select a.iCouponMemberSeq,a.nvcCouponNum,c.nvcExpiredate "
	sql = sql & " from tb_CouponMember a inner join tb_Couponissue b on a.iCouponissueSeq=b.iCouponissueSeq and a.iMemberSeq=b.iMemberSeq "
	sql = sql & "	inner join tb_Coupon c on a.nvcCouponNum=c.nvcCouponNum and c.iCouponSeq=b.iCouponSeq "
	sql = sql & "	where  b.siCouponissueFlag=1 and a.siCouponMemberFlag=0 "
	sql = sql & " and c.nvcProductCode=N'"&nvcProductCode&"' and a.iMemberSeq='"&iMemberSeq&"' and c.nvcExpiredate >= '"&nowdate&"'"

    Set Rs = dbSelect(sql)

    if Not (Rs.Eof and Rs.Bof) then
        arrData = Rs.getrows
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

			If gubun="1" Then

				name = "<b>["&arrData(1, iFor)&"]</b> [유효기간:"&arrData(2, iFor) & "]"

			End if

            returnVal = returnVal & "<row>"
            returnVal = returnVal & "<code>" & arrData(1, iFor) & "</code>"
            returnVal = returnVal & "<name>" & name & "</name>"
            returnVal = returnVal & "</row>"
        next

    end if

    returnVal = returnVal & "</rows>"

    response.write returnVal
    response.end
%>


