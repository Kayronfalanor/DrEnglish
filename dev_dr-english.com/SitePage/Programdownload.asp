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
Dim sMenu : sMenu = "7"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<!--#include virtual="/include/inc_top.asp"-->
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="contents_title"><img src="../img/sub/title_7_06.gif" alt="프로그램 다운로드" /></td>
	</tr>
	<tr>
		<td><br><br></td>
	</tr>
	<tr>
		<td align="center"><img src="../img/newx/sub/sub06_img05.png" /></td>
	</tr>
	<tr>
		<td ></td>
	</tr>
	<tr>
		<td align="center">
			<img src="../img/newx/sub/dl1.png" />
			<img src="../img/newx/sub/dl2.png" alt="" usemap="#dl2.png" style="border: 0;" /></a>
			<map name="dl2.png">
				<area shape="rect" coords="0,0,272,106" href="/upfiles/FilesDownLoad/install_flash_player_10_active_x100452.exe" target="" alt="" />
			</map>

			<img src="../img/newx/sub/dl3.png" />
			<a href=""><img src="../img/newx/sub/dl4.png" alt="" usemap="#dl4.png" style="border: 0;" /></a>
			<map name="dl4.png">
				<area shape="rect" coords="0,0,272,106" href="/upfiles/FilesDownLoad/mzAxRecST.msi" target="" alt="" />
				<area shape="rect" coords="314,0,586,106" href="/upfiles/FilesDownLoad/wmp11-windowsxp-x86-ko-kr.exe" target="" alt="" />
			</map>
		</td>
	</tr>
	<tr>
		<td align="center">
			<a href="/SitePage/Videoguide.asp"><img src="../img/newx/sub/dl5.png" /></a>
		</td>
	</tr>
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->