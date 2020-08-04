<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"
 
'// Login 여부
Dim IsLogin : IsLogin = True
'// menu setting
Dim mMenu : mMenu = "1"
Dim sMenu : sMenu = "7"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<!--#include virtual="/include/inc_top.asp"-->
<div class="contents">
<!-- ##### // Contents ##### -->
<script language="javascript">

function fn_Remote()
{
	<%if sUserid="" then %>
		alert('로그인 하신 후에 이용해주세요.');	
		return  false;
	<%else%>
	
	if (Rform.SL_Cdate1.value=="")
	{	
		alert("원격지원 날짜를 선택해주세요.");
		Rform.SL_Cdate1.focus();
		return false;
	}

	if (Rform.SL_Ctime1.value=="")
	{	
		alert("원격지원 시간을 선택해주세요.");
		Rform.SL_Ctime1.focus();
		return false;
	}

	if (Rform.SL_Ctime2.value=="")
	{	
		alert("원격지원 시간을 선택해주세요.");
		Rform.SL_Ctime2.focus();
		return false;
	}

	

	if (Rform.SL_Cdate1.value==Rform.strnowdate.value)
	{
		if (parseInt(Rform.SL_Ctime1.value) < parseInt(Rform.strnowhour.value)+2 )
		{
			alert("원격지원요청은 현재보다 2시간후의 시간으로 신청 가능합니다.");
			return false;
		}
	}
	
	if (Rform.SL_Name.value=="")
	{	
		alert("원격지원 받으실 분의 성명을 입력해주세요.");		
		return false;
	}

	if (Rform.SL_Phone.value=="")
	{	
		alert("원격지원시 연락처를 입력해주세요.");
		Rform.SL_Phone.focus();
		return false;
	}

	Rform.submit();
	<%end if%>

}
</script>
<script language="javascript">
  function TimeChange(obj4){
	if(obj4 == "11"){
		 for(var i=0; i<2; i++){
		  document.Rform.SL_Ctime2.options[5] = null;
		  document.Rform.SL_Ctime2.options[6] = null;
		}
	}else{
		document.Rform.SL_Ctime2.options[5] = new Option("40","40");
		document.Rform.SL_Ctime2.options[6] = new Option("50","50");
	}
  }
</script>

<table width="681" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="contents_title"><img src="../img/newx/sub/title_8_1.png" alt="원격지원센터" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td ></td>
	</tr>
	<tr>
		<td >&nbsp;</td>
	</tr>
	<tr>
		<td align="center" >
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				
				
				
				<tr><td></td></tr>
				<tr><td>
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				
				<form name="Rform" id="Rform" method="post" action="./PCControl_proc.asp" >
				<input type="hidden" name="strnowdate" value="<%=Left(Now(),10)%>">
				<input type="hidden" name="strnowhour" value="<%=Right("0"&Hour(Now()),2)%>">
				<input type="hidden" name="strnowmin" value="<%=Right("0"&minute(Now()),2)%>">
				<tr>
					<td width="15"><img src="../img//board/brbox_lt.gif" width="15" height="15" /></td>
					<td background="../img/board/brbox_tbg.gif"></td>
					<td width="15"><img src="../img//board/brbox_rt.gif" width="15" height="15" /></td>
				</tr>
				<tr>
					<td background="../img/board/brbox_lbg.gif">&nbsp;</td>
					<td align="left">
						<table width="100%" border="0" cellspacing="1" cellpadding="2" class="t_style02">
							<tr>
								<th width="160" align="left" class="point">원격지원 날짜/시간</th>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="30">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr><td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="26"><span class="point"><span class="point03">*
															원격지원요청은 현재보다 2시간 후의 시간으로 신청 가능합니다.</span></td>
													</tr>
												</table>
												</td></tr>
													<tr>
														<td>
															<select name="SL_Cdate1" class="select csstest" id="select2" caption="날짜">
															<!-- ##### // Level Test ##### -->	
																<option value="">선택</option>
																<%
																For i=0 To 10
																	If weekday(DateAdd("d",i,Now()))<>"1" and weekday(DateAdd("d",i,Now()))<>"7" then
																	
																%>
																<option value="<%=Left(DateAdd("d",i,Now()),10)%>" ><%=Left(DateAdd("d",i,Now()),10)%></option>
																<%
																End if
																next
																%>
															<!-- ##### Level Test // ##### -->
															</select>
															
															<span id="div_Sch">
															<select name="SL_Ctime1" class="select csstest" id="SL_Ctime1" caption="시간" >
																<option value="">선택</option>
																<option value="15" >15</option>
																<option value="16" >16</option>
																<option value="17" >17</option>
																<option value="18" >18</option>
																<option value="20" >20</option>
																<option value="21" >21</option>
															</select>
															시
															</span>

															<select name="SL_Ctime2" class="select csstest" id="SL_Ctime2" caption="시간">
																<option value="">선택</option>
																<option value="00" >00분 ~ 29분</option>
																<option value="30" >30분 ~ 59분</option>															
															</select>
															분
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
									
								</td>
							</tr>
							<tr>
								<td height="1" colspan="2" align="left" background="../img/dot.gif"></td>
							</tr>
							<tr>
								<th width="105" align="left" class="point">성 명 </th>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="26" align="left"><input name="SL_Name" type="text" class="box" value="<%=sUserName%>" maxlength="20" readonly />
											</td>
											
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="1" colspan="2" align="left" background="../img/dot.gif"></td>
							</tr>	
							<tr>
								<th width="105" align="left" class="point">연락처 </th>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="26" align="left"><input name="SL_Phone" type="text" class="box" value="<%=session("UserPhone")%>" maxlength="14" />
											</td>
											
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="1" colspan="2" align="left" background="../img/dot.gif"></td>
							</tr>
							<tr>
								<th width="160" align="left" class="point">원격지원 사유<span class="bold"></span></th>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0" >
										<tr>
										<textarea name="nvcReason" id="nvcReason" rows="4" cols="46"></textarea>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="1" colspan="2" align="left" background="../img/dot.gif"></td>
							</tr>

						<tr>
								<td COLSPAN="2" ALIGN=CENTER HEIGHT=40>
									<input type="button" value="원격지원 신청하기 " style="height:30px;width:150px;" onclick="return fn_Remote();">
								</td>
							</tr>
							<tr>
								<td height="1" colspan="2" align="left" background="../img/dot.gif"></td>
							</tr>
						</table>
					</td>
					<td background="../img/board/brbox_rbg.gif">&nbsp;</td>
				</tr>
				<tr>
					<td width="15"><img src="../img/board/brbox_lb.gif" width="15" height="15" /></td>
					<td background="../img/board/brbox_bbg.gif"></td>
					<td width="15"><img src="../img/board/brbox_rb.gif" width="15" height="15" /></td>
				</tr>
				
				</form>
			</table>
				
				</td></tr>
				<tr><td></td></tr>
				<tr>
					<td align="center"><img src="/img/newx/sub/sp1.png" width="600px" /></td>
				</tr>
				<tr>
					<td align="center"><a href="https://939.co.kr/" target="_blank"><img src="/img/newx/sub/sp_bt.png" /></a></td>
				</tr>
				<tr>
					<td align="cneter"><br><br></td>
				</tr>
				<tr>
					<td align="center"><img src="/img/newx/sub/sp_sub.png" /></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td >&nbsp;</td>
	</tr>
	<tr>
		<td >&nbsp;</td>
	</tr>
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->