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
Dim sMenu : sMenu = "5"

'// Parameters
Dim execMode	: execMode	= sqlCheck(Replace(Request("execmode"), "'", "''"))
Dim req_seq		: req_seq	= sqlCheck(Replace(Request("req_seq"), "'", "''"))
Dim sche_seq	: sche_seq	= sqlCheck(Replace(Request("sche_seq"), "'", "''"))

returnParam		= "?execmode="& execMode &"&req_seq="& req_seq & "&sche_seq="& sche_seq
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
chkRequestVal execMode,	"잘못된 접근입니다.\n정상적인 방법으로 이용해 주세요."
If Trim(execMode) = "INS" Then chkRequestVal sche_seq,	"수업 정보가 없습니다.\n정상적인 방법으로 이용해 주세요." End If
If Trim(execMode) = "MOD" Then chkRequestVal req_seq,	"요청 정보가 없습니다.\n정상적인 방법으로 이용해 주세요." End If

Dim Sql, objRs, arrSche, arrData, arrHDay
Dim arrWeek(7)
Dim strHDate, strBDate, strReason, strPhone, strFlag

'##### 수강 정보 #####
Sql = "PRC_tb_Schedule_User_Select_View N'"& SiteCPCode &"', '"& sche_seq &"', '"& sUserSeq &"'"
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrSche = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing

If IsArray(arrSche) Then
	strPSSeq	= arrSche(0, 0)
	strPName	= arrSche(1, 0)
	strBName	= arrSche(2, 0)
	strTName	= arrSche(3, 0)
	strSSDate	= arrSche(4, 0)
	strSEDate	= arrSche(5, 0)
	strMon		= arrSche(6, 0)
	strTue		= arrSche(7, 0)
	strWed		= arrSche(8, 0)
	strThu		= arrSche(9, 0)
	strFri		= arrSche(10, 0)
	strSat		= arrSche(11, 0)
	strSun		= arrSche(12, 0)
	siFlag		= arrSche(13, 0)
	strScheTime	= arrSche(14, 0)
	strPlayTime = arrSche(15, 0)
	strScheType = arrSche(16, 0)
	strCSeq		= arrSche(17, 0)
	strTSeq		= arrSche(18, 0)
	strMaxSeq	= arrSche(19, 0)
	iSchePostPone= CInt(arrSche(20, 0)) '클래스 수강 연기 제한 횟수
	iUserPostPone= CInt(arrSche(21, 0))	'휴강 신청해 연기 보강한 횟수
	arrPhone	= Split(arrSche(22, 0), "-")

	If IsArray(arrPhone) Then
		Phone1 = arrPhone(0)
		Phone2 = arrPhone(1)
		Phone3 = arrPhone(2)
	End If

	If strMon = "Y" Then arrWeek(0) = "월" End If
	If strTue = "Y" Then arrWeek(1) = "화" End If
	If strWed = "Y" Then arrWeek(2) = "수" End If
	If strThu = "Y" Then arrWeek(3) = "목" End If
	If strFri = "Y" Then arrWeek(4) = "금" End If
	If strSat = "Y" Then arrWeek(5) = "토" End If
	If strSun = "Y"	Then arrWeek(6) = "일" End If

	'휴강 신청 횟수 제한	
	If Trim(execMode) = "INS" Then
		If iUserPostPone >= iSchePostPone Then
			Call DBClose()
			chkRequestVal "",	"휴강신청은 월 "& iSchePostPone - iUserPostPone &"회만 가능합니다."
		End If
	End If

	'##### 센터별 휴무일 가져오기
	Sql = "PRC_tb_Holiday_Select_List N'"& SiteCPCode &"', N'"& strSSDate &"', N'"& strSEDate &"', '4'"
	Set objRs = dbSelect(Sql)
	If Not objRs.Eof Then
		arrHDay = objRs.GetRows()
	End	If
	objRs.Close	:	Set objRs = Nothing

	Dim tmpHoliDay : tmpHoliDay = ""
	If IsArray(arrHDay) Then
		For i = 0 To Ubound(arrHDay, 2)
			tmpHoliDay = tmpHoliDay & arrHDay(0, i)

			If i < Ubound(arrHDay, 2) Then
				tmpHoliDay = tmpHoliDay & ","
			End If
		Next
	End If

	'##### // 휴강 신청 정보 수정 #####
	If Trim(execMode) = "MOD" Then
		Dim bProcess : bProcess = False

		Sql = "PRC_tb_RequestPostPone_User_Select_View '"& req_seq &"', '"& sUserSeq &"'"
		Set objRs = dbSelect(Sql)
		If Not objRs.Eof Then
			arrData = objRs.GetRows()
		End If
		objRs.Close	:	Set objRs = Nothing

		If IsArray(arrData) Then
		'0.nvcHDate, 1.nvcBDate, 2.nvcReason, 3.nvcPhone, 4.cFlag
			strHDate = arrData(0, 0)
			strBDate = arrData(1, 0)
			strReason= arrData(2, 0)
			strPhone = arrData(3, 0)

			arrPhone = Split(strPhone, "-")

			If arrData(4, 0) = "Y" Then
				bProcess = True
				strFlag	 = "처리완료"
				strColor = "red"
			Else
				strFlag	 = "접수대기"
				strColor = "blue"
			End If		
		Else
			Call DBClose()
			chkRequestVal "",	"요청하신 정보가 존재하지 않습니다."
		End If
	End If
	'##### 휴강 신청 정보 수정 // #####
