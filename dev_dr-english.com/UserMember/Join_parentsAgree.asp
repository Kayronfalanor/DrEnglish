<%@Codepage=65001%>
<%
Response.CharSet = "utf-8"
Session.CodePage = 65001

Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Expires","0"
%>
<!--#include virtual="/commonfiles/DBINCC/DBINCC1.asp" -->
<%

UserID=sqlCheck(trim(replace(request("ID"),"'","''")))
    UserID = replace (UserID,"<%","&lt;%")
    UserID = replace (UserID,"%\>","%&gt;")
	UserID = replace (UserID,"|","")
	UserID = replace (UserID,"(","")
	UserID = replace (UserID,")","")
	UserID = replace (UserID,"&","")
	UserID = replace (UserID,"'","")
	UserID = replace (UserID,"+","")
	UserID = replace (UserID,",","")
	UserID = replace (UserID,"\","")
	
	
UserPW=sqlCheck(trim(replace(request("code"),"'","''")))
    UserPW = replace (UserPW,"<%","&lt;%")
    UserPW= replace (UserPW,"%\>","%&gt;")
	UserPW = replace (UserPW,"|","")
	UserPW = replace (UserPW,"(","")
	UserPW = replace (UserPW,")","")
	UserPW = replace (UserPW,"&","")
	UserPW = replace (UserPW,"'","")
	UserPW = replace (UserPW,"+","")
	UserPW = replace (UserPW,",","")
	UserPW = replace (UserPW,"\","")	


sql="select iMemberSeq, nvcMemberName,isnull(siMemberFlag,0) from tb_member where nvcMemberID='" & UserID & "' and nvcCPCode=N'" & Base64decode(UserPW)& "' "

set rs=db1.execute(sql)
IF NOT RS.EOF THEN
		iMemberSeq=Trim(Rs(0))
		nvcMemberName=Trim(rs(1))
		siMemberFlag=Trim(rs(2))

		If siMemberFlag="2" then
			sql = "update tb_member set "
			sql = sql & " siMemberFlag = '1'"
			sql = sql &  "  where iMemberSeq='" & iMemberSeq & "'"
			db1.execute(SQL)

			%>	
			<SCRIPT LANGUAGE="javascript">
			alert("승인이 완료되었습니다.<%=nvcMemberName%> 님은 정상적으로 사이트를 이용하실수 있습니다.");
			window.close();
			</script>
			<%		
		Else
			%>	
			<SCRIPT LANGUAGE="javascript">
			alert("<%=nvcMemberName%> 님은 대기상태(부모동의 필요상태)가 아닙니다.");
			window.close();
			</script>
			<%
		End if

ELSE

		%>
		<SCRIPT LANGUAGE="javascript">
		alert("동일한 회원이 없습니다.");
		window.close();
		</script>
		<%

END IF	

%>
<!--#include virtual="/commonfiles/DBINCC/DBclose1.asp"--> 