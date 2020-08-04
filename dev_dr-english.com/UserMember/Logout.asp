<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = False
%>
<!--#include virtual="/commonfiles/DBINCC/Expires.asp"-->
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
Session.Abandon()
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp" -->
<%
Response.Redirect "/"
Response.End
%>
