<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = False
'// menu setting
Dim mMenu : mMenu = "6"
Dim sMenu : sMenu = "1"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<!--#include virtual="/include/inc_top.asp"-->
<div class="contents">
<!-- ##### // Contents ##### -->

<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->