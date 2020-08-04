<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = True
'// menu setting
Dim mMenu : mMenu = "0"
Dim sMenu : sMenu = "6"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/commonfiles/scripts/member.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$member.out.init.call(this);
});
</script>
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="contents_title"><img src="../img/mem/title_8_06.gif" alt="회원탈퇴" /></td>
	</tr>
	<tr>
	<td>&nbsp;</td>
	</tr>
	<tr>
		<td background="../img/mem/idpw_bgimg06.gif" style="background-repeat:no-repeat;">
			<table width="681" height="169" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="115" align="left" valign="top"></td>
				</tr>
				<tr>
					<td align="left">
					<!-- id find -->
						<table width="500" border="0" cellpadding="0" cellspacing="0">
						<form action="UserDelOK.asp" method="post" name="Dform">
							<tr>
								<td height="30"><img src="../img/mem/sub_s_title05.gif" alt="정말탈퇴하시겠습니까?" /></td>
							</tr>
							<tr>
								<td height="20"><img src="../img/mem/icon_atten2.gif" alt="주의" align="absmiddle" /> <span class="point02">탈퇴를 원하시면 아래 내용을 입력 후 확인버튼을 눌러주시기 바랍니다.</span></td>
							</tr>
							<tr>
								<td>
									<table width="500" border="0" cellpadding="0" cellspacing="0" class="t_style01">
										<tr>
											<th width="126" class="line_top">아이디</th>
											<td width="354" class="line_top"><%=sUserID%></td>
										</tr>
										<tr>
											<th class="line_middle">비밀번호</th>
											<td class="line_middle"><input name="UserPW" type="password" class="input cssinput" id="textfield5" size="20"  caption="등록하신 패스워드" /></td>
										</tr>
										<tr>
											<th class="line_middle01">이름</th>
											<td class="line_middle01"><input name="UserName" type="text" class="input cssinput" id="textfield5" size="20"  caption="등록하신 회원 이름"/></td>
										</tr>
										<tr>
											<th class="line_middle01">이메일</th>
											<td class="line_middle01"><input name="UserEmail01" type="text" class="input cssinput" id="textfield" size="20" caption="등록하신 이메일 주소" />
												@
												<input name="UserEmail02" type="text" class="input cssinput" id="textfield6" size="25" caption="등록하신 이메일 주소" />
											</td>
										</tr>
										<tr>
											<th class="line_bot">탈퇴사유</th>
											<td class="line_bot">
												<select name="UserMflagsau" class="select cssinput" id="UserMflagsau" caption="탈퇴 사유">
													<option value="">:: 탈퇴 사유선택 ::</option>
													<option value="학습종료">학습종료</option>
													<option value="프로그램에 대한 불만">프로그램에 대한 불만</option>
													<option value="타사의 서비스로 이동">타사의 서비스로 이동</option>
													<option value="학습방법에 대한 싫증">학습방법에 대한 싫증</option>
													<option value="이벤트 혜택">이벤트 혜택</option>
													<option value="기타">기타</option>
												</select>							
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<!-- btn -->
							<tr>
								<td height="30" align="right">
									<img src="../img/board/btn_ok.gif" alt="확인" style="cursor:pointer;" id="outBtns" />
									<a href="/"><img src="../img/board/btn_can.gif" alt="취소" border=0/></a>
								</td>
							</tr>
						</form>
						</table>
					<!-- id find end -->
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
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