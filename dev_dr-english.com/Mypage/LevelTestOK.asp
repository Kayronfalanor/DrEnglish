<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = True
%>
<!--#include virtual="/commonfiles/DBINCC/Expires.asp"-->
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%
Dim iLevelCnt : iLevelCnt = 0
Sql = "SELECT COUNT(iLevelTestSeq) FROM TB_LEVELTEST WITH(READUNCOMMITTED) "
Sql = Sql & "WHERE nvcCPCode = N'"& SiteCPCode &"' AND iMemberSeq = '"& sUserSeq &"'"
Set objRs = dbSelect(Sql)
iLevelCnt = objRs(0)
objRs.Close	:	Set objRs = Nothing

If iLevelCnt > 0 Then
	Call DBClose()
	chkRequestVal "",	"무료 레벨 테스트는 1회만 신청이 가능합니다."
	Response.End
End If

SL_Cdate1		= sqlCheck(trim(replace(request.form("SL_Cdate1"),"'","''")))
SL_Ctime1		= sqlCheck(replace(trim(request.form("SL_Ctime1")),"'","''"))
SL_Ctime2		= sqlCheck(replace(trim(request.form("SL_Ctime2")),"'","''"))
SL_Ctime		= SL_Ctime1&":"&SL_Ctime2

StudentLeveL	= sqlcheck(Replace(Trim(request.form("StudentLeveL")),"'","''"))
UserBalanceSeq	= sqlcheck(Replace(Trim(request.form("UserBalanceSeq")),"'","''"))
PhoneChoice		= sqlcheck(Replace(Trim(request.form("PhoneChoice")),"'","''"))

L_UserPhone1_1	= sqlcheck(Replace(Trim(request.form("L_UserPhone1_1")),"'","''"))
L_UserPhone1_2	= sqlcheck(Replace(Trim(request.form("L_UserPhone1_2")),"'","''"))
L_UserPhone1_3	= sqlcheck(Replace(Trim(request.form("L_UserPhone1_3")),"'","''"))
L_UserPhone1	= L_UserPhone1_1&"-"&L_UserPhone1_2&"-"&L_UserPhone1_3

L_UserPhone2_1	= sqlcheck(Replace(Trim(request.form("L_UserPhone2_1")),"'","''"))
L_UserPhone2_2	= sqlcheck(Replace(Trim(request.form("L_UserPhone2_2")),"'","''"))
L_UserPhone2_3	= sqlcheck(Replace(Trim(request.form("L_UserPhone2_3")),"'","''"))
L_UserPhone2	= L_UserPhone2_1&"-"&L_UserPhone2_2&"-"&L_UserPhone2_3

IF PhoneChoice="P" Then		'// 일반전화 선택
	SL_Phone=L_UserPhone1
ElseIf PhoneChoice="C" Then '// 휴대전화선택
	SL_Phone=L_UserPhone2
END If

chkRequestVal SiteCPCode,		"사이트 정보가 없습니다.!"
chkRequestVal SL_Cdate1,		"날자 정보가 없습니다.!"
chkRequestVal SL_Ctime1,		"시간 정보가 없습니다.!"
chkRequestVal SL_Ctime2,		"시간 정보가 없습니다.!"
chkRequestVal PhoneChoice,		"수업전화번호 정보가 없습니다.!"
chkRequestVal SL_Phone,			"수업전화번호 정보가 없습니다.!"
chkRequestVal StudentLeveL,		"영어 실력 정보가 없습니다.!"

Dim Week_day
Dim Mon : Mon = "N"
Dim Tue	: Tue = "N"
Dim Wed : Wed = "N"
Dim Thu	: Thu = "N"
Dim Fri : Fri = "N"
Dim Sat	: Sat = "N"
Dim Sun : Sun = "N"
If LevelFlag = "Y" Then '레벨 테스트 신청
	Week_day=Weekday(SL_Cdate1)
	If Week_day=2 Then
		Mon = "Y"
	ElseIf Week_day=3 Then 
		Tue = "Y"
	ElseIf Week_day=4 Then 
		Wed = "Y"
	ElseIf Week_day=5 Then 
		Thu = "Y"
	ElseIf Week_day=6 Then 
		Fri = "Y"
	ElseIf Week_day=7 Then 
		Sat = "Y"
	ElseIf Week_day=1 Then 
		Sun = "Y"
	End If 
End If

DB1.BeginTrans

sql = ""
sql = "INSERT INTO TB_LEVELTEST ( "
sql = sql & "nvcCPCode "
sql = sql & ", nvcLevelTestDay "
sql = sql & ", nvcLevelTestTime "
sql = sql & ", nvcWishTime1 "
sql = sql & ", ncLevelTestYN "
sql = sql & ", iCourseSeq "
sql = sql & ", iMemberSeq "
sql = sql & ", dtCreateDate "
sql = sql & ", ncCCheckYN "
sql = sql & ", ncTCheckYN "
sql = sql & ", iScheTypeSeq "
sql = sql & ", iCLCourseSeq "
sql = sql & ", iBalanceCourseSeq "
sql = sql & ", siPlayTime "
sql = sql & ", ncMon "
sql = sql & ", ncTue "
sql = sql & ", ncWed "
sql = sql & ", ncThu "				
sql = sql & ", ncFri "
sql = sql & ", ncSat "
sql = sql & ", ncSun "
sql = sql & ", nvcScheTel "
sql = sql & ") VALUES ( "
sql = sql & "N'"& SiteCPCode &"' "
sql = sql & ", N'"& SL_Cdate1 &"' "
sql = sql & ", N'"& SL_Ctime &"' "
sql = sql & ", N'"& SL_Ctime &"' "
sql = sql & ", N'N' "
sql = sql & ", '1' "	'과목 설정 값 1 : English로 설정
sql = sql & ", '"& sUserSeq &"' "	
sql = sql & ", GETDATE() "
sql = sql & ", N'N' "
sql = sql & ", N'N' "
sql = sql & ", '2' "	'수업 방식 전화 방식으로 설정
sql = sql & ", '"& StudentLeveL &"' "
sql = sql & ", '"& UserBalanceSeq &"' "
sql = sql & ", '10' "	'레벨테스트는 10분 수업 설정
sql = sql & ", N'"& Mon &"' "
sql = sql & ", N'"& Tue &"' "
sql = sql & ", N'"& Wed &"' "
sql = sql & ", N'"& Thu &"' "
sql = sql & ", N'"& Fri &"' "
sql = sql & ", N'"& Sat &"' "
sql = sql & ", N'"& Sun &"' "
sql = sql & ", N'"& SL_Phone &"' "
sql = sql & ") "		
strResult = insertUpdateDB(sql)

If strResult <> "Y" Then 
	msg = "레벨테스트 예약 등록중 오류가 발생하였습니다.\n" & strResult
	   
	'/*********************************/
	RollBackAndHistoryBack DB1, msg
	'/*********************************/
Else
   msg = UserName & "회원님께서는 ["& SL_CDate1 &" "& SL_CTime1 &"] 레벨테스트 예약이 완료 되었습니다.\n\n레벨 테스트 예약 신청은 1회만 가능합니다."

	'/*************************************/
	DB1.CommitTrans
	'/*************************************/
End If 
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp"--> 
<FORM action="/" name="Form" method="post"></FORM>
<script language="JavaScript">
alert("<%=MSG%>");
document.Form.submit();
</script>