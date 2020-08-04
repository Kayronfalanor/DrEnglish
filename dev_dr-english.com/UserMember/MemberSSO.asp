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

function sqlCheckSSO(str)

	Val = str
	Val = REPLACE(Val,"'","")
	Val = replace(Val,"|","")
	Val = replace(Val,"/","")
	Val = replace(Val,"\","")
	Val = replace(Val,"'","")
	Val = replace(Val,"+","")
	Val = replace(Val,",","")
	Val = REPLACE(Val,";","")
	Val = REPLACE(Val,":","")
	Val = REPLACE(Val,"`","")
	Val = REPLACE(Val,"*","")
	Val = REPLACE(Val,"--","")
	Val = replace(Val,"<","&lt")
	Val = replace(Val,">","&gt")

	sqlCheckSSO = Val

end Function


'// Parameters
Dim uid : uid = sqlCheckSSO(Trim(Replace(Request.Form("uid"),"'", "''")))
Dim uname : uname = sqlCheckSSO(Trim(Replace(Request.Form("uname"),"'", "''")))
Dim uename : uename = sqlCheckSSO(Trim(Replace(Request.Form("uename"),"'", "''")))
Dim oterseq : oterseq = sqlCheckSSO(Trim(Replace(Request.Form("oterseq"),"'", "''")))
Dim otercenter : otercenter = sqlCheckSSO(Trim(Replace(Request.Form("otercenter"),"'", "''")))

referUrl = request.ServerVariables("HTTP_REFERER")

referUrl = Replace(referUrl,"https","http")

'Response.write " uid : " & uid & "<br>"
'Response.write " uname : " & uname & "<br>"
'Response.write " uename : " & uename & "<br>"
'Response.write " oterseq : " & oterseq & "<br>"
'Response.write " otercenter : " & otercenter & "<br>"
'dbclose
'Response.end

ReturnTxt = ""

If uid = "" Or uname = "" Or otercenter = "" Or oterseq = "" Then
		ReturnTxt = "3"
End If 


If ReturnTxt = "" Then 
	
		Sql = "PRC_tb_Member_User_Select_View N'"& SiteCPCode &"', N'"& uid &"'"
		Set objRs = dbSelect(Sql)

		If Not (objRs.Eof And objRs.Bof) Then	
			ReturnTxt = "2"
		End If
		objRs.Close	
		Set objRs = Nothing

End If


If ReturnTxt = "" Then 

		' 회원 가입 전 센터의 정보 유무 확인
		If InStr(otercenter,"공터영어") <= 0 Then
			otercenter = "공터영어 " & otercenter 
		End If
		
		oterBelongCode = ""

		sql = "select top 1 nvcBelongCode from tb_Belong where siflag = 1 and ltrim(rtrim(nvcBelongName))='" & otercenter & "'"	
		Set objRs = dbSelect(Sql)

		If Not (objRs.Eof And objRs.Bof) Then	
			oterBelongCode = Trim(objRs(0)&"")					
		End If
		objRs.Close	
		Set objRs = Nothing	
		
		If oterBelongCode = "" Then
			'등록하자
				On Error Resume Next

				DB1.BeginTrans
				
				oterBelonguid = ""
							
				
				For iid = 1 To 20 

					On Error Resume Next

					oterBelongCode = ""

					sql = "  "			
					sql = sql & " SELECT Max(nvcBelongCode) + " & iid & " FROM tb_Belong WHERE LEN(nvcBelongCode) = 3 and LEFT(nvcPBelongCode, 1) = '1' "
					Set objRs = dbSelect(Sql)

					If Not (objRs.Eof And objRs.Bof) Then	
						oterBelongCode = Trim(objRs(0)&"")	
					Else
						oterBelongCode = "111"
					End If

					objRs.Close	
					Set objRs = Nothing
					
					oterBelonguid = ""
					oterBelongupw = ""

					oterBelonguid = "oter" & oterBelongCode		
					oterBelongupw = Base64encode(Trim(oterBelonguid))



					On Error Resume Next
					
					sql = ""
					sql = " if not exists(select top 1 nvcBelongCode from tb_Belong where Userid=N'" & oterBelonguid  & "') "
					sql = sql & " begin "
					sql = sql & "  "
					sql = sql & " INSERT INTO tb_Belong (nvcBelongCode,nvcBelongName,nvcPBelongCode,siFlag,"
					sql = sql & " nvcCPCode,UserID,UserPW ) VALUES ("
					sql = sql & " N'" & oterBelongCode & "',N'" & otercenter & "',N'1',1,N'" & SiteCPCode & "', "
					sql = sql & " N'" & oterBelonguid & "',N'" & oterBelongupw & "') ; "
					sql = sql & "  "
					sql = sql & "  select 1; "
					sql = sql & " end  "
					sql = sql & " else  "
					sql = sql & " begin  "
					sql = sql & "  "
					sql = sql & " select 0;  "
					sql = sql & "  "
					sql = sql & " end  "
					Set objRs = dbSelect(Sql)

					If Not (objRs.Eof And objRs.Bof) Then	
						If objRs(0) = 1 Then
							iid = 21														
						End If
					End If
					objRs.Close	
					Set objRs = Nothing
					
					

				Next
				

			DB1.CommitTrans	

		End If



		If oterBelongCode <> "" Then
			
			'회원 등록 하자
			
			On Error Resume Next
			upw = ""
			upw = Base64encode(Trim(uid))
					
					sql = ""
					sql = " if not exists(select top 1 nvcMemberID from tb_member where nvcMemberID=N'" & uid  & "') "
					sql = sql & " begin "
					sql = sql & "  "
					sql = sql & " INSERT INTO tb_Member(nvcMemberID,nvcMemberName, nvcMemberEName "
					sql = sql & ", nvcMemberTel, nvcMemberEmail, ncMemberEmailYN "
					sql = sql & ", siMemberFlag, nvcMemberRDate, ncMemberSMSYN "
					sql = sql & ", nvcMemberCTN,nvcMemberPW, nvcCPCode "
					sql = sql & ", nvcBirth, nvcZipCode, nvcAddress1, nvcAddress2 "
					sql = sql & ", nvcParentsName, nvcParentsPhone, nvcParentsEmail, siBirthType "
					sql = sql & ", nvcBelongCode,nvcEtcInfo,nvcDepartment,nvcPosition,oterseq "
					sql = sql & " ) VALUES ( "
					sql = sql & " "
					sql = sql & " N'" & uid & "',N'" & uname & "',N'" & uename & "'"
					sql = sql & " ,'--',N'',N'N' "
					sql = sql & " ,1,N'" & Left(now(),10) & "',N'N' "
					sql = sql & " ,'--',N'" &upw  & "',N'" & SiteCPCode & "' "
					sql = sql & " ,N'-00-00',N'-',N'',N'' "
					sql = sql & " ,N'',N'',N'',1 "
					sql = sql & " ,N'" & oterBelongCode & "',N'',N'',N'',N'" & oterseq & "' ) ; "
					sql = sql & "  "
					sql = sql & "  select 1; "
					sql = sql & " end  "				
					sql = sql & " else  "	
					sql = sql & " begin  "	
					sql = sql & "   "	
					sql = sql & " select 0;  "	
					sql = sql & "   "	
					sql = sql & " end  "	
					Set objRs = dbSelect(Sql)

					If Not (objRs.Eof And objRs.Bof) Then	
						If objRs(0) = 1 Then
							ReturnTxt = "1"		
						Else
							ReturnTxt = "5"	
						End If
					End If
					objRs.Close	
					Set objRs = Nothing

		Else
		
			ReturnTxt = "4"	
		
		End If



	
End If 


If ReturnTxt = "" Then 
	ReturnTxt = "99"
End If 


Response.write ReturnTxt


DBClose
Response.End

%>
