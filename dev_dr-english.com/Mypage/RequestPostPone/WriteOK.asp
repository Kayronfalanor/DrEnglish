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
Dim strResult, msg
Dim execMode	: execMode	= sqlCheck(Replace(Request.Form("ExecMode"), "'", "''"))
Dim req_seq		: req_seq	= sqlCheck(Replace(Request.Form("req_seq"), "'", "''"))
Dim sche_seq	: sche_seq	= sqlCheck(Replace(Request.Form("sche_seq"), "'", "''"))
Dim Phone1		: Phone1	= sqlCheck(Replace(Request.Form("Phone1"), "'", "''"))
Dim Phone2		: Phone2	= sqlCheck(Replace(Request.Form("Phone2"), "'", "''"))
Dim Phone3		: Phone3	= sqlCheck(Replace(Request.Form("Phone3"), "'", "''"))
Dim strHDate	: strHDate	= sqlCheck(Replace(Request.Form("hdate"), "'", "''"))
Dim strBDate	: strBDate	= sqlCheck(Replace(Request.Form("bdate"), "'", "''"))
Dim strReason	: strReason = sqlCheck(Replace(Request.Form("Reason"), "'", "''"))

chkRequestVal SiteCPCode,		"사이트 정보가 없습니다.!"
chkRequestVal execMode,			"잘못된 접근입니다.\n정상적인 경로로 이용해 주세요.!"
If Trim(execMode) = "INS" Then
	chkRequestVal sche_seq,		"수강 정보가 없습니다.!"
ElseIf Trim(execMode) = "MOD" OR Trim(execMode) = "DEL" Then
	chkRequestVal req_seq,		"휴강신청 정보가 없습니다.!"
End If
chkRequestVal Phone1,		"연락처 정보가 없습니다.!"
chkRequestVal Phone2,		"연락처 정보가 없습니다.!"
chkRequestVal Phone3,		"연락처 정보가 없습니다.!"
chkRequestVal StrHDate,		"휴강 신청일 정보가 없습니다.!"
chkRequestVal strBDate,		"보강 신청일 정보가 없습니다.!"
chkRequestVal strReason,	"휴강 신청 사유 정보가 없습니다.!"

Dim strPhone	: strPhone	= Phone1 & "-" & Phone2 & "-" & Phone3

If DateDiff("d", Date(), strHDate) < 2 Then
	chkRequestVal "",	"휴강 신청은 이틀전에 가능합니다.!"
End If

Dim arrSche
'##### 등록, 수정, 삭제 전 체크 사항 #####
Sql = "SELECT A.iPScheduleSeq, A.iScheShapeSeq, A.siPostPone, IsNull(iPostPone, 0) As iPostPone, C.cFlag "
Sql = Sql & "FROM TB_SCHEDULE AS A WITH(NOLOCK) "
Sql = Sql & "LEFT OUTER JOIN ( "
Sql = Sql & "	SELECT iScheduleSeq, Count(iDailyReportSeq) AS iPostPone FROM TB_DAILYREPORT WITH(NOLOCK) "
Sql = Sql & "	WHERE siScheType = '2' GROUP BY iScheduleSeq "
Sql = Sql & ")  AS B ON(A.iScheduleSeq = B.iScheduleSeq) "
Sql = Sql & "LEFT OUTER JOIN TB_REQUESTPOSTPONE AS C WITH(NOLOCK) ON(A.iScheduleSeq = C.iScheduleSeq AND A.iPScheduleSeq = C.iPScheduleSeq) "
Sql = Sql & "WHERE A.iScheduleSeq = '"& sche_seq &"' "
Set objRs = dbSelect(Sql)
If Not objRs.Eof Then
	arrSche = objRs.GetRows()
End If
objRs.Close	:	Set objRs = Nothing

If IsArray(arrSche) Then
	iPScheduleSeq	= arrSche(0, 0)
	iScheShape		= arrSche(1, 0) ' 수업형태 1:1, 1:2, 1:3...
	iSiPostPone		= arrSche(2, 0) ' 클래스 수강 연기 가능 횟수
	iUserPostPont	= arrSche(3, 0) ' 학생의 실제 연기되어 보강되어진 강의 횟수
	strPostPoneFlag = arrSche(4, 0)	' 휴강 신청 처리 정보	
