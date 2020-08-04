<!--METADATA type="typelib" File="c:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"-->
<%
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1 

function twochar(va)
	if len(va)=2 then
		twochar=va
	elseif len(va)=1 then
		twochar="0"&va
	elseif len(va)=0 then
		twochar="00"
	end if
end function

'Cnnstring= "Provider=SQLOLEDB;Data Source=211.210.124.92;Initial Catalog=sdm;User ID=sdm;Password=sdm!@#$;Persist Security Info=True;"
'Set DB =Server.Createobject("ADODB.Connection")
'DB.Open Cnnstring

pthispage= REQUEST.SERVERVARIABLES("URL")
OMSLMS_REQ_TIME=Replace(Left(Now(),10),"-","")&right("0"&Hour(Now()),2)&right("0"&minute(Now()),2)&right("0"&second(Now()),2)&"000"
sptError=""
dbtError=""
dbtDescription=""

Function dbSelect(strSql)
    dim objRs

	sptError=sptError&Chr(9)&"[Query:"&strSql&"]"


    Set objRs = Server.CreateObject("ADODB.Recordset")

        objRs.open strSql, DB1, 1, 2, 1

    Set dbSelect = objRs

    Set objRs = Nothing

End Function

Function GF_ExecuteSQL(strSql)
	Dim objRecordSet, arrResultSet
	Set objRecordSet = Server.CreateObject("ADODB.RECORDSET")

	objRecordSet.CursorLocation = adUseClient
	objRecordSet.Open strSql, Application("Cnnstring"), adOpenForwardOnly, adLockReadOnly, adCmdText

	objRecordSet.ActiveConnection = Nothing

	If objRecordSet.State <> adStateClosed Then
		If objRecordSet.RecordCount > 0 Then
			arrResultSet = objRecordSet.GetRows()
		End If

	End If

	If objRecordSet.State = adStateOpen Then
		objRecordSet.Close
	End If

	Err.Clear

	Set objRecordSet = Nothing

	GF_ExecuteSQL = arrResultSet
End Function

Function dbSelectCnt(strSql)
    dim objRs, cnt

	sptError=sptError&Chr(9)&"[Query:"&strSql&"]"

    Set objRs = Server.CreateObject("ADODB.Recordset")

       objRs.open strSql, DB1, 1, 2, 1
   cnt = 1

    if Err.Number <> 0 then
        cnt = -999
    else
        if Not (objRs.Eof And objRs.Bof) Then
            cnt = objRs(0)
        End if
    end if

    objRs.close
    Set objRs = Nothing

    dbSelectCnt = cnt
End Function


Function dbSelectError(strSql)
    dim objRs, cnt

	On Error Resume Next
	sptError=sptError&Chr(9)&"[Query:"&strSql&"]"

    Set objRs = Server.CreateObject("ADODB.Recordset")
	objRs.open strSql, DB1
	'set objRs = DB1.execute(strSql) 
	   'cnt = "Y"
		
    if Err.Number <> 0 then
        cnt = Replace(Err.Description,"'","")
    else
        if Not (objRs.Eof And objRs.Bof) Then
			cnt = objRs(0)
            cnt = cnt&"||"&objRs(1)
        End if
    end if

    objRs.close
    Set objRs = Nothing

    dbSelectError = cnt
End Function



Function insertUpdateDB(strSql)

	sptError=sptError&Chr(9)&"[Query:"&strSql&"]"

   On Error Resume Next


        DB1.execute(strSql)


    if Err.Number <> 0 then
        insertUpdateDB = Replace(Err.Description,"'","")
    else
        insertUpdateDB = "Y"
    end if

End Function


Function InsertConnection()


        Set InsertConnection = DB1

End Function


Function DB2ConnectionTest()
    dim returnVal

    If DB2.State <> 1 Then
        returnVal = "False"
    else
        returnVal = "True"
    end if
End Function


Function DB1ConnectionTest()
    dim returnVal

    If DB1.State <> 1 Then
        returnVal = "False"
    else
        returnVal = "True"
    end if

End Function

Sub DbClose()
    If Not DB1 Is Nothing Then
		If DB1.State = 1 Then
			DB1.close
			set DB1=Nothing
		End if
    end if
End Sub

'On Error Resume Next

Set DB1 =Server.Createobject("ADODB.Connection")

DB1.Open Application("Cnnstring")

if Err.Number <> 0 then
%>
<script type="text/javascript">
    alert("DB Connect Fail!")
</script>
<%

dbtDescription=Err.Description
dbtError="Fail"
Else
dbtError="Success"
end if

'sptError=sptError
%>