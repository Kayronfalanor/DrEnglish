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
    id = sqlCheck(replace(request("id"),"'","''"))   
    gubun= sqlCheck(replace(request("gubun"),"'","''"))
    str= sqlCheck(replace(request("str"),"'","''"))

    sql = ""
    if gubun ="M" then
        sql = sql & " Update tb_BComment"
        sql = sql & " Set    nvcComment   = N'" & str & "'"
    else
        sql = sql & " Delete From  tb_BComment"
    end if

    sql = sql & " Where  iBCommentSeq = " & id

    'Set dbConn = InsertConnection()
	strResult=""
    '/*************************************/
    DB1.BeginTrans
    '/*************************************/

    'dbConn.execute(sql)
	strResult=insertUpdateDB(sql)

    if strResult <> "Y" Then
    
        returnVal = strResult
        
        '/*********************************/
        DB1.RollbackTrans
        '/*********************************/
    else
        returnVal = "Y"

        '/*************************************/
        DB1.CommitTrans
        '/*************************************/
    end if

    'dbConn.close
    'Set dbConn = Nothing
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
    response.write returnVal
    response.end
%>