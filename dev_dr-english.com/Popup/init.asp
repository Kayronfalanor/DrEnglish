<%
If IsArray(arrPop) Then
'0.nvcPopupTop, 1.nvcPopupLeft, 2.nvcPopupWidth, 3.nvcPopupHeight, 4.nvcPopupImage, 5.siType
With Response
	.Write "<form name='popupform' method='post' action='/popup/'>" & vbCrlf
	.Write "<input type='hidden' name='pop_name'	value='' />" & vbCrlf
	.Write "<input type='hidden' name='pop_img'		value='' />" & vbCrlf
	.Write "</form>" & vbCrlf

	.Write "<ul class='csspopup' style='display:none;'>" & vbCrlf
	For i = 0 To Ubound(arrPop, 2)
		.Write "	<li data-top='"& arrPop(0, i) &"' data-left='"& arrPop(1, i) &"' data-width='"&  arrPop(2, i)  &"' data-height='"& CLng(arrPop(3, i)&"")+40 &"' data-type='"& arrPop(5, i) &"' data-name='popup_"& i &"' data-path='"& lms_file_url&"popup/'>"& arrPop(4, i) &"</li>" & vbCrlf
	Next
	.Write "</ul>" & vbCrlf
End With
End If
%>