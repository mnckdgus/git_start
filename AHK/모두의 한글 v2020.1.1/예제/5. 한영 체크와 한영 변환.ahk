﻿ #include ..\EveryHangul.ahk
 
 /* =====================================
 * 한영체크() 함수는 현재 한/영 상태를 가져옵니다.
 * 한글이면 "한", 영어면 "영"이 반환됩니다.
 * 
 * [사용법]
 * 한영체크()
 * =====================================
 */
MsgBox, % 한영체크()
 
 
 /* =====================================
 * 한영변환() 함수는 한/영 상태를 원하는대로 변경합니다.
 * 반환값이 없습니다.
 * 
 * [사용법]
 * 한영체크("toEng 또는 toKor") → 각각 영어로, 한글로
 * "한"또는 "영"을 적으셔도 됩니다.
 * =====================================
 */
한영변환("toKor")
Send, dkssudgktpdy ;실행 전 한영상태와 관계 없이 "안녕하세요"로 입력됩니다.
 
한영변환("영")
한영변환("한")
 