<style>
	.download_list{margin-top: 20px;}
    .download_list ul li{display: inline-block; border:0px solid red; width:48%;}
	.download_list ul li img{width:100%;}
	.download_list ul li:hover{cursor:pointer;}
</style>
<%



MobilePath = Trim(siteconfigMobilePath&"")

%>

<script language="javascript">
function goProDown(){
	location.href="<%=VideoClassFile%>";
}

</script>

<div id="leftmenubox">


	<!-- ##### // 마이페이지 ##### -->

	<ul class="leftmenu">
		<img src="/img/sub/upsidedown_nav_title.png" class="lmenu" />
		<div class="leftwrap">
			<ul>
			<a href="/Mypage/Mypage.asp"><li <%IF sMenu="1" THEN%>class="menu_hover"<%END IF%>>학습현황</li></a>
			<a href="/SitePage/Videoguide.asp"><li <%IF sMenu="9" THEN%>class="menu_hover"<%END IF%>>화상영어가이드</li></a>
			<a href="/SitePage/FAQ/List.asp"><li <%IF sMenu="8" THEN%>class="menu_hover"<%END IF%>>자주묻는질문</li></a>
			<a href="/SitePage/Q&A/List.asp"><li <%IF sMenu="6" THEN%>class="menu_hover"<%END IF%>>묻고답하기</li></a>
			<a href="/SitePage/PCControl.asp"><li <%IF sMenu="7" THEN%>class="menu_hover"<%END IF%>>원격지원센터</li></a>
			<% If sUserid="" Then %>
			<a href="/UserMember/LoginPage.asp"><li <%IF sMenu="10" THEN%>class="menu_hover"<%END IF%>>로그인</li></a>
			<a href="/UserMember/UserRegistCheck.asp"><li <%IF sMenu="11" THEN%>class="menu_hover"<%END IF%>>회원가입</li></a>
			<a href="/MyPage/MyClassOrder.asp"><li <%IF sMenu="14" THEN%>class="menu_hover"<%END IF%>>수강신청</li></a>
			<% Else %>
			<a href="/UserMember/Logout.asp"><li <%IF sMenu="12" THEN%>class="menu_hover"<%END IF%>>로그아웃</li></a>
			<a href="/UserMember/UserModifyCheck.asp"><li <%IF sMenu="13" THEN%>class="menu_hover"<%END IF%>>회원정보수정</li></a>
			<a href="/MyPage/MyPageClassOrder.asp"><li <%IF sMenu="14" THEN%>class="menu_hover"<%END IF%>>수강신청</li></a>
			<% End If %>


			</ul>
		</div>

		<div class="download_list">
			<ul>
			 <a value="화상 프로그램 다운로드" onclick="javascript:goProDown();"><li><img src="/img/subimg/download_btnpc.png" alt="화상 프로그램 다운로드"/></li></a>
			<a href="<%=MobilePath%>" ><li><img src="/img/subimg/download_btnmobile.png" alt="화상 프로그램 다운로드"/></li></a>
			</ul>
		</div>
		

	</ul>

	<!-- ##### 마이페이지 // ##### -->

	<!-- ##### 학습 시스템 // ##### -->

	<ul style="padding:0;">
		<!--include virtual="/include/inc_banner.asp" -->
	</ul>
</div>
