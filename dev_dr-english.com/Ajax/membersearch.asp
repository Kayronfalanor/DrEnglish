<%@Codepage=65001%>
<%
	Response.CharSet = "utf-8"
    Session.CodePage = 65001
    
    Response.AddHeader "Pragma","no-cache"
    Response.AddHeader "Expires","0"

	docstat="3"
%>
<!--#include virtual="/commonfiles/Session/Admin_Session/AdminSessionClose.asp" -->
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<!--#include virtual="/commonfiles/DBINCC/commFunction.asp" -->
<%
    strMember = sqlCheck(Trim(replace(request("searchmem"),"'","''")))
	
	If strMember <> "" then
		sql = "exec PRC_tb_Member_Select_SearchData N'" & strMember & "', '1', N'', N''"

		Set Rs = dbSelect(sql)

		if Not (Rs.Eof and Rs.Bof) then
			arrData = Rs.getrows
		end if

		Rs.close
		Set Rs = Nothing
	End if
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp"--> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><%=adminTitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link type="text/css" rel="stylesheet" href="/Commonfiles/ETC/Acss.css"  >
<script type="text/javascript" src="/Commonfiles/Script/jQuery/jquery-1.7.2.min.js"></script>
<script language="javascript">
	self.focus();

	function PIC2(sday,sdy2) 
	{ 
		parent.fv.strMemberSeq.value=sday;
		parent.fv.strMemberName.value=sdy2;
		parent.f_cal_hidden();

	}

	function f_window_close(arg)
	{
		parent.f_cal_hidden();
	}

	function ccheck()
	{
		if (f.searchmem.value=="")
		{
			alert("회원아이디 or 회원명을 2자 이상 입력하세요.");
			f.searchmem.focus();
			return;
		}

		if (f.searchmem.value.length < 3 )
		{
			alert("회원아이디 or 회원명을 2자 이상 입력하세요.");
			f.searchmem.focus();
			return;
		}

		f.submit();
	
	}
</script>
</head>
<body leftmargin=0 topmargin=0>
<%If strMember <> "" then%>

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td height="14"><img src="/adminclass/AdminImage/PopUpBoxtopLeft.gif" width="13" height="14"></td>
                <td width="100%" background="/adminclass/AdminImage/PopUpBoxtopBG.gif" height="14"></td>
                <td height="14"><img src="/adminclass/AdminImage/PopUpBoxtopright.gif" width="13" height="14"></td>
            </tr>
            <tr>
                <td background="/adminclass/AdminImage/PopUpBoxrightBG.gif">&nbsp;</td>
                <td align="center" valign="top">
                    <table width="350" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr> 
                            <td align="center" valign="top">
                                <table width="350" border=0 cellpadding=0 cellspacing=1 bgcolor="#dddddd"  style="font-size:8pt">
									<form name="f" id="f" method="post" action="membersearch.asp">
                                    <tr bgcolor="#eeeeee">
                                        <td>
                                            <input type="text" name="searchmem" id="searchmem" value="<%=strMember%>"/>
                                            <img src="/adminclass/AdminImage/ListSearchSubmit.gif" id="searchBtn" style="cursor:hand" border=0 onclick="return ccheck();"/>
                                        </td>
                                    </tr>
									</form>
                                </table>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr><td height="5"></td></tr>
                                </table>
								<div style="height:270px; border-width:1px; border-style: solid;overflow:scroll; overflow-x:hidden">
                                <table width="350" border=0 cellpadding=0 cellspacing=0 bgcolor="#FFFFFF"> 
								<tr>
                                        <td bgcolor=efefef height=24 align=center>아이디</td>
										<td bgcolor=efefef height=24 align=center>이름</td>
										<td bgcolor=efefef height=24 align=center>연락처</td>
                                    </tr>
                                   <%  
										if isArray(arrData) = false then
									%>
									<tr>
                                        <td colspan=3 align=center height=20>검색된 회원이 없습니다.</td>
                                    </tr>
									<%Else
									maxLen = ubound(arrData, 2)        
										for iFor = 0 to maxLen
									%>

									<tr>
                                        <td height=20 align=center><a href="javascript:PIC2('<%=arrData(0,iFor)%>','<%=arrData(1,iFor)%>');"><%=arrData(2,iFor)%></a></td>
										<td align=center><a href="javascript:PIC2('<%=arrData(0,iFor)%>','<%=arrData(1,iFor)%>');"><%=arrData(1,iFor)%></a></td>
										<td align=center><a href="javascript:PIC2('<%=arrData(0,iFor)%>','<%=arrData(1,iFor)%>');"><%=arrData(3,iFor)%></a></td>
                                    </tr>
									<%
										next
									
									End if%>
                                    
                                </table>
								</div>
                            </td>
                        </tr>
                    </table>
                </td>
                <td background="/adminclass/AdminImage/PopUpBoxLeftBG.gif">&nbsp;</td>
            </tr>
            <tr>
                <td  height="31"><img src="/adminclass/AdminImage/PopUpBoxbottomLeft.gif" width="13" height="31"></td>
                <td height="31" align="right" valign="bottom" background="/adminclass/AdminImage/PopUpBoxbottomBG.gif">
                     <a href="javascript:f_window_close();"><img src="/Adminclass/AdminImage/PopUpBoxclose.gif" width="93" height="22" border="0"></a>
                </td>
                <td height="31"><img src="/adminclass/AdminImage/PopUpBoxbottomright.gif" width="13" height="31"></td>
            </tr>
        </table>

