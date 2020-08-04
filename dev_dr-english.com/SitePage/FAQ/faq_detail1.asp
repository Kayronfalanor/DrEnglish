
<%
If Ftype = "F01" Then
%>
<div class="accordion">
	
	<%
						'###################################### Array Info ######################################
						'0.nvcCPName,		1.nvcBoardTitle,	2.nvcManagerName,	3.nvcManagerID, 4.nvcMemberID 
						'5.nvcMemberName,	6.nvcMemberEName,	7.nvcTeacherID,		8.ReadCnt,		9.createDate
						'10.Rid,			11.iBoardSeq,		12.iWriterSeq,		13.iComment,	14.TOTCNT
						'15.TOTPAGE,		16.siWriterPRole,	17.iReWriterSeq,	18.nvcEtcCode,	19.ntxBoardContent
						
						If IsArray(arrFtype) Then
							For i = 0 To Ubound(arrFtype, 2)

						%>
						
						<%
							If IsArray(arrData) Then
								iNum = 1
								For j = 0 To Ubound(arrData, 2)
									If Trim(arrFtype(0, i)) = "F01" Then
									'If Ftype = Trim(arrData(18, j)) Then
						%>	
							<h3><%=arrData(1, j)%></h3>
							<p>
							<%
								if Trim(arrData(20,j)) <> "" Then

									sfile1_ext = ""
									sfile1_ext = LCASE(MID(Trim(arrData(20,j)),instrrev(Trim(arrData(20,j)),".")+1))
                                    
									'Call setAttachFileTagView(sfile1_ext, Trim(arrData(20,j)),Trim(arrData(23,j)))
									Call setAttachFileTagView(sfile1_ext, Trim(arrData(20,j)),SiteCPCode)

								%>
								<br>
								<% End If %>
								
								<%=arrData(19, j)%>
							</p>

							
						<%
										iNum = iNum + 1
									end if
								Next
							End If
						%>
						
						<%	
							
							Next
						End If
						%>


</div>
<% End If %>