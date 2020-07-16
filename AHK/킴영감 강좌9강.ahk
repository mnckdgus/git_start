#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



Gui, Add, Text, x30 y5 w100 h20, 매크로 프로그램
Gui, Add, Text, x20 y30 w70 h20 , 클리어횟수 :
Gui, Add, Text, x95 y30 w40 h20 v횟수, 0 회     ;<=== 여기서의 횟수는 단순히 표시만하는 text라서 변수값을 저장하지 않음
Gui, Add, Text, x20 y53 w70 h20 , 횟수제한 :
Gui, Add, Edit, x85 y50 w40 h20 v제한, 1        ;<=== 제한 1
Gui, Add, CheckBox, x20 y80 w100 h20 v체크 Checked, 스킬사용 ;<=== 체크 (Checked 1)
Gui, Add, Text, x20 y113 w40 h20 , 스킬 :
Gui, Add, ComboBox, x60 y110 w60 h200 v스킬 Choose1, 집|회사  ;<=== 스킬 (집,회사)
Gui, Add, ListView, x140 y25 w200 h105 v로그 Grid, 시간|동작  ;<=== 로그
Gui, Add, Button, x140 y140 w60 h20, 시작
Gui, Add, Button, x210 y140 w60 h20, 멈춤
Gui, Add, Button, x280 y140 w60 h20, 종료
Gui, Show, , 매크로

FormatTime, OutTime, , M-d H:m:s
LV_Add("", OutTime, "프로그램 실행")
LV_ModifyCol()

return

^a::         ;컨트롤 + A를 누르거나
Button시작:  ;시작버튼을 누르면
{
   global 매크로상태 := true  ;(매크로상태=전역변수) <===
   CoordMode, Mouse, Screen
   CoordMode, Pixel, Screen
   Gui, Submit, nohide       ;Gui에서 Submit은 변수를 받아오는것
   횟수카운트 := 0            ;(횟수카운트=전역변수) <===
   While ((횟수카운트 < 제한) && (매크로상태 = true))
   {
      WinGetPos, wX ,wY, wWidth, wHeight, LDPlayer ;LDPlayer
      if (체크 = 1)
      {
         PixelSearch, OutX, OutY, 0, 0, A_ScreenWidth, A_ScreenHeight, 0x659388, , Fast RGB
         if(ErrorLevel = 0)
         {
            로그추가("돈벌기") ;돈벌기라는 버튼을 함수로 넘겨주니까 실행하면 돈벌기버튼 클릭 이라는 표시가 뜹니다
            Click down %OutX%, %OutY% ;마우스를 누르고있는상태(딸 하는동작)
            GuiControl, , 횟수, %A_Index% 회 ; <=== 실행하면 선택해준만큼 횟수로 표시해줌
            Sleep, 9000 ;9초동안 유지되고
            Click up %OutX%, %OutY% ;마우스 떼는시간(깍 하는동작)
            Sleep, 500              ;0.5초동안 유지됨
         }
      }
      if (스킬 = "집") ;스킬이라는 변수에 (집)텍스트가 들어가게하면
      {
         ImageSearch, OutX, OutY, 0, 0, A_ScreenWidth, A_ScreenHeight, *80 Image\집버튼.bmp ;이미지서치
         if(ErrorLevel = 0) ;성공하면
         {
            로그추가(스킬) ;스킬이라는 변수를 넣어서 로그추가(함수)를 실행을 시킵니다
            Click %OutX%, %OutY%
            Sleep, 3000
         }

      }
      else if (스킬 = "회사")
      {
         ImageSearch, OutX, OutY, 0, 0, A_ScreenWidth, A_ScreenHeight, *80 Image\회사버튼.bmp
         if(ErrorLevel = 0)
         {
            로그추가(스킬)
            Click %OutX%, %OutY%
            Sleep, 3000
            ;~ 결과 := 이미지서치("회사버튼") ;리턴한0을 받아서 결과에저장 (0=찾음)
          }
      }
      
      횟수카운트++
   }
   
}
return 

로그추가(텍스트) ;생성해준 로그추가함수(변수=텍스트)로 여기들어오는 텍스트는 집,회사 가되고
{
   텍스트_ := 텍스트 . "버튼 클릭" ;텍스트_ 변수를 만들고 텍스트에있는 글자와 다른글자를 합하는거고 .을찍으면 뒤에따라오는 텍스트와 이어붙이는 연산자니까 집,회사 뒤에다가 버튼 클릭 이라는 글자를 이어붙여서 텍스트_ 이름을가진 변수에 넣습니다
   FormatTime, OutTime, , M-d H:m:s
   LV_Add("", OutTime, 텍스트_) ;그리고리스트뷰 텍스트에 표시를 할때는 텍스트_에 있는내용을 표시를하면 집버튼이랑회사 버튼을 클릭하도록 텍스트라는 변수로 처리해서 구현을 할수가 있는겁니다
   LV_ModifyCol()  ;줄맞춤 해주고
   return ;리턴 적으면 원래자리로 돌아감
}

F2:: ; F2 누르거나
Button멈춤: ;멈춤버튼 누를때마다
{
   매크로상태 := false ;매크로 동작이 일시정지/다시작동 합니다
}
return

Button종료: ;종료버튼 누르면
{
   ExitApp ;스크립트 종료되면서 프로그램을 닫음
}
return

GuiClose: ;닫기X 누르면
{
   ExitApp ;종료되면서 프로그램을 닫음
}
return