<%else%>
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td height="14"><img src="/adminclass/AdminImage/PopUpBoxtopLeft.gif" width="13" height="14"></td>
                <td width="100%" background="/adminclass/AdminImage/PopUpBoxtopBG.gif" height="14"></td>
                <td height="14"><img src="/adminclass/AdminImage/PopUpBoxtopright.gif" width="13" height="14"></td>
            </tr>
            <tr>
                <td background="/adminclass/AdminImage/PopUpBoxrightBG.gif">&nbsp;</td>
                <td align="center" valign="top">
                    <table width="350" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr> 
                            <td align="center" valign="top">
                                <table width="350" border=0 cellpadding=0 cellspacing=1 bgcolor="#dddddd"  style="font-size:8pt">
									<form name="f" id="f" method="post" action="membersearch.asp">
                                    <tr bgcolor="#eeeeee">
                                        <td>
                                            <input type="text" name="searchmem" id="searchmem" />
                                             <img src="/adminclass/AdminImage/ListSearchSubmit.gif" id="searchBtn" style="cursor:hand" border=0 onclick="return ccheck();"/>
                                        </td>
                                    </tr>
									</form>
                                </table>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr><td height="5"></td></tr>
                                </table>
                                <table width="350" border=0 cellpadding=0 cellspacing=0 bgcolor="#FFFFFF">
                                    <tbody> 
                                    <tr>
                                        <td><div style="height:270px; border-width:1px; border-style: solid;"><ul style="width: 100%; list-style:none" id="memList"><li>아이디 OR 회원명 OR CTN(-포함) OR 연락처(-포함)로 <br>검색해주세요.</li></ul></div></td>
                                    </tr>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td background="/adminclass/AdminImage/PopUpBoxLeftBG.gif">&nbsp;</td>
            </tr>
            <tr>
                <td  height="31"><img src="/adminclass/AdminImage/PopUpBoxbottomLeft.gif" width="13" height="31"></td>
                <td height="31" align="right" valign="bottom" background="/adminclass/AdminImage/PopUpBoxbottomBG.gif">
                   <a href="javascript:f_window_close();"><img src="/Adminclass/AdminImage/PopUpBoxclose.gif" width="93" height="22" border="0"></a>
                </td>
                <td height="31"><img src="/adminclass/AdminImage/PopUpBoxbottomright.gif" width="13" height="31"></td>
            </tr>
        </table>
<%End if%>
</body>
</html>
 <%
If Err.Number <> 0 Then
	
	Errornumcheck="1"
	OMSService_type="LM16"
	OMSRESULT_STATUS="2"  ' 1:성공 2: 실패 
	OMSRESULT_CODE="LMS500" '0:성공   LMS400 , LMS401 , LMS403 은 따로 처리
	Else
	Errornumcheck="1"
	OMSService_type="LM16"
	OMSRESULT_STATUS="1"  ' 1:성공 2: 실패 
	OMSRESULT_CODE="0" '0:성공   LMS400 , LMS401 , LMS403 은 따로 처리
	End IF

%>
<!--#include virtual="/adminclass/Etcincc/OMS_Log.asp"-->
<%
	Errornumcheck="0"
	Err.Clear
%>



