function pni_goFlashUrl(P_Lcod, P_Mcod )
{

	var pageUrl;
	var strMsg;
	var strSitePath = "";
	var alertchk = 0;

	strMsg = "잘못된 페이지 코드입니다!";
	if( P_Lcod.length == 2 && P_Mcod.length == 2 )
	{
		switch(P_Lcod)
		{
			// 홈
			case "00" : 
				switch (P_Mcod)
				{
					case "00" : pageUrl = "/"; break;
				}
			break;
			// 마이노트
			case "01" : 
				switch (P_Mcod)
				{
					case "01" : pageUrl = "/Mypage/Mypage.asp"; break;
					case "02" : pageUrl = "/Mypage/ReportList.asp"; break;
					case "03" : pageUrl = "/Mypage/Diary/List.asp"; break;
					case "04" : pageUrl = "/Mypage/Tomyteacher/List.asp"; break;
				}
			break;				
			// 학습시스템
			
			case "02" :

				switch (P_Mcod)
				{
					case "01" : pageUrl = "/ClassSystem/TestClass.asp"; break;
					case "02" : pageUrl = "/ClassSystem/ClassSystem.asp"; break;
					case "03" : pageUrl = "/ClassSystem/Program.asp"; break;
					case "04" : pageUrl = "/ClassSystem/Book01.asp";break;
					case "05" : pageUrl = "/ClassSystem/Espt.asp"; break;
				}
			break;	
			// 수강신청
			case "03" :
				switch (P_Mcod)
				{
					case "01" : pageUrl = "/OrderPage/Information.asp"; break;
					case "02" : pageUrl = "/OrderPage/Application01.asp"; break;
					case "03" : pageUrl = "/Mypage/Leveltest.asp"; break;
					case "04" : pageUrl = "/OrderPage/FreeApplication.asp"; break;
					case "05" : pageUrl = "/OrderPage/policyClass.asp"; break;
				}
			break;	
			// 콘텐츠
			case "04" :
				switch (P_Mcod)
				{
					case "01" : pageUrl = "/Contents/TodayEnglish/List.asp"; break;
					case "02" : pageUrl = "/Contents/Expression/List.asp"; break;
					case "03" : pageUrl = "/Contents/JollyGoAdvance/List.asp"; break;
					case "04" : pageUrl = "/Contents/EnglishTyping.asp"; break;
					case "05" : pageUrl = "/Contents/SpeedQuiz.asp"; break;
					case "06" : pageUrl = "/Contents/ContentsNexus/index.asp"; break;
				}
			break;	
			// 커뮤니티
			case "05" :
				switch (P_Mcod)
				{
					case "01" : pageUrl = "/community/ClassAfter/List.asp"; break;
					case "02" : pageUrl = "/community/MotherTalks/List.asp"; break;
					case "03" : pageUrl = "/community/EnglishCamp/List.asp"; break;
					case "04" : pageUrl = "/community/EnglishCampPhoto/List.asp"; break;
					case "05" : pageUrl = "/community/LanguageGame/List.asp"; break;
					case "06" : pageUrl = "/community/TalkTalk/List.asp"; break;
				}
			break;	
			// 고객지원
			case "06" :
				switch (P_Mcod)
				{
					case "01" : pageUrl = "/SitePage/Videoguide.asp"; break;
					case "02" : pageUrl = "/SitePage/Notice/List.asp"; break;
					case "03" : pageUrl = "/SitePage/SpecialEvent.asp"; break;
					case "04" : pageUrl = "/SitePage/News/List.asp"; break;
					case "05" : pageUrl = "/SitePage/FAQ/List.asp"; break;
					case "06" : pageUrl = "/SitePage/Q&A/List.asp"; break;
					case "07" : pageUrl = "/SitePage/Programdownload.asp"; break;
				}
			break;		
		}

		if (alertchk==0){
			location.href=strSitePath+pageUrl;
		}

	} else{
	
		//alert(strMsg);
		return;
	}
	
	
}


function pni_postFlashUrl(P_Lcod)
{
if(P_Lcod=="04"){
window.open('http://www.imfill.co.kr/mbc/','','')
}
if(P_Lcod=="03"){
location.href="/Mypage/Leveltest.asp"
}
if(P_Lcod=="02"){
location.href="/ClassSystem/TestClass.asp"
}
if(P_Lcod=="01"){
location.href="/Contents/ContentsNexus/index.asp"
}
if(P_Lcod=="00"){
location.href="/SitePage/Sitemap.asp"
}
}

function pni_noteFlashUrl(P_Lcod)
{
if(P_Lcod=="03"){
location.href="/Company/Companypartnership.asp"
}
if(P_Lcod=="02"){
location.href="/Company/CompanyPr.asp"
}
if(P_Lcod=="01"){
location.href="/Company/Companyintro.asp"
}
}


function pni_keyFlashUrl(P_Lcod)
{
if(P_Lcod=="01"){
location.href="/SitePage/FAQ/List.asp"
}
if(P_Lcod=="02"){
location.href="/SitePage/Q&A/List.asp"
}
if(P_Lcod=="03"){
location.href="/SitePage/Programdownload.asp"
}
if(P_Lcod=="04"){
location.href="/ClassSystem/Espt.asp"
}
if(P_Lcod=="05"){
location.href="/SitePage/PCControl.asp"
}
if(P_Lcod=="06"){
location.href="/SitePage/Notice/List.asp"
}
if(P_Lcod=="07"){
location.href="/Mypage/Mypage.asp"
}
}




function strBanner(width,height,strUrl,P_Lcod,P_Mcod){
  document.write("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0\" width=\""+width+"\" height=\""+height+"\">");
  document.write("<param name=\"flashVars\" value=\"P_Lcod="+P_Lcod+"&P_Mcod="+P_Mcod+"\">");
  document.write("<param name=\"movie\" value=\""+strUrl+"?P_Lcod="+P_Lcod+"&P_Mcod="+P_Mcod+"\">");
  document.write("<param name=\"quality\" value=\"high\">");
  document.write("<param name=\"wmode\" Value=\"Transparent\">");
  document.write("<embed src=\""+strUrl+"\" quality=\"high\" pluginspage=\"http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash\" type=\"application/x-shockwave-flash\" width=\""+width+"\" height=\""+height+"\"></embed>");
  document.write("</object>");
}
