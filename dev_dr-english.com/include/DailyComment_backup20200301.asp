<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = False
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
	'chkRollPop "M07"



	iScheduleSeq=sqlcheck(Replace(Trim(request("iScheduleSeq")),"'","''"))
	iSchedetailSeq=sqlcheck(Replace(Trim(request("iSchedetailSeq")),"'","''"))
	AttenDate=sqlcheck(Replace(Trim(request("AttenDate")),"'","''"))
	iDailyReportSeq=sqlcheck(Replace(Trim(request("iDailyReportSeq")),"'","''"))



	chkRequestValPop iScheduleSeq&"", "Wrong Information 1.!"
	chkRequestValPop iSchedetailSeq&"", "Wrong Information 2.!"
	chkRequestValPop AttenDate&"", "Wrong Information 3.!"
	chkRequestValPop iDailyReportSeq&"", "Wrong Information 4.!"

	gopage="writing.asp"
	'수업정보

       sql = "SELECT top 1 a.nvcDailyReportDate,a.siAttendance, a.nvcScheTel,a.nvcTitleContent1,a.nvcTitleContent2,"
	   sql = sql & " 			e.nvcMemberID,e.nvcMemberName,e.nvcMemberEName,a.nvcScheTime "
  	   sql = sql & " 			,a.siTitlePoint1,a.siTitlePoint2,a.siTitlePoint3,a.siTitlePoint4 "
   	   sql = sql & " 			,a.siTitlePoint5,a.siTitlePoint6,a.siTitlePoint7,a.siTitlePoint8 "
	   sql = sql & " 			from tb_DailyReport a left outer join tb_Schedetail d "
	   sql = sql & "		on a.ischeduleSeq=isnull(d.iScheduleSeq,0) and a.iScheDetailSeq=d.iScheDetailSeq "
	   sql = sql & "			left outer join tb_Member e "
	   sql = sql & "			on d.iMemberSeq=e.iMemberSeq  "
	   sql = sql & "			where a.iDailyReportSeq='"&iDailyReportSeq&"' and a.iScheduleSeq='"&iScheduleSeq&"' and a.iScheDetailSeq='"&iSchedetailSeq&"'	"

        set rs = dbSelect(sql)

        if not rs.eof  then
           siAttendance=Trim(Rs(1))
		   nvcScheTel=Trim(Rs(2))
		   nvcTitleContent1=Trim(Rs(3))
		   nvcMemberName=Trim(Rs(6))
		   nvcMemberEName=Trim(Rs(7))

		   nvcScheTime=Trim(Rs(8))
		   nvcPoint1 = Trim(Rs(9))
		   nvcPoint2 = Trim(Rs(10))
		   nvcPoint3 = Trim(Rs(11))
		   nvcPoint4 = Trim(Rs(12))
		   nvcPoint5 = Trim(Rs(13))
		   nvcPoint6 = Trim(Rs(14))
		   nvcPoint7 = Trim(Rs(15))
		   nvcPoint8 = Trim(Rs(16))


           if siAttendance <> "0" then

		       If nvcPoint1="" Or nvcPoint1="0" Then
			    nvcPoint1="6"
		       End If

		       If nvcPoint2="" Or nvcPoint2="0" Then
			    nvcPoint2="6"
		       End If

		       If nvcPoint3="" Or nvcPoint3="0" Then
			    nvcPoint3="6"
		       End If

		       If nvcPoint4="" Or nvcPoint4="0" Then
			    nvcPoint4="6"
		       End If

		       If nvcPoint5="" Or nvcPoint5="0" Then
			    nvcPoint5="6"
		       End If

		       If nvcPoint6="" Or nvcPoint6="0" Then
			    nvcPoint6="6"
		       End If

		       If nvcPoint7="" Or nvcPoint7="0" Then
			    nvcPoint7="6"
		       End If

		       If nvcPoint8="" Or nvcPoint8="0" Then
			    nvcPoint8="6"
		       End if
            end If

        end if

        rs.close
        set rs=nothing


     Call DBClose()

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><%=subTitleName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/css/style01.css" rel="stylesheet" type="text/css">
 <link href="/css/main.css" rel="stylesheet" type="text/css" />
