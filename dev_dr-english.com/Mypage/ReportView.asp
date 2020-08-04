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
Dim sMenu : sMenu = "2"

Dim imr_seq : imr_seq = sqlCheck(Replace(Request("imr_seq"), "'", "''"))
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
chkRequestVal imr_seq,		"월간 성적 정보가 없습니다.!"

Dim Sql, objRs, arrData, arrData2
'##### 월간 평가 상세 #####
Sql = "Exec PRC_tb_MonthlyReport_User_Select_View '"& imr_seq &"', '"& sUserSeq &"'"
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If
objRs.Close	

'##### 월간 평가 최근 5개 #####
Sql = "Exec PRC_tb_MonthlyReport_User_Select_Top_List '"& sUserSeq &"' "
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrData2 = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing	:	Call DBClose()

Dim arrPoint(6)
If IsArray(arrData) Then
'0.nvcMonthlyReportSDate,	1.nvcMonthlyReportEDate,	2.nvcTeacherName,			3.nvcMemberEName,		4.nvcMemberName,		5.iPresent
'6.iAbsend,					7.iPostpone,				8.iCancel,					9.siComprehensionPoint,	10.siSpeakingPoint
'11.siPronunciationPoint,	12.siGrammarPoint,			13.siVocabularyPoint,		14.siListeningPoint,	15.siReadingPoint
'16.nvcPronunciationComment,17.nvcGrammarComment,		18.nvcRecommendationsComment,19.nvcTBooksName,		20.siScheDay

	strDuration		= arrData(0, 0) & " ~ " & arrData(1, 0)
	strTeacherName	= arrData(2, 0)
	strUserEName	= arrData(3, 0)
	strUserName		= arrData(4, 0)
	iPresend		= arrData(5, 0)
	iAbsened		= arrData(6, 0)
	iPostpone		= arrData(7, 0)
	iCancel			= arrData(8, 0)
	iScheStudyDay	= arrData(20, 0)

	On Error Resume Next 
	TotalPer_=(iScheStudyDay / iPresend) * 100
 
	siCPoint		= arrData(9, 0)
	siSPoint		= arrData(10, 0)
	siPPoint		= arrData(11, 0)
	siGPoint		= arrData(12, 0)
	siVPoint		= arrData(13, 0)
	siLPoint		= arrData(14, 0)
	siRPoint		= arrData(15, 0)

	arrPoint(0)		= siCPoint
	arrPoint(1)		= siSPoint
	arrPoint(2)		= siPPoint
	arrPoint(3)		= siGPoint
	arrPoint(4)		= siVPoint
	arrPoint(5)		= siLPoint
	arrPoint(6)		= siRPoint

	TotalPoint_ = 0
	For i = 0 To Ubound(arrPoint)
		TotalPoint_	= TotalPoint_ + arrPoint(i)
	Next
	Total_ = (TotalPoint_) / (Ubound(arrPoint)+1)

	IF Total_>=0 and Total_<=20 THEN
		LeveLIN="Level 1"
	ELSEIF Total_>=21 and Total_<=40 THEN
		LeveLIN="Level 2"
	ELSEIF Total_>=41 and Total_<=60 THEN
		LeveLIN="Level 3"
	ELSEIF Total_>=61 and Total_<=80 THEN
		LeveLIN="Level 4"
	ELSEIF Total_>=81 and Total_<=90 THEN
		LeveLIN="Level 5"
	ELSEIF Total_>=91 and Total_<=100 THEN
		LeveLIN="Level 6"
	END IF			

	Comment_Pronunciation	= arrData(16, 0)
	Comment_Pronunciation	= replace (Comment_Pronunciation,Chr(13),"<br>") '줄바꿈
	Comment_Grammar			= arrData(17, 0)
	Comment_Grammar			= replace (Comment_Grammar,Chr(13),"<br>") '줄바꿈
	Comment_Recommendations	= arrData(18, 0)
	Comment_Recommendations = replace (Comment_Recommendations,Chr(13),"<br>") '줄바꿈

	strTBooksName	= arrData(19, 0)
Else
	chkRequestVal "",		"요청하신 월간 성적표 정보가 없습니다.!"
