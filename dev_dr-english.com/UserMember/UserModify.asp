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
<%

Dim Sql, objRs, arrData
Sql = "Exec PRC_tb_Member_User_Select_View N'"& SiteCPCode &"', '"& sUserID &"'"
Set objRs = dbSelect(Sql)
If Not (objRs.Eof And objRs.Bof) Then
	'If Trim(objRs("nvcMemberPW")) = Trim(session("UserPW")) Then
		arrData = objRs.GetRows()
	'End If
End If
objRs.Close	:	Set objRs	= Nothing	:	Call DBClose()

If IsArray(arrData) Then
'Array Info
'0.nvcCPCode,		1.iMemberSeq,		2.nvcMemberID,		3.nvcMemberName,	4.nvcMemberEName  
'5.nvcMemberPW,		6.nvcMemberTel,		7.nvcMemberCTN,		8.nvcBirth,			9.siBirthType
'10.nvcZipCode,		11.nvcAddress2,		12.ncMemberSMSYN,	13.nvcMemberEmail,	14.ncMemberEmailYN 

	UserBirth		= arrData(8, 0)
	UserBirthType	= arrData(9, 0)
	UserEName		= arrData(4, 0)

	UserPost		= arrData(10, 0)
	On Error Resume Next
	UserPost		= Split(UserPost, "-")
	UserPost1		= UserPost(0)
	UserPost2		= UserPost(1)

	

UserAddr1		= arrData(15, 0)
	UserAddr2		= arrData(11, 0)

	UserTel			= arrData(6, 0)
	On Error Resume Next
	UserTel			= Split(UserTel, "-")
	UserPhone1_1	= UserTel(0)
	UserPhone1_2	= UserTel(1)
	UserPhone1_3	= UserTel(2)

	UserCTN			= arrData(7, 0)
	On Error Resume Next
	UserCTN			= Split(UserCTN, "-")
	UserPhone2_1	= UserCTN(0)
	UserPhone2_2	= UserCTN(1)
	UserPhone2_3	= UserCTN(2)

	UserSMSYN		= arrData(12, 0)

	UserEmail		= arrData(13, 0)
	On Error Resume Next
	UserEmail		= Split(UserEmail, "@")
	UserEmail1		= UserEmail(0)
	UserEmail2		= UserEmail(1)

	UserEmailEMS	= arrData(14, 0)
Else
	chkMessageBack "동일한 회원정보가 없습니다. 다시한번 확인하세요~!"
End If 
%>
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/commonfiles/scripts/jquery.alphanumeric.pack.js"></script>
<script type="text/javascript" src="/commonfiles/scripts/member.js"></script>
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
  <div><img src="/img/subimg/title_13.png" alt="회원정보 수정"/></div>
	<div style="margin-top: 40px;">
		
<form action="UserRegistUPOK.asp" name="Uform" method="post">
			<input name="username"	type="hidden"		value="<%=UserName%>" />
			<input name="birthday"	type="hidden"		value="<%=BirthDate%>" />
			<input name="utype"		type="hidden"		value="<%=UType%>" />
			<input name="today"		type="hidden"		value="<%=today%>" />
			<input name="todayhour" type="hidden"		value="<%=cint(today_time)+2%>" />
			<input name="todaymin"	type="hidden"		value="<%=today_tMin%>" />
			<input name="useidYN"	type="hidden"		value="N" />

	<p style="font-size:18px;">정보 입력(수정)</p>
		 <div class="text_list_common">		 
			<ul>
		 <li class="text_style5">개인정보를 입력(수정)하세요.</li><br>		
			 </ul>
		</div>

