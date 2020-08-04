<!--

function IntroVideo(url){
								document.write('<OBJECT ID="MMPlayer1"  classid="CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95" CODEBASE="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701" standby="Loading Microsoft Windows Media Player components..." type="application/x-oleobject" width="350" height="350">');
								document.write('<PARAM NAME="FileName" VALUE="' + url + '"> ');
								document.write('<PARAM NAME="ShowControls" VALUE="1">');
								document.write('<PARAM NAME="ShowStatusBar" VALUE="1"> ');
								document.write('<PARAM NAME="AutoRewind" VALUE="0"> ');
								document.write('<PARAM NAME="ShowDisplay" VALUE="0">');
								document.write('<PARAM NAME="DefaultFrame" VALUE="Slide">');
								document.write('<PARAM NAME="Autostart" VALUE="1">');
								document.write('<PARAM NAME="SendMouseClickEvents" VALUE="1">');
								document.write('<PARAM NAME="EnableContextMenu" value="false">');
								document.write('<PARAM NAME="TransparentAtStart" value="-1">');
								document.write('<PARAM NAME="AnimationAtStart" value="0">');
								document.write('<Embed type="application/x-mplayer2" pluginspage="http://www.microsoft.com/Windows/MediaPlayer/download/default.asp" src="' + url + '" Name=MMPlayer1 Autostart="1" ShowControls="0" ShowDisplay="0" ShowStatusBar="0" DefaultFrame="Slide"  AutoRewind="0" SendMouseClickEvents="1" EnableContextMenu="false" TransparentAtStart="-1" AnimationAtStart="0"></OBJECT>	');
}

// flashWrite(파일경로, 가로, 세로, 아이디, 배경색, 변수, 윈도우모드)
function ShowFlashView(url, width, height, zidx, wmode){
        document.write('<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="' + width + '" height="' + height + '" VIEWASTEXT Style="z-index:'+zidx+'">');
        document.write('<param name="movie" value="' + url + '">');
        document.write('<param name="quality" value="high">');
        document.write('<param name="wmode" value="' + wmode + '">');
        document.write('<param name="allowScriptAccess" value="always">');
        document.write('<embed src="' + url + '" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="' + width + '" height="' + height + '" allowScriptAccess="always"></embed>');
        document.write('</object>');
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function print_ok(){ //프린트
 print();
}



function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function MM_showHideLayers() { //v9.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) 
  with (document) if (getElementById && ((obj=getElementById(args[i]))!=null)) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}


function DetailView(Url,type_){
    window.open(Url,'DetailView',type_)
}

function MainMovie(UrlName){
//메인 동영상
document.write("<embed pluginspage='http://www.macromedia.com/go/getflashplayer' src='"+UrlName+"' width='407' height='365' type='application/x-shockwave-flash'> </embed>")
}
//-->
