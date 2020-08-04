<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = True
'// menu setting
Dim mMenu : mMenu = "6"
Dim sMenu : sMenu = "6"
%>
<!--#include file="Inc.asp" -->
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
Dim Sql, arrData

Sql = "PRC_tb_Board_User_Select_List N'"& bcode &"' "
Sql = Sql & ", N'"& SiteCPCode &"' "
Sql = Sql & ", '"& sUserSeq &"' "
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
//$(document).ready(function() { $site.qna.init.call(this); });



function fn_List()
{	
	
	document.formdboard.action = "List.asp";
	document.formdboard.submit();
}

function fn_Write()
{	
	
	document.formdboard.action = "Write.asp";
	document.formdboard.submit();
}

function fn_View(ac)
{	
	document.formdboard.seq.value=ac;
	document.formdboard.action = "View.asp";
	document.formdboard.submit();
}

</script>
	
	<style>
	  
/**묻고답하기**/
		.qna_list_wrap{margin: 20px 0;height:40px;}
        .qna_list{float: right;}
		.qna_wirte{display: block; padding:8px 10px; background-color: #ff402f;color:#fff;font-size: 14px; cursor: pointer;}
        .qna_list li{border:0px solid red; display: inline-block;}
		.qna_list li:nth-child(2){position: relative; top:-3px;}
		.qna_list li:nth-child(3){padding:5px 10px; background-color: #3d3d3d;color:#fff; cursor: pointer; position: relative; top:-3px;}
		
		table.type08 {
			font-size: 14px;
    border-collapse: collapse;
    text-align: center;
    line-height: 1.5;
}

table.type08 thead th {
    padding: 10px;
    font-weight: bold;
	text-align: center;
    border-bottom: 2px solid #ffa800;
    background: #eee;
}
table.type08 td {
    width: 350px;
    padding: 10px;
    vertical-align: middle;
    border-bottom: 1px solid #ccc;
}
		

.pagination_wrap{text-align: center;margin-top: 40px;}
.pagination {
  display: inline-block;
}

		
.pagination a {
  color: black;
  float: left;
  padding: 8px 16px;
  text-decoration: none;
}

.pagination a.active {
  background-color: #ffa800;
  color: white;
}

.pagination a:hover:not(.active) {background-color: #ddd;}
	</style>
	
<div class="contents_right">
	<div><img src="/img/subimg/title_4.png" alt="화상영어가이드 "/></div>
	
	         <form method="post" Action="List.asp" name="formdboard">
			<input type="hidden" name="currPage" id="currPage" value="<%=currPage%>"/>
			<input type="hidden" name="sortField" id="sortField" value="<%=sortField%>"/>
            <input type="hidden" name="sortMethod" id="sortMethod" value="<%=sortMethod%>"/>
            <input type="hidden" name="seq" id="seq" value="<%=seq%>"/>
            <input type="hidden" name="bcode" id="bcode" value="<%=bcode%>"/>
			<input type="hidden" name="btype" id="btype" value="<%=btype%>"/>
		
	<div class="qna_list_wrap">
		<%If Session("UserId") <> "" And bcode = "B05" Then%>
	      <a href="javascript:fn_Write();"><p style="float: left;padding:8px 10px;background-color:#ff402f;color:#fff;fontsize:14px;cursor:pointer;"  >글등록</p></a>
		<%End If%>
	 <ul class="qna_list">
		 <li>
			 <select name="strColumn" id="strColumn" class="selectstyle">
			 	<option value='TITLE' <%if strColumn="TITLE"then%>selected<%end if%>>글제목</option>
			 	<option value='CONTE' <%if strColumn="CONTE"then%>selected<%end if%>>글내용</option>
			 	<%If InStr("B01,B03", bcode) > 0 Then%>
			 		<option value='WRITE' <%if strColumn="WRITE"then%>selected<%end if%>>글쓴이</option>
			 	<%End If%>
			 </select>
		 </li>
		 <li><input class="selectstyle" name="searchStr" type="text" id="searchStr" size="16" value="<%=searchStr%>"></li>
		<a href="javascript:fn_List();"><span style="padding:5px 10px; background-color: #3d3d3d;color:#fff; cursor: pointer; position: relative; top:-3px;">검색</span></a>
	 </ul>
	</div>
	    </form>
	
	  <div>
		<table class="type08">
           <thead>
           <tr>
               <th scope="cols">번호</th>
               <th scope="cols">제목</th>
               <th scope="cols">작성자</th>
               <th scope="cols">처리여부</th>
               <th scope="cols">등록일</th>
               <th scope="cols">조회</th>
           </tr>
           </thead>
           <tbody>
          
		   	<!-- 공지글을 먼저 보여준다. 끝 -->
			<%
			'###################################### Array Info ######################################
			'0.iBoardSeq,		1.nvcBoardTitle,	2.iComment,			3.iCorrect,			4.nvcMemberName,	5.dtCreateDate
			'6.iBoardRead,		7.iReWriterSeq,		8.RID,				9.TOTCNT,			10.TOTPAGE'

			
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
               <td><%=k%></td>
               <td><a href="javascript:fn_View('<%=arrData(0, i)%>');"><%=tmpTitle%></a><span class="point02"><%=strNew%></span></td>
               <td><a href="javascript:fn_View('<%=arrData(0, i)%>');"><%=arrData(4, i)%></a></td>
               <td><%If arrData(7, i) > 0 Then%>답변완료<%Else%>미답변<%End If%></td>
               <td><%=Left(tmpDate,10)%></td>
               <td><%=arrData(6, i)%></td>
           </tr>
			<%
					k = k - 1
				Next
			Else
			%>
			
				<tr>
				<td colspan='6' style="width:740px;" >등록된 데이타 내역이 없습니다.</td>
				</tr>
				<%
			End If
			
			%>	

           </tbody>
       </table>
	 </div>
       <!--#include virtual="/include/Paging.asp"-->
		
  </div>
				
				
	

<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->