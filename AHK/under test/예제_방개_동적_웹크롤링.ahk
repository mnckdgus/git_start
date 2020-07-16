wh := ComObjCreate("WinHTTP.WinHTTPRequest.5.1") 
wh.Open("POST", "https://banggae.space")
wh.Send()
MsgBox, % wh.ResponseText()