</head>

<body leftmargin="0" topmargin="0">
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">

        <tr>
            <td height="14"><img src="/AdminImage/PopUpBoxtopLeft.gif" width="13" height="14"></td>
            <td width="100%" background="/AdminImage/PopUpBoxtopBG.gif" height="14" colspan="2"></td>
            <td height="14"><img src="/AdminImage/PopUpBoxtopright.gif" width="13" height="14"></td>
        </tr>
        <tr>
            <td background="/AdminImage/PopUpBoxrightBG.gif">&nbsp;</td>
            <td align="center" valign="top" colspan="2">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="15" align="center"><img src="/AdminImage/PopUpBoxJum.gif" width="10" height="10"></td>
                        <td><STRONG><font color="#0066CC">Daily Comment</font></strong></td>
                    </tr>
                </table>
			</td>
			 <td background="/AdminImage/PopUpBoxLeftBG.gif">&nbsp;</td>
		</tr>


			<tr>
            <td background="/AdminImage/PopUpBoxrightBG.gif">&nbsp;</td>
            <td align="center" valign="top" colspan="2" >
			<br>

             <table width="98%"  border="0" cellpadding="0" cellspacing="0">

                    <tr>
                        <td height="22"><img src="/AdminImage/Popimages/TitleLeft.gif" width="3" height="22"></td>
                        <td width="100%" background="/AdminImage/Popimages/TitleBg.gif" style="padding-left:10px"><strong> Daily Information</strong></td>
                        <td><img src="/AdminImage/Popimages/Titleright.gif" width="3" height="22"></td>
                    </tr>
                    <tr>
                        <td background="/AdminImage/Popimages/TitleLeftBg.gif"></td>
                        <td align="center" valign="top">
                             <table width="98%" border="0" cellspacing="0" cellpadding="0">
							<tr>
							  <td height="2" colspan="4" align="right" ></td>
							</tr>
							<tr>
							  <td height="1" colspan="4" align="right" bgcolor="C9D5E7"></td>
							</tr>
							<tr>
							  <td width="20%" align="right" bgcolor="F2F4F9" style="padding-right:10"><strong><font color="#0066CC">Class date</font></strong></td>
							  <td   style="padding-left:5" COLSPAN="3" height="28"><strong><%=attenDate%></strong></td>
							</tr>
							<tr>
							  <td height="1" colspan="4" align="right" bgcolor="C9D5E7"></td>
							</tr>
							<tr>
							  <td width="20%" align="right" bgcolor="F2F4F9" style="padding-right:10"><strong><font color="#0066CC">Class Time</font></strong></td>
							  <td   style="padding-left:5" COLSPAN="3" height="28"><strong><%=nvcScheTime%></strong></td>
							</tr>
							<tr>
							  <td height="1" colspan="4" align="right" bgcolor="C9D5E7"></td>
							</tr>
							<tr>
							  <td width="20%" align="right" bgcolor="F2F4F9" style="padding-right:10"><strong><font color="#0066CC">Name</font></strong></td>
							  <td   style="padding-left:5" COLSPAN="3" height="28"><strong><%=nvcMemberEName&" ["&nvcMemberName&"] "%></strong></td>
							</tr>
							<tr>
							  <td height="1" colspan="4" align="right" bgcolor="C9D5E7"></td>
							</tr>
							<tr>
							  <td width="20%" align="right" bgcolor="F2F4F9" style="padding-right:10"><strong><font color="#0066CC">TEL</font></strong></td>
							  <td   style="padding-left:5" COLSPAN="3" height="28"><strong><%=nvcScheTel%></strong></td>
							</tr>
							<tr>
							  <td height="1" colspan="4" align="right" bgcolor="C9D5E7"></td>
							</tr>



							<tr>
							  <td width="20%" align="right" bgcolor="F2F4F9" style="padding-right:10"><strong><font color="#0066CC">Speaking<br>말하기</font></strong></td>
							  <td   style="padding-left:5"  height="28"><strong><%=nvcPoint1%></strong></td>
							  <td width="20%" align="right" bgcolor="F2F4F9" style="padding-right:10"><strong><font color="#0066CC">Pronunciation<br>발음</font></strong></td>
							  <td   style="padding-left:5"  height="28"><strong><%=nvcPoint2%></strong></td>
							</tr>
							<tr>
							  <td height="1" colspan="4" align="right" bgcolor="C9D5E7"></td>
							</tr>



							<tr>
							  <td width="20%" align="right" bgcolor="F2F4F9" style="padding-right:10"><strong><font color="#0066CC">Grammar<br>문법</font></strong></td>
							  <td   style="padding-left:5"  height="28"><strong><%=nvcPoint3%></strong></td>
							  <td width="20%" align="right" bgcolor="F2F4F9" style="padding-right:10"><strong><font color="#0066CC">Vocabulary<br>단어</font></strong></td>
							  <td   style="padding-left:5"  height="28"><strong><%=nvcPoint4%></strong></td>
							</tr>
							<tr>
							  <td height="1" colspan="4" align="right" bgcolor="C9D5E7"></td>
							</tr>

							<tr>
							  <td width="20%" align="right" bgcolor="F2F4F9" style="padding-right:10"><strong><font color="#0066CC">Listening<br>듣기</font></strong></td>
							  <td   style="padding-left:5"  height="28"><strong><%=nvcPoint5%></strong></td>
							  <td width="20%" align="right" bgcolor="F2F4F9" style="padding-right:10"><strong><font color="#0066CC">Overall<br>종합</font></strong></td>
							  <td   style="padding-left:5"  height="28"><strong><%=nvcPoint6%></strong></td>
							</tr>
							<tr>
							  <td height="1" colspan="4" align="right" bgcolor="C9D5E7"></td>
							</tr>

							<!--<tr>
							  <td width="20%" align="right" bgcolor="F2F4F9" style="padding-right:10"><strong><font color="#0066CC">Reading<br>읽기</font></strong></td>
							  <td   style="padding-left:5"  height="28"><strong><%=nvcPoint7%></strong></td>
							  <td width="20%" align="right" bgcolor="F2F4F9" style="padding-right:10"><strong><font color="#0066CC">Attitude<br>수업 태도</font></strong></td>
							  <td   style="padding-left:5"  height="28"><strong><%=nvcPoint8%></strong></td>
							</tr>
							<tr>
							  <td height="1" colspan="4" align="right" bgcolor="C9D5E7"></td>
							</tr> -->

							<tr>
							  <td width="20%" align="right" bgcolor="F2F4F9" style="padding-right:10"><strong><font color="#0066CC">Comment</font></strong></td>
							  <td   style="padding-left:5" COLSPAN="3" height="28"><textarea name="nvcSComment" rows="16" id="nvcSComment" style="width:100%"><%=nvcTitleContent1%></textarea>	</td>
							</tr>
							<tr>
							  <td height="1" colspan="4" align="right" bgcolor="C9D5E7"></td>
							</tr>
							<tr>
							  <td height="2" colspan="4" align="right" ></td>
							</tr>
						  </table>

                    </td>
                    <td background="/AdminImage/Popimages/TitleRightBg.gif"></td>
                </tr>
                <tr><td colspan="3" bgcolor="B7C5DE" height="1"></td></tr>
            </table>
            <br>


            </td>

            <td background="/AdminImage/PopUpBoxLeftBG.gif">&nbsp;</td>
        </tr>
		<tr>
		<td background="/AdminImage/PopUpBoxrightBG.gif">&nbsp;</td>
            <td align="center" valign="top" colspan="2">


		</td>
            <td background="/AdminImage/PopUpBoxLeftBG.gif">&nbsp;</td>
		</tr>

		<tr>
		<td background="/AdminImage/PopUpBoxrightBG.gif">&nbsp;</td>
            <td align="center" valign="top" colspan="2">


		</td>
            <td background="/AdminImage/PopUpBoxLeftBG.gif">&nbsp;</td>
		</tr>


    </table>
	</DIV></DIV>
</body>
</html>

