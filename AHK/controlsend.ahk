#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;Chrome_RenderWidgetHostHWND1
f3::

Run, Notepad,, Min, PID  ; Run Notepad minimized.
WinWait, ahk_pid %PID%  ; Wait for it to appear.
; Send the text to the inactive Notepad edit control.
; The third parameter is omitted so the last found window is used.
ControlSend, Edit1, This is a line of text in the notepad window.{Enter}
ControlSendRaw, Edit1, Notice that {Enter} is not sent as an Enter keystroke with ControlSendRaw.

MsgBox, Press OK to activate the window to see the result.
WinActivate, ahk_pid %PID%  ; Show the result.

return

f4::
ControlSend, ahk_class gLFyf gsfi, Hello_world, Google - Internet Explorer ; 안된다.
msgbox, complete

return