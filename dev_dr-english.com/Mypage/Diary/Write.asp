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
Dim sMenu : sMenu = "3"
%>
<!--#include file="Inc.asp"-->
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
chkRequestVal SiteCPCode,	"로그인 정보 오류\n관리자에게 문의해 주세요.!"
chkRequestVal bcode,		"게시판 정보가 없습니다.\n다시 이용해 주세요.!"

strReWriter = "0"
If Len(seq) > 0 And IsNumeric(seq) Then
	Sql = "PRC_tb_Board_User_View '"& seq &"'"

	Set objRs = dbSelect(Sql)
	If Not objRs.Eof Then
		arrData = objRs.GetRows()
	End If
	objRs.Close	:	Set objRs = Nothing

	If IsArray(arrData) Then
		strTitle	= arrData(1, 0)
		strReWriter	= arrData(11, 0)
		strContents = arrData(4, 0)
	Else
		chkMessageBack "요청하신 데이터가 삭제되었거나 존재하지 않습니다.!"
	End If
End If

%>
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/Commonfiles/Scripts/mypage.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$mypage.diary.init.call(this);
	
	var TchSeq = $("#rewriter").val();
	if(TchSeq != '' && TchSeq != null){
		goChange();
	}else{
		$("#cntTch").text('전송할 수 있는 강사가 없습니다.');
	}
});

function goChange(){
	var TchSeq = $("#rewriter").val();
	if(TchSeq != '' && TchSeq != null){
		$.ajax({
				url: '/Ajax/diaryTchCnt.asp?TchSeq='+TchSeq+"&bcode=<%=bcode%>&nvcCPCode=B0000",
				type: 'GET',
				async: false,
				success: function(data) {
					if(data != '' && data != null){
						$("#cntTch").text(data+'회');
					}else{
						$("#cntTch").text('전송할 수 있는 강사가 없습니다.');
					}					
				},
				error: function(x) {
					alert(x.responseText);
				}
			});

	}
}

</script>
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
<form method="post" action="WriteOK.asp" name="formdboard">
<input type="hidden" name="currPage" id="currPage" value="<%=currPage%>"/>
<input type="hidden" name="sortField" id="sortField" value="<%=sortField%>"/>
<input type="hidden" name="sortMethod" id="sortMethod" value="<%=sortMethod%>"/>
<input type="hidden" name="seq" id="seq" value="<%=seq%>"/>
<input type="hidden" name="bcode" id="bcode" value="<%=bcode%>"/>
	<tr>
		<td>&nbsp;</td>
    </tr>
	<tr>
		<td class="contents_title"><img src="/img/sub/title_1_03.gif" alt="영어일기" /></td>
    </tr>
    <tr>
		<td>&nbsp;</td>
    </tr>
    <tr>
		<td><img src="/img/sub/sub01_img07.gif" /></td>
    </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="30" align="right" >
		<!-- search box -->          
		<!-- search box end -->      
		</td>
	</tr>
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
								<td><input name="Name" type="text" class="input cssinput" readonly id="name" size="20" value="<%=sUserName%>" maxlength="5" caption="작성자"></td>
							</tr>
							<tr> 
								<td height="1" colspan="2" align="left" background="/img/dot.gif"></td>
							</tr>
							<tr> 
								<th width="100" align="left" bgcolor="#F8F3ED">제목</th>
								<td><input name="Subject" type="text" class="input cssinput" id="Subject" size="80" caption="제목" value="<%=strTitle%>" /></td>
							</tr>
							<tr> 
								<td height="1" colspan="2" align="left" background="/img/dot.gif"></td>
							</tr>	
							<tr> 
								<th width="100" align="left" bgcolor="#F8F3ED">전송강사</th>
								<td>
									<select size="1" name="rewriter" id="rewriter" class="cssinput" caption="전송강사" onchange="javascript:goChange();">
										<%=getMyScheduleTeacher(strReWriter)%>
									</select>
									&nbsp;&nbsp;전송 가능 횟수 : <span id="cntTch">pppd</span>
								</td>
				            </tr>
						    <tr> 
								<td height="1" colspan="2" align="left" background="/img/dot.gif"></td>
		                    </tr>	
							<tr> 
								<th width="100" align="left" bgcolor="#F8F3ED">내용</th>
								<td><textarea name="Content1" cols="60" rows="15" class="textarea cssinput" caption="내용"><%=strContents%></textarea></td>
							</tr>
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
		<!-- btn_page -->   
		<!-- btn_page end -->      
			<table width="660" border="0" cellspacing="0" cellpadding="0">
				<tr> 
					<td width="533" align="right">&nbsp;</td>
					<td width="64" align="right">&nbsp;</td>         
					<td width="63" align="right"><img src="/img/board/btn_<%If Len(Seq) > 0 Then%>modif<%Else%>record<%End If%>.gif" style="border-width:0;cursor:pointer" class="cssBtns" caption="WRITEOK"></td>
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