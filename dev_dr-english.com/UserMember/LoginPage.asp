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
Dim sMenu : sMenu = "10"

%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
ReturnUrl = sqlCheck(Replace(Request.Form("returnUrl"), "'", "''"))
'Response.write "=====================================*******************"&ReturnUrl
%>
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/Commonfiles/Scripts/member.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$member.init.call(this);
});
</script>
<style>
	.selectstyle{padding:5px 8px; }
	</style>
<div class="contents">


	
	
  <div class="contents_right"> 

    <div><img src="/img/subimg/title_10.png" alt="로그인"/></div>
	<div style="margin-top: 40px;">
		     <form action="http://<%=site___url_real%>/UserMember/LoginOK.asp" method="post" name="Gform">
				<input name="returnUrl" type="hidden" value="<%=ReturnUrl%>">     
	  <table class="type07">
           <tbody>
           <tr>
               <th style="border-top: 1px solid #ccc;">아이디</th>
               <td style="border-top: 1px solid #ccc;">
				<input type="text" name="id" id="input_id" title="아이디"  value="" maxlength="30" class="txt_box" style="width:200px;height:24px;font-size:16px;" />
			    </td>
           </tr>
           <tr>
               <th scope="row">비밀번호</th>
               <td colspan=""><input  type="password" name="password" id="input_pw"  title="비밀번호"  class="txt_box" value="" maxlength="30" style="width:200px;height:24px;font-size:16px;"  /></td>
           </tr>         
           </tbody>
       </table>
	   <input type="button" value="로그인" class="won_gobtn"  id="loginBtn">
	   </form>
	</div>



</div>
<!--#include virtual="/include/inc_footer.asp"-->