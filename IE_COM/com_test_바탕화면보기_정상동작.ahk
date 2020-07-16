#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#include COM_L.ahk

f3::
com_init()
shell := Com_CreateObject("Shell.Application")
Com_invoke(shell, "minimizeall") 

return