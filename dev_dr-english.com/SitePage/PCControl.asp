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
Dim sMenu : sMenu = "7"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<!--#include virtual="/include/inc_top.asp"-->
<div class="contents">
<!-- ##### // Contents ##### -->
<script language="javascript">

function fn_Remote()
{
	<%if sUserid="" then %>
		alert('로그인 하신 후에 이용해주세요.');	
		return  false;
	<%else%>
	
	if (Rform.SL_Cdate1.value=="")
	{	
		alert("원격지원 날짜를 선택해주세요.");
		Rform.SL_Cdate1.focus();
		return false;
	}

	if (Rform.SL_Ctime1.value=="")
	{	
		alert("원격지원 시간을 선택해주세요.");
		Rform.SL_Ctime1.focus();
		return false;
	}

	if (Rform.SL_Ctime2.value=="")
	{	
		alert("원격지원 시간을 선택해주세요.");
		Rform.SL_Ctime2.focus();
		return false;
	}

	

	if (Rform.SL_Cdate1.value==Rform.strnowdate.value)
	{
		if (parseInt(Rform.SL_Ctime1.value) < parseInt(Rform.strnowhour.value)+2 )
		{
			alert("원격지원요청은 현재보다 2시간후의 시간으로 신청 가능합니다.");
			return false;
		}
	}
	
	if (Rform.SL_Name.value=="")
	{	
		alert("원격지원 받으실 분의 성명을 입력해주세요.");		
		return false;
	}

	if (Rform.SL_Phone.value=="")
	{	
		alert("원격지원시 연락처를 입력해주세요.");
		Rform.SL_Phone.focus();
		return false;
	}

	Rform.submit();
	<%end if%>

}
</script>
<script language="javascript">
  function TimeChange(obj4){
	if(obj4 == "11"){
		 for(var i=0; i<2; i++){
		  document.Rform.SL_Ctime2.options[5] = null;
		  document.Rform.SL_Ctime2.options[6] = null;
		}
	}else{
		document.Rform.SL_Ctime2.options[5] = new Option("40","40");
		document.Rform.SL_Ctime2.options[6] = new Option("50","50");
	}
  }
</script>
	<style>
	.selectstyle{padding:5px 8px; }
	</style>
	
	
  <div class="contents_right"> 
    <div><img src="/img/subimg/title_2.png" alt="원격지원센터"/></div>
	<div style="margin-top: 40px;">
		        <form name="Rform" id="Rform" method="post" action="./PCControl_proc.asp" >
				<input type="hidden" name="strnowdate" value="<%=Left(Now(),10)%>">
				<input type="hidden" name="strnowhour" value="<%=Right("0"&Hour(Now()),2)%>">
				<input type="hidden" name="strnowmin" value="<%=Right("0"&minute(Now()),2)%>">
	  <table class="type07">
           <tbody>
           <tr>
               <th style="border-top: 1px solid #ccc;">원격지원 날짜/시간</th>
               <td style="border-top: 1px solid #ccc;">
			    <div>* 원격지원요청은 현재보다 2시간 후의 시간으로 신청 가능합니다.</div>
				   <div style="margin-top: 10px;">
				    <select class="selectstyle" name="SL_Cdate1" id="select2" caption="날짜">
					<!-- ##### // Level Test ##### -->	
						<option value="">선택</option>
						<%
						For i=0 To 10
							If weekday(DateAdd("d",i,Now()))<>"1" and weekday(DateAdd("d",i,Now()))<>"7" then
							
						%>
						<option value="<%=Left(DateAdd("d",i,Now()),10)%>" ><%=Left(DateAdd("d",i,Now()),10)%></option>
						<%
						End if
						next
						%>
					<!-- ##### Level Test // ##### -->
					</select>&nbsp;
					<span id="div_Sch">
					<select class="selectstyle" name="SL_Ctime1" id="SL_Ctime1" caption="시간" >
						<option value="">선택</option>
						<option value="15" >15</option>
						<option value="16" >16</option>
						<option value="17" >17</option>
						<option value="18" >18</option>
						<option value="20" >20</option>
						<option value="21" >21</option>
					</select>
					시&nbsp;&nbsp;
					</span>
				   <select class="selectstyle" name="SL_Ctime2" id="SL_Ctime2" caption="시간">
				   	<option value="">선택</option>
				   	<option value="00" >00분 ~ 29분</option>
				   	<option value="30" >30분 ~ 59분</option>															
				   </select>
				   분
				   </div>
			    </td>
           </tr>
           <tr>
               <th scope="row">성명</th>
               <td colspan=""><input name="SL_Name" type="text" class="selectstyle" value="<%=sUserName%>" maxlength="20" readonly /></td>
           </tr>
           <tr>
               <th scope="row">연락처</th>
               <td><input name="SL_Phone" type="text" class="selectstyle" value="<%=session("UserPhone")%>" maxlength="14" /></td>
           </tr>
			   <tr>
               <th scope="row">원격지원 사유</th>
               <td><textarea name="nvcReason" id="nvcReason" rows="4" cols="46"></textarea></td>
           </tr>
           </tbody>
       </table>
	   <input type="button" value="원격지원 신청하기" class="won_gobtn" onclick="return fn_Remote();">
	</div>
	  
	<div><img src="/img/subimg/sp1.png" alt="원격지원서비스란"/></div>
	  
	<a href="https://939.co.kr/" target="_blank"><div style="width:255px; margin: 0 auto 100px auto;"><img src="/img/subimg/won_btnimg.png" alt="원격지원서비스 실행"/></div></a>
  </div>

<!--#include virtual="/include/inc_footer.asp"-->