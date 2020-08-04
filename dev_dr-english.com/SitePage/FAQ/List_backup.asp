<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = False
'// menu setting
Dim mMenu : mMenu = "1"
Dim sMenu : sMenu = "8"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<!--#include file="Inc.asp" -->

<%
Dim Ftype : Ftype = sqlCheck(Replace(Request("ftype"), "'", "''"))
If Len(Ftype) = 0 Then
	Ftype = "F01"
End If

PageSize = 100

'##### FAQ TOP 100 불러와 카테고리별로 출력
Dim Sql, arrData
Sql = "PRC_tb_Board_Select_List N'"& bcode &"', N'"& SiteCPCode &"', N'"& strColumn &"', N'"& searchStr &"', '1', '"& PageSize &"', N'S'"
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing
Call DBClose()

'##### FAQ 카테고리 가져오기
Dim arrFtype : arrFtype = getCommCode("FAQ", "B10", True)



Sub setAttachFileTagView(ext, file,nvcCPCode)
	Dim html : html = ""
	'If Len(Trim(strCPCode)) > 0 Then
		bburl1 = BBSURL(CInt(Right(bcode, 2)))
	'Else 
	'	bburl1 = BBSURL(14) 
	'End If 
	html = "<div align='center'>"
	Select Case(ext)
		Case "gif", "jpg", "jpeg", "png", "bmp" :
			html = html & "<img src='"& lms_file_url& "Board/" & nvcCPCode &"/"& bcode & "/" & file &"' border='0' width='100%'>"

		Case "swf" :
			html = html & "<object classid=""clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"" codebase=""http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0"" width=""200"" id=""MMPlayer0"">"
			html = html & "<param name=""movie"" value="""& lms_file_url& "Board/" & nvcCPCode &"/"& bcode & "/" & file &""">"
			html = html & "<embed src="""& lms_file_url& "Board/" & nvcCPCode &"/"& bcode & "/"  & file &""" width=""200"" quality=""high"" pluginspage=""http://www.macromedia.com/go/getflashplayer"" type=""application/x-shockwave-flash""></embed>"
			html = html & "</object>"

		Case "asf", "wmv", "mpeg", "avi", "mp3", "wav" : 
			html = html & "<OBJECT ID=""MMPlayer1""  classid=""CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95"" CODEBASE=""http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701"" standby=""Loading Microsoft Windows Media Player components..."" type=""application/x-oleobject"">"
			html = html & "<PARAM NAME=""FileName""				VALUE="""& lms_file_url& "Board/" & nvcCPCode &"/"& bcode & "/"  & file &""">"
			html = html & "<PARAM NAME=""ShowControls""			VALUE=""1"">"
			html = html & "<PARAM NAME=""ShowStatusBar""		VALUE=""1"">"
			html = html & "<PARAM NAME=""AutoRewind""			VALUE=""0"">"
			html = html & "<PARAM NAME=""ShowDisplay""			VALUE=""0"">"
			html = html & "<PARAM NAME=""DefaultFrame""			VALUE=""Slide"">"
			html = html & "<PARAM NAME=""Autostart""			VALUE=""1"">"
			html = html & "<PARAM NAME=""SendMouseClickEvents""	VALUE=""1"">"
			html = html & "<PARAM NAME=""EnableContextMenu""	value=""false"">"
			html = html & "<PARAM NAME=""TransparentAtStart""	value=""-1"">"
			html = html & "<PARAM NAME=""AnimationAtStart""		value=""0"">"
			'아래는 네스케이프 사용자를 위해 <embed>태그 추가-->
			html = html & "<Embed type=""application/x-mplayer2"" pluginspage=""http://www.microsoft.com/Windows/MediaPlayer/download/default.asp"" src="""& lms_file_url& "Board/" & nvcCPCode &"/"& bcode & "/"  & file &""" Name=MMPlayer1 Autostart=""1"" ShowControls=""0"" ShowDisplay=""0"" ShowStatusBar=""0"" DefaultFrame=""Slide""  AutoRewind=""0"" SendMouseClickEvents=""1"" EnableContextMenu=""false"" TransparentAtStart=""-1"" AnimationAtStart=""0"">"
			html = html & "</OBJECT>"
		Case Else
			html = html & "<br><a href='" & lms_file_url& "Board/" & nvcCPCode &"/"& bcode & "/"  & file & "' target='_blank'><font color=blue><u>" &  file  & "</u></font></a><br><br>"
	End Select
	html = html & "</div>"

	Response.Write html
End Sub

%>
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/Commonfiles/Scripts/sitepage.js"></script>
<script type="text/javascript">
	$(document).ready(function() { $site.faq.init.call(this); });
</script>
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>

	<tr>
		<td class="contents_title"><img src="/img/sub/title_6_05.gif" alt="자주묻는질문" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td ><img src="/img/sub/sub06_img07.gif" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td align="center" valign="top" >
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<div class="titletab">
							<ul id="titletab_btn">
							<%
							'	If IsArray(arrFType) Then
									For i = 0 To Ubound(arrFType, 2)
										If arrFType(0, i) <> "F03" Then 	
							%>
								<li><img src='/img/sub/s06_2tab<%=Right(arrFType(0, i), 2)%><%If i = 0 Then%>on<%End If%>.gif' alt='<%=arrFType(1, i)%>' border='0' class='cssftype' data-ftype='<%=arrFType(0, i)%>' style='cursor:pointer;' /></li>
							<%
										End If 
									Next
							'	End If
							%>								
							</ul>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<%
						'###################################### Array Info ######################################
						'0.nvcCPName,		1.nvcBoardTitle,	2.nvcManagerName,	3.nvcManagerID, 4.nvcMemberID 
						'5.nvcMemberName,	6.nvcMemberEName,	7.nvcTeacherID,		8.ReadCnt,		9.createDate
						'10.Rid,			11.iBoardSeq,		12.iWriterSeq,		13.iComment,	14.TOTCNT
						'15.TOTPAGE,		16.siWriterPRole,	17.iReWriterSeq,	18.nvcEtcCode,	19.ntxBoardContent
						Dim iNum
						If IsArray(arrFtype) Then
							For i = 0 To Ubound(arrFtype, 2)

						%>
						<table id="tbl<%=arrFtype(0, i)%>" class="blist2 cssftbl" border="0" style="width:590px;border:0;display:<%If i = 0 Then%>block<%Else%>none<%End If%>;" summary="<%=arrFtype(1, i)%>">
						<colgroup><col width="50" /><col width="600" /></colgroup>
						<tbody id="tbdList">
						<%
							If IsArray(arrData) Then
								iNum = 1
								For j = 0 To Ubound(arrData, 2)
									If Trim(arrFtype(0, i)) = Trim(arrData(18, j)) Then
									'If Ftype = Trim(arrData(18, j)) Then
						%>
							<tr>
								<td><img src="/img/sub/icon_q.gif"/></td>
								<td class="title_txt"><a class="off css<%=arrFtype(0, i)%>" data-seq="<%=arrData(11, j)%>" style="cursor:pointer;"><%=iNum%>. <%=arrData(1, j)%></a></td>
							</tr>
							<tr id="tr<%=arrData(11, j)%>" class="cssftr" style="display:none;">	
								<td colspan="3" class="eanswer"><div class="eacont"> 
								<%
								if Trim(arrData(20,j)) <> "" Then

									sfile1_ext = ""
									sfile1_ext = LCASE(MID(Trim(arrData(20,j)),instrrev(Trim(arrData(20,j)),".")+1))
                                    
									'Call setAttachFileTagView(sfile1_ext, Trim(arrData(20,j)),Trim(arrData(23,j)))
									Call setAttachFileTagView(sfile1_ext, Trim(arrData(20,j)),SiteCPCode)

								%>
								<br>
								<% End If %>
								
								<%=arrData(19, j)%></div></td>
							</tr>
						<%
										iNum = iNum + 1
									end if
								Next
							End If
						%>
						</tbody>
						</table>
						<%	
							
							Next
						End If
						%>							
						<!-- list end -->
					</td>
				</tr>
				<tr>
					<td height="60" align="center">&nbsp;</td>
				</tr>	
			</table>
		</td>
	</tr>
	<tr>
		<td height="30" align="center" ></td>
	</tr>
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->