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
    sec = sqlCheck(replace(request("sec"),"'","''"))
    iseq= sqlCheck(replace(request("iseq"),"'","''"))

    sql = "IF Exists("

    if sec = "2" then
        sql = sql & " Select *"
        sql = sql & " From   tb_LevelTest"
        sql = sql & " Where  nvcLevelTestDay = CONVERT(nvarchar(10), getdate(), 126)"
        sql = sql & " And    ncTCheckYN = 'N'"
        sql = sql & " And    iTeacherSeq = " & iseq
    else
        sql = sql & " Select *"
        sql = sql & " From   tb_LevelTest A "
        sql = sql & "        Inner Join tb_Teacher B"
        sql = sql & "     On A.iTeacherSeq = B.iTeacherSeq"
        sql = sql & "        Inner Join tb_CallCenter C"
        sql = sql & "     On B.iCallCenterSeq = C.iCallCenterSeq"
        sql = sql & " Where  A.nvcLevelTestDay = CONVERT(nvarchar(10), getdate(), 126)"
        sql = sql & " And    A.ncCCheckYN = 'N'"
        sql = sql & " And    C.iCallCenterSeq = " & iseq
    end if

	sql = sql & " ) "
	sql = sql & "   Begin"
	sql = sql & "       Select 'Y'"
	sql = sql & "   End"
	sql = sql & " Else"
	sql = sql & "   Begin"
	sql = sql & " 	    Select 'N'"
	sql = sql & " End"


    Set Rs = dbSelect(sql)
    sYN = "N"
    if Not (Rs.Eof and Rs.Bof) then
        sYN = Rs(0)
    end if

    Rs.close
    Set Rs = Nothing

    response.write sYN
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