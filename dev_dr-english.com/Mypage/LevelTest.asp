<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = True
'// menu setting
Dim mMenu : mMenu = "3"
Dim sMenu : sMenu = "4"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<!--#include virtual="/include/inc_top.asp"-->
<%
'########## 레벨테스트 날짜 및 시간 정보 CP 수강 방식에 따라 변경
Dim strLevelTest : strLevelTest = getLevelTestDate(Application("CP_ORDER"))

Dim bTest : bTest = False
Dim arrData, arrLevel, objRs

Sql = "SELECT nvcMemberTel, nvcMemberCTN FROM TB_MEMBER WITH(NOLOCK) WHERE iMemberSeq = '"& sUserSeq &"' "
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	strMemberTel = objRs(0)
	On Error Resume Next
	strMemberTel = Split(strMemberTel, "-")
	strMemberTel1= strMemberTel(0)
	strMemberTel2= strMemberTel(1)
	strMemberTel3= strMemberTel(2)

	strMemberCTN = objRs(1)
	On Error Resume Next
	strMemberCTN = Split(strMemberCTN, "-")
	strMemberCTN1= strMemberCTN(0)
	strMemberCTN2= strMemberCTN(1)
	strMemberCTN3= strMemberCTN(2)
End If
objRs.Close

Sql = "SELECT iLevelTestSeq, IsNull(B.nvcTeacherName, '미배정') AS nvcTeacherName, "
Sql = Sql & "nvcLevelTestDay, nvcLevelTestTime, iCLCourseSeq,A.nvcScheTel "
Sql = Sql & "FROM TB_LEVELTEST AS A WITH(NOLOCK) "
Sql = Sql & "LEFT OUTER JOIN TB_TEACHER AS B WITH(NOLOCK) ON(A.iTeachersEQ = B.iTeacherSeq) "
Sql = Sql & "WHERE iMemberSeq = '"& sUserSeq &"'"
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If
objRs.Close

If IsArray(arrData) Then
	bTest = True

	iTSeq	= arrData(0, 0)
	strTName= arrData(1, 0)
	strTDate= arrData(2, 0)
	strTTime= Split(arrData(3, 0), ":")
	iCSeq	= arrData(4, 0)
	strScheTel= arrData(5, 0)
End If

'########## 레벨테스트 
Sql = "SELECT A.iCLCourseSeq, A.nvcCLCourseName FROM TB_CLCOURSE AS A WITH(NOLOCK) "
Sql = Sql & "INNER JOIN TB_CLLEVEL AS B WITH(NOLOCK) ON(A.iCLLevelSeq = B.iCLLevelSeq) "
Sql = Sql & "WHERE A.nvcCPCode = N'"& SiteCPCode &"' AND A.iCourseSeq = 1 "
Sql = Sql & "AND siClCourseFlag = '1' AND B.siFlag = '1' ORDER BY B.iCLLevelSeq "
Set Rs = dbSelect(Sql)
If Not Rs.Eof Then
	arrLevel = Rs.GetRows()
End If
Rs.Close	:	Set Rs = Nothing	

Dim toDay		: toDay		= Date()
Dim today_time	: today_time= hour(now)
Dim today_tMin	: today_tMin=minute(now)

today_tMin=today_tMin
IF today_tMin<0 THEN
	today_tMin=0
END If

If Application("CP_ORDER")=1 then
	sql="select top 1 iBalanceCourseSeq from tb_BalanceCourse where siFlag=1 and nvcCPCode=N'"& SiteCPCode &"'  Order by iBalanceCourseSeq desc "
	Set Rs = dbSelect(Sql)
	If Not Rs.Eof Then
		UserBalanceSeq=Rs(0)
	End If
	Rs.Close	:	Set Rs = Nothing	
