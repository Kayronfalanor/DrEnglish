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
Dim sMenu : sMenu = "13"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript">
$(document).ready(function() {
	if($("#btnMBtn").length > 0) {
		$("#btnMBtn").bind("click", function() {

			if($("INPUT[name='UserPW']").val().trim() == "") {
				alert("등록하신 패스워드를 입력하세요.");
				$("INPUT[name='UserPW']").focus();
				return;
			}

			$("FORM[name='Dform']").submit();
		});
	}

	if($("#btnCBtn").length > 0) {
		$("#btnCBtn").bind("click", function() {
			location.href="/";
		});
	}
});
</script>
<style>
	.selectstyle{padding:5px 8px; }
	</style>
<div class="contents">


	
	
  <div class="contents_right"> 

    <div><img src="/img/subimg/title_13.png" alt="로그인"/></div>
	<div style="margin-top: 40px;">
	
	<p style="font-size:18px;"><%=sUserName%></span> 님의 정보를 안전하게 보호하기 위하여 	비밀번호를 다시 한 번 확인 합니다</p>
	

		     <form action="UserModify.asp" method="post" name="Dform">
	  <table class="type07">
           <tbody>
           <tr>
               <th style="border-top: 1px solid #ccc;">아이디</th>
               <td style="border-top: 1px solid #ccc;">
				<%=sUserID%>
			    </td>
           </tr>
           <tr>
               <th scope="row">비밀번호</th>
               <td colspan="">
			
			   
			   <input  type="password" name="UserPW" id="UserPW"  title="비밀번호"  class="txt_box" value="" maxlength="30" style="width:200px;height:24px;font-size:16px;"  /></td>
           </tr>         
           </tbody>
       </table>
	    <p style="font-size:18px;"></p>
			 <div class="text_list_common">		 
				<ul>
			 <li class="text_style5">비밀번호가 타인에게 노출되지 않도록 항상 주의해 주세요.</li><br>		
				 </ul>
			</div>
		<table  class="type07none" cellpadding=0 cellspacing=0 border=0 width="100%" >
				<tr> <td height=10></td></tr>
		</table>
		 <table  class="type07none" cellpadding=0 cellspacing=0 border=0 width="100%" >
				<tr> 
					<td width="50%">					
							<input type="button" value="확인" caption="REG" class="cssregBtns" id="btnMBtn"  alt="확인" border="0" style="cursor:pointer;float:right;margin-right:20px;" >
							</td>
					<td > 
						<input type="button" value="취소" caption="CANCEL" class="cssregBtns" id="btnCBtn" alt="취소" border="0" style="cursor:pointer;background-color:red;" >
					</td>
				</tr>
			</table>
							
		<table  class="type07none" cellpadding=0 cellspacing=0 border=0 width="100%" >
				<tr> <td height=50></td></tr>
		</table>

	   </form>
	</div>

</div>

<!--#include virtual="/include/inc_footer.asp"-->