Else
	Call DBClose()
	chkRequestVal "",	"수강 정보가 존재하지 않습니다."
End If

Call DBClose()
%>
<!--#include virtual="/include/inc_top.asp"-->
<link href="/Commonfiles/Scripts/datepicker/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/Commonfiles/Scripts/datepicker/jquery-ui.min.js"></script>
<script type="text/javascript" src="/Commonfiles/Scripts/datepicker/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/Commonfiles/Scripts/mypage.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$mypage.PostPone.init.call(this);
});
</script>
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
<input type="hidden" id="holiday" name="holiday" value='<%=tmpHoliDay%>' />
<form method="post"	action="WriteOK.asp" name="formdboard">
<input type="hidden" id="ExecMode" name="ExecMode" value="<%=ExecMode%>" />
<input type="hidden" id="req_seq" name="req_seq" value="<%=req_seq%>" />
<input type="hidden" id="sche_seq" name="sche_seq" value="<%=sche_seq%>" />
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td class="contents_title"><img src="/img/sub/title_1_05.gif" alt="휴강신청" /></td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td><img src="/img/sub/sub01_img09.gif" /></td>
	</tr>
	<tr><td >&nbsp;</td></tr>
	<tr><td height="30" align="right"></td></tr>
	<tr>
		<td align="center" valign="top" >
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="15"><img src="/img/board/gbox_lt.gif" width="15" height="15" /></td>
					<td background="/img/board/gbox_tbg.gif"></td>
					<td width="15"><img src="/img/board/gbox_rt.gif" width="15" height="15" /></td>
				</tr>
				<tr>
					<td background="/img/board/gbox_lbg.gif">&nbsp;</td>
					<td align="left" bgcolor="#FFFFFF">
					<!-- input boxs end -->
						<table width="100%" border="0" cellspacing="1" cellpadding="5" class="t_style02">
							<tr>
								<td height="1" colspan="2" align="left" background="/img/dot.gif"></td>
							</tr>
							<tr>
								<th width="100" align="left" bgcolor="#F8F3ED">작성자</th>
								<td><%=sUserID%></td>
							</tr>
							<tr>
								<td height="1" colspan="2" align="left" background="/img/dot.gif"></td>
							</tr>
							<tr>
								<th width="100" align="left" bgcolor="#F8F3ED">연락처</th>
								<td>
									<select id="Phone1" name="Phone1" class="cssinput" caption="연락처를 선택해 주세요.">
										<%Call setPhoneHtml("C", Phone1)%>
									</select>-
									<input type="text" id="Phone2" name="Phone2" value="<%=Phone2%>" size="5" maxlength="4"  class="cssinput" caption="연락처를 입력해 주세요." />-
									<input type="text" id="Phone3" name="Phone3" value="<%=Phone3%>" size="5" maxlength="4"  class="cssinput" caption="연락처를 입력해 주세요." />
								</td>
							</tr>
							<tr>
								<td height="1" colspan="2" align="left" background="/img/dot.gif"></td>
							</tr>
							<tr>
								<th width="100" align="left" bgcolor="#F8F3ED">휴강요청수업</th>
								<td>
									<div id="SchInfoArea">
										<%=strSSDate%> ~ <%=strSEDate%> (<%For i = 0 To Ubound(arrWeek)%><%=arrWeek(i)%><%Next%>) <br />
										<%=strTName%> (<%=strScheTime%> / <%=strPlayTime%>) <br />
										<%
											If ExecMode = "INS" Then
										%>
											<strong>이번달 남은 휴강신청 횟수 : <%=iSchePostPone - iUserPostPone%>회</strong>
										<%
										End If
										%>										
									</div>
								</td>
							</tr>
							<tr>
								<td height="1" colspan="2" align="left" background="/img/dot.gif"></td>
							</tr>
							<tr>
								<th width="100" align="left" bgcolor="#F8F3ED">휴강신청일</th>
								<td><input type="text" id="Hdate" name="Hdate" class="cssinput cssdate" value="<%=strHDate%>" data-date="<%=CDate(strSEDate)%>" readonly caption="휴강일을 선택해 주세요." /></td>
							</tr>
							<tr>
								<td height="1" colspan="2" align="left" background="/img/dot.gif"></td>
							</tr>
							<tr>
								<th width="100" align="left" bgcolor="#F8F3ED">보강신청일</th>
								<td><input type="text" id="Bdate" name="Bdate" value="<%=strBDate%>" class="cssinput cssdate" data-date="<%=CDate(strSEDate)%>" readonly caption="보강일을 선택해 주세요." /></td>
							</tr>
							<tr>
								<td height="1" colspan="2" align="left" background="/img/dot.gif"></td>
							</tr>
							<tr>
								<th width="100" align="left" bgcolor="#F8F3ED">사유</th>
								<td><textarea name="Reason" cols="60" rows="15" class="textarea cssinput" caption="사유를 입력해 주세요." id="Reason"><%=strReason%></textarea></td>
							</tr>
							<tr>
								<td height="1" colspan="2" align="left" background="/img/dot.gif"></td>
							</tr>
						<%
							If ExecMode = "MOD" Then
						%>
							<tr>
								<th width="100" align="left" bgcolor="#F8F3ED">처리여부</th>
								<td><font color="<%=strColor%>"><strong><%=strFlag%></strong></font></td>
							</tr>
						<%
							End If
						%>						
						</table>
					<!-- input boxs end -->
					</td>
					<td background="/img/board/gbox_rbg.gif">&nbsp;</td>
				</tr>
				<tr>
					<td width="15"><img src="/img//board/gbox_lb.gif" width="15" height="15" /></td>
					<td background="/img/board/gbox_bbg.gif"></td>
					<td width="15"><img src="/img/board/gbox_rb.gif" width="15" height="15" /></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td >&nbsp;</td>
	</tr>
	<tr>
		<td height="30" align="center" >
			<table width="660" border="0" cellspacing="0" cellpadding="0">
				<tr>	
					<td width="63" align="right">&nbsp;</td>
					<td width="64" align="right">&nbsp;</td>
					<td width="533" align="right">
						<img src="/img/board/btn_list.gif" style="border-width:0;cursor:pointer;" class="cssPBtns" caption="LIST" />
						<%If Not bProcess Then%>
							<img src="/img/board/btn_<%If ExecMode = "MOD" Then%>modif<%Else%>record<%End If%>.gif" style="border-width:0;cursor:pointer;" class="cssPBtns" caption="REGIST">
							<img src="/img/board/btn_del.gif" style="border-width:0;cursor:pointer;" class="cssPBtns" caption="DELETE">
						<%End If%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td >&nbsp;</td>
	</tr>
</form>
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->