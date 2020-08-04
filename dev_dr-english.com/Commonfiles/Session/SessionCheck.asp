<%
'로그인 여부 체크
If IsLogin Then
	If Session("UserID") = "" Then
	With Response
		.Write "<form action='/UserMember/LoginPage.asp' name='LoginForm' method='post' target='_top'>
		.Write "<input type='hidden' name='returnUrl'	value='"& returnUrl &"' />"
		.Write "<input type='hidden' name='ggno'		value='"& gno &"'	/>"
		.Write "<input type='hidden' name='CuponNubmer' value='"& CuponNumber &"' />"
		.Write "</form>"

		.Write "<script type='text/javascript'>"
		'.Write "if(self.opener != null) {"
		'.Write "	self.close();"
		'.Write "} else {"
		'.Write "	documnet.LoginForm.submit();"
		.Write "	self.close();"
		'.Write "}
		.Write "</script>"
		.End
	End With
	End If
End If
%>