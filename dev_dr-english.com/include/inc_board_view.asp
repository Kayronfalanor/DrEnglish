<script language="javascript" src="/Commonfiles/Scripts/embeded.js"></script>
<%
Dim sfile1_ext, sfile2_ext
If sfile1 <> "" Then
	sfile1_ext = LCASE(MID(sfile1,instrrev(sfile1,".")+1))

	Call setAttachFileTag(sfile1_ext, sfile1)

ElseIf sfile2 <> "" Then
	sfile2_ext = LCASE(MID(sfile2,instrrev(sfile2,".")+1))

	Call setAttachFileTag(sfile1_ext, sfile1)

End If

Sub setAttachFileTag(ext, file)
	Dim html : html = ""

	html = "<div align='center'>"
	Select Case(ext)
		Case "gif", "jpg", "jpeg", "png", "bmp" :
			html = html & "<img src='"& BBSURL(CInt(Right(bcode, 2))) & file &"' border='0' width='600'>"

		Case "swf" :
			html = html & "<object classid=""clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"" codebase=""http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0"" width=""200"" id=""MMPlayer0"">"
			html = html & "<param name=""movie"" value="""& BBSURL(CInt(Right(bcode, 2))) & file &""">"
			html = html & "<embed src="""& BBSURL(CInt(Right(bcode, 2))) & file &""" width=""200"" quality=""high"" pluginspage=""http://www.macromedia.com/go/getflashplayer"" type=""application/x-shockwave-flash""></embed>"
			html = html & "</object>"

		Case "asf", "wmv", "mpeg", "avi", "mp3", "wav" : 
			html = html & "<OBJECT ID=""MMPlayer1""  classid=""CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95"" CODEBASE=""http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701"" standby=""Loading Microsoft Windows Media Player components..."" type=""application/x-oleobject"">"
			html = html & "<PARAM NAME=""FileName""				VALUE="""& BBSURL(CInt(Right(bcode, 2))) & file &""">"
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
			html = html & "<Embed type=""application/x-mplayer2"" pluginspage=""http://www.microsoft.com/Windows/MediaPlayer/download/default.asp"" src="""& BBSURL(CInt(Right(bcode, 2))) & file &""" Name=MMPlayer1 Autostart=""1"" ShowControls=""0"" ShowDisplay=""0"" ShowStatusBar=""0"" DefaultFrame=""Slide""  AutoRewind=""0"" SendMouseClickEvents=""1"" EnableContextMenu=""false"" TransparentAtStart=""-1"" AnimationAtStart=""0"">"
			html = html & "</OBJECT>"
		Case Else
			html = html & "<br><a href='" & BBSURL(CInt(Right(bcode, 2))) & file & "' target='_blank'><font color=blue><u>" &  file  & "</u></font></a><br><br>"
	End Select
	html = html & "</div>"

	Response.Write html
End Sub
%>