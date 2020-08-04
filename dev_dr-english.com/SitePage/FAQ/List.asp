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
Dim sMenu : sMenu = "8"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<!--#include file="Inc.asp" -->

<%
Dim Ftype : Ftype = sqlCheck(Replace(Request("ftype"), "'", "''"))
Ftypeseq = sqlCheck(Replace(Request("Ftypeseq"), "'", "''"))
If Len(Ftype) = 0 Then
	Ftype = "F02"
End If

If Len(Ftypeseq) = 0 Then
	Ftypeseq = "0"
End If

PageSize = 100

'##### FAQ TOP 100 불러와 카테고리별로 출력'
Dim Sql, arrData
Sql = "PRC_tb_Board_Select_List N'"& bcode &"', N'"& SiteCPCode &"', N'"& strColumn &"', N'"& searchStr &"', '1', '"& PageSize &"', N'S'"
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrData = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing
Call DBClose()



'##### FAQ 카테고리 가져오기
Dim arrFtype : arrFtype = getCommCode("FAQ", "B10", True)



Sub setAttachFileTagView(ext, file,nvcCPCode)
	Dim html : html = ""
	'If Len(Trim(strCPCode)) > 0 Then
		bburl1 = BBSURL(CInt(Right(bcode, 2)))
	'Else 
	'	bburl1 = BBSURL(14) 
	'End If 
	html = ""
	Select Case(ext)
		Case "gif", "jpg", "jpeg", "png", "bmp" :
			html = html & "<img src='"& lms_file_url& "Board/" & nvcCPCode &"/"& bcode & "/" & file &"' border='0' width='100%'>"

		Case "swf" :
			html = html & "<object classid=""clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"" codebase=""http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0"" width=""200"" id=""MMPlayer0"">"
			html = html & "<param name=""movie"" value="""& lms_file_url& "Board/" & nvcCPCode &"/"& bcode & "/" & file &""">"
			html = html & "<embed src="""& lms_file_url& "Board/" & nvcCPCode &"/"& bcode & "/"  & file &""" width=""200"" quality=""high"" pluginspage=""http://www.macromedia.com/go/getflashplayer"" type=""application/x-shockwave-flash""></embed>"
			html = html & "</object>"

		Case "asf", "wmv", "mpeg", "avi", "mp3", "wav" : 
			html = html & "<OBJECT ID=""MMPlayer1""  classid=""CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95"" CODEBASE=""http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701"" standby=""Loading Microsoft Windows Media Player components..."" type=""application/x-oleobject"">"
			html = html & "<PARAM NAME=""FileName""				VALUE="""& lms_file_url& "Board/" & nvcCPCode &"/"& bcode & "/"  & file &""">"
			html = html & "<PARAM NAME=""ShowControls""			VALUE=""1"">"
			html = html & "<PARAM NAME=""ShowStatusBar""		VALUE=""1"">"
			html = html & "<PARAM NAME=""AutoRewind""			VALUE=""0"">"
			html = html & "<PARAM NAME=""ShowDisplay""			VALUE=""0"">"
			html = html & "<PARAM NAME=""DefaultFrame""			VALUE=""Slide"">"
			html = html & "<PARAM NAME=""Autostart""			VALUE=""1"">"
			html = html & "<PARAM NAME=""SendMouseClickEvents""	VALUE=""1"">"
			html = html & "<PARAM NAME=""EnableContextMenu""	value=""false"">"
			html = html & "<PARAM NAME=""TransparentAtStart""	value=""-1"">"
			html = html & "<PARAM NAME=""AnimationAtStart""		value=""0"">"
			'아래는 네스케이프 사용자를 위해 <embed>태그 추가-->
			html = html & "<Embed type=""application/x-mplayer2"" pluginspage=""http://www.microsoft.com/Windows/MediaPlayer/download/default.asp"" src="""& lms_file_url& "Board/" & nvcCPCode &"/"& bcode & "/"  & file &""" Name=MMPlayer1 Autostart=""1"" ShowControls=""0"" ShowDisplay=""0"" ShowStatusBar=""0"" DefaultFrame=""Slide""  AutoRewind=""0"" SendMouseClickEvents=""1"" EnableContextMenu=""false"" TransparentAtStart=""-1"" AnimationAtStart=""0"">"
			html = html & "</OBJECT>"
		Case Else
			html = html & "<br><a href='" & lms_file_url& "Board/" & nvcCPCode &"/"& bcode & "/"  & file & "' target='_blank'><font color=blue><u>" &  file  & "</u></font></a><br><br>"
	End Select
	html = html & ""

	Response.Write html
End Sub

%>
<!--#include virtual="/include/inc_top.asp"-->
<script type="text/javascript" src="/Commonfiles/Scripts/sitepage.js"></script>
<script type="text/javascript">
	//$(document).ready(function() { $site.faq.init.call(this); });
</script>
	
	<!--아코디언스크립트-->
<script type="text/javascript">
$(document).ready(function(){
	
	//$(".accordion h3:first").addClass("active");
	//$(".accordion p:not").hide();
	//$(".accordion p:not").hide();

	$(".accordion h3").click(function(){
		$(this).next("div").slideToggle("slow").siblings("div:visible").slideUp("slow");
		$(this).toggleClass("active");
		$(this).siblings("h3").removeClass("active");
		//$(this).next("p").next("p:not").show();
	});

});

function fn_gofaq(ac,ftseq)
{	
	document.fm1.Ftype.value = ac;
	document.fm1.Ftypeseq.value = ftseq;
	document.fm1.action = "List.asp";
	document.fm1.submit();
}


</script>
	
	<style>
	 
.accordion {
	width: 100%;
	margin-top: 20px;
	border:none;
}
.accordion h3 {
	border-radius: 50px;
	padding: 10px 15px;
	margin: 10px 0;
	font-size: 17px;
	font-weight: 500;
	border-bottom: none;
	cursor: pointer;
	background-color: #eee;
}
.accordion h3:hover {
	background-color: #666; color:#fff;transition-duration: 0.3s;
}
.accordion h3.active {
	background-position: right 5px;
}
/*.accordion p {
	background: #f7f7f7;
	margin: 10px 0 ;
	border:none;
	padding: 10px 15px 20px;
}*/
	</style>
	
<form name="fm1" id="fm1" method="post">
<input type="hidden" name="Ftype" id="Ftype" value="<%=Ftype%>">
<input type="hidden" name="Ftypeseq" id="Ftypeseq" value="">
</form>
	
<div class="contents_right">
	<div><img src="/img/subimg/title_5.png" alt="화상영어가이드 "/></div>
	
	<div style="margin-top: 20px;">
	  <ul data-tabscrollnavcontainer class="tab_ul">
			
    <li> <a href="javascript:fn_gofaq('F02','0');" class="tab_a" >수강 관련</a> </li>	
    <li> <a href="javascript:fn_gofaq('F04','1');" class="tab_a" >시스템 관련</a> </li>
	<li> <a href="javascript:fn_gofaq('F01','2');" class="tab_a">사이트 관련</a> </li>    
    <li> <a href="javascript:fn_gofaq('F05','3');" class="tab_a">기타</a> </li>

  </ul>
		
   <article>
    <section >
      <p ><!--#include file="faq_detail.asp" --></p>
    </section>
  </article>
		
		
		
<!--<script src="/Commonfiles/Scripts/tabscroll.js"></script>-->
<script type="text/javascript">

function setUpPage(ac) {

    // finds all anchor tabs within the data-tabscrollnavcontainer
    $tabscroll_anchors = $("[data-tabscrollnavcontainer]").find("a");
    
    // adds the active class to the first tab-navigation
    $($tabscroll_anchors[ac]).parent().addClass("tabscroll_activeNavi");

    for ($i = 0; $i < $tabscroll_anchors.length; $i++){
        
        // targets each and every link's href-attribute found within the tabscrollnavcontainer
        var $eachAnchor = $($tabscroll_anchors[$i]).attr("href");
    
        // adds the navigational data-attribute to each anchor tag's parent
        $($tabscroll_anchors[$i]).parent().attr("data-tabscrollnavi", $eachAnchor.substring(1))  
        
        // we then use this anchor to find each element, section, etc. that has the 
        // same ID as the anchor tag we found.
        
        // sets a custom data-tabscroll attribute to each section that correspons
        // with the link in the navigation, stripping off the # (substring)
        $($eachAnchor).attr("data-tabscroll", $eachAnchor.substring(1));
    }    
}

setUpPage('<%=Ftypeseq%>');

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-36251023-1']);
  _gaq.push(['_setDomainName', 'jqueryscript.net']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
	</div>
	
</div>
<!--#include virtual="/include/inc_footer.asp"-->