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
Dim objRs, arrData
'// 리스트
Sql = "PRC_tb_Board_User_Select_List N'"& bcode &"' "
Sql = Sql & ", N'"& SiteCPCode &"' "
Sql = Sql & ", '"& sUserSeq &"' "
Sql = Sql & ", N'"& strColumn &"' "
Sql = Sql & ", N'"& searchStr &"' "
Sql = Sql & ", '"& currPage &"' "
Sql = Sql & ", '"& rowSize &"' "
'Response.write Sql

Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing

Dim TotalCount	: TotalCount	= 0
Dim TotalPage	: TotalPage		= 1
If IsArray(arrData) Then
	TotalCount = arrData(9, 0)	:	TotalPage = arrData(10, 0)
End If

Dim writeCnt,totCnt
Sql = "select dbo.FUN_ClassCount_Get('" & sUserSeq & "','','" & bcode & "','B0000') as writeCnt ,count(iDailyReportSeq) as totCnt from tb_DailyReport WHERE iMemberSeq='" & sUserSeq & "' AND siAttendance in ('0','1','2') AND siScheType='1' "
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	writeCnt = objRs(0)
	totCnt = objRs(1)
End If
objRs.Close	:	Set objRs = Nothing

%>
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/Commonfiles/Scripts/mypage.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$mypage.diary.init.call(this);
});
</script>
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
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
		<td height="30" align="right">
        <!-- search box -->
			<table border="0" width="100%" cellspacing="0" cellpadding="0">
			<form method="post" Action="List.asp" name="Bform">
			<input type="hidden" name="currPage" id="currPage" value="<%=currPage%>"/>
			<input type="hidden" name="sortField" id="sortField" value="<%=sortField%>"/>
            <input type="hidden" name="sortMethod" id="sortMethod" value="<%=sortMethod%>"/>
            <input type="hidden" name="seq" id="seq" value="<%=seq%>"/>
            <input type="hidden" name="bcode" id="bcode" value="<%=bcode%>"/>
			<input type="hidden" name="btype" id="btype" value="<%=btype%>"/>
				<tr>
					<td width="2%" align="left">&nbsp;</td>
					<td width="*" align="left"><% If CInt(writeCnt) > 0 Then %><img src="/img/board/btn_write.gif" width="71" height="24" style="cursor:pointer" class="cssBtns" caption="WRITE" /><% End If %>작성 : <%=CInt(totCnt)-CInt(writeCnt)%>회 / 작성가능 : <%=CInt(writeCnt)%>회</td>

					<td width="10%">
						<select name="strColumn" id="strColumn">
							<option value='TITLE' <%if strColumn="TITLE"then%>selected<%end if%>>글제목</option>
							<option value='CONTE' <%if strColumn="CONTE"then%>selected<%end if%>>글내용</option>
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
		<td align="center" valign="top">
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
					<!-- board_title -->
						<table width="650" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="11"><img src="../../img/board/b_bar1.gif" width="11" height="31" /></td>
		                        <td width="56" align="center" background="../../img/board/b_bar2.gif"><img src="../../img/board/b_title_no.gif" alt="번호" /></td>
					            <td width="280" align="center" background="../../img/board/b_bar2.gif">
						            <img src="../../img/board/b_title_title.gif" alt="제목" />
							    </td>
								<td width="113" align="center" background="../../img/board/b_bar2.gif">
									<img src="/img/board/b_title_edit.gif" alt="첨삭여부" width="50" height="15" />
	                            </td>
		                        <td width="115" align="center" background="../../img/board/b_bar2.gif">
			                        <img src="../../img/board/b_title_name.gif" alt="작성자" />
				                </td>
					            <td width="64" align="center" background="../../img/board/b_bar2.gif">
						            <img src="../../img/board/b_title_date.gif" alt="등록일" />
							    </td>
								<td width="11">
									<img src="../../img/board/b_bar3.gif" width="11" height="31" />
	                            </td>
		                    </tr>
			            </table>
                    <!-- board_title end -->
				    </td>
	            </tr>
		        <tr>
			        <td valign="top">
                    <!-- board_list -->
				        <table width="650" border="0" cellspacing="0" cellpadding="0" class="notice_style">
<%
With Response
If IsArray(arrData) Then
'###################################### Array Info ######################################
'0.iBoardSeq,		1.nvcBoardTitle,	2.iComment,			3.iCorrect,			4.nvcMemberName,	5.dtCreateDate
'6.iBoardRead,		7.iReWriterSeq,		8.RID,				9.TOTCNT,			10.TOTPAGE

	Dim k : k = TotalCount - (rowSize * (currPage-1 ) )

	Dim tmpTitle, tmpDate, strNew, strCorrect

	For i = 0 To Ubound(arrData, 2)

		tmpTitle = arrData(1, i)
		If Len(tmpTitle) > 30 Then
			tmpTitle = Left(tmpTitle, 30) & ".."
		End If
		
		tmpDate = arrData(5, i)	:	strNew = ""
		If DateDiff("h", tmpDate, Now()) < 24 Then
			strNew = "<img src=/img/board/new.gif>"
		End If

		If arrData(3, i) = "Y" Then
			strCorrect = "[첨삭완료]"
		Else
			strCorrect = "[첨삭대기]"
		End If

		.Write "<tr>"
		.Write "<td style='width:67px;text-align:center;'>"& k &"</td>"
		.Write "<td><a style='cursor:pointer;' class='t_center csshref' data-seq='"& arrData(0, i) &"'>"& tmpTitle &"</a> (<font color='red'>"& arrData(2, i) &"</font>) "& strNew &"</td>"
		.Write "<td style='width:113px;text-align:center;'>"& strCorrect &"</td>"
		.Write "<td style='width:115px;text-align:center;'>"& arrData(4, i) &"</td>"
		.Write "<td style='width:74px;text-align:center;'>"& Left(tmpDate, 10) &"</td>"
		.Write "</tr>"

		k = k - 1
	Next
Else
	.Write "<tr><td colspan='5' style='text-align:center;height:150px;'>등록된 데이타 내역이없습니다.</td></tr>"
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
		<td>&nbsp;</td>
	</tr>
	<tr>
	    <td height="30" align="center">
        <!-- btn_page -->
		    <table height="16" border="0" align="center" cellpadding="0" cellspacing="0">
			    <tr align="center">
				    <td><!--#include virtual="/include/Paging.asp"--></td>
	            </tr>
		    </table>
		<!-- btn_page end -->
	    </td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->