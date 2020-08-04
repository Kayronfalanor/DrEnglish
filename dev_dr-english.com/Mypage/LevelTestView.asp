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
Dim Sql, arrData, arrLevel, objRs

Sql = "PRC_tb_LevelTest_User_View N'"& SiteCPCode &"', '"& sUserSeq &"'"
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrdata = objRs.GetRows()
End If
objRs.Close

Dim CWidth	: CWidth= 360
Dim BgLv	: BgLv	= "_lv9"

If IsArray(arrData) Then
	strUName	= arrdata(0, 0)
	strTName	= arrdata(1, 0)	
	strWDate	= arrdata(2, 0)
	strRDate	= arrdata(3, 0)
	strSubject  = arrData(4, 0)
	strLevel	= arrdata(5, 0)
	strLPoint	= arrdata(6, 0)
	strCPoint	= arrdata(7, 0)
	strVPoint	= arrdata(8, 0)
	strGPoint	= arrdata(9, 0)
	strPPoint	= arrdata(10, 0)
	strPTxt		= arrdata(11, 0)
	strGTxt		= arrdata(12, 0)
	strRTxt		= arrdata(13, 0)
	iCLCourseSeq= arrData(14, 0)

	Sql = "PRC_tb_Level_SearchValueArea '"& iCLCourseSeq &"' "
	Set objRs = dbSelect(Sql)
	If Not objRs.Eof Then
		arrLevel = objRs.GetRows()
	End If
	objRs.Close

	If IsArray(arrLevel) Then
		BgLv   = "_lv" & (Ubound(arrLevel, 2) + 1)
		CWidth = CWidth / (Ubound(arrLevel, 2) + 1)

		strLPoint = strLPoint * CWidth
		strCPoint = strCPoint * CWidth
		strVPoint = strVPoint * CWidth
		strGPoint = strGPoint * CWidth
		strPPoint = strPPoint * CWidth
	End If
