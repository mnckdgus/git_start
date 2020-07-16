#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


winHttp := ComObjCreate("WinHttp.WinHttpRequest.5.1") 

winHttp.Open("GET","https://www.naver.com") ;

winHttp.Send("") 

winHttp.WaitForResponse( ) ;



Data:= winHttp.ResponseText





RegExMatch(Data, "실시간 급상승 검색어</h3>(.*)<h3 class=\Cah_ltit\C>실시간 급상승", ddd)



a := 1

Loop 20     ;검색어순위가 20위까지 있음.

{

	Pos = 1 ;시작 위치

	Loop, %a%  ; a 번째 것을 파싱

	{

	Pos:= RegExMatch(ddd1, "<span class=\Cah_k\C>(.*?)</span>", Result,Pos)+Strlen(Result)

}

	some%a%:=Result1

	

	a++

}		



Msgbox, 1위 : %some1%`n2위 : %some2%`n3위 : %some3%`n4위 : %some4%`n5위 : %some5%`n6위 : %some6%`n7위 : %some7%`n8위 : %some8%`n9위 : %some9%`n10위 : %some10%`n11위 : %some11%`n12위 : %some12%`n13위 : %some13%`n14위 : %some14%`n15위 : %some15%`n16위 : %some16%`n17위 : %some17%`n18위 : %some18%`n19위 : %some19%`n20위 : %some20%



exitapp