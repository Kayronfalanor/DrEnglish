<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = False
'// menu setting
Dim mMenu : mMenu = "6"
Dim sMenu : sMenu = "0"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<!--#include virtual="/include/inc_top.asp"-->
<div class="contents">
<!-- ##### // Contents ##### -->
<table width="681" border="0" cellpadding="0" cellspacing="0">
<tr>
  <td>&nbsp;</td>
</tr>
<tr>
  <td class="contents_title"><img src="../img/sub/title_map.gif" alt="사이트맵" /></td>
</tr>
<tr>
  <td>&nbsp;</td>
</tr>
<tr>
  <td ><table width="598" border="0" cellspacing="0" cellpadding="0">
	<tr>
	  <td><img src="../img/sub/map_btop.gif" width="655" height="53" /></td>
	</tr>
	<tr>
	  <td align="center" background="../img/sub/map_bg.gif">
	  
	  <table width="560" border="0" cellspacing="0" cellpadding="0" class="sitemap">
		<tr>
		  <td width="228"><img src="../img/sub/map_01.gif" alt="마이노트"  /></td>
		  <td width="212"><img src="../img/sub/map_02.gif" alt="학습시스템" /></td>
		  <td width="120"><img src="../img/sub/map_03.gif" alt="수강신청" /></td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		</tr>
		<tr>
		  <td><a href="/Mypage/Mypage.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image60','','../img/sub/map_01_1.gif',1)">
		  <img src="../img/sub/map_01_1off.gif" alt="학습현황" name="Image60"  border="0" id="Image60" /></a></td>
		  
		 <td><a href="/ClassSystem/Book01.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image65','','../img/sub/map_02_2.gif',1)"><img src="../img/sub/map_02_2off.gif" alt="프로그램구성" name="Image65"   border="0" id="Image65" /></a><a href="/ClassSystem/Espt.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image52','','../img/sub/map_02_5.gif',1)"></a></td>
		  
		  
		
		  
		  <td><a href="/OrderPage/Information.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image68','','../img/sub/map_03_1.gif',1)">
		  <img src="../img/sub/map_03_1off.gif" alt="수강안내" name="Image68"   border="0" id="Image68" /></a></td>
		</tr>
		<tr>
		  <td><a href="/Mypage/ReportList.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image61','','../img/sub/map_01_2.gif',1)">
		  <img src="../img/sub/map_01_2off.gif" alt="나의성적표" name="Image61"  border="0" id="Image61" /></a></td>
		  
			<td><a href="/Teacher/List.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image52','','../img/sub/map_02_5.gif',1)"><img src="../img/sub/map_02_5off.gif" alt="ESPT" name="Image52" border="0"></a><!--<a href="/ClassSystem/TestClass.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image54','','../img/sub/map_02_6.gif',1)"><img src="../img/sub/map_02_6off.gif" name="Image54" border="0"></a><a href="/ClassSystem/ClassSystem.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image64','','../img/sub/map_02_1.gif',1)"></a>--></td>
		  
	  
		  
		  <td><a href="/OrderPage/Application01.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image69','','../img/sub/map_03_2.gif',1)">
		  <img src="../img/sub/map_03_2off.gif" alt="수강신청" name="Image69"   border="0" id="Image69" /></a></td>
		</tr>
		<tr>
		  <td><a href="/Mypage/Diary/List.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image62','','../img/sub/map_01_3.gif',1)">
		  <img src="../img/sub/map_01_3off.gif" alt="영어일기" name="Image62" border="0" id="Image62" /></a></td>
		  
			  <td><!--<a href="/ClassSystem/Program.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image65','','../img/sub/map_02_2.gif',1)"></a><a href="/ClassSystem/TestClass01.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image55','','../img/sub/map_02_7.gif',1)"><img src="../img/sub/map_02_7off.gif" name="Image55" border="0"></a>--></td>
		  
 
		  
		  <td><a href="/Mypage/Leveltest.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image70','','../img/sub/map_03_3.gif',1)">
		  <img src="../img/sub/map_03_3off.gif" alt="무료체험신청" name="Image70"   border="0" id="Image70" /></a></td>
		</tr>
		<tr>
		  <td><a href="/Mypage/Tomyteacher/List.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image63','','../img/sub/map_01_4.gif',1)">
		  <img src="../img/sub/map_01_4off.gif" alt="to my teacher" name="Image63"  border="0" id="Image63" /></a></td>
		  
				   <td>&nbsp;</td>
		  
		  <td><a href="/OrderPage/FreeApplication.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image71','','../img/sub/map_03_4.gif',1)"></a></td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
		  <td><a href="/ClassSystem/ClassSystem.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image64','','../img/sub/map_02_1.gif',1)"></a></td>
		  <td>&nbsp;</td>
		</tr>
		 <tr>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		</tr>
		 <tr>
		  <td>&nbsp;</td>
		  <td><!--<a href="/ClassSystem/Book01.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image56','','../img/sub/map_02_6.gif',1)"><img src="../img/sub/map_02_6off.gif" name="Image56" border="0"></a><a href="/ClassSystem/Book01.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image66','','../img/sub/map_02_3.gif',1)"></a>--></td>
		  <td>&nbsp;</td>
		</tr>
		 <tr>
		  <td>&nbsp;</td>
		  <td><!--<a href="/ClassSystem/Book04.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image57','','../img/sub/map_02_7.gif',1)"><img src="../img/sub/map_02_7off.gif" name="Image57" border="0"></a>--></td>
		  <td>&nbsp;</td>
		</tr>
		 <tr>
		  <td>&nbsp;</td>
		  <td><a href="/ClassSystem/Espt.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image52','','../img/sub/map_02_5.gif',1)"></a></td>
		  <td>&nbsp;</td>
		</tr>
		 <tr>
		  <td>&nbsp;</td>
		  <td><a href="/ClassSystem/Espt.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image52','','../img/sub/map_02_5.gif',1)"></a></td>
		  <td>&nbsp;</td>
		</tr>
	  
		<tr>
		  <td><img src="../img/sub/map_04.gif" alt="콘텐츠" /></td>
		  <td><img src="../img/sub/map_05.gif" alt="커뮤니티" /></td>
		  <td><img src="../img/sub/map_06.gif" alt="고객지원" /></td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		</tr>
		<tr>
		  <td><a href="/Contents/TodayEnglish/List.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image72','','../img/sub/map_04_1.gif',1)"><img src="../img/sub/map_04_1off.gif" alt="오늘의영어한마디" name="Image72" border="0" id="Image72" /></a></td>
		  <td><a href="/community/ClassAfter/List.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image77','','../img/sub/map_05_1.gif',1)"><img src="../img/sub/map_05_1off.gif" alt="수업후기" name="Image77" border="0" id="Image77" /></a></td>
		  <td><a href="/SitePage/Videoguide.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image83','','../img/sub/map_06_1.gif',1)"><img src="../img/sub/map_06_1off.gif" alt="화상영어가이드" name="Image83"  border="0" id="Image83" /></a></td>
		</tr>
		<tr>
		  <td><a href="/Contents/Expression/List.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image73','','../img/sub/map_04_2.gif',1)"><img src="../img/sub/map_04_2off.gif" alt="유용한표현" name="Image73"  border="0" id="Image73" /></a></td>
		  <td><a href="/community/LanguageGame/List.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image81','','../img/sub/map_05_5.gif',1)"><img src="../img/sub/map_05_5off.gif" alt="영어끝말잇기" name="Image81" border="0" id="Image81" /></a></td>
		  <td><a href="/SitePage/Notice/List.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image84','','../img/sub/map_06_2.gif',1)"><img src="../img/sub/map_06_2off.gif" alt="공지사항" name="Image84"  border="0" id="Image84" /></a></td>
		</tr>
		<tr>
		  <td><a href="/Contents/JollyGoAdvance/List.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image74','','../img/sub/map_04_3.gif',1)"><img src="../img/sub/map_04_3off.gif" alt="JollyGo Advance" name="Image74"  border="0" id="Image74" /></a></td>
		  <td><a href="/community/TalkTalk/List.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image82','','../img/sub/map_05_6.gif',1)"><img src="../img/sub/map_05_6off.gif" alt="영어수다떨기" name="Image82"  border="0" id="Image82" /></a><a href="/community/LanguageGame/List.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image81','','../img/sub/map_05_5.gif',1)"></a></td>
		  <td><a href="/SitePage/SpecialEvent.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image85','','../img/sub/map_06_3.gif',1)"><img src="../img/sub/map_06_3off.gif" alt="Special Event  " name="Image85"  border="0" id="Image85" /></a></td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
		  <td><a href="/community/TalkTalk/List.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image82','','../img/sub/map_05_6.gif',1)"></a></td>
		  <td><a href="/SitePage/News/List.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image86','','../img/sub/map_06_4.gif',1)"><img src="../img/sub/map_06_4off.gif" alt="보도자료" name="Image86"  border="0" id="Image86" /></a></td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
		  <td><a href="/community/LanguageGame/List.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image81','','../img/sub/map_05_5.gif',1)"></a></td>
		  <td><a href="/SitePage/FAQ/List.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image87','','../img/sub/map_06_5.gif',1)"><img src="../img/sub/map_06_5off.gif" alt="자주묻는질문" name="Image87"  border="0" id="Image87" /></a></td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
		  <td><a href="/community/TalkTalk/List.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image82','','../img/sub/map_05_6.gif',1)"></a></td>
		  <td><a href="/SitePage/Q&A/List.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image88','','../img/sub/map_06_6.gif',1)"><img src="../img/sub/map_06_6off.gif" alt="묻고답하기" name="Image88"  border="0" id="Image88" /></a></td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td><a href="/SitePage/Programdownload.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image89','','../img/sub/map_06_7.gif',1)"><img src="../img/sub/map_06_7off.gif" alt="프로그램다운로드" name="Image89"  border="0" id="Image89" /></a></td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td><a href="/UserMember/UserRegistcheck.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image93','','../img/sub/map_08_1.gif',1)"><img src="../img/sub/map_08_1off.gif" alt="회원가입" name="Image93" border="0" id="Image93" /></a></td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td><a href="/UserMember/UserUpdatecheck.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image94','','../img/sub/map_08_2.gif',1)"><img src="../img/sub/map_08_2off.gif" alt="회원정보수정" name="Image94" border="0" id="Image94" /></a></td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td><a href="/UserMember/UserIDsearch.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image95','','../img/sub/map_08_3.gif',1)"><img src="../img/sub/map_08_3off.gif" alt="아이디비밀번호찾기" name="Image95"  border="0" id="Image95" /></a></td>
		</tr>
		   <tr>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td><a href="/UserMember/Useragreement.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image96','','../img/sub/map_08_4.gif',1)"><img src="../img/sub/map_08_4off.gif" alt="이용약관" name="Image96"  border="0" id="Image96" /></a></td>
		</tr>
		   <tr>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td><a href="/UserMember/Userprivate.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image97','','../img/sub/map_08_5.gif',1)"><img src="../img/sub/map_08_5off.gif" alt="개인정보보호정책" name="Image97"  border="0" id="Image97" /></a></td>
		</tr>
		   <tr>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td><a href="/UserMember/UserDel.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image98','','../img/sub/map_08_6.gif',1)"><img src="../img/sub/map_08_6off.gif" alt="회원탈퇴" name="Image98" border="0" id="Image98" /></a></td>
		</tr>
	  </table>
	  </td>
	</tr>
	<tr>
	  <td><img src="../img/sub/map_bot.gif" width="655" height="53" /></td>
	</tr>
  </table></td>
</tr>
<tr>
  <td >&nbsp;</td>
</tr>
<tr>
  <td height="30" align="right" >
	  <!-- search box -->          <!-- search box end -->      </td>
</tr>
<tr>
  <td >&nbsp;</td>
</tr>
</table>
<!-- ##### Contents // ##### -->
</div>
<!--#include virtual="/include/inc_footer.asp"-->