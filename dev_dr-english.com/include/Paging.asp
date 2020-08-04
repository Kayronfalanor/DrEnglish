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

<%
function showPrev()
	dim str
    str = ""

    if startPage > 1 then
    	str = "<a href=""#"" style=""text-decoration: none;"" onclick=""$common.goPage('" & (startPage - 1) & "')"">&laquo;</a> &nbsp; "
    else
        str = "<a href=""#"">&laquo;</a> &nbsp; "
    end if

    showPrev  = str
end function


function showPage()
	dim str
    str = ""

    for iFor = startPage to endPage
        if iFor&"" = currPage&"" then
            str = str & "<a href=""#"" class=""active"">"& iFor &"</a>"
        else
            str = str & "<a href=""#"" style=""text-decoration: none;"" onclick=""$common.goPage('" & iFor & "')"">" & iFor & "</a>"
        end If
        
		If iFor < endPage Then
			Str = Str 
		End If
    next

    showPage = str
end function

function showNext()
    dim str
    str = ""


    if endPage < compareEndPage then
        str = " &nbsp; <a href=""#"" style=""text-decoration: none;"" onclick=""$common.goPage('" & (endPage + 1) & "');"">&raquo;</a>"
    else
        str = " &nbsp; <a href=""#"">&raquo;</a>"
    end if

    showNext = str
end function

%>

<div class="pagination_wrap">
		<div class="pagination">
          <%=showPrev() & showPage() & showNext() %>	
        </div>
</div>

