<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = False
'// menu setting
Dim mMenu : mMenu = "1"
Dim sMenu : sMenu = "11"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
Dim LevelFlag : LevelFlag = sqlCheck(Replace(Request("LevelFlag"), "'", "''"))
%>
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/commonfiles/scripts/member.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$member.init.call(this);
});
</script>
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="contents_title"><img src="../img/mem/title_8_07.gif" alt="회원가입" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td valign="top" style="background-repeat:no-repeat;">
			<table width="681" height="169" border="0" cellpadding="0" cellspacing="0">
				<tr> 
					<td height="115" align="center" valign="top"> 
						<table border="0" cellpadding="0" cellspacing="0">
							<tr> 
								<td width="111"><img src="../img/mem/mem_pro_title.gif" alt="회원가입프로세스" /></td>
								<td width="123"><img src="../img/mem/mem_pro_title01.gif" alt="약관동의/실명확인" /></td>
								<td width="65"><img src="../img/mem/mem_proc_arrow.gif" alt="화살표" /></td>
								<td width="123"><img src="../img/mem/mem_pro_title02.gif" alt="정보입력" /></td>
								<td width="65"><img src="../img/mem/mem_proc_arrow.gif" alt="화살표" /></td>
								<td width="130"><img src="../img/mem/mem_pro_title03on.gif" alt="가입완료" /></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr> 
					<td height="27" align="center">&nbsp;</td>
				</tr>
				<tr> 
					<td align="center"><img src="../img/mem/mem_img03.gif" /></td>
				</tr>
				<tr> 
					<td align="center">&nbsp;</td>
				</tr>
				<tr> 
					<td align="center"> 
					<!-- box -->
						<table width="621" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td width="16"><img src="../img/sub/y_box1.gif" width="16" height="16" /></td>
								<td background="../img/sub/y_box2.gif"></td>
								<td width="16"><img src="../img/sub/y_box3.gif" width="16" height="16" /></td>
							</tr>
							<tr> 
								<td background="../img/sub/y_box8.gif"></td>
								<td align="center" bgcolor="#FAF7EA"> 
								<!-- txt -->
									<table width="98%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="97%" height="70" align="left">국내 최고의 화상교육 
											서비스 ‘<%=subTitleName%>’를 무료로 체험해보시겠습니까?<br />
											실제 수업과 같은 무료레벨테스트를 경험하시려면<span class="point02"> “학습시스템 
											&gt; 맛보기수업”에 “Preveiw학습”과 “Review학습”</span>을 화상수업전에 
											미리 학습해보세요~ <br />
											‘<%=subTitleName%>’만의 학습노하우를 체험하실 수 있습니다.<br /></td>
										</tr>
									</table>
								<!-- txt -->
								</td>
								<td background="../img/sub/y_box4.gif">&nbsp;</td>
							</tr>
							<tr> 
								<td><img src="../img/sub/y_box7.gif" width="16" height="16" /></td>
								<td background="../img/sub/y_box6.gif">&nbsp;</td>
								<td><img src="../img/sub/y_box5.gif" width="15" height="16" /></td>
							</tr>
						</table>
					<!-- box -->
					</td>
				</tr>
				<tr> 
					<td height="35" align="center"> 
					<!-- btn -->
						<table width="346" height="55" border="0" cellpadding="0" cellspacing="0">
							<tr> 
								<td align="center"><a href="/Mypage/Leveltest.asp"> 
								<%IF LevelFlag="Y" THEN%>
									<img src="../img/mem/btn_free02.gif" alt="무료체험신청" border="0" />
								<%END IF%>
								</a><!--<a href="/ClassSystem/TestClass.asp"><img src="../img/mem/btn_free03.gif" alt="맛보기수업" /></a>--></td>
							</tr>
						</table>
					<!-- btn -->
					</td>
				</tr>
				<tr> 
					<td align="left"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->