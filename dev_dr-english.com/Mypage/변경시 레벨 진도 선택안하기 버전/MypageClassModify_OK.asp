<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"

'// Login 여부
Dim IsLogin : IsLogin = True
'// menu setting
Dim mMenu : mMenu = "1"
Dim sMenu : sMenu = "1"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<% 

iTeacherSeq = sqlCheck(Replace(Request("iTeacherSeq"), "'", "''"))
iDailyReportSeq = sqlCheck(Replace(Request("iDailySeq"), "'", "''"))
iMemberSeq = sUserSeq
chg_date = sqlCheck(Replace(Request("m_classDate0"), "'", "''"))
chg_time = sqlCheck(Replace(Request("m_classTime0"), "'", "''"))
chg_playTime = sqlCheck(Replace(Request("m_classMinute0"), "'", "''"))
iScheduleSeq = sqlCheck(Replace(Request("iScheduleSeq"), "'", "''"))

nowRunTime = sqlCheck(Replace(Request("nowRunTime"), "'", "''"))
strDates = sqlCheck(Replace(Request("strDates"), "'", "''"))


nuseclass = 0

If iTeacherSeq = "" Or iDailyReportSeq = "" Or iMemberSeq = "" Or iScheduleSeq = "" Or chg_date = "" Or chg_time = "" Or chg_playTime = ""  Then
%>
<script language="javascript">
	alert("비정상적인 접근입니다1.");
	window.close();
</script>

<%

Call DBClose()
response.end
End If


sql = "select top 1 iDailyReportSeq from tb_DailyReport where nvcDailyReportDate > '" & Left(now(),10) & "' and isnull(siAttendance,0) = 0 "
sql = sql & " and iDailyReportSeq='" & iDailyReportSeq & "' "
Set Rs = dbSelect(sql)
If Not Rs.eof Then
	nuseclass = 0
Else
	nuseclass = 1
End If
Rs.close
Set Rs = nothing



If nuseclass = 1 Then
%>
<script language="javascript">
	alert("비정상적인 접근입니다2.");
	window.close();
</script>

<%

Call DBClose()
response.end
End If

nuseclass = 0



dupcnt = 0

chksql = "SELECT count(iDailyReportSeq) as cnt FROM tb_DailyReport "
chksql = chksql & " WHERE iScheduleSeq='" & iScheduleSeq & "' AND nvcDailyReportDate='" & chg_date & "' "
chksql = chksql & " AND nvcScheTime='" & chg_time & "' and iMemberSeq = '" & iMemberSeq & "' "
chksql = chksql & "  and iDailyReportSeq <> '" & iDailyReportSeq & "' and siAttendance in (0,1,2) "
Set Rs = dbSelect(chksql)	

if Not(Rs.Eof And Rs.Bof) then
	dupcnt = Rs(0)
End if

Rs.close
Set Rs = Nothing


If dupcnt > 0 Then
%>
<script language="javascript">
	alert("회원님은 동일시간대의 수업이 이미 존재합니다.");
	window.close();
</script>

<%