End If
Set objRs = Nothing	:	Call DBClose()
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp"--> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script src="/Commonfiles/Scripts/jquery.min.js" type="text/javascript"></script>
<link href="/css/popup.css" rel="stylesheet" type="text/css" />
<title><%=TitleName%></title>
<body style="overflow-x:hidden;">
<!-- ##### // Contents ##### -->
<table width="670" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="262" align="center">
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td><img src="../img/popup/pop_level_t01.gif" alt="level test report" /></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="15"><img src="../img//board/brbox_lt.gif" width="15" height="15" /></td>
								<td background="../img/board/brbox_tbg.gif"></td>
								<td width="15"><img src="../img//board/brbox_rt.gif" width="15" height="15" /></td>
							</tr>
							<tr>
								<td background="../img/board/brbox_lbg.gif">&nbsp;</td>
								<td align="left">
									<table width="100%" border="0" cellspacing="1" cellpadding="6" class="t_style02">
										<tr>
											<th width="117" align="left">Student's Name</th>
											<td width="125" class="point03"><%=strUName%></td>
											<th width="133">Teacher's Name</th>
											<td width="124"><%=strTName%></td>
										</tr>
										<tr>
											<td height="1" colspan="4" align="left" background="../img/dot.gif"></td>
										</tr>
										<tr>
											<th width="117" align="left">Request Date</th>
											<td><%=strRDate%></td>
											<th>Free Class Date</th>
											<td><%=strWDate%></td>
										</tr>
										<tr>
											<td height="1" colspan="4" align="left" background="../img/dot.gif"></td>
										</tr>
										<tr>
											<th width="117" align="left">Student's Level</th>
											<td colspan="3"><%=strSubject%> - <%=strLevel%></td>
										</tr>
										<tr>
											<td height="1" colspan="4" align="left" background="../img/dot.gif"></td>
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
						</table>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>
					<!-- 테스트결과 -->
						<table width="580" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><img src="../img/popup/pop_paper1_1.gif"/></td>
							</tr>
							<tr>
								<td align="center" background="../img/popup/pop_paper1_bg.gif">
									<table width="564" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="564" align="left">
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="191"><img src="../img/popup/pop_level01.gif" alt="이해력/듣기" /></td>
														<td width="360" align="left" background="../img/popup/graph_bg01<%=BgLv%>.gif">
														<img src="../img/popup/pop_level01_1.gif" width="<%=strLPoint%>" height="5" /></td>
														<td width="4"><img src="../img/popup/graph_r01.gif" width="4" height="33" /></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td align="center">&nbsp;</td>
										</tr>
										<tr>
											<td align="left">
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="191"><img src="../img/popup/pop_level02.gif" alt="의사소통" /></td>
														<td width="360" align="left" background="../img/popup/graph_bg02<%=BgLv%>.gif"><img src="../img/popup/pop_level01_2.gif" width="<%=strCPoint%>" height="5" /></td>
														<td width="4"><img src="../img/popup/graph_r02.gif" width="4" height="33" /></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td align="center">&nbsp;</td>
										</tr>
										<tr>
											<td align="left">
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="191"><img src="../img/popup/pop_level03.gif" alt="어휘표현" /></td>
														<td width="360" align="left" background="../img/popup/graph_bg03<%=BgLv%>.gif"><img src="../img/popup/pop_level01_3.gif" width="<%=strVPoint%>" height="5" /></td>
														<td width="4"><img src="../img/popup/graph_r03.gif" width="4" height="33" /></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td align="center">&nbsp;</td>
										</tr>
										<tr>
											<td align="left">
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="191"><img src="../img/popup/pop_level04.gif" alt="문법" /></td>
														<td width="360" align="left" background="../img/popup/graph_bg04<%=BgLv%>.gif"><img src="../img/popup/pop_level01_4.gif" width="<%=strGPoint%>" height="5" /></td>
														<td width="4"><img src="../img/popup/graph_r04.gif" width="4" height="33" /></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td align="center">&nbsp;</td>
										</tr>
										<tr>
											<td align="left">
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="191"><img src="../img/popup/pop_level05.gif" alt="발음" /></td>
														<td width="360" align="left" background="../img/popup/graph_bg05<%=BgLv%>.gif"><img src="../img/popup/pop_level01_5.gif" width="<%=strPPoint%>" height="5" /></td>
														<td width="4"><img src="../img/popup/graph_r05.gif" width="4" height="33" /></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td><img src="../img/popup/pop_paper1_3.gif" /></td>
							</tr>
						</table>
					<!-- 테스트결과 end -->
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td><img src="../img/popup/pop_teacher_t02.gif" alt="teacher's comment" /></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>
					<!-- teacher's comment box -->
						<table width="580" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><img src="../img/popup/pop_paper1_1.gif"/></td>
							</tr>
							<tr>
								<td align="center" background="../img/popup/pop_paper1_bg.gif">
									<table width="95%" border="0" cellspacing="0" cellpadding="2">
										<tr>
											<td width="9" valign="top">&nbsp;</td>
											<td align="left" valign="top"><strong><img src="../img/popup/bullet04.gif" width="22" height="18" align="absmiddle" /> Pronunciation</strong><br />
											<%=strPTxt%> <br /><br /><br />
											<strong><img src="../img/popup/bullet04.gif" width="22" height="18" align="absmiddle" /> Grammar</strong><br /><%=strGTxt%> <br /> <br />
											<strong><img src="../img/popup/bullet04.gif" width="22" height="18" align="absmiddle" /> Recommendations</strong><br /><%=strRTxt%> </td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td><img src="../img/popup/pop_paper1_3.gif" /></td>
							</tr>
						</table>
					<!-- teacher's comment box end -->
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td height="35" align="center">
					<!-- btn -->
						<table width="160" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="76"><a href="javascript:print()"><img src="../img/board/btn_pring.gif" alt="프린트" border="0" /></a></td>
								<td>&nbsp;</td>
								<td width="71"><a href="javascript:window.close()"><img src="../img/board/btn_close02.gif" alt="닫기" border="0"	/></a></td>
							</tr>
						</table>
					<!-- btn end -->
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ##### Contents // ##### -->
</body>
</html>
