#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#include Gdip_All.ahk
pToken := Gdip_StartUp()

pBitmap := Gdip_CreateBitmapFromFile("1.png")
Gdip_GetImageDimensions(pBitmap, outputWidth, outputHeight)
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)

MsgBox, % "너비: " outputWidth ", 높이: " outputHeight
Exitapp