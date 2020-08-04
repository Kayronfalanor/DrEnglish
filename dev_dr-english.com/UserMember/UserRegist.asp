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
Dim sMenu : sMenu = "11"

'// Parameters
UserName	= sqlCheck(trim(replace(request("username"),"'","''")))
BirthYear	= sqlCheck(trim(replace(request("birthyear"),"'","''")))
BirthMonth	= sqlCheck(trim(replace(request("birthMonth"),"'","''")))
BirthDay	= sqlCheck(trim(replace(request("birthday"),"'","''")))
Utype		= sqlCheck(trim(replace(request("utype"),"'","''")))
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
chkRequestVal UserName,		"이름 정보가 없습니다.!"
chkRequestVal BirthYear,	"생년월일 정보가 없습니다.!"
chkRequestVal BirthMonth,	"생년월일 정보가 없습니다.!"
chkRequestVal BirthDay,		"생년월일 정보가 없습니다.!"
chkRequestVal Utype,		"생년월일 정보가 없습니다.!"

BirthDate	= CDate(BirthYear + "-" + BirthMonth + "-" + BirthDay)

Dim toDay		: toDay		= Date()
Dim today_time	: today_time= hour(now)
Dim today_tMin	: today_tMin=minute(now)

today_tMin=today_tMin
IF today_tMin<0 THEN
	today_tMin=0
END If

'########## 레벨테스트 날짜 및 시간 정보 CP 수강 방식에 따라 변경
Dim strLevelTest : strLevelTest = getLevelTestDate(Application("CP_ORDER"))

