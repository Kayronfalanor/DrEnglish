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
Dim sMenu : sMenu = "9"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
Type_ =sqlCheck(replace(request("Type"),"'","''"))
IF Type_ = "" THEN
	Type_ = "1"
END IF
%> 
<!--#include virtual="/include/inc_top.asp"-->
<script language="javascript"> 
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

function fn_room(CPCODE,CPUSERS,ID,NAME,STATE,TITLE,CINDEX,MAXUSER,VIEWUSER,PLAYTIME,STIME,CURL,ATTURL){
	MM_openBrWindow('http://install.inetstudy.co.kr/ASPStandard/UseTalk26/netstudy_installX.asp?serviceid='+CPCODE+'&servicemaxuser='+CPUSERS+'&ID='+ID+'&name='+NAME+'&state='+STATE+'&title='+TITLE+'&cindex='+CINDEX+'&maxuser='+MAXUSER+'&viewuser='+VIEWUSER+'&playtime='+PLAYTIME+'&stime='+STIME+'&curl='+CURL+'&atturl='+ATTURL,'Installer','width=400,height=170,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,left=80');
}


-->
</script>

<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
	<tr> 
		<td><p>&nbsp;</p></td>
	</tr>
	<tr> 
		<td class="contents_title"><img src="../img/sub/title_6_01.gif" alt="화상영어가이드" /></td>
	</tr>
	<tr> 
		<td>&nbsp;</td>
	</tr>
	<tr> <td>
	
	<strong>1. Test1~Test3 중 하나를 클릭하여 화상 프로그램을 실행합니다.(학습현황에서 프로그램 설치를 꼭 하세요.)</strong><br><br>
					<table cellpadding="2" cellspacing="2" border=0 width="700" >
						<%
						For i = 1 To 3
						newid=""
						newname=""
						newid=randNumChoice&i
						newname=randNumChoice&i
						newroom="ROOM_" + randNumChoice&i
						%>
						<tr>
							<td width="180" height="30" bgcolor="#27a5e0" align="Center"><strong><font color="#ffffff">TEST ROOM <%=i%></font></strong></td>
							<td bgcolor="#e0e0e0" width="520">&nbsp;&nbsp; 
							<!--<a href="#" onclick="fn_room('C0011','2','hbeduNew_sStudent<%=i%>','hbeduNew_sStudent<%=i%>','2','hbeduNew_tClassRoom<%=i%>','hbeduNew_ClassRoom<%=i%>','1','1','30','201305020930','','');">Test<%=i%></a>  -->
							<a href="#" onclick="fn_room('<%=SiteCPCOde%>','2','<%=newid%>','<%=newname%>','2','<%=newroom%>','<%=newroom%>','1','1','30','<%=Replace(Left(now(),10),"-","")%>0930','','');"><strong>Test<%=i%></strong></a>  
							</td>
						</tr>

						<%
						next
							function randNumChoice()
							  Dim RandNum                 : RandNum = ""
							  Dim coupTemp                : coupTemp=""
							  Dim couponValue(35)
							  
							  couponValue(0)   = "A"
							  couponValue(1)   = "B"
							  couponValue(2)   = "C"
							  couponValue(3)   = "D"
							  couponValue(4)   = "E"
							  couponValue(5)   = "F"
							  couponValue(6)   = "G"
							  couponValue(7)   = "H"
							  couponValue(8)   = "I"
							  couponValue(9)   = "J"
							  couponValue(10)  = "K"
							  couponValue(11)  = "L"
							  couponValue(12)  = "M"
							  couponValue(13)  = "N"
							  couponValue(14)  = "O"
							  couponValue(15)  = "P"
							  couponValue(16)  = "Q"
							  couponValue(17)  = "R"
							  couponValue(18)  = "S"
							  couponValue(19)  = "T"
							  couponValue(20)  = "U"
							  couponValue(21)  = "V"
							  couponValue(22)  = "W"
							  couponValue(23)  = "X"
							  couponValue(24)  = "Y"
							  couponValue(25)  = "Z"
							  couponValue(26)  = "0"
							  couponValue(27)  = "1"
							  couponValue(28)  = "2"
							  couponValue(29)  = "3"
							  couponValue(30)  = "4"
							  couponValue(31)  = "5"
							  couponValue(32)  = "6"
							  couponValue(33)  = "7"
							  couponValue(34)  = "8"
							  couponValue(35)  = "9"

							  Do while true
								Randomize     
								coupTemp = couponValue(Int((35- 0 + 1) * Rnd + 0))
								if instr(RandNum, coupTemp) = 0 then 
									RandNum = RandNum & coupTemp
									if Len(RandNum) = 4 then 
									  Exit Do 
									End If  
								End If  
							  Loop 
							  randNumChoice = RandNum
							End Function
						%>
					</table>
				<br>
	
	</td></tr>
	<tr><td></td></tr>

	<tr>
		<td align="center" valign="top" >
			<table width="670" border="0" cellspacing="0" cellpadding="0">
				<tr> 
					<td>
						<a href="Videoguide.asp?Type=1" > <img src="../img/sub/s06_tab01<%IF Type_="1" THEN%>on<%END IF%>.gif"  alt="권장pc사양"  border="0"  /></a> 
						<a href="Videoguide.asp?Type=2" > <img src="../img/sub/s06_tab02<%IF Type_="2" THEN%>on<%END IF%>.gif" alt="캠설정방법"  border="0"  /></a> 
						<a href="Videoguide.asp?Type=3"  > <img src="../img/sub/s06_tab03<%IF Type_="3" THEN%>on<%END IF%>.gif" alt="헤드셋설정방법" border="0" /></a> 
						<a href="Videoguide.asp?Type=4"  > <img src="../img/sub/s06_tab04<%IF Type_="4" THEN%>on<%END IF%>.gif" alt="비스타환경설정" border="0" /></a> 
						<a href="Videoguide.asp?Type=5"  > <img src="../img/sub/s06_tab05<%IF Type_="5" THEN%>on<%END IF%>.gif" alt="장애관련Q&amp;A" border="0" /></a> 
						<a href="Videoguide.asp?Type=6"  > <img src="../img/sub/s06_tab06<%IF Type_="6" THEN%>on<%END IF%>.gif" alt="모바일 가이드" border="0" /></a> 
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr> 
		<td align="center" valign="top" > 
			<table width="670" border="0" cellpadding="0" cellspacing="0">
				<tr> 
					<td align="center" valign="top">
					<%IF Type_="1" THEN%>
						<!--#include file="Videoguide01.asp" -->
					<%ELSEIF Type_="2" THEN%>
						<!--#include file="Videoguide02.asp" -->
					<%ELSEIF Type_="3" THEN%>
						<!--#include file="Videoguide03.asp" -->
					<%ELSEIF Type_="4" THEN%>
						<!--#include file="Videoguide04.asp" -->
					<%ELSEIF Type_="5" THEN%>
						<!--#include file="Videoguide05.asp" -->
					<%ELSEIF Type_="6" THEN%>
						<!--#include file="Videoguide06.asp" -->
					<%END IF%>
					
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->
