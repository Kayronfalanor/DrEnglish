<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = False
'// menu setting
Dim mMenu : mMenu = "0"
Dim sMenu : sMenu = "2"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
Dim IDNPW, UserID, UserName, UserEmail1, UserEmail2, Email
IDNPW		= sqlCheck(replace(request.form("IDNPW"),"'","''"))
IDNPW		= replace (IDNPW,"<%","&lt;%")
IDNPW		= replace (IDNPW,"%\>","%&gt;")
	
UserID		= sqlCheck(replace(request.form("UserID"),"'","''"))
UserID		= replace (UserID,"<%","&lt;%")
UserID		= replace (UserID,"%\>","%&gt;")
	
UserEmai1	= sqlCheck(replace(request.form("UserEmai1"),"'","''"))
UserEmai1	= replace (UserEmai1,"<%","&lt;%")
UserEmai1	= replace (UserEmai1,"%\>","%&gt;")
UserEmai2	= sqlCheck(replace(request.form("UserEmai2"),"'","''"))
UserEmai2	= replace (UserEmai2,"<%","&lt;%")
UserEmai2	= replace (UserEmai2,"%\>","%&gt;")		
EMAIL		= UserEmai1&"@"&UserEmai2

UserName	= sqlCheck(replace(request.form("UserName"),"'","''"))
UserName	= replace (UserName,"<%","&lt;%")
UserName	= replace (UserName,"%\>","%&gt;")
UserEmail	= sqlCheck(replace(request.form("UserEmail"),"'","''"))
UserEmail	= replace (UserEmail,"<%","&lt;%")
UserEmail	= replace (UserEmail,"%\>","%&gt;")

Dim strWhere : strWhere = ""
Dim strSQL, Rs, arrData

If Len(Trim(IDNPW)) > 0 Then
	If IDNPW = "ID" Then
		strWhere = " AND nvcMemberName = N'"& UserName &"' AND (nvcMemberEmail = N'"& EMAIL &"' OR nvcParentsEmail = N'"& EMAIL &"') "
	ElseIf IDNPW = "PW" Then
		strWhere = " AND nvcMemberID = N'"& UserID &"' AND nvcMemberName = N'"& UserName &"' "
		strWhere = strWhere & " AND (nvcMemberEmail = N'"& EMAIL &"' OR nvcParentsEmail = N'"& EMAIL &"') "
	End If
	strWhere = strWhere & " AND siMemberFlag = '1' "


	strSQL = "SELECT nvcMemberID, nvcMemberPW, dtCreateDate FROM TB_MEMBER WITH(NOLOCK) "
	strSQL = strSQL & "WHERE nvcCPCode = N'"& SiteCPCode &"' "
	strSQL = strSQL & strWhere
	Set Rs = dbSelect(strSQL)
	If Not Rs.Eof Then
		arrData = Rs.GetRows()
	End If
	Rs.Close	:	Set Rs = Nothing
	DB1.Close	:	Set DB1 = Nothing
