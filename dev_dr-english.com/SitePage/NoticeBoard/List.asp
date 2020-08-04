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
Dim sMenu : sMenu = "9"
%>
<!--#include file="Inc.asp" -->
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
Dim Sql, arrData

Sql = "PRC_tb_NoticeBoard_Select_List N'"& bcode &"' "
Sql = Sql & ", N'"& SiteCPCode &"' "
'Sql = Sql & ", '"& sUserSeq &"' "
Sql = Sql & ", '' "
Sql = Sql & ", N'"& strColumn &"' "
Sql = Sql & ", N'"& searchStr &"' "
Sql = Sql & ", '"& currPage &"' "
Sql = Sql & ", '"& rowSize &"' "

Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing
Call DBClose()

Dim TotalCount	: TotalCount	= 0
Dim TotalPage	: TotalPage		= 1
If IsArray(arrData) Then
	TotalCount = arrData(9, 0)	:	TotalPage = arrData(10, 0)
End If
%>
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/Commonfiles/Scripts/sitepage.js"></script>
<script type="text/javascript">
$(document).ready(function() { $site.qna.init.call(this); });
</script>
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="contents_title"><img src="/img/sub/title_6_066.gif" alt="묻고답하기" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td ><img src="/img/sub/sub06_img04.gif" /></td>
	</tr>
	<tr>
		<td >&nbsp;</td>
	</tr>
	<tr>
		<td height="30" align="right" >
		<!-- search box -->
			<table border="0" width="100%" cellspacing="0" cellpadding="0">
			<form method="post" Action="List.asp" name="formdboard">
			<input type="hidden" name="currPage" id="currPage" value="<%=currPage%>"/>
			<input type="hidden" name="sortField" id="sortField" value="<%=sortField%>"/>
            <input type="hidden" name="sortMethod" id="sortMethod" value="<%=sortMethod%>"/>
            <input type="hidden" name="seq" id="seq" value="<%=seq%>"/>
            <input type="hidden" name="bcode" id="bcode" value="<%=bcode%>"/>
			<input type="hidden" name="btype" id="btype" value="<%=btype%>"/>
				<tr>
					<td width="2%" align="left">&nbsp;</td>
					<td width="*" align="left">
						<%If Session("UserId") <> "" And bcode = "B12" Then%>
							<img src="/img/board/btn_record.gif" width="71" height="24" style="cursor:pointer;" id="btnWrite" />
						<%End If%>
					</td>
					<td width="10%">
						<select name="strColumn" id="strColumn">
							<option value='TITLE' <%if strColumn="TITLE"then%>selected<%end if%>>글제목</option>
							<option value='CONTE' <%if strColumn="CONTE"then%>selected<%end if%>>글내용</option>
							<%If InStr("B01,B03", bcode) > 0 Then%>
								<option value='WRITE' <%if strColumn="WRITE"then%>selected<%end if%>>글쓴이</option>
							<%End If%>
						</select>
					</td>
					<td width="108" align="center">
						<input name="searchStr" type="text" id="searchStr" size="16" value="<%=searchStr%>">
					</td>
					<td width="63" align="left">
						<input name="imageField2" type="image" style="border-width:0" src="/img/board/btn_search02.gif">
					</td>
					<td width="16">&nbsp;</td>
				</tr>
			</form>
			</table>
		<!-- search box end -->
		</td>
	</tr>
	<tr>
		<td align="center" valign="top" >
			<table width="650" border="0" cellspacing="0" cellpadding="0">			
				<tr>
					<td valign="top">
					<!-- board_list -->
						<table width="650" border="0" cellspacing="0" cellpadding="0" class="notice_style">
							<tr>
								<td width="11"><img src="../../img/board/b_bar1.gif" width="11" height="31" /></td>
								<td width="56" align="center" background="../../img/board/b_bar2.gif"><img src="../../img/board/b_title_no.gif" alt="번호" /></td>
								<td width="*" align="center" background="../../img/board/b_bar2.gif"><img src="../../img/board/b_title_title.gif" alt="제목" /></td>
								<td width="113" align="center" background="../../img/board/b_bar2.gif"><img src="../../img/board/b_title_name.gif" alt="작성자" /></td>
								<td width="115" align="center" background="../../img/board/b_bar2.gif"><img src="../../img/board/b_title_date.gif" alt="등록일" /></td>
								<td width="64" align="center" background="../../img/board/b_bar2.gif"><img src="../../img/board/b_title_hit.gif" alt="조회" /></td>
								<td width="11"><img src="../../img/board/b_bar3.gif" width="11" height="31" /></td>
							</tr>
						<!-- 공지글을 먼저 보여준다. 시작 -->
						
						<!-- 공지글을 먼저 보여준다. 끝 -->
<%
'###################################### Array Info ######################################
'0.iBoardSeq,		1.nvcBoardTitle,	2.iComment,			3.iCorrect,			4.nvcMemberName,	5.dtCreateDate
'6.iBoardRead,		7.iReWriterSeq,		8.RID,				9.TOTCNT,			10.TOTPAGE

With Response
Dim tmpTitle, tmpDate, strNew
If IsArray(arrData) Then
	Dim k : k = TotalCount - (rowSize * (currPage-1 ) )
	For i = 0 To Ubound(arrData, 2)
		tmpTitle = arrData(1, i)
		If Len(tmpTitle) > 28 Then
			tmpTitle = Left(tmpTitle, 28) & ".."
		End If
		
		tmpDate = arrData(5, i)	:	strNew = ""
		If DateDiff("h", tmpDate, Now()) < 24 Then
			strNew = "<img src=/img/board/new.gif align='absmiddle'>"
		End If
%>
<tr> 
	<td></td>
	<td width="67" align="center" ><%=k%></td>
	<td width="280" align="left" class="t_cetner"><a style="cursor:pointer;" class="csshref" data-seq="<%=arrData(0, i)%>"><%=tmpTitle%></a><span class="point02"><%=strNew%></span></td>
	<td width="113" align="center" ><%=arrData(4, i)%></td>
	<td width="115" align="center"><%=Left(tmpDate,10)%></td>
	<td width="74" align="center"><%=arrData(6, i)%></td>
	<td></td>
</tr>
<%
		k = k - 1
	Next
Else
	.Write "<tr><td colspan='10' style='text-align:center;height:100px;'>등록된 데이타 내역이없습니다.</td></tr>" & vbCrlf
End If
End With
%>							
						</table>
					<!-- board_list end-->
					</td>
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
			<table height="16" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr align="center">
					<td>
						<!--#include virtual="/include/Paging.asp"-->
					</td>
				</tr>
			</table>
		<!-- btn_page end -->
		</td>
	</tr>
	<tr>
		<td >&nbsp;</td>
	</tr>
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->