Call DBClose()
response.end
End If


	
		sql = "select top 1 nvcTeacherName from tb_teacher where iteacherseq = '" & iTeacherSeq & "'"
		Set Rs = dbSelect(chksql)	

		if Not(Rs.Eof And Rs.Bof) then
			chg_teacher = Trim(Rs(0)&"")
		End if

		Rs.close
		Set Rs = Nothing


		chg_Etime = Right("0" & Hour(dateadd("n",chg_playTime,chg_time)),2) & ":" & Right("0" & minute(dateadd("n",chg_playTime,chg_time)),2)
		
		If Left(chg_Etime,2) ="00" Then
			chg_Etime = "24:" & Right(chg_Etime,2)
		End If
		

		sql = " set nocount on "
		sql = sql & " begin try "
		sql = sql & " begin tran	"
		sql = sql & " DECLARE @cnt int "
		sql = sql & " DECLARE @sDate nvarchar(10); "
		sql = sql & " DECLARE @eDate nvarchar(10); "
		sql = sql & " DECLARE @ErrorMessage NVARCHAR(100) ;						 "
		
		sql = sql & " IF dbo.FUN_ClassTime_CheckNew('" & iTeacherSeq & "','" & chg_date & "','" & chg_time & "','" & chg_Etime & "','" & chg_playTime & "') = 'true' "
		sql = sql & " begin "
		sql = sql & " update tb_DailyReport set "
		sql = sql & " nvcScheTime = '" & chg_time & "' "
		sql = sql & " ,iTeacherSeq = '" & iTeacherSeq & "' "
		sql = sql & " ,nvcDailyReportDate = '"&chg_date&"' "		
		sql = sql & " where iDailyReportSeq = '"&iDailyReportSeq&"'  "		
		
		sql = sql & " SELECT @cnt=count(iTeacherSeq) FROM  "		'선생님이 모두 같은 사람인지 체크
		sql = sql & " (SELECT iTeacherSeq FROM tb_DailyReport WHERE iScheduleSeq='"&iScheduleSeq&"' GROUP BY iTeacherSeq)tt "

		sql = sql & " select @sDate = ssDate from (  "				'변경일이 시작일보다 빠른날인지 체크
		sql = sql & " SELECT top 1(nvcDailyReportDate) as ssDate "
		sql = sql & " FROM tb_DailyReport WHERE iScheduleSeq='"&iScheduleSeq&"'  "
		sql = sql & " AND (LTrim(rtrim(nvcDailyReportDate))<>'' or isnull(nvcDailyReportDate,'') <> '') "
		sql = sql & " and nvcDailyReportDate is not null "
		sql = sql & " ORDER BY nvcDailyReportDate,nvcScheTime)tt "

		sql = sql & " select @eDate = eeDate from ( "				'변경일이 종료일보다 늦은날인지 체크
		sql = sql & " SELECT top 1(nvcDailyReportDate) as eeDate "	
		sql = sql & " FROM tb_DailyReport WHERE iScheduleSeq='"&iScheduleSeq&"'  "
		sql = sql & " AND (LTrim(rtrim(nvcDailyReportDate))<>'' or isnull(nvcDailyReportDate,'') <> '') "
		sql = sql & " and nvcDailyReportDate is not null "
		sql = sql & " ORDER BY nvcDailyReportDate desc,nvcScheTime desc)tt "

		'sql = sql & " if @cnt = 1 "
		'sql = sql & " begin "
		'sql = sql & " update tb_Schedule set "
		'sql = sql & " iTeacherSeq = '"&chg_Teacher_seq&"' "
		'sql = sql & " WHERE iScheduleSeq='"&iScheduleSeq&"' "
		'sql = sql & " END "

		sql = sql & "  "
		sql = sql & " UPDATE tb_Schedule "
		sql = sql & " SET nvcScheStartDate = @sDate, "
		sql = sql & " nvcScheEnddate = @eDate , siScheFlag = 1 "
		sql = sql & " WHERE iScheduleSeq='"&iScheduleSeq&"' ; "
		sql = sql & "  "
		sql = sql & " UPDATE tb_Schedetail "
		sql = sql & " SET siScheFlag = 1 "
		sql = sql & " WHERE iScheduleSeq='"&iScheduleSeq&"' and siScheFlag=2 ; "
		sql = sql & "  "	
		sql = sql & " end "
		sql = sql & " else "
		sql = sql & "	BEGIN "
		sql = sql & "	RAISERROR (N'"&chg_teacher&"선생님의 "&chg_date&"/"&chg_time&" 수업은 이미 신청되었습니다.' ,16 ,1) "
		sql = sql & "	END "
		sql = sql & " SELECT 'Y' as flag "
		sql = sql & " COMMIT TRAN; 	"
		sql = sql & " END TRY	"
		sql = sql & " BEGIN CATCH	"
		sql = sql & " IF @@TRANCOUNT > 0 "
		sql = sql & " ROLLBACK TRAN  "

		sql = sql & " set @ErrorMessage=ERROR_MESSAGE() "
		sql = sql & " select @ErrorMessage "

		sql = sql & " END CATCH	"

		result = dbSelectError(sql)
		
		If result = "Y" Then

		
			sqlTT="exec PRC_tb_DailyReport_Daynum_sort '" & iScheduleSeq & "','" & iScheduleSeq & "' "				
			msg = insertUpdateDB(sqlTT)
			
			strnewDates = Left(Trim(chg_date&""),4) & "년 " & mid(Trim(chg_date&""),6,2)  & "월 " & right(Trim(chg_date&""),2) & "일 "
			strnewDates = strnewDates & Left(Trim(chg_time&""),2) &"시 " & right(Trim(chg_time&""),2) &"분 "

			result = strDates & " 수업을 " & strnewDates & " 으로 변경하였습니다."
				

		End If




	
%>
<script language="javascript">
	
	alert("<%=result%>");
	opener.fn_goRefresh(this);
	/*
	if(navigator.appVersion.indexOf("MSIE 7.0") >= 0 || navigator.appVersion.indexOf("MSIE 8.0") >= 0  || navigator.appVersion.indexOf("Trident") >= 0)
	{
	  window.open('about:blank','_self').close();
	}
	else
	{
	  window.close();
	}
	*/
</script>
<%



Call DBClose()
 %>
<!--#include virtual="/include/inc_footer.asp"-->
	