<script language="javascript">
	function goMouseOver(over){
		if(over == "sub1_1"){
			document.getElementById("sub1_1").style.display = "block";
			document.getElementById("ss1").style.color = "#07457d";
			document.getElementById("sub2_2").style.display = "none";
			document.getElementById("ss2").style.color = "#000000";
			document.getElementById("sub3_3").style.display = "none";
			document.getElementById("ss3").style.color = "#000000";
			document.getElementById("sub4_4").style.display = "none";
			document.getElementById("ss4").style.color = "#000000";
		}else if(over == "sub2_2"){
			document.getElementById("sub1_1").style.display = "none";
			document.getElementById("ss1").style.color = "#000000";
			document.getElementById("sub2_2").style.display = "block";
			document.getElementById("ss2").style.color = "#07457d";
			document.getElementById("sub3_3").style.display = "none";
			document.getElementById("ss3").style.color = "#000000";
			document.getElementById("sub4_4").style.display = "none";
			document.getElementById("ss4").style.color = "#000000";
		
		}else if(over == "sub3_3"){
			document.getElementById("sub1_1").style.display = "none";
			document.getElementById("ss1").style.color = "#000000";
			document.getElementById("sub2_2").style.display = "none";
			document.getElementById("ss2").style.color = "#000000";
			document.getElementById("sub3_3").style.display = "block";
			document.getElementById("ss3").style.color = "#07457d";
			document.getElementById("sub4_4").style.display = "none";
			document.getElementById("ss4").style.color = "#000000";
		
		}else if(over == "sub4_4"){
			document.getElementById("sub1_1").style.display = "none";
			document.getElementById("ss1").style.color = "#000000";
			document.getElementById("sub2_2").style.display = "none";
			document.getElementById("ss2").style.color = "#000000";
			document.getElementById("sub3_3").style.display = "none";
			document.getElementById("ss3").style.color = "#000000";
			document.getElementById("sub4_4").style.display = "block";
			document.getElementById("ss4").style.color = "#07457d";;	
		
		}
	}
	function goMouseOut(out){
		if(out == "sub1_1"){
			document.getElementById("sub1_1").style.display = "none";
			document.getElementById("ss1").style.color = "#000000";
		}else if(out == "sub2_2"){
			document.getElementById("sub2_2").style.display = "none";
			document.getElementById("ss2").style.color = "#000000";
		
		}else if(out == "sub3_3"){
			document.getElementById("sub3_3").style.display = "none";
			document.getElementById("ss3").style.color = "#000000";
		
		}else if(out == "sub4_4"){
			document.getElementById("sub4_4").style.display = "none";
			document.getElementById("ss4").style.color = "#000000";
		}
	}