End If
Call DBClose()
%>
<script type="text/javascript" src="/commonfiles/scripts/jquery.alphanumeric.pack.js"></script>
<script type="text/javascript" src="/Commonfiles/Scripts/orderpage.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$order.levelTest.init.call(this);
});
</script>
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
<form action="LevelTestOK.asp" name="Uform" method="post">
<input name="today"				type="hidden" value="<%=today%>" />
<input name="todayhour"			type="hidden" value="<%=cint(today_time)+2%>" />
<input name="todaymin"			type="hidden" value="<%=today_tMin%>" />
<input name="UserBalanceSeq"	type="hidden" value="<%=UserBalanceSeq%>" />
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="contents_title"><img src="../img/sub/title_3_03.gif" alt="무료체험신청" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td ><img src="../img/sub/sub03_img03.gif" alt="무료체험신청" /></td>
	</tr>
	<tr>
		<td height="30" >&nbsp;</td>
	</tr>
	<tr>
		<td align="center">
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><img src="../img/sub/sub03_tx_img07.gif" /></td>
				</tr>
				<tr>
					<td align="center" valign="top">&nbsp;</td>
				</tr>
				<tr>
					<td align="center">
						<table width="616" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="616" align="left">아래의 화상수업 Start버튼을 클릭하면 해당시간에 맞춰 강사와 수업을 진행하실 수 있습니다.</td>
							</tr>
						</table>
						<br />

						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="15"><img src="../img/board/gbox_lt.gif" width="15" height="15" /></td>
								<td background="../img/board/gbox_tbg.gif"></td>
								<td width="15"><img src="../img/board/gbox_rt.gif" width="15" height="15" /></td>
							</tr>
							<tr>
								<td background="../img/board/gbox_lbg.gif">&nbsp;</td>
								<td align="left" bgcolor="#FFFFFF">
								<!-- 입력박스 -->
									<table width="100%" border="0" cellspacing="1" cellpadding="6" class="t_style02">
										<tr>
											<th width="105" align="left">이름(국문)</th>
											<td width="519"><%=sUserName%></td>
										</tr>
										<tr>
											<td height="1" colspan="2" align="left" background="../img/dot.gif"></td>
										</tr>
										<tr>
											<th width="105" align="left">이름(영어)</th>
											<td><%=sUserEName%></td>
										</tr>
										<tr>
											<td height="1" colspan="2" align="left" background="../img/dot.gif"></td>
										</tr>
									<%If bTest Then%>
										<tr>
											<th width="105" align="left">수업강사</th>
											<td><%=strTName%></td>
										</tr>
										<tr>
											<td height="1" colspan="2" align="left" background="../img/dot.gif"></td>
										</tr>
									<%End If%>
																			
										<tr>
											<th width="105" align="left">무료체험예약<br />시간/날짜<br /></th>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<%If bTest Then%>
													<tr>
														<td><%=strTDate%> / <%=strTTime(0)%>시 <%=strTTime(1)%>분</td>
													</tr>
												<%Else%>
													<tr>
														<td>
															<select name="SL_Cdate1" class="select csstest" id="select2" caption="날짜">
															<!-- ##### // Level Test ##### -->	
																<%=strLevelTest%>
															<!-- ##### Level Test // ##### -->
															</select>

															<span id="div_Sch">
															<select name="SL_Ctime1" class="select csstest" id="SL_Ctime1" caption="시간">
																<option value="">선택</option>
															</select>
															시
															</span>

															<select name="SL_Ctime2" class="select csstest" id="SL_Ctime2" caption="시간">
																<option value="">선택</option>
																<option value="00" >00</option>
																<option value="30" >30</option>
															</select>
															분
														</td>
													</tr>													
												<%End If%>
												</table>
											</td>
										</tr>
										<tr>
											<td height="1" colspan="2" align="left" background="../img/dot.gif"></td>
										</tr>
									<%If bTest Then%>									
										<tr>
											<th width="105" align="left">수업전화번호</th>
											<td><%=strScheTel%></td>
										</tr>
										<tr>
											<td height="1" colspan="2" align="left" background="../img/dot.gif"></td>
										</tr>
									<%else%>
										<tr>
											<th width="105" align="left">수업전화번호</th>
											<td>
												<table border="0" width="100%" cellpadding="0" cellspacing="0">
													<tr>
														<td width="25" height="26" align="center"><input name="PhoneChoice" type="radio" class="box" id="radio11" value="P" /></td>
					                                    <td width="40" height="26" align="left">유선</td>
														<td align="left">
															<select size="1" name="L_UserPhone1_1" class="select">
															<%Call setPhoneHtml("P", strMemberTel1)%>
															</select>
															-
						                                    <input name="L_UserPhone1_2" type="text" class="textfield cssnumber" id="L_UserPhone1_2" size="5" maxlength="4"  value="<%=strMemberTel2%>"  />
												            -
															<input name="L_UserPhone1_3" type="text" class="textfield cssnumber" id="L_UserPhone1_3" size="5" maxlength="4"  value="<%=strMemberTel2%>" />
														</td>
													</tr>
													<tr>
														<td width="25" height="26" align="center"><input name="PhoneChoice" type="radio" class="box" id="radio11" value="C" /></td>
					                                    <td width="40" height="26" align="left">무선</td>
														<td align="left">
															<select size="1" name="L_UserPhone2_1" class="select">
															<%Call setPhoneHtml("C", strMemberCTN1)%>
															</select>
															-
						                                    <input name="L_UserPhone2_2" type="text" class="textfield cssnumber" id="L_UserPhone2_2" size="5" maxlength="4"  value="<%=strMemberCTN2%>" />
												            -
															<input name="L_UserPhone2_3" type="text" class="textfield cssnumber" id="L_UserPhone2_3" size="5" maxlength="4"  value="<%=strMemberCTN3%>" />
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="1" colspan="2" align="left" background="../img/dot.gif"></td>
										</tr>
									<%End If%>
										<tr>
											<th width="105" align="left">희망하는 <br>수강과정<span class="bold"></span></th>
												<td>
													<table  border="0" cellspacing="0" cellpadding="0" class="t_style02">
														