End If
%>
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/commonfiles/scripts/member.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$member.search.init.call(this);
});
</script>
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="contents_title"><img src="../img/mem/title_8_02.gif" alt="아이디비밀번호찾기" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td background="../img/mem/idpw_bgimg01.gif" style="background-repeat:no-repeat;">
			<table width="681" height="169" border="0" cellpadding="0" cellspacing="0">
				<tr> 
					<td	height="115">&nbsp;</td>
				</tr>
				<tr> 
					<td align="left"> 
					<!-- id find -->
						<table width="500" border="0" cellpadding="0" cellspacing="0">
						<form action="UserIDsearch.asp#id" name="IDForm" method="post">
						<input type="hidden" name="IDNPW" value="ID">
							<tr> 
								<td height="30"><img src="../img/mem/sub_s_title01.gif" alt="아이디찾기" /></td>
							</tr>
							<tr> 
								<td height="20"><img src="../img/mem/sub_login_txt01.gif" alt="가입시 등록하셨던 이름과 이메일 주소를 입력하세요" /></td>
							</tr>
							<tr> 
								<td>
									<table width="500" border="0" cellpadding="0" cellspacing="0" class="t_style01">
										<tr> 
											<th width="126" class="line_top">이름</th>
											<td width="354" class="line_top"><input name="UserName" type="text" class="input cssfid" id="UserName" size="20" caption="이름을 공백없이 입력하세요~!!" /></td>
										</tr>
										<tr> 
											<th class="line_bot01">이메일</th>
											<td class="line_bot01"><input name="UserEmai1" type="text" class="input cssfid" id="textfield14" size="20" caption="회원가입 시 입력하셨던 이메일 주소 앞자리를 입력하세요~!!" />
											@ 
											<input name="UserEmai2" type="text" class="input cssfid" id="UserEmai2" size="25" caption="회원가입 시 입력하셨던 이메일 주소 뒷자리를 입력하세요~!!" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr> 
								<td height="30" align="right"><img src="../img/board/btn_ok.gif" alt="확인" class="cssfBtns" caption="FIND" data-class=".cssfid" data-form="IDForm" style="cursor:pointer;" /><img src="../img/board/btn_can.gif" alt="취소" border="0" class="cssfBtns" caption="CANCEL" style="cursor:pointer;" /></td>
							</tr>
							</form>
						</table>
						
					<%If IDNPW = "ID" Then%>
					<a name="id">
						<table width="500" border="0" cellpadding="0" cellspacing="0">
							<tr> 
								<td height="30"><img src="../img/mem/sub_s_title01.gif" alt="아이디찾기" /></td>
							</tr>
							<tr> 
								<td height="20">&nbsp;</td>
							</tr>
							<tr> 
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="10"><img src="../img/board/box_b_01.gif" width="10" height="10" /></td>
											<td background="../img/board/box_b_02.gif" bgcolor="#FEF0ED"></td>
											<td width="10"><img src="../img/board/box_b_03.gif" width="10" height="10" /></td>
										</tr>
										<tr bgcolor="#FEF0ED"> 
											<td background="../img/board/box_b_08.gif">&nbsp;</td>
											<td height="70" align="center" bgcolor="#F8FCFF">
											<%If IsArray(arrData) Then%>
												회원님의 아이디는 <span class="point"><%=arrData(0, 0)%> </span>입니다.
											<%Else%>
												<font color="#FF0000">입력하신 정보가 일치하지 않습니다. 다시확인 후 검색하세요.</font>
											<%End If%>
											</td>
											<td background="../img/board/box_b_04.gif">&nbsp;</td>
										</tr>
										<tr> 
											<td width="10"><img src="../img/board/box_b_07.gif" width="10" height="10" /></td>
											<td background="../img/board/box_b_06.gif" bgcolor="#FEF0ED"><img src="../img/board/box_b_06.gif" width="1" height="10" /></td>
											<td width="10"><img src="../img/board/box_b_05.gif" width="10" height="10" /></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</a>
					<%End IF%>
					<!-- id find end -->
					</td>
				</tr>
				<tr> 
					<td>&nbsp;</td>
				</tr>
				<tr> 
					<td align="left"> 
					<!-- pw find -->
						<table width="500" border="0" cellpadding="0" cellspacing="0">
						<form action="UserIDsearch.asp#pw" name="PWForm" method="post">
						<input type="hidden" name="IDNPW" value="PW">                     
							<tr> 
								<td height="30"><img src="../img/mem/sub_s_title02.gif" alt="비밀번호찾기" /></td>
							</tr>
							<tr> 
								<td height="20"><img src="../img/mem/sub_login_txt02.gif" alt="가입시 등록하셨던 이름과 이메일 주소를 입력하세요" /></td>
							</tr>
							<tr> 
								<td>
									<table width="500" border="0" cellpadding="0" cellspacing="0" class="t_style01">
										<tr> 
											<th width="126" class="line_top">아이디</th>
											<td width="354" class="line_top"><input name="UserID" type="text" class="input cssfpw" id="UserID" size="20" caption="아이디를 공백없이 입력하세요~!!" /></td>
										</tr>
										<tr> 
											<th class="line_middle">이름</th>
											<td class="line_middle"><input name="UserName" type="text" class="input cssfpw" id="textfield5" size="20" caption="이름을 공백없이 입력하세요~!!" /></td>
										</tr>
										<tr> 
											<th class="line_bot">이메일</th>
											<td class="line_bot"><input name="UserEmai1" type="text" class="input cssfpw" id="textfield3" size="20" caption="회원가입 시 입력하셨던 이메일 주소 앞자리를 입력하세요~!!" />
											@ 
											<input name="UserEmai2" type="text" class="input cssfpw" id="textfield4" size="25" caption="회원가입 시 입력하셨던 이메일 주소 뒷자리를 입력하세요~!!" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr> 
								<td height="30" align="right"><img src="../img/board/btn_ok.gif" alt="확인" class="cssfBtns" caption="FIND" data-class=".cssfpw" data-form="PWForm" style="cursor:pointer;" /><img src="../img/board/btn_can.gif" alt="취소" border="0" class="cssfBtns" caption="CANCEL" style="cursor:pointer;" /></td>
							</tr>
						</form>
						</table>

					<%If IDNPW = "PW" Then%>
					<a name="pw">
						<table width="500" border="0" cellpadding="0" cellspacing="0">
							<tr> 
								<td height="30"><img src="../img/mem/sub_s_title02.gif" alt="비밀번호찾기" /></td>
							</tr>
							<tr> 
								<td height="20">&nbsp;</td>
							</tr>
							<tr> 
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td width="10"><img src="../img/board/box_b_01.gif" width="10" height="10" /></td>
											<td background="../img/board/box_b_02.gif" bgcolor="#FEF0ED"></td>
											<td width="10"><img src="../img/board/box_b_03.gif" width="10" height="10" /></td>
										</tr>
										<tr bgcolor="#FEF0ED"> 
											<td background="../img/board/box_b_08.gif">&nbsp;</td>
											<td height="70" align="center" bgcolor="#F8FCFF">
											<%If IsArray(arrData) then%>
												<span class="style3">회원님의 패스워드는 <span class="point"><%=Base64decode(arrData(1, 0))%> </span>입니다.</span>
											<%Else%>
												<font color="#FF0000">입력하신 정보가 일치하지 않습니다. 다시확인 후 검색하세요.</font>
											<%End If%>
											</td>
											<td background="../img/board/box_b_04.gif">&nbsp;</td>
										</tr>
										<tr> 
											<td width="10"><img src="../img/board/box_b_07.gif" width="10" height="10" /></td>
											<td background="../img/board/box_b_06.gif" bgcolor="#FEF0ED"><img src="../img/board/box_b_06.gif" width="1" height="10"		/></td>
											<td width="10"><img src="../img/board/box_b_05.gif" width="10" height="10" /></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</a>
					<%End If%>
					<!-- pw find end -->
					</td>
				</tr>
				<tr> 
					<td>&nbsp;</td>
                </tr>
			</table>
		</td>
	</tr>
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->