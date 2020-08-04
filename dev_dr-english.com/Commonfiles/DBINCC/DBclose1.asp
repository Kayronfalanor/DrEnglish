<%
If Not DB1 Is Nothing Then
	If DB1.State = 1 Then
        DB1.close
        set DB1=Nothing
    End If
End If
%>