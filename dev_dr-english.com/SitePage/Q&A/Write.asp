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
Dim arrQtype : arrQtype = getCommCode("QNA", bcode, True)
%>
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/Commonfiles/Scripts/sitepage.js"></script>
<script type="text/javascript">
//$(document).ready(function() { $site.qna.init.call(this); });

function fn_write()
{	
	if ($("#name").val().trim() =='')
	{
		alert("작성자를 입력해주세요.");		
		return;
	}

	if ($("select[name='etccode'] option:selected").val().trim() == '')
	{
		alert("작성유형을 선택해주세요.");
		$("#etccode").focus();
		return;
	}
	

	if ($("#Subject").val().trim() =='')
	{
		alert("제목을 입력해주세요.");
		$("#Subject").focus();
		return;
	}

	if ($("#Content1").val().trim() =='')
	{
		alert("내용을 입력해주세요.");
		$("#Content1").focus();
		return;
	}


	$("FORM[name='formdboard']").attr("action", "WriteOK.asp").submit();
	
}

</script>
	<style>
.wirte_okbtn{ width:70px; height:40px; line-height: 40px;margin-top: 20px; float: right;text-align: center;background-color: #3d3d3d; color:#fff; font-size: 14px;}
		.wirte_okbtn:hover{cursor: pointer;}
	</style>
	
<div class="contents_right">
	<div><img src="/img/subimg/title_4.png" alt="화상영어가이드 "/></div>
	
	  <table class="type07">
		  <form method="post" action="WriteOK.asp" name="formdboard" id="formdboard">
          <input type="hidden" name="currPage" id="currPage" value="<%=currPage%>"/>
          <input type="hidden" name="sortField" id="sortField" value="<%=sortField%>"/>
          <input type="hidden" name="sortMethod" id="sortMethod" value="<%=sortMethod%>"/>
          <input type="hidden" name="seq" id="seq" value="<%=seq%>"/>
          <input type="hidden" name="bcode" id="bcode" value="<%=bcode%>"/>
          <input type="hidden" name="btype" id="btype" value="<%=btype%>"/>
           <tbody>
           <tr>
               <th style="border-top: 1px solid #ccc;">작성자</th>
               <td style="border-top: 1px solid #ccc;"><input class="selectstyle" name="Name" type="text" id="name" size="20" value="<%=sUserName%>" readonly caption="이름"></td>
           </tr>
		   <tr>
               <th style="border-top: 1px solid #ccc;">작성유형</th>
               <td style="border-top: 1px solid #ccc;">
				   <select name="etccode" id="etccode" size="1" class="selectstyle" caption="질문 유형">
				   	<option value="">++ 선택 ++</option>
				   <%
				   	If IsArray(arrQtype) Then
				   		For i = 0 To Ubound(arrQtype, 2)
				   			Response.Write "<option value='"& arrQtype(0, i) &"'>"& arrQtype(1, i) &"</option>" & vbCrlf
				   		Next
				   	End If
				   %>
				   </select>
			  </td>
           </tr>
		  <tr>
               <th style="border-top: 1px solid #ccc;">제목</th>
               <td style="border-top: 1px solid #ccc;"><input name="Subject" type="text" class="selectstyle" id="Subject" size="80" caption="제목" /></td>
           </tr>
			   <tr>
               <th style="border-top: 1px solid #ccc;">내용</th>
               <td style="border-top: 1px solid #ccc;"><textarea name="Content1" cols="60" rows="15" class="selectstyle" id="Content1" caption="내용"></textarea></td>
           </tr>
           </tbody>
       </table>
	
	  <a href="javascript:fn_write();"><div class="wirte_okbtn" id="btnRegist">글등록</div></a>

</form>
</div>
<!--#include virtual="/include/inc_footer.asp"-->