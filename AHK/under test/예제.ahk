wh := ComObjCreate("WinHTTP.WinHTTPRequest.5.1") 
wh.Open("GET", "https://pnal.kr")
wh.Send()
MsgBox, % wh.ResponseText()