Else
	Call DBClose()
	chkRequestVal "",	"잘못된 접근입니다.\n정상적인 경로로 이용해 주세요.!"
End If

'##### 수업 형태가 1:1 인지 체크 #####
If CStr(iScheShape) <> "1" Then
	Call DBClose()
	chkRequestVal "",	"휴강신청은 1:1수업만 가능합니다.!"
End If

If Trim(execMode) = "INS" Then
	'##### 연기 가능 횟수 #####
	If CInt(iUserPostPont) >= CInt(iSiPostPone) Then
		Call DBClose()
		chkRequestVal "",	"휴강신청은 월 "& iSiPostPone &"회만 가능합니다.!"
	End If

	'##### 휴강 신청 정보 입력
	DB1.BeginTrans

	Sql = "INSERT INTO TB_REQUESTPOSTPONE ( "
	Sql = Sql & "	nvcCPCode,	iScheduleSeq,	iPScheduleSeq,	"
	Sql = Sql & "	iWriterSeq, iWriterPRole,	nvcHDate,		"
	Sql = Sql & "	nvcBDate,	nvcReason,		nvcPhone		"
	Sql = Sql & ") VALUES ( "
	Sql = Sql & "	N'"& SiteCPCode &"',	'"& sche_seq &"',	'"& iPScheduleSeq &"',	"
	Sql = Sql & "	'"& sUserSeq &"',		'"& sUserPRole &"',	N'"& strHDate &"',		"
	Sql = Sql & "	N'"& strBDate &"',		N'"& strReason &"',	N'"& strPhone &"'		"
	Sql = Sql & ")"

Else
	
	'##### 휴강 신청 처리완료된 내역 수정/삭제불가 #####
	If Trim(strPostPoneFlag) = "Y" Then
		Call DBClose()
		chkRequestVal "",	"관리자가 이미 처리한 내용은 수정 및 삭제를 할 수 없습니다.!"
	End If

	'##### 휴강 신청 정보 수정 및 삭제
	DB1.BeginTrans

	If Trim(execMode) = "MOD" Then
		
		Sql = "UPDATE TB_REQUESTPOSTPONE SET "
		Sql = Sql & "nvcHDate	= N'"& strHDate &"',	"
		Sql = Sql & "nvcBDate	= N'"& strBDate &"',	"
		Sql = Sql & "nvcReason	= N'"& strReason &"',	"
		Sql = Sql & "nvcPhone	= N'"& strPhone &"'		"
		Sql = Sql & "WHERE iPostPoneSeq = '"& req_seq &"' AND iWriterSeq = '"& sUserSeq &"' "

	ElseIf Trim(execMode) = "DEL" Then

		Sql = "DELETE TB_REQUESTPOSTPONE WHERE iPostPoneSeq = '"& req_seq &"' AND iWriterSeq = '"& sUserSeq &"' "

	End If

End If

strResult = insertUpdateDB(sql)

If strResult <> "Y" Then 
	If Trim(execMode) = "INS" Then
		msg = "휴강 신청 입력 도중 오류가 발생하였습니다.\n" & strResult
	ElseIf Trim(execMode) = "MOD" Then
		msg = "휴강 신청 수정 도중 오류가 발생하였습니다.\n" & strResult
	ElseIf Trim(execMode) = "DEL" Then
		msg = "휴강 신청 삭제 도중 오류가 발생하였습니다.\n" & strResult
	End If
	   
	'/*********************************/
	RollBackAndHistoryBack DB1, msg
	'/*********************************/
Else
    If Trim(execMode) = "INS" Then
		msg = "휴강 신청을 완료하였습니다."
	ElseIf Trim(execMode) = "MOD" Then
		msg = "휴강 신청을 수정하였습니다."
	ElseIf Trim(execMode) = "DEL" Then
		msg = "휴강 신청을 삭제하였습니다."
	End If

	'/*************************************/
	DB1.CommitTrans
	'/*************************************/
End If 
%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp"--> 
<FORM action="/Mypage/requestPostPone/List.asp" name="Form" method="post"></FORM>
<script language="JavaScript">
alert("<%=MSG%>");
document.Form.submit();
</script>