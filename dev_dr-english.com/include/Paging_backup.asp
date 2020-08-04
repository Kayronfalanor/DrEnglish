<%
    ''//해당 블럭에서 첫번째 페이지 번호와 마지막 페이지번호를 구한다

    tmpPage = clng(ceil((CLng(currPage) - 1), CLng(pageSize))) + 1
    startPage = (tmpPage - 1) * CLng(pageSize) + 1
    endPage = startPage + CLng(pageSize) - 1
	compareEndPage = TotalPage
    if clng(endPage) > clng(compareEndPage) then
        endPage = compareEndPage
    end if

%>

<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td align="center" style="padding-top:5">
        <%=showPrev() & showPage() & showNext() %>	
        </td>
    </tr>
</table>


<%
function showPrev()
	dim str
    str = ""

    if startPage > 1 then
    	str = "<a href=""#"" style=""text-decoration: none;"" onclick=""$common.goPage('" & (startPage - 1) & "')""><img src=""/img/board/btn_fir.gif""  style=""border:0;"" alt=""이전페이지"" align='absmiddle' /></a> &nbsp; "
    else
        str = "<img src=""/img/board/btn_fir.gif""  style=""border:0;"" alt=""이전페이지"" align='absmiddle' /> &nbsp; "
    end if

    showPrev  = str
end function


function showPage()
	dim str
    str = ""

    for iFor = startPage to endPage
        if iFor&"" = currPage&"" then
            str = str & "<font color=""tomato""><strong>"& iFor &"</strong></font>"
        else
            str = str & "<a href=""#"" style=""text-decoration: none;"" onclick=""$common.goPage('" & iFor & "')"">" & iFor & "</a>"
        end If
        
		If iFor < endPage Then
			Str = Str & "&nbsp; | &nbsp;"
		End If
    next

    showPage = str
end function

function showNext()
    dim str
    str = ""


    if endPage < compareEndPage then
        str = " &nbsp; <a href=""#"" style=""text-decoration: none;"" onclick=""$common.goPage('" & (endPage + 1) & "');""><img src=""/img/board/btn_end.gif"" align='absmiddle' style='border:0;' alt=""다음페이지"" /></a>"
    else
        str = " &nbsp; <img src=""/img/board/btn_end.gif"" style='border:0;' alt=""다음페이지"" align='absmiddle' />"
    end if

    showNext = str
end function

%>