<!-- ########## // 과목별 과정 ########## -->
<%
itrnum=0
With Response
If IsArray(arrLevel) Then
	For i = 0 To Ubound(arrLevel, 2)
		If itrnum=0 then
		.Write "<tr>"
		End If
		
		.Write "<td style='width:25px;height:26px;text-align:center;'>"
		.Write "	<input type='radio' class='box' name='StudentLeveL' id='StudentLeveL"& i+1 &"' value='"& arrLevel(0, i) &"' "
		If iCSeq = arrLevel(0, i) Then
			.Write "checked"
		End If
		.Write "/>"
		.Write "</td>"
		.Write "<td style='width:120px;heigth:26px;text-align:left;'><label for='StudentLeveL"& i+1 &"'>"& arrLevel(1, i) &"</label></td>"
		
		If itrnum=2 or Ubound(arrLevel, 2)=i then
		.Write "</tr>"
		End If

		itrnum=itrnum+1
		If itrnum=3 Then
			itrnum=0
		End if
	Next
Else
	.Write "<tr><td style='text-align:center;height:26px;'>등록된 과정이 없습니다.</td></tr>"
End If
End With
%>
<!-- ########## 과목별 과정 // ########## -->
														
													</table>
												</td>
											</tr>
											<tr>
												<td height="1" colspan="2" align="left" background="../img/dot.gif"></td>
											</tr>
										</table>
										<!-- 입력박스 -->
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td height="50" align="center">	
												<%If Not bTest Then%>
													<img src="../img/board/btn_app.gif" style="cursor:pointer;" class="cssBtns" caption="APPLY" />
												<%End If%>
												 
													<img src="../img/board/btn_result.gif" border="0" style="cursor:pointer;" class="cssBtns" caption="VIEW" />
												</td>
											</tr>
										</table>
									</td>
									<td background="../img/board/gbox_rbg.gif">&nbsp;</td>
								</tr>
								<tr>
									<td width="15"><img src="../img//board/gbox_lb.gif" width="15" height="15" /></td>
									<td background="../img/board/gbox_bbg.gif"></td>
									<td width="15"><img src="../img/board/gbox_rb.gif" width="15" height="15" /></td>
								</tr>
							</table> 
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center" >&nbsp; </td>
		</tr>
	</form>
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->