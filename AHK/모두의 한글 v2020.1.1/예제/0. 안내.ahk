#include ..\EveryHangul.ahk
;위와 같이 모두의 한글 라이브러리를 임포트하시면 됩니다.

var := 분리("함수명은 모두 한글입니다.")
MsgBox, %var%

var2 := 초성추출("EveryHangul.ahk 내부를 보시면 모든 함수에 대한 설명이 있습니다.", 1)
MsgBox, %var2%

/*
예제는 예제일 뿐입니다. 라이브러리(EveryHangul.ahk)를 꼭 열어봐주세요.

EveryHangul.ahk에 해당 함수에 대한 기능, 특이사항, 매개변수등이 기재되어있습니다.
입맛에 맞게 수정해서 쓰셔도 됩니다.

라이브러리(EveryHangul.ahk)는 임의로 수정하여도 좋으나, 최상단의 제작자는 놔두셨으면 좋겠습니다.
*/