'########## 레벨테스트 [1 : English, 3 : Chinese, 4 : Japanese, 5 : 한국어, 6 : 베트남어]
Dim Sql, objRs, arrLevel
Sql = "Exec PRC_tb_CLCourse_User_Select_List N'"& SiteCPCode &"', '1'"
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrLevel = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing	:	Call DbClose()
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
  <div><img src="/img/subimg/title_11.png" alt="회원가입"/></div>
	<div style="margin-top: 40px;">
		
		<form action="UserRegistUPOK.asp" name="Uform" method="post">
			<input name="username"			type="hidden"		value="<%=UserName%>" />
			<input name="birthday"			type="hidden"		value="<%=BirthDate%>" />
			<input name="utype"				type="hidden"		value="<%=UType%>" />
			<input name="today"				type="hidden"		value="<%=today%>" />
			<input name="todayhour"			type="hidden"		value="<%=cint(today_time)+2%>" />
			<input name="todaymin"			type="hidden"		value="<%=today_tMin%>" />
			<input name="useidYN"			type="hidden"		value="N" />
			<input name="UserBalanceSeq"	type="hidden"			value="" />

	<p style="font-size:18px;">정보 입력</p>
		 <div class="text_list_common">		 
			<ul>
		 <li class="text_style5">개인정보를 입력하세요.</li><br>		
			 </ul>
		</div>

		<%If Trim(UType) = "J" Then '14세 미만일 경우 법정대리인 정보 입력 창 보여주기%>
			
		<table class="type07">
           <tbody>
		     <tr>
               <th style="border-top: 1px solid #ccc;" colspan="2">법정대리인 정보</th>              
           </tr>
           <tr>
               <th style="border-top: 1px solid #ccc;">이름</th>
               <td style="border-top: 1px solid #ccc;">
			   <input name="PName" type="text" class="input csspinput" id="PName" size="20" caption="이름" style="width:200px;height:24px;font-size:16px;"  />				
			    </td>
           </tr>
           <tr>
               <th scope="row">휴대전화</th>
               <td colspan="">
			  <select name="PPhone_1" id="PPhone_1" class="csspinput select" caption="휴대전화번호"  style="width:80px;height:24px;font-size:16px;">
																<option value="">선택</option>
																<option value="010" >010</option>
																<option value="011" >011</option>
																<option value="016" >016</option>
																<option value="017" >017</option>
																<option value="018" >018</option>
																<option value="019" >019</option>
															</select>
															-
															<input name="PPhone_2" type="text" class="input cssnumber csspinput" id="PPhone_2"   style="width:80px;height:24px;font-size:16px;" size="5" maxlength="4" caption="휴대전화번호" />
															-
															<input name="PPhone_3" type="text" class="input cssnumber csspinput" id="PPhone_3"   style="width:80px;height:24px;font-size:16px;" size="5" maxlength="4" caption="휴대전화번호" />
																							
				</td>
           </tr>       
		   
		   <tr>
               <th scope="row">이메일</th>
               <td colspan="">
										<input name="PEmail1" type="text" class="input csspinput" id="PEmail1" size="20" caption="이메일" style="width:200px;height:24px;font-size:16px;" maxlength="30" />
															@
															<input name="PEmail2" type="text" class="input csspinput" id="PEmail2" size="30" caption="이메일"  maxlength="30" style="width:200px;height:24px;font-size:16px;" />
																							
				</td>
           </tr>  



           </tbody>
       </table>
	<p style="font-size:18px;"></p>
		 <div class="text_list_common">		 
			<ul>
		 <li class="text_style5">만 14세 미만 회원의 정보 보호를 위해 법정대리인의 동의를 받고 있습니다.</li><br>		
			 </ul>
		</div>

		<%End If%>

		<table class="type07">
           <tbody>
		     <tr>
               <th style="border-top: 1px solid #ccc;" colspan="2">기본 정보</th>              
           </tr>
           <tr>
               <th style="border-top: 1px solid #ccc;">이름</th>
               <td style="border-top: 1px solid #ccc;">
			   <%=UserName%>			
			    </td>
           </tr>
           <tr>
               <th scope="row">생년월일</th>
               <td colspan="">
			 <%=BirthDate%><br>
						<div style="padding:5px 0 5px 0;">
							<input type="radio" name="birthflag" id="birthflag" value="0" /> 음력
							&nbsp; &nbsp; 
							<input type="radio" name="birthflag" id="birthflag" value="1" checked /> 양력
						</div>
																							
				</td>
           </tr>       
		   
		    <tr>
               <th scope="row">아이디</th>
               <td colspan="" align="left">
				   <table  class="type07none" cellpadding=0 cellspacing=0 border=0 width="100%" >
				   <tr><td width="160">
				   <input name="UserID" type="text" class="input cssinput"	id="UserID" size="20" readonly caption="아이디" style="width:150px;height:24px;font-size:16px;" />
					</td>
					<td>
				   <input type="button" value="중복 체크"  alt="중복 체크" border="0" class="cssregBtns"  caption="OVERLAP">
				   </td>
				   <td>* 중복체크 클릭하여 검색해주세요. <br>* 6~12자 입력, 한글/특수문자 입력불가</td></tr>
				   </table>
																							
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
																	<td width="160" align="left"><input name="UserEname" type="text" class="input cssinput alpha" id="UserEname" size="30" caption="수업용(영문) 이름"  maxlength="30" style="width:200px;height:24px;font-size:16px;" /></td>
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
					<input name="UserPhone2_2" type="text" class="input cssnumber cssinput" id="UserPhone2_2" style="width:80px;height:24px;font-size:16px;" size="5" maxlength="4" caption="휴대폰번호" />
					-
					<input name="UserPhone2_3" type="text" class="input cssnumber cssinput" id="UserPhone2_3" style="width:80px;height:24px;font-size:16px;" size="5" maxlength="4" caption="휴대폰번호" />
				
				  <input type="hidden" name="UserPhoneSMS" id="UserPhoneSMS" value="N">
				</td>
           </tr>  
		     <tr>
               <th scope="row">이메일</th>
               <td colspan="">

			   	<input name="SearchEmail1" type="text" class="input csspinput" id="SearchEmail1" size="20" caption="이메일" style="width:200px;height:24px;font-size:16px;" maxlength="30" />
					@
					<input name="SearchEmail2" type="text" class="input csspinput" id="SearchEmail2" size="30" caption="이메일"  maxlength="30" style="width:200px;height:24px;font-size:16px;" />
																							

			   <!--<table  class="type07none" cellpadding=0 cellspacing=0 border=0 width="100%" >
					<tr> 
						<td><input name="SearchEmail1" type="text" class="input cssinput" id="SearchEmail1" caption="이메일" value="<%=UserEmail1%>" size="20" maxlength="50" style="width:200px;height:24px;font-size:16px;" />
						 @ </td>
						<td id="EmailForm" style="display:none;padding-left:5"> 
						<input name="SearchEmail2" id="SearchEmail2" style="width:150px;height:24px;font-size:16px;"  type="text" class="input" value="<%=UserEmail2%>" size="25" maxlength="50" /> 
						</td>
						<td style="padding-left:5px;text-align:left;"> 
							<select name="SearchEmail3" id="SearchEmail3"  caption="이메일"  class="select cssinput" style="width:200px;height:24px;font-size:16px;" >
								<option value="">이메일을 선택해 주세요</option>
								<option value="naver.com"    <%if UserEmai2="naver.com" then%>selected<%end if%>>naver.com</option>
								<option value="gmail.com"    <%if UserEmai2="gmail.com" then%>selected<%end if%>>gmail.com</option>
								<option value="daum.net"     <%if UserEmai2="daum.net" then%>selected<%end if%>>daum.net</option>
								<option value="hanmail.net"  <%if UserEmai2="hanmail.net" then%>selected<%end if%>>hanmail.net</option>
								<option value="nate.com"     <%if UserEmai2="nate.com" then%>selected<%end if%>>nate.com</option>
								<option value="yahoo.co.kr"  <%if UserEmai2="yahoo.co.kr" then%>selected<%end if%>>yahoo.co.kr</option>
								<option value="dreamwiz.com" <%if UserEmai2="dreamwiz.com" then%>selected<%end if%>>dreamwiz.com</option>
								<option value="freechal.com" <%if UserEmai2="freechal.com" then%>selected<%end if%>>freechal.com</option>
								<option value="hotmail.com"  <%if UserEmai2="hotmail.com" then%>selected<%end if%>>hotmail.com</option>
								<option value="korea.com"    <%if UserEmai2="korea.com" then%>selected<%end if%>>korea.com</option>
								<option value="lycos.co.kr"  <%if UserEmai2="lycos.co.kr" then%>selected<%end if%>>lycos.co.kr</option>
								<option value="00">직접입력</option>
							</select>
						</td>
					</tr>
				</table>-->
				
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
							<input type="button" value="회원 가입" caption="REG" class="cssregBtns"  alt="회원 가입" border="0" style="cursor:pointer;float:right;margin-right:20px;" >
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