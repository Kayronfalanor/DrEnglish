﻿<%
function sqlCheck(str)
val=REPLACE(UCASE(str),"'","")
val=REPLACE(val,";","")
val=REPLACE(val,"`","")
val=REPLACE(val,",","")
val=REPLACE(val,"+","")
val=REPLACE(val,"|","")
val=REPLACE(val,"*","")
val=REPLACE(val,"--","")
'val=REPLACE(val,"/*","")
'val=REPLACE(val,"*/","")

val=REPLACE(val,"&","&amp")
val=REPLACE(val,"<","&lt")
val=REPLACE(val,">","&gt")
val=REPLACE(val,"(","&#40")
val=REPLACE(val,")","&#41")

if instr(str,"''") <=0 and instr(str,"'") > 0 then
	str = REPLACE(UCASE(str),"'","''")
end IF


'if (instr(str,"&quot;") <=0 and instr(str,"&amp;") <=0 and instr(str,"&lt;") <=0 and instr(str,"&gt;") <= 0 and instr(str,"&#40;") <=0 and instr(str,"&#41;") <=0 and instr(str,"&ga;") <=0 and instr(str,"&nbsp;") <=0 And instr(val, ";") <> 0) Or _
if instr(val, "ONERROR") <> 0 Or _
instr(val, "ONMOUSEENTER") <> 0 Or _
instr(val, "ONMOUSEOVER") <> 0 Or _
(instr(val, "MARQUEE") <> 0 And instr(val, "onstart") <> 0 ) Or _
instr(val, "ALERT(") <> 0  Or _
instr(val, "ALERT&#40") <> 0  Or _
instr(val, "EVAL(") <> 0  Or _
instr(val, "EVAL&#40") <> 0  Or _
instr(val, "*") <> 0 Or _
(instr(str,"''") <=0 and instr(str,"'") > 0) Or _
instr(val, "`") <> 0 Or _
instr(val, "--") <> 0 Or _
instr(val, "/*") <> 0 Or _
instr(val, "*/") <> 0 Or _
instr(val, "%3B") <> 0 Or _
instr(val, "@@") <> 0 Or _
instr(val, "SYSOBJECTS") <> 0 Or _
instr(val, "SYSCOLUMNS") <> 0 Or _
instr(val, "&ltSCRIPT") <> 0 Or _
instr(val, "&lt;SCRIPT") <> 0 Or _
instr(val, "SCRIPT&gt") <> 0 Or _
instr(val, "SCRIPT&gt;") <> 0 Or _
instr(val, "JAVASCRIPT") <> 0 Or _
instr(val, "VBSCRIPT") <> 0 Or _
instr(val, "DROP1234") <> 0 then
%>
<script language="JavaScript">
alert("<%=val%> 보안상 페이지를 오픈하실 수 없습니다." );
window.close();
</script>
<%
response.End
Else

sqlCheck=str
end if
end Function
%>