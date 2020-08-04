<%
Response.Buffer = True
response.Expires=-1440
Response.AddHeader "Cache-Control", "no-cache"    '// 캐시 저장 안하기
Response.AddHeader "Pragma", "no-cache"    '// 캐시 저장 안하기
%>