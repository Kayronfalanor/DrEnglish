<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = True
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
Dim sche_seq : sche_seq = sqlCheck(Replace(Request.Form("sche_seq"), "'", "''"))
If Len(Trim(sche_seq)) = 0 Then
	chkMessageClose "잘못된 접근입니다."
End If

Dim Sql, objRs, arrData
Sql = "PRC_tb_Certificate_User_Select_View '"& sche_seq &"', '"& sUserSeq &"'"
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing

If IsArray(arrData) Then
	strBName	= arrData(0, 0)
	strPrice	= arrData(1, 0)
	strSSDate	= arrData(2, 0)
	strSEDate	= arrData(3, 0)
	strTName	= arrData(4, 0)

	'##### 학생 출결석 현황 #####
	Dim iTotalLec	: iTotalLec		= 0
	Dim iTotalAttend: iTotalAttend	= 0
	Dim iPerAttend	: iPerAttend	= 0
	Dim iStudy		: iStudy		= 0
	Dim iPresent	: iPresent		= 0
	Dim iAbsend		: iAbsend		= 0
	Dim iPostpone	: iPostpone		= 0
	Dim iCancel		: iCancel		= 0
	Sql = "PRC_tb_DailyReport_User_Progress '"& sche_seq &"', '"& sUserSeq &"'"
	Set objRs = dbSelect(Sql)
	If Not objRs.Eof Then
		iTotalLec	= objRs(0)
		iStudy		= objRs(1)
		iPresent	= objRs(2)
		iAbsend		= objRs(3)
		iPostpone	= objRs(4)
		iCancel		= objRs(5)

		iPerAttend = FormatNumber((iPresend / (iTotalLec - iCancel)) * 100, 0) 
	End If
	objRs.Close	:	Set objRs = Nothing
Else
	Call DBClose()
	chkMessageClose "완료한 수강 내역이 없습니다."
