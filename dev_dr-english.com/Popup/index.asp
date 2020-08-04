<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
Dim pop_name: pop_name	= sqlCheck(replace(request("pop_name"),"'","''"))
Dim pop_img : pop_img	= sqlCheck(replace(request("pop_img"),"'","''"))
If Len(Trim(pop_img))	= 0 Or Len(Trim(pop_name)) = 0 Then
End If
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="/css/popup.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/Commonfiles/Scripts/jquery.min.js"></script>
<script type="text/javascript" src="/commonfiles/scripts/jquery.cookie.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("INPUT[name='popupchk']").bind("click", function() {
		//setCookie($(this).val(), "no", 1);
		$.cookie($(this).val(), "no", {path : "/", expires : 1});
		self.close();
	});
});
</script>
<title><%=TitleName%></title>
</head>
<body style="overflow-x:hidden;">
<!-- ##### // Contents ##### -->
<ul class="popup">
	<li><img src="<%=lms_file_url%>popup/<%=SiteCPCode%>/<%=pop_img%>" border="0" /><li>
	<li style="text-align:right;">
		<input type="checkbox" name="popupchk" value="<%=pop_name%>" /> 오늘 하루 열지 않기
	</li>
</ul>
<!-- ##### Contents // ##### -->
</body>
</html>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp" -->