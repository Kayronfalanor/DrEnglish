<%
    bcode = sqlCheck(replace(request("bcode"),"'","''"))            ''//bcode
    siFaqType = sqlCheck(replace(request("siFaqType"),"'","''"))    ''//siFaqType
    if session("CPPermission") = False then ''수강업체문의만 가능
        siFaqType = "7"
    end if

    iCourseSeq = sqlCheck(replace(request("iCourseSeq"),"'","''"))  ''//과목
    SearchVal01 = sqlCheck(replace(request("SearchVal01"),"'","''"))''//질문유형 or 항목
    nvcCPCode = sqlCheck(replace(request("nvcCPCode"),"'","''"))    ''//CP
    if SESSION("CPPermission") = False then
        nvcCPCode = SESSION("AdminCP")
    end if


    strColumn = sqlCheck(Request("strColumn"))                          ''//검색 field
    searchStr = sqlCheck(replace(request("searchStr"),"'","''"))        ''//검색어
    currPage = sqlCheck(replace(request("currPage"),"'","''"))          ''//현재페이지
    if currPage = "" then
        currPage = "1"
    end If
    currPage = CInt(currPage)

    sortField = sqlCheck(replace(request("sortField"),"'","''"))        ''//sortField
    if bcode ="B03" then
        if sortField = "" then
             sortField = "nvcEventUrl"
        end if
    end if

    sortMethod = sqlCheck(replace(request("sortMethod"),"'","''"))      ''//sortMethod
    if sortMethod&"" = "" then
        sortMethod = "Desc"
    end if

    seq       = sqlCheck(replace(request("seq"),"'","''"))              ''//seq

    rowSize = 20   ''//페이지에 보여지는 Row
    pageSize = 10  ''//하단의 페이지 수

    commentrowSize = 10   ''//댓글 페이지에 보여지는 Row
    commentpageSize = 10  ''//댓글 하단의 페이지 수

    commentPage = sqlCheck(replace(request("commentPage"),"'","''"))          ''//현재페이지
    if commentPage = "" then
        commentPage = "1"
    end If    

	Dim strParam : strParam = "?bcode="& bcode &"&currpage="& page &"&strColumn="& strColumn &"&searchStr="& searchStr

	returnParam = strParam
%>