End If
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp"--> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="../css/popup.css" rel="stylesheet" type="text/css" />
<title><%=TitleName%></title>
<script type="text/javascript" src="/Commonfiles/Scripts/jquery.min.js"></script>
<script type="text/javascript" src="/Commonfiles/Scripts/common.js"></script>
<script type="text/javascript" src="/Commonfiles/Scripts/mypage.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$mypage.study.init.call(this);
});
</script>
</head>
<body>
<!-- ##### // Contents ##### -->
<table width="427" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="left"><img src="../img/popup/receipt_title.gif" alt="서대문구 화상영어" /></td>
	</tr>
	<tr>
		<td align="center">
			<table width="427" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="520" align="center" valign="top" background="../img/popup/receipt_bg.gif">
						<table width="332" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="36">&nbsp;</td>
							</tr>
							<tr>
								<td align="center"><img src="../img/popup/receipt_txt02.gif" alt="수강확인증" width="314" height="49" /></td>
							</tr>
							<tr>
								<td height="5"></td>
							</tr>
							<tr align="center">
								<td>
									<table width="314" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15"><img src="../img/board/gbox_lt.gif" width="15" height="15" /></td>
											<td background="../img/board/gbox_tbg.gif"></td>
											<td width="15"><img src="../img/board/gbox_rt.gif" width="15" height="15" /></td>
										</tr>
										<tr>
											<td background="../img/board/gbox_lbg.gif">&nbsp;</td>
											<td align="center">
												<table width="100%" border="0" cellpadding="0" cellspacing="0">
													<tr>
														<td width="71" height="23"><img src="../img/popup/bull.gif" width="9" height="19" align="absmiddle" /><span class="point">수강자명</span></td>
														<td width="10" align="center"><img src="../img/popup/var_01.gif" width="2" height="11" /></td>
														<td width="203" align="left"><%=sUserName%> ( <%=sUserEName%> 
														) / <%=sUserPhone%></td>
													</tr>
													<tr>
														<td height="1" colspan="3" background="../img/popup/line_dot.gif"></td>
													</tr>
													<tr>
														<td width="71" height="23"><img src="../img/popup/bull.gif" width="9" height="19"	align="absmiddle" /><span class="point">수강내역</span></td>
														<td width="10" align="center"><img src="../img/popup/var_01.gif" width="2" height="11" /></td>
														<td align="left">화상영어 <span class="point"> <%=strBName%> 과정</span></td>
													</tr>
													<tr>
														<td height="1" colspan="3" background="../img/popup/line_dot.gif"></td>
													</tr>
													<tr>
														<td width="71" height="23"><img src="../img/popup/bull.gif" width="9" height="19" align="absmiddle" /><span class="point">결제금액</span></td>
														<td width="10" align="center"><img src="../img/popup/var_01.gif" width="2" height="11" /></td>
														<td align="left"><%=formatnumber(strPrice,0)%> 원</td>
													</tr>
													<tr>
														<td height="1" colspan="3" background="../img/popup/line_dot.gif"></td>
													</tr>
													<tr>
														<td width="71" height="23"><img src="../img/popup/bull.gif" width="9" height="19" align="absmiddle" /><span class="point">수강기간</span></td>
														<td width="10" align="center"><img src="../img/popup/var_01.gif" width="2" height="11" /></td>
														<td align="left"><%=replace(strSSDate,"-",".")%> ~ <%=replace(strSEDate,"-",".")%></td>
													</tr>
													<tr>
														<td height="1" colspan="3" background="../img/popup/line_dot.gif"></td>
													</tr>
													<tr>
														<td width="71" height="23"><img src="../img/popup/bull.gif" width="9" height="19" align="absmiddle" /><span class="point">담당강사</span></td>
														<td width="10" align="center"><img src="../img/popup/var_01.gif" width="2" height="11" /></td>
														<td align="left"><%=strTName%></td>
													</tr>
													<tr>
														<td height="4" colspan="3" valign="top"></td>
													</tr>
													<tr>
														<td width="71" height="23" valign="top"><img src="../img/popup/bull.gif" width="9" height="19" align="absmiddle" /><span class="point">출석현황</span></td>
														<td width="10" align="center" valign="top"><img src="../img/popup/var_01.gif" width="2" height="11" /></td>
														<td align="left">총<%=iStudy - iPostpone - iCancel%>회 수업중 출석<%=formatnumber(iPresent,0)%>회 
														/ 결석<%=formatnumber(iAbsend,0)%> / 지각<%=formatnumber(d,0)%> / 조퇴<%=formatnumber(e,0)%> 
														/ 연기<%=formatnumber(iPostpone,0)%><br />
														출석률 : <%=FormatNumber(iPerAttend, 0)%>
														% </td>
													</tr>
												</table>
											</td>
											<td background="../img/board/gbox_rbg.gif">&nbsp;</td>
										</tr>
										<tr>
											<td width="15"><img src="../img/board/gbox_lb.gif" width="15" height="15" /></td>
											<td background="../img/board/gbox_bbg.gif"></td>
											<td width="15"><img src="../img/board/gbox_rb.gif" width="15" height="15" /></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="6"></td>
							</tr>
							<tr>
								<td align="center">
									<table width="314" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td align="left">본 수강확인증은 <span class="point"><%=sUserName%>(<%=sUserEName%>)회원님</span>께서<br />
											<%=subTitleName%>에서 제공하는 화상영어 프로그램<br>수강을 증명하여 이에 증빙서류로 제출이 가능합니다.</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td align="center" valign="top" background="/img/popup/signin.gif">
									<table width="130" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="15"></td>
										</tr>
										<tr>
											<td align="center"><%=left(date(),4)%>년 <%=left(right(date(),5),2)%>월 <%=right(date(),2)%>일</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="30" align="center"><img src="../img/popup/receipt_title03.gif" /></td>
							</tr>
							<tr>
								<td height="22" align="center" background="../img/popup/receipt_bg3.gif">본 영수증은 증빙서류로 회사에 제출이 가능합니다. </td>
							</tr>
							<tr>
								<td height="40" align="center" valign="bottom"><a href="javascript:print()"><img src="../img/board/btn_pring.gif" alt="프린트" border="0" /></a>&nbsp;<a href="javascript:window.close()"><img src="../img/board/btn_close02.gif" alt="닫기" border="0" /></a></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>    
		</tr>
</table>
<!-- ##### Contents // ##### -->
</body>
</html>