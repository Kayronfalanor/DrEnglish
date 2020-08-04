<%@Codepage=65001%>
<%
	Response.CharSet = "utf-8"
    Session.CodePage = 65001

    Response.AddHeader "Pragma","no-cache"
    Response.AddHeader "Expires","0"

	Response.Clear
	'Response.Buffer = false
%>