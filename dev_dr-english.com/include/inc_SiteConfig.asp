<%

	'#####################  화상프로그램 연동 ##############################

If InStr(Request.ServerVariables("HTTP_USER_AGENT"),"iPod") Or InStr(Request.ServerVariables("HTTP_USER_AGENT"),"iPhone") Or InStr(Request.ServerVariables("HTTP_USER_AGENT"),"iPad") Or InStr(Request.ServerVariables("HTTP_USER_AGENT"),"Macintosh") Then
	BrowseFlag="IOS"
	MobileFlag="IOS"
End If

If InStr(Request.ServerVariables("HTTP_USER_AGENT"),"Android")  Then
	BrowseFlag="Android"
	MobileFlag=""
End If



Set oDOM = Server.CreateObject("Microsoft.XMLDOM")
With oDOM
    .async = False '
    .setProperty "ServerHTTPRequest", True ' HTTP XML
    .Load("http://siteconfig.inetstudy.co.kr/ClassConfig/mobileapk.asp?CompanyCode="&SiteCPCode & "&MobileFlag="&MobileFlag)
End With

Set Nodes = oDOM.getElementsByTagName("row")

	For Each SubNodes In Nodes
		siteconfigMobilePath= SubNodes.getElementsByTagName("mobilepath")(0).Text
		siteconfigpcPath= SubNodes.getElementsByTagName("pcpath")(0).Text
		siteconfiginstallerurl = SubNodes.getElementsByTagName("installerurl")(0).Text
		siteconfigserverip = SubNodes.getElementsByTagName("serverip")(0).Text
		'servermaxuser = SubNodes.getElementsByTagName("servermaxuser")(0).Text
		'siteconfigaccountname = SubNodes.getElementsByTagName("accountname")(0).Text
		siteconfigpcversion = SubNodes.getElementsByTagName("pcversion")(0).Text
		siteconfigmobileversion = SubNodes.getElementsByTagName("mobileversion")(0).Text
	Next

Set Nodes=nothing
Set oDOM=Nothing

		isSiteConfigyn = "Y"
		

		if isSiteConfigyn ="Y" then

			VideoClassFile = siteconfigpcPath
			'
			If BrowseFlag="Android" THEN
				'VideoClassURL = "http://siteconfig.inetstudy.co.kr/ClassConfig/MobileLink.asp"
				siteconfigversion = siteconfigmobileversion
			END iF
			'
			IF BrowseFlag="IOS" Then
			'	VideoClassURL = "http://siteconfig.inetstudy.co.kr/ClassConfig/MobileLink.asp"
				siteconfigversion = siteconfigmobileversion
			END iF
			'
			If BrowseFlag <> "Android" AND BrowseFlag <> "IOS" THEN
			'	VideoClassURL = "http://siteconfig.inetstudy.co.kr/ClassConfig/VideoLink.asp"
				siteconfigversion = siteconfigpcversion
			End If
		end If
%>