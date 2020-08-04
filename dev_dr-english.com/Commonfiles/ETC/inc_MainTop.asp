<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<title>::: 서대문구 원어민화상영어 :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" type="text/css" src="/css/maincss.css" />
<style type="text/css">
<!--
td {  font-size: 9pt; line-height: 16pt}
a:link {  color: #15679D; text-decoration: none}
a:visited {  color: #01A0FF; text-decoration: none}
a:hover {  color: #01A0FF; text-decoration: none}
a:active {  color: #FF9900; text-decoration: none}
.CalendarStartDay {	COLOR: white; BACKGROUND-COLOR: #f4165e
}
.calendar {	FONT-SIZE: 8pt; FONT-FAMILY: Arial; TEXT-ALIGN: center
}
.monthNameCell {	FONT-WEIGHT: bold; FONT-SIZE: small; WIDTH: auto; COLOR: #003366; FONT-FAMILY: Arial, Helvetica, sans-serif; HEIGHT: auto; BACKGROUND-COLOR: #fff77b; TEXT-ALIGN: center
}
.b_normal {WIDTH:113PX;BORDER:1px solid d0d0d0;}
.b_active {WIDTH:113PX;BORDER:1px solid green;BACKGROUND-IMAGE:NONE;}
.style8 {color: #FFFFFF}
.input_id {BACKGROUND-IMAGE:URL(/img/txt_input_id.gif);BACKGROUND-REPEAT:NO-REPEAT;}
.input_pw {BACKGROUND-IMAGE:URL(/img/txt_input_pw.gif);BACKGROUND-REPEAT:NO-REPEAT;}
-->
</style>
<script type="text/javascript" src="/Commonfiles/scripts/common.js"></script>
<script type="text/javascript" src="/Commonfiles/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/Commonfiles/scripts/jquery.flash.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#topFlash").flash({
		src		: "/img/img/menu.swf",
		width	: "731",
		height	: "84"
	});

	/* Main script init */
	$main.init.call(this);
});
</script>
</head>
<body bgcolor="#FFFFFF" background="/img/img/m_bg.gif" text="#000000" leftmargin=0 topmargin=0>
<center>
<table width="100" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table cellpadding=0 cellspacing=0 border=0 width=100%  background="/img/img/m_bg.gif">
				<tr>
					<td>
						<table width="1000" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="3"></td>
							</tr>
						<%IF session("UserID")<>"" THEN%>
							<tr>
								<td>
									<table width="241" border="0" align="right" cellpadding="0" cellspacing="0">
										<tr>
											<td width="85"><a href="/" target="_self"><img src="/img/img/top_m01.gif" width="85" height="24" border="0"></a></td>
											<td ><a href="/UserMember/Logout.asp"><img src="/img/img/top_m022.gif"  border=0></a></td>
											<td ><a href="/UserMember/UserUpdateCheck.asp"><img src="/img/img/top_m033.gif"  border=0></a></td>
											<td width="26"><a href="/sitepage/sitemap.asp"><img src="/img/img/top_m04.gif" width="86" height="24" border=0></a></td>
										</tr>
									</table>
								</td>
							</tr>
						<%Else%>
							<tr>
								<td>
									<table width="241" border="0" align="right" cellpadding="0" cellspacing="0">
										<tr>
											<td width="85"><a href="/" target="_self"><img src="/img/img/top_m01.gif" width="85" height="24"				border="0"></a></td>
											<td width="59"><a href="/UserMember/LoginPage.asp"><img src="/img/img/top_m02.gif" width="59" height="24" border=0></a></td>
											<td width="71"><a href="/UserMember/UserRegistCheck.asp"><img src="/img/img/top_m03.gif" width="71" height="24" border=0></a></td>
											<td width="26"><a href="/sitepage/sitemap.asp"><img src="/img/img/top_m04.gif" width="86" height="24" border=0></a></td>
										</tr>
									</table>
								</td>
							</tr>
						<%End If%>
							<tr>
								<td height="20"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table width="1000" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="269" align="center" valign="top"><a href="/"><img src="/img/img/logo.gif" width="219" height="84" border=0></a></td>
								<td width="731" id="topFlash"><!--##### Top Flash #####--></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>