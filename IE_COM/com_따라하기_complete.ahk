#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include COM_L.ahk


f3::

wb := ComObjCreate("InternetExplorer.Application")
wb.Visible := True
;wb.Navigate("Google.com")
URL = Google.com
wb.Navigate(URL)

IEGet(Name="")        ;Retrieve pointer to existing IE window/tab
{
    IfEqual, Name,, WinGetTitle, Name, ahk_class IEFrame
        Name := ( Name="New Tab - Windows Internet Explorer" ) ? "about:Tabs"
        : RegExReplace( Name, " - (Windows|Microsoft) Internet Explorer" )
    For wb in ComObjCreate( "Shell.Application" ).Windows
        If ( wb.LocationName = Name ) && InStr( wb.FullName, "iexplore.exe" )
            Return wb
} ;written by Jethrow

/*
wb := IEGet() ;Last active window/tab
;OR
wb := IEGet("Google") ;Tab name you define can also be a variable
*/

IELoad(wb) ;You must send the function your Handle for it to work

IELoad(wb)    ;You need to send the IE handle to the function unless you define it as global.
{
    If !wb    ;If wb is not a valid pointer then quit
        Return False
    Loop    ;Otherwise sleep for .1 seconds untill the page starts loading
        Sleep,100
    Until (wb.busy)
    Loop    ;Once it starts loading wait until completes
        Sleep,100
    Until (!wb.busy)
    Loop    ;optional check to wait for the page to completely load
        Sleep,100
    Until (wb.Document.Readystate = "Complete")
Return True
}

;wb.Document.All.q.Value := "site:autohotkey.com tutorial"

Website = site:autohotkey.com tutorial
wb.Document.All.q.Value := Website

;wb.Document.All.btnK.Click()
;xvar := btnK
wb.document.All[BtnG][1].Click()
MsgBox, end
return
/*
wb := IEGet("Google") ;IE instance already open and tab named google exists
wb.Document.All.q.Value := "site:autohotkey.com tutorial"
wb.Document.All.btnG.Click()
IELoad(wb)
;or
wb := ComObjCreate("InternetExplorer.Application") ;create a IE instance
wb.Visible := True
wb.Navigate("Google.com")
IELoad(wb)
wb.Document.All.q.Value := "site:autohotkey.com tutorial"
wb.Document.All.btnG.Click()
IELoad(wb)
*/


f4::

SetBatchLines, -1

WB := ComObjCreate("InternetExplorer.Application")

WB.Visible := true ; Make the IE object visible
WB.navigate( "www.google.com" )

while WB.busy || wb.ReadyState != 4
    sleep,50

searchvar := "q"

queryfield := wb.document.getelementsbyName( searchVar )

queryfield[0].value := "hello hello"

searchvar := "btnK"

buttonToClick := wb.document.getelementsbyName( searchVar )

buttonToClick[0].click()

ExitApp

/*

f6::


iweb_init()
pwb:=iweb_newie()
iweb_nav(pwb,"http://www.autohotkey.co.kr")
iweb_complete(pwb)
iweb_clicktext(pwb,"자유게시판")
iweb_complete(pwb)
iweb_clicktext(pwb,"추억의 명언")
iweb_complete(pwb)

MsgBox, end
return

*/