End If
%>
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/Commonfiles/Scripts/mypage.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$mypage.report.init.call(this);
});
</script>
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="670" border="0" cellspacing="0" cellpadding="0">
	<tr> 
		<td height="262" align="center"> 
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr><td>&nbsp;</td></tr>
				<tr><td><img src="../img/popup/pop_level_t03.gif" alt="progress report" /></td></tr>
				<tr><td>&nbsp;</td></tr>
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
											<td height="1" colspan="4" align="left" background="../img/dot.gif"></td>
										</tr>
										<tr> 
											<th width="128" align="left">Class Term<br>(학습기간)</th>
											<td colspan="3" ><%=strDuration%></td>
										</tr>
										<tr> 
											<td height="1" colspan="4" align="left" background="../img/dot.gif"></td>
										</tr>
										<tr> 
											<th width="128" align="left">Teacher<br>(선생님)</th>
											<td width="114"><%=strTeacherName%></td>
											<th width="133">Student<br>(학생)</th>
											<td width="124"><%=strUserEName%> / <%=strUserName%></td>
										</tr>
										<tr> 
											<td height="1" colspan="4" align="left" background="../img/dot.gif"></td>
										</tr>
										<tr> 
											<th width="128" align="left"><p>Percentage of <br />Attendace <br>(출석률)</p></th>
											<td><%=formatnumber(TotalPer_,0)%>%</td>
											<th>Result <br>(평가결과)</th>
											<td><%'=LeveLIN%><%=formatnumber(Total_,0)%> 점</td>
										</tr>
										<tr> 
											<th width="128" align="left"><p>출석/결석일</p></th>
											<td><%=iPresend%>/<%=iAbsened+iCancel%></td>
											<th>Course<br>(학습레벨)</th>
											<td ><%=strTBooksName%></td>
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
						<table width="650" border="0" cellspacing="0" cellpadding="1">
							<tr> 
								<td width="35"><img src="../img/popup/bullet05.gif" /></td>
								<td width="63" align="left"><img src="../img/popup/report_grtitle1.gif" alt="result" /></td>
								<td width="456">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr> 
					<td> 
					<!-- result -->
						<table width="650" border="0" cellpadding="0" cellspacing="0">
							<tr> 
								<td><img src="../img/popup/pop_paper1_1.gif"/></td>
							</tr>
							<tr> 
								<td align="center" background="../img/popup/pop_paper1_bg.gif"> 
									<table width="95%" border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF" class="point_w">
										<tr> 
											<td width="45" height="20" align="center" bgcolor="#999999">100</td>										
											<%
												With Response
												For i = 0 To Ubound(arrPoint)
													.Write "<td width='85' rowspan='10' align='center' valign='bottom' bgcolor='#FFF0E6'>"
													.Write "	<table width='100%' border='0' cellspacing='0' cellpadding='0'>"
													For j = 1 To arrPoint(i) / 10
														.Write "<tr>"
														.Write "	<td align='center'><img src=/img/popup/bar0"& i+1 &".gif width=45 height=20 /></td>"
														.Write "</tr>"
													Next
													.Write "	</table>"
													.Write "</td>"
												Next
												End With
											%>
										</tr>
										<tr> 
											<td width="45"  height="20" align="center" bgcolor="#999999">90</td>
										</tr>
										<tr> 
											<td width="45" height="19" align="center" bgcolor="#999999">80</td>
										</tr>
										<tr> 
											<td width="45" height="20" align="center" bgcolor="#999999">70</td>
										</tr>
										<tr> 
											<td width="45" height="20" align="center" bgcolor="#999999">60</td>
										</tr>
										<tr> 
											<td width="45" height="20" align="center" bgcolor="#999999">50</td>
										</tr>
										<tr> 
											<td width="45" height="20" align="center" bgcolor="#999999">40</td>
										</tr>
										<tr> 
											<td width="45" height="20" align="center" bgcolor="#999999">30</td>
										</tr>
										<tr> 
											<td width="45" height="20" align="center" bgcolor="#999999">20</td>
										</tr>
										<tr> 
											<td width="45" height="20" align="center" bgcolor="#999999">10</td>
										</tr>
										<tr> 
											<td width="45" height="30" align="center" bgcolor="#999999">&nbsp;</td>
											<td width="85" height="30" align="center" bgcolor="#FF6600">comprehension<br>이해</td>
											<td width="85" height="30" align="center" bgcolor="#FFB400">speaking<br>말하기</td>
											<td width="85" height="30" align="center" bgcolor="#9DBF13">pronunciation<br>발음<br></td>
											<td width="85" height="30" align="center" bgcolor="#0DC8CA">grammar<br>문법</td>
											<td width="85" height="30" align="center" bgcolor="#129ACC"><p>vocabulary<br>단어</p></td>
											<td width="85" height="30" align="center" bgcolor="#954DE7">listening<br>듣기</td>
											<td width="85" height="30" align="center" bgcolor="#F24788"><p>reading<br>읽기</p></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr> 
								<td><img src="../img/popup/pop_paper1_3.gif" /></td>
							</tr>
						</table>
					<!-- result end -->
					</td>
				</tr>
				<tr> 
					<td>&nbsp;</td>
				</tr>
				<tr> 
					<td>
						<table width="650" border="0" cellspacing="0" cellpadding="1">
							<tr> 
								<td width="35"><img src="../img/popup/bullet05.gif" /></td>
								<td width="63" align="left"><img src="../img/popup/report_grtitle2.gif" alt="교육향상도" /></td>
								<td width="456">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr> 
					<td> 
					<!-- 교육향상도 -->
						<table width="580" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td><img src="../img/popup/pop_paper1_1.gif"/></td>
							</tr>
							<tr> 
								<td align="center" background="../img/popup/pop_paper1_bg.gif"> 
									<table border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF" class="point_w">
										<tr> 
											<td width="110" height="20" align="center" bgcolor="#999999">100</td>
