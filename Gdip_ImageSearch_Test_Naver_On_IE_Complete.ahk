#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



#Include Gdip_All.ahk
#Include Gdip_ImageSearch.ahk

pToken := Gdip_Startup()
;N_hWnd := WinExist("NAVER - Internet Explorer")
;ControlClick, x100 y100, ahk_id %N_hWnd% - 활성화 안됨.



pHaystack := Gdip_BitmapFromHwnd(WinExist("NAVER - Internet Explorer"))
MsgBox, %pHaystack%

Gdip_SaveBitmapToFile(pHaystack, A_Desktop "\새 폴더\Result.png") 

pNeedle := Gdip_CreateBitmapFromFile("naver.png")
;result := Gdip_ImageSearch(pHaystack, pNeedle, outputVar)
result := Gdip_ImageSearch(pHaystack, pNeedle, outputVar, 0, 0, 0, 0, 100)

MsgBox, % result

Gdip_DisposeImage(pHaystack)
Gdip_DisposeImage(pNeedle)
Gdip_Shutdown(pToken)

if (result = 1)
{
    RegExMatch(outputVar, "(.*),(.*)", out)
    MsgBox, X: %out1% Y: %out2%
}

ExitApp