</script>

				<table width="677" border="0" cellspacing="0" cellpadding="0">
					<tr id="navArea">
						<td  align="left"><a href="/mypage/mypage.asp" onMouseOver="goMouseOver('sub1_1');"><span id="ss1"><strong>학습현황</strong></span></a></td>
						<td><a href="/Mypage/Diary/List.asp" onMouseOver="goMouseOver('sub2_2')"><span id="ss2"><strong>영어일기</strong></span></a></td>
						<td><a href="/UserMember/UserModify.asp" onMouseOver="goMouseOver('sub3_3')"><span id="ss3"><strong>회원정보수정</strong></span></a></td>
						<td><a href="/SitePage/PCControl.asp" onMouseOver="goMouseOver('sub4_4')"><span id="ss4"><strong>원격지원센터</strong></span></a></td>
					</tr>
					<tr>
					<td colspan="4" height="35" style="display:none;">
					<table width="677" border="0" cellspacing="0" cellpadding="0">
					<tr id="sub1_1" class="sub" style="display:none;" onMouseOver="goMouseOver('sub1_1')" onMouseOut="goMouseOut('sub1_1')">
						<td colspan="4">
						<table>
						<tr>
						<td width="122" align="right"><a href="/Mypage/Mypage.asp" onMouseOver="this.style.color='#98cd34';" onMouseOut="this.style.color='#ffffff';">학습현황</a><img src="/img/sub_dote.gif"></td>
						<td><a href="/Mypage/ReportList.asp" onMouseOver="this.style.color='#98cd34';" onMouseOut="this.style.color='#ffffff';">나의성적표</a><img src="/img/sub_dote.gif"></td>
						<td><a href="/Mypage/Diary/List.asp" onMouseOver="this.style.color='#98cd34';" onMouseOut="this.style.color='#ffffff';">영어일기</a><img src="/img/sub_dote.gif"></td>
						<td><a href="/Mypage/Tomyteacher/List.asp" onMouseOver="this.style.color='#98cd34';" onMouseOut="this.style.color='#ffffff';">To. My Teacher</a></td>
						</tr>
						</table>
						</td>
					</tr>

					<tr id="sub2_2" class="sub"  style="display:none;" onMouseOver="goMouseOver('sub2_2')" onMouseOut="goMouseOut('sub2_2')">
						<td colspan="4">
						<table>
						<tr>
						<td width="298" align="right" class="text1"><a href="/ClassSystem/Introduce.asp" onMouseOver="this.style.color='#98cd34';" onMouseOut="this.style.color='#ffffff';">사이트소개</a><img src="/img/sub_dote.gif"></td>
						<td class="text1"><a href="/ClassSystem/Book01.asp" onMouseOver="this.style.color='#98cd34';" onMouseOut="this.style.color='#ffffff';">프로그램구성</a><img src="/img/sub_dote.gif"></td>
						<td class="text1"><a href="/Teacher/List.asp" onMouseOver="this.style.color='#98cd34';" onMouseOut="this.style.color='#ffffff';">강사소개</a></td>
						</tr>
						</table>
						</td>
					</tr>
					<tr id="sub3_3" class="sub"  style="display:none;" onMouseOver="goMouseOver('sub3_3')" onMouseOut="goMouseOut('sub3_3')">
						<td colspan="4">
						<table>
						<tr>
						<td width="386" align="right"><a href="/Contents/TodayEnglish/List.asp" onMouseOver="this.style.color='#98cd34';" onMouseOut="this.style.color='#ffffff';">오늘의 영어 한마디</a><img src="/img/sub_dote.gif"></td>
						<td><a href="/Contents/Expression/List.asp" onMouseOver="this.style.color='#98cd34';" onMouseOut="this.style.color='#ffffff';">유용한 표현</a><img src="/img/sub_dote.gif"></td>
						<td><a href="/Contents/JollyGoAdvance/List.asp" onMouseOver="this.style.color='#98cd34';" onMouseOut="this.style.color='#ffffff';">JollyGo Advance</a></td>
						</tr>
						</table>
						</td>
					</tr>
					<tr id="sub4_4" class="sub"  style="display:none;" onMouseOver="goMouseOver('sub4_4')" onMouseOut="goMouseOut('sub4_4')">
						<td colspan="4">
						<table>
						<tr>
						<td width="456" align="right"><a href="/SitePage/Videoguide.asp" onMouseOver="this.style.color='#98cd34';" onMouseOut="this.style.color='#ffffff';">화상영어가이드</a><img src="/img/sub_dote.gif"></td>
						<td><a href="/SitePage/FAQ/List.asp?bcode=B10" onMouseOver="this.style.color='#98cd34';" onMouseOut="this.style.color='#ffffff';">자주묻는질문</a><img src="/img/sub_dote.gif"></td>
						<td><a href="/SitePage/Programdownload.asp" onMouseOver="this.style.color='#98cd34';" onMouseOut="this.style.color='#ffffff';">프로그램 다운로드</a></td>
						</tr>
						</table>
						</td>
					</tr>
					</table>
					</td>
					</tr>
				</table>
			