<table class="type07">
           <tbody>
		     <tr>
               <th style="border-top: 1px solid #ccc;" colspan="2">기본 정보</th>              
           </tr>
           <tr>
               <th style="border-top: 1px solid #ccc;">이름</th>
               <td style="border-top: 1px solid #ccc;">
			   <%=sUserName%>			
			    </td>
           </tr>
		   <tr>
               <th style="border-top: 1px solid #ccc;">아이디</th>
               <td style="border-top: 1px solid #ccc;">
			   <%=sUserID%>			
			    </td>
           </tr>
			<tr>
               <th scope="row">패스워드</th>
               <td colspan="">
				<table  class="type07none" cellpadding=0 cellspacing=0 border=0 width="100%" >
																<tr>
																	<td width="160" align="left"><input name="UserPW" type="password" class="input  cssinput" id="UserPW" size="20" caption="패스워드" maxlength="16" style="width:150px;height:24px;font-size:16px;" /></td>
																	<td>&nbsp;	</td>
																	<td style="text-align:left;">* 9~16자, 영문자, 숫자, 특수문자 ( ~!@#$%^()_ ) 를 조합해 주세요.</td></tr>
																
															</table>
																							
				</td>
           </tr>  

		    <tr>
               <th scope="row">패스워드 확인</th>
               <td colspan="">
			<table  class="type07none" cellpadding=0 cellspacing=0 border=0 width="100%" >
																<tr>
																	<td width="160" align="left"><input name="UserPW2" type="password" class="input  cssinput" id="UserPW2" size="20" caption="패스워드확인" maxlength="16" style="width:150px;height:24px;font-size:16px;" /></td>
																	<td>&nbsp;	</td>
																	<td style="text-align:left;">* 패스워드와 동일하게 입력해주세요.</td></tr>
																
															</table>
																							
				</td>
           </tr>  

		    <tr>
               <th scope="row">수업용이름(영문)</th>
               <td colspan="">
			   <table  class="type07none" cellpadding=0 cellspacing=0 border=0 width="100%" >
																<tr>
																	<td width="160" align="left"><input name="UserEname" type="text" class="input cssinput alpha" id="UserEname" size="30" caption="수업용(영문) 이름"  maxlength="30" style="width:200px;height:24px;font-size:16px;"  value="<%=UserEName%>"/></td>
																	<td>&nbsp;	</td>
																	<td style="text-align:left;">* 수업용(영문) 이름을 입력해 주세요.</td></tr>
																
															</table>
																							
				</td>
           </tr>  
			
			 <tr>
               <th scope="row">휴대전화</th>
               <td colspan="">
			   <select name="UserPhone2_1" class="select cssinput" caption="휴대폰 앞자리" style="width:80px;height:24px;font-size:16px;">
						<option value="">선택</option>
						<option value="010" <%if UserPhone2_1="010" then%>selected<%end if%>>010</option>
						<option value="011" <%if UserPhone2_1="011" then%>selected<%end if%>>011</option>
						<option value="016" <%if UserPhone2_1="016" then%>selected<%end if%>>016</option>
						<option value="017" <%if UserPhone2_1="017" then%>selected<%end if%>>017</option>
						<option value="018" <%if UserPhone2_1="018" then%>selected<%end if%>>018</option>
						<option value="019" <%if UserPhone2_1="019" then%>selected<%end if%>>019</option>
					</select>
					-
					<input name="UserPhone2_2" type="text" class="input cssnumber cssinput" id="UserPhone2_2" style="width:80px;height:24px;font-size:16px;" size="5" maxlength="4" caption="휴대폰번호" value="<%=UserPhone2_2%>" />
					-
					<input name="UserPhone2_3" type="text" class="input cssnumber cssinput" id="UserPhone2_3" style="width:80px;height:24px;font-size:16px;" size="5" maxlength="4" caption="휴대폰번호" value="<%=UserPhone2_3%>"  />
				
				  <input type="hidden" name="UserPhoneSMS" id="UserPhoneSMS" value="N">
				</td>
           </tr>  
		     <tr>
               <th scope="row">이메일</th>
               <td colspan="">

			   	<input name="SearchEmail1" type="text" class="input csspinput" id="SearchEmail1" size="20" caption="이메일" style="width:200px;height:24px;font-size:16px;" maxlength="30"  value="<%=UserEmail1%>"/>
					@
					<input name="SearchEmail2" type="text" class="input csspinput" id="SearchEmail2" size="30" caption="이메일"  maxlength="30" style="width:200px;height:24px;font-size:16px;" value="<%=UserEmail2%>" />
																					
				
				<input type="hidden" name="UserEmailEMS" id="UserEmailEMS" value="N">																			
				</td>
           </tr>  

</tbody>
</table>

<table  class="type07none" cellpadding=0 cellspacing=0 border=0 width="100%" >
				<tr> <td height=10></td></tr>
		</table>
		 <table  class="type07none" cellpadding=0 cellspacing=0 border=0 width="100%" >
				<tr> 
					<td width="50%">					
							<input type="button" value="회원정보 수정" caption="REG" class="cssregBtns"  alt="회원정보 수정" border="0" style="cursor:pointer;float:right;margin-right:20px;" >
							</td>
					<td > 
						<input type="button" value="취소" caption="CANCEL" class="cssregBtns"  alt="취소" border="0" style="cursor:pointer;background-color:red;" >
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