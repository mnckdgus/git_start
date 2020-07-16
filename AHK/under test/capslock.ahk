#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


Capslock::
Send, {Blind}{ctrl}
Return

Capslock & c::
Send, {Blind}^c
Return

Capslock & v::
Send, {Blind}^v
Return

Capslock & s::
Send, {Blind}^s
Return

Capslock & w::
Send, {Blind}^w 
Return

Capslock & z::
Send, {Blind}^z 
Return

Capslock & y::
Send, {Blind}^y 
Return

Capslock & a::
Send, {Blind}^a 
Return

Capslock & x::
Send, {Blind}^x 
Return


Capslock & f::
Send, {Blind}^f
Return


Capslock & Tab::
SendInput ^{Tab}
Return

;+CapsLock & tab:: ; error - invalid hotkey
;SendInput ^+{Tab}
;Return

Ctrl::
Send, {Blind}{Capslock} 
Return

Capslock & j::
Send, {Blind}{Left} 
Return

Capslock & k::
Send, {Blind}{Down} 
Return

Capslock & i::
Send, {Blind}{Up} 
Return

Capslock & l::
Send, {Blind}{Right} 
Return

Capslock & u::
Send, {Blind}{Home}
Return

Capslock & o::
Send, {Blind}{End}
Return

Capslock & Space::
Send, {Blind}{Backspace}
Return