<!-- // 여기서 평가서 5개 정렬 -->
<%
With Response
If IsArray(arrData2) Then
'nvcMonthlyReportSDate, nvcMonthlyReportEDate
'siComprehensionPoint,	siSpeakingPoint,		siPronunciationPoint
'siGrammarPoint,		siVocabularyPoint,		siListeningPoint,		siReadingPoint	

	Dim arrPoint2(6)

	For i = 0 To Ubound(arrData2, 2)
		
		strSDate = arrData2(0, i)	:	strEDate = arrData2(1, i)

		arrPoint2(0) = arrData2(2, i)
		arrPoint2(1) = arrData2(3, i)
		arrPoint2(2) = arrData2(4, i)
		arrPoint2(3) = arrData2(5, i)
		arrPoint2(4) = arrData2(6, i)
		arrPoint2(5) = arrData2(7, i)
		arrPoint2(6) = arrData2(8, i)
		
		LoopTotal_ = 0
		For j = 0 To Ubound(arrPoint2)
			LoopTotal_ = LoopTotal_ + arrPoint2(j) / 10
		Next
		LoopTotal_ = FormatNumber((LoopTotal_) / 7, 0)

		IF i=0 THEN
			Color1="#FFF0E6"	:	Color2="#FF6600"
		ELSEIF i=1 THEN
			Color1="#FFF9E8"	:	Color2="#FFB400"						
		ELSEIF i=2 THEN
			Color1="#F5FBE3"	:	Color2="#9DBF13"						
		ELSEIF i=3 THEN
			Color1="#EBFAFC"	:	Color2="#0DC8CA"						
		ELSEIF i=4 THEN
			Color1="#EBF5FC"	:	Color2="#129ACC"						
		END If
%>
<td width="100" rowspan="11" align="center" valign="bottom" bgcolor="<%=Color1%>">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<%For j = 1 To LoopTotal_%>
					<tr> 
						<td align="center"><img src="../img/popup/bar0<%=i+1%>.gif" width="45" height="20" /></td>
					</tr>																
				<%Next%>
				</table>
			</td>
		</tr>
		<tr> 
			<td height="30" align="center" bgcolor="<%=Color2%>"><%=strSDate%>~<BR><%=strEDate%></td>
		</tr>
	</table>
</td>
<%
	Next 
End If
End With
%>											
<!-- 여기서 평가서 5개 정렬 // -->
										</tr>
										<tr> 
											<td height="20" align="center" bgcolor="#999999">90</td>
										</tr>
										<tr> 
											<td height="20" align="center" bgcolor="#999999">80</td>
										</tr>
										<tr> 
											<td height="20" align="center" bgcolor="#999999">70</td>
										</tr>
										<tr> 
											<td height="20" align="center" bgcolor="#999999">60</td>
										</tr>
										<tr> 
											<td height="20" align="center" bgcolor="#999999">50</td>
										</tr>
										<tr> 
											<td height="20" align="center" bgcolor="#999999">40</td>
										</tr>
										<tr> 
											<td height="20" align="center" bgcolor="#999999">30</td>
										</tr>
										<tr> 
											<td height="20" align="center" bgcolor="#999999">20</td>
										</tr>
										<tr> 
											<td height="20" align="center" bgcolor="#999999">10</td>
										</tr>
										<tr> 
											<td height="30" align="center" bgcolor="#999999">&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr> 
								<td><img src="../img/popup/pop_paper1_3.gif" /></td>
							</tr>
						</table>
					<!-- 교육향상도 end -->
					</td>
				</tr>
				<tr> 
					<td>&nbsp;</td>
				</tr>
				<tr> 
					<td>
						<table width="650" border="0" cellspacing="0" cellpadding="1">
							<tr> 
								<td width="35"><img src="../img/popup/bullet05.gif" /></td>
								<td width="63" align="left"><img src="../img/popup/report_grtitle3.gif" alt="scoring Guideline" /></td>
								<td width="456">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr> 
					<td> 
					<!-- scoring guideline box -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td width="15"><img src="../img/board/gbox_lt.gif" width="15" height="15" /></td>
								<td background="../img/board/gbox_tbg.gif"></td>
								<td width="15"><img src="../img/board/gbox_rt.gif" width="15" height="15" /></td>
							</tr>
							<tr> 
								<td background="../img/board/gbox_lbg.gif">&nbsp;</td>
								<td align="left" bgcolor="#FFFFFF"> 
									<table width="100%" border="0" cellspacing="1" cellpadding="6" class="t_style02">
										<tr> 
											<td height="1" colspan="6" align="left" background="../img/dot.gif"></td>
										</tr>
										<tr align="center"> 
											<th> &nbsp;&nbsp;&nbsp;&nbsp;0~20</th>
											<th>&nbsp;&nbsp;&nbsp;21~40</th>
											<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;41~60</th>
											<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;61~80</th>
											<th>&nbsp;&nbsp;&nbsp;&nbsp;81~90</th>
											<th>&nbsp;&nbsp;&nbsp;&nbsp;91~100</th>
										</tr>
										<tr align="center"> 
											<td height="1" colspan="6" background="../img/dot.gif"></td>
										</tr>
										<tr align="center"> 
											<td <%IF LeveLIN="Level 1" THEN%>class="point03"<%END IF%>><p>Level 1<br />(Low Beginner)</p></td>
											<td <%IF LeveLIN="Level 2" THEN%>class="point03"<%END IF%>>Level 2<br />(High Beginner)</td>
											<td <%IF LeveLIN="Level 3" THEN%>class="point03"<%END IF%>>Level 3<br />(Low Intermediate)</td>
											<td <%IF LeveLIN="Level 4" THEN%>class="point03"<%END IF%>>Level 4<br />(High Intermediate)</td>
											<td <%IF LeveLIN="Level 5" THEN%>class="point03"<%END IF%>>Level 5<br />(Low Advanced)</td>
											<td <%IF LeveLIN="Level 6" THEN%>class="point03"<%END IF%>>Level 6<br />(High Advanced)</td>
										</tr>
										<tr> 
											<td height="1" colspan="6" align="left" background="../img/dot.gif"></td>
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
					<!-- scoring guideline box end -->
					</td>
				</tr>
				<tr> 
					<td>&nbsp;</td>
				</tr>
				<tr> 
					<td><img src="../img/popup/pop_teacher_t02.gif" /></td>
				</tr>
				<tr>	
					<td>&nbsp;</td>
				</tr>
				<tr> 
					<td> 
					<!-- teacher's comment box-->
						<table width="650" border="0" cellspacing="0" cellpadding="0">
							<tr> 
								<td><img src="../img/popup/pop_paper1_1.gif"/></td>
							</tr>
							<tr> 
								<td align="center" background="../img/popup/pop_paper1_bg.gif"> 
									<table width="95%" border="0" cellspacing="0" cellpadding="2">
										<tr> 
											<td width="9" valign="top">&nbsp;</td>
											<td align="left"><strong><img src="../img/popup/bullet04.gif" alt="체크아이콘" align="absmiddle" /> Pronunciation (발음)</strong><br />
											<%=Comment_Pronunciation%><br /> <br /> 
											<strong><img src="../img/popup/bullet04.gif" alt="체크아이콘" align="absmiddle" /> Grammar (문법)</strong><br /><%=Comment_Grammar%><br /><br /> 
											<strong><img src="../img/popup/bullet04.gif" alt="체크아이콘" align="absmiddle" /> 
											Recommendations (조언)</strong><br />
											<%=Comment_Recommendations%></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr> 
								<td><img src="../img/popup/pop_paper1_3.gif" /></td>
							</tr>
						</table>
					<!-- teacher's comment end -->
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
								<td width="71"><a href="javascript:window.close()"><img src="../img/board/btn_close02.gif" alt="닫기" border="0" /></a></td>
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
</div>
<!--#include virtual="/include/inc_footer.asp"-->