<%
Const sBASE_64_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/" 

Function Base64decode(ByVal asContents) 

Dim lsResult 

Dim lnPosition 

Dim lsGroup64, lsGroupBinary 

Dim Char1, Char2, Char3, Char4 

Dim Byte1, Byte2, Byte3 

If Len(asContents) Mod 4 > 0 Then asContents = asContents & String(4 - (Len(asContents) Mod 4), " ") 

lsResult = "" 



For lnPosition = 1 To Len(asContents) Step 4 

lsGroupBinary = "" 

lsGroup64 = Mid(asContents, lnPosition, 4) 

Char1 = INSTR(sBASE_64_CHARACTERS, Mid(lsGroup64, 1, 1)) - 1 

Char2 = INSTR(sBASE_64_CHARACTERS, Mid(lsGroup64, 2, 1)) - 1 

Char3 = INSTR(sBASE_64_CHARACTERS, Mid(lsGroup64, 3, 1)) - 1 

Char4 = INSTR(sBASE_64_CHARACTERS, Mid(lsGroup64, 4, 1)) - 1 

Byte1 = Chr(((Char2 And 48) \ 16) Or (Char1 * 4) And &HFF) 

Byte2 = lsGroupBinary & Chr(((Char3 And 60) \ 4) Or (Char2 * 16) And &HFF) 

Byte3 = Chr((((Char3 And 3) * 64) And &HFF) Or (Char4 And 63)) 

lsGroupBinary = Byte1 & Byte2 & Byte3 

lsResult = lsResult + lsGroupBinary 

Next 

Base64decode = lsResult 

End Function 



Function Base64encode(ByVal asContents) 

Dim lnPosition 

Dim lsResult 

Dim Char1 

Dim Char2 

Dim Char3 

Dim Char4 

Dim Byte1 

Dim Byte2 

Dim Byte3 

Dim SaveBits1 

Dim SaveBits2 

Dim lsGroupBinary 

Dim lsGroup64 



If Len(asContents) Mod 3 > 0 Then asContents = asContents & String(3 - (Len(asContents) Mod 3), " ") 

lsResult = "" 



For lnPosition = 1 To Len(asContents) Step 3 

lsGroup64 = "" 

lsGroupBinary = Mid(asContents, lnPosition, 3) 



Byte1 = Asc(Mid(lsGroupBinary, 1, 1)): SaveBits1 = Byte1 And 3 

Byte2 = Asc(Mid(lsGroupBinary, 2, 1)): SaveBits2 = Byte2 And 15 

Byte3 = Asc(Mid(lsGroupBinary, 3, 1)) 



Char1 = Mid(sBASE_64_CHARACTERS, ((Byte1 And 252) \ 4) + 1, 1) 

Char2 = Mid(sBASE_64_CHARACTERS, (((Byte2 And 240) \ 16) Or (SaveBits1 * 16) And &HFF) + 1, 1) 

Char3 = Mid(sBASE_64_CHARACTERS, (((Byte3 And 192) \ 64) Or (SaveBits2 * 4) And &HFF) + 1, 1) 

Char4 = Mid(sBASE_64_CHARACTERS, (Byte3 And 63) + 1, 1) 

lsGroup64 = Char1 & Char2 & Char3 & Char4 

lsResult = lsResult + lsGroup64 

Next 



Base64encode = lsResult 

End Function 

%>