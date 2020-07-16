#include COM_L.ahk
#include unhtml.ahk
#SingleInstance ignore

menu, tray, NoStandard 
menu, tray, DeleteAll
Menu, tray, add, EXIT
Menu, tray, tip,HTML 분석 -W-

;~ Gui, +AlwaysOnTop
Gui,Add,Text,section cred,* Frame 추천
Gui,Add,edit,vFrame_Recommend_v w300 h150
Gui,Add,Text,,Frame 속성정보
Gui,Add,edit,vFrame_Info_v w300 h80

Gui,Add,GroupBox, 	yp+98 w300 h127 , Browser Info
Gui,Add,GroupBox,	xp+15 yp+20 w270 h43,WindowTitle
Gui,Add,edit,		xp+7 yp+16 w255 vWindowTitle_v ReadOnly,
Gui,Add,GroupBox,	xp-7 yp+30 w270 h43,URL
Gui,Add,edit,		xp+7 yp+16 w255 vURL_v ReadOnly,

Gui,Add,GroupBox, 	xp-22 yp+62 w300 h127 , 진행 안내
Gui, Add, Progress,xp+15 yp+18 w270 h20 cgreen BackgroundC0C0C0  vStatus_Progress,
Gui,Add,Text, w280 r2 vInfo_Progress cblue,[안내] Gui 로딩 완료
Gui,Add,Text, w280 r2 vsetup_info cgreen,[설정]

Gui,Add,Text,section ys cred,* Self 추천
Gui,Add,edit,vSelf_Recommend_v w300 h150
Gui,Add,Text,,Self 속성정보
Gui,Add,edit,vSelf_Info_v w300 h80
Gui,Add,Text,,Self Tag
Gui,Add,edit,vSelf_Tag_v w300 h120
Gui,Add,Text,,Self Text
Gui,Add,edit,vSelf_Text_v w300 h120

Gui,Add,Text,ys cred,* Parent 추천
Gui,Add,edit,vParent_Recommend_v w300 h150
Gui,Add,Text,,Parent 속성정보
Gui,Add,edit,vParent_Info_v w300 h80
Gui,Add,Text,,Parent Tag
Gui,Add,edit,vParent_Tag_v w300 h120
Gui,Add,Text,,Parent Text
Gui,Add,edit,vParent_Text_v w300 h120

gui,Show,,IE_Macro_Helper

SysGet, Monitor_,MonitorWorkArea
Monitor_Right-=300
Monitor_Bottom-=70
Progress, b x%Monitor_Right% y%Monitor_Bottom% FM10 FS10 w300 h70 CBC0C0C0 CTFFFFFF CW808080  HIDE,[초기화],[초기화], Progress Title
DetectHiddenWindows,on
Progress_hwnd:=WinExist("Progress Title")
WinSet, Transparent, 220, Progress Title
return

EXIT:
GuiClose:
ExitApp

F1::IE_HtmlElement()


IE_HtmlElement()
{
	;~ I Changed ahk web recorder (By Tank, Jethrow and Sinkfaze)
	;~ http://www.autohotkey.com/forum/topic51270.html
	global WinHWND,Progress_hwnd
	
	;****** option ********
	Parent_Tag_Skip=B,P,BR				;	Parent_Tag_Skip	=	Parent_node를 구할때 B,P,BR태그는 Parent태그로써 이용하기 힘드므로 건너뛰게 한다
	Max_tag_search_count=0				;	tag_search_count가 너무크면 필요가 없기때문에 값을 제한함 (0=무한대)
	;**********************
	GuiControl,Text,setup_info,% "[설정]	Parent_Tag_Skip=" Parent_Tag_Skip "`n	Max_tag_search_count=" Max_tag_search_count
	
	ComObjError(false)
	COM_error(false)
	
	CoordMode, Mouse
	MouseGetPos, xpos, ypos,WinHWND, hCtl, 3
	WinGetClass, sClass, ahk_id %hCtl%
	
	IfInString,sClass,	MacromediaFlashPlayerActiveX
	{
		if not hCtl:=DllCall("GetAncestor", uint, hCtl, uint, 1)
		{
			GuiControl,text,Info_Progress	, class가 맞지 않습니다. [%sClass%]
			GuiControl,,Status_Progress		, 0
			Gui,show
			Return
		}
		WinGetClass, sClass, ahk_id %hCtl%
	}
	
	If Not sClass == "Internet Explorer_Server"
	{
		GuiControl,text,Info_Progress	, class가 맞지 않습니다. [%sClass%]
		GuiControl,,Status_Progress		, 0
		Gui,show
		Return
	}
	
	GuiControl,text,Info_Progress	, [ 0 단계 ] IE 탐색 시작
	Progress,show
	Progress,0,[ 0 단계 ] IE 탐색 시작,[ IE_Macro_Helper 분석중 ]
	GuiControl,,Status_Progress		, 0
    
	AccObject := Acc_ObjectFromWindow(hCtl) ; Access the IAccessible Interface
	;~ AccObject Example By Jethrow [ http://www.autohotkey.com/forum/topic79790.html ]
	ObjRelease(AccObject)
	IID_IHTMLWindow2 := "{332C4427-26CB-11D0-B483-00C04FD90119}" ; IHTMLWindow2 GUID
	ptr := ComObjQuery(AccObject, IID_IHTMLWindow2, IID_IHTMLWindow2) ; Query for the IHTMLWindow2 Interface
	pwin := ComObjEnwrap(ptr) ; Wrap the pointer so we can use it
	pdoc:=pwin.document
	
	IID_IWebBrowserApp:="{0002DF05-0000-0000-C000-000000000046}"
	ptr2:=ComObjQuery(ptr,IID_IWebBrowserApp,IID_IWebBrowserApp)
	iWebBrowser2 := ComObjEnwrap(ptr2)
	ObjRelease(ptr2)
	
	GuiControl,Text,WindowTitle_v	,%	iWebBrowser2.LocationName
	GuiControl,Text,URL_v			,%	iWebBrowser2.LocationURL
	ObjRelease(iWebBrowser2)
	
	If   pelt := pwin.document.elementFromPoint(	xpos-xorg:=pwin.screenLeft,	ypos-yorg:=pwin.screenTop	)
	{
		ObjRelease(ptr) ; Release the pointer
		ObjRelease(pwin)
		
		Status_timer("[ 1 단계 ] Frame 분석 중")
		Progress,5
		GuiControl,,Status_Progress		, 5
		
		;~ Frame 분석
		Frame_var1_Valid=1
		Frame_var2_Valid=1
		While   (type:=pelt.tagName)="IFRAME" || type="FRAME"
		{
			Frame_temp_Info=
			loop % pelt.attributes.length
			{
				item_value := pelt.attributes.item(A_index-1).value
				if ( item_value  <> "null") AND ( item_value  <> "")
				{
					item_name := pelt.attributes.item(A_index-1).name
					IfNotInString,item_name,aria-
					{
						if item_name in id,name
							Frame_temp_Info:= "[" item_name "] = " item_value "`n" Frame_temp_Info
						else
							Frame_temp_Info.= "[" item_name "] = " item_value "`n"
					}
				}
			}
			
			frame_index		:=	Find_Tag_Index(type, pelt, pdoc)
			frame_referrer	:=	pelt.contentWindow.document.referrer
			Frame_Info .= "[tagName] = " type "`n[frame Index] = " frame_index "`n" Frame_temp_Info "[referrer] = " frame_referrer "`n`n"
			
			frame_name		:=	pelt.name
			frame_id		:=	pelt.id
			
			if (frame_name <> "") AND (Frame_var1_Valid)
				Frame_var1.= type "=" frame_name	","
			else if ( frame_id <> "") AND (Frame_var1_Valid)
				Frame_var1.= type "=" frame_id		","
			else if (Frame_var1_Valid)
			{
				Frame_var1_Valid=
				Frame_var1.= "[" A_index "]단계 Frame name,id 정보를 구하지 못하였습니다,"
			}
			
			if (frame_index <> "") AND (Frame_var2_Valid)
				Frame_var2.= type "=" frame_index	","
			else if (Frame_var1_Valid)
			{
				Frame_var2_Valid=
				Frame_var2.= "[" A_index "]단계 Frame index 정보를 구하지 못하였습니다,"
			}
			
			pbrt:=pelt.contentWindow
			ptr :=   ComObjQuery(ComObjUnwrap(pbrt), IID_IHTMLWindow2,IID_IHTMLWindow2)
			pwin := ComObjEnwrap(ptr)
			ObjRelease(pdoc)
			pdoc :=   pwin.document
			ObjRelease(ptr)
			ObjRelease(pwin)
			
			pbrt :=   pdoc.elementFromPoint( xpos-xorg+=pelt.getBoundingClientRect().left, ypos-yorg+=pelt.getBoundingClientRect().top)
			ObjRelease(pelt)
			pelt:=pbrt
			ObjRelease(pbrt)
		}
		if (Frame_var1 <>"")
		{
			StringTrimRight,Frame_var1,Frame_var1,1
			Frame_var1=frame=%Frame_var1%
		}
		if (Frame_var2 <>"")
		{
			StringTrimRight,Frame_var2,Frame_var2,1
			Frame_var2=frame=%Frame_var2%
		}
		
		
		;~ 아웃라인 그리기
		pbrt :=   pelt.getBoundingClientRect()
		l  :=   pbrt.left
		t  :=   pbrt.top
		r  :=   pbrt.right
		b  :=   pbrt.bottom
		ObjRelease(pbrt)
		;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
		global x1, y1, x2, y2
		If(x1 <> l+xorg || y1 <> t+yorg || x2 <> r+xorg || y2 <> b+yorg)
			Outline( x1:=l+xorg, y1:=t+yorg, x2:=r+xorg, y2:=b+yorg)
		;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		
		
		;~ Self Tag 분석 파트
		Status_timer("[ 2 단계 ] Self Tag 분석 중")
		Progress,20
		GuiControl,,Status_Progress		, 20
		Tag_Analysis(pelt , pdoc , Self_Recommend , Self_info , Self_HTML , Self_Text)
		
		
		;~ Self의 ParentNode Tag 분석 파트
		Status_timer("[ 3 단계 ] Parent Tag 분석 중")
		Progress,60
		GuiControl,,Status_Progress		, 60
		Loop
		{
			pelt	:=	pelt.parentNode
			type	:=	pelt.tagName
			if type not in %Parent_Tag_Skip%
				break
		}
		Tag_Analysis(pelt , pdoc , Parent_Recommend , Parent_info , Parent_HTML , Parent_Text)
		
		
		ObjRelease(pelt)
		
		;~ Gui 창에 수집한 정보 띄우기
		GuiControl,Text,Frame_Info_v,%		Frame_Info
		GuiControl,Text,Frame_Recommend_v,%	"[ name,id 추천 ]`n" Frame_var1 "`n`n[ index 추천 ]`n" Frame_var2
		
		GuiControl,Text,Self_Recommend_v,%	Self_Recommend
		GuiControl,Text,Self_Info_v,%			Self_info
		GuiControl,Text,Self_Tag_v,%			Self_HTML
		GuiControl,Text,Self_Text_v,%			Self_Text
		
		GuiControl,Text,Parent_Recommend_v,%	Parent_Recommend
		GuiControl,Text,Parent_Info_v,%		Parent_info
		GuiControl,Text,Parent_Tag_v,%		parent_HTML
        GuiControl,Text,Parent_Text_v,%		Parent_Text
		
		Progress,100,[ 분석완료 ]
		GuiControl,,Status_Progress		, 100
		GuiControl,text,Info_Progress	, [ 분석완료 ]
	}
	else
		GuiControl,text,Info_Progress	, [ 실패 ] elementFromPoint 명령 실패
	
	WinHide,ahk_id %Progress_hwnd%
	Gui,show
	ObjRelease(pdoc)
	SetTimer,Status_timer_act,off
	Return
}


Tag_Analysis(pelt , pdoc , ByRef Recommend , ByRef info , ByRef HTML , ByRef Text)
{
	type			:=	pelt.TagName
	Tag_Index		:=	Find_Tag_Index(type, pelt, pdoc)
	Recommend	:= "tag_type=" type "`ntag_option_name=index`ntag_option_value=" Tag_Index "`ntag_search_count:=1`ntag_search_Exact:=1`n`n"
	loop % pelt.attributes.length
	{
		item_value := pelt.attributes.item(A_index-1).value
		if ( item_value  <> "null") AND ( item_value  <> "")
		{
			item_name := pelt.attributes.item(A_index-1).name
			IfNotInString,item_name,aria-
			{
				if item_name=class
					item_name=className
				
				if item_name in id,name
					info:= "[" item_name "] = " item_value "`n" info
				else
					info.= "[" item_name "] = " item_value "`n"
				
				;~ 추천 변수 자동생성
				temp_pdoc:=ComObjUnwrap(pdoc)
				tag_search_count=0
				Loop % pdoc.all.tags(type).length
				{
					temp_value := Com_invoke(temp_pdoc,"all.tags(" type ").item(" A_Index-1 ")." item_name)
					if (temp_value = item_value) OR ( (item_value="false") AND (temp_value = 0) )
					{
						tag_search_count++
						if Com_invoke(temp_pdoc,"all.tags(" type ").item(" A_Index-1 ").sourceIndex") = pelt.sourceIndex
						{
							if item_name in id,name
								Recommend := "tag_type=" type "`ntag_option_name=" item_name "`ntag_option_value=" temp_value "`ntag_search_count:=" tag_search_count "`ntag_search_Exact:=1`n`n" Recommend
							else
								Recommend .= "tag_type=" type "`ntag_option_name=" item_name "`ntag_option_value=" temp_value "`ntag_search_count:=" tag_search_count "`ntag_search_Exact:=1`n`n"
							break
						}
						if (Max_tag_search_count) AND ( tag_search_count >= Max_tag_search_count )
							break
					}
				}
				ObjRelease(temp_pdoc)
			}
		}
	}
	info:="[tagName] = " type "`n[tag index] = " Tag_index "`n" info
	HTML:=unHTML_StripEntities(pelt.outerHTML)
	Text:=pelt.outerText
}


Find_Tag_Index(type, pelt, pdoc)
{
	Loop % pdoc.all.tags(type).length
	{
		if ( pdoc.all.tags(type).item(A_index-1).sourceIndex = pelt.sourceIndex )
			return A_Index-1
	}
	return
}


SetOutlineTransparent:
	Loop, 4
		WinSet, Transparent, 0, % outline%A_Index%
Return

Outline(x1,y1="",x2="",y2="") {
	global Resized, WinHWND
	If x1 = Hide
	{
		Loop, 4
			Gui, % A_Index+1 ": Hide"
		Return
	}
	GoSub, SetOutlineTransparent
	Loop, 4 {
		Gui, % A_Index+1 ": Hide"
		Gui, % A_Index+1 ": -Caption +ToolWindow"
		Gui, % A_Index+1 ": Color" , Red
	}
    
	WinGetPos, Wx, Wy, , , ahk_id %WinHWND%
	
	ControlGetPos, Cx1, Cy1, Cw, Ch, Internet Explorer_Server1, ahk_id %WinHWND%
	Cx1 += Wx, Cy1 += Wy, Cx2 := Cx1+Cw, Cy2 := Cy1+Ch, Resized := False ; set "Internet Explorer_Server1" dimensions (set variable "Resized" as true)
	
	If(y1>Cy1)
		Gui, 2:Show, % "NA X" (x1<Cx1 ? Cx1 : x1)-2 " Y" (y1<Cy1 ? Cy1 : y1)-2 " W" (x2>Cx2 ? Cx2 : x2)-(x1<Cx1 ? Cx1 : x1)+4 " H" 2,outline1
	If(x2<Cx2)
		Gui, 3:Show, % "NA X" (x2>Cx2 ? Cx2 : x2) " Y" (y1<Cy1 ? Cy1 : y1) " W" 2 " H" (y2>Cy2 ? Cy2 : y2)-(y1<Cy1 ? Cy1 : y1),outline2
	If(y2<Cy2)
		Gui, 4:Show, % "NA X" (x1<Cx1 ? Cx1 : x1)-2 " Y" (y2>Cy2 ? Cy2 : y2) " W" (x2>Cx2 ? Cx2 : x2)-(x1<Cx1 ? Cx1 : x1)+4 " H" 2,outline3
	If(x1>Cx1)
		Gui, 5:Show, % "NA X" (x1<Cx1 ? Cx1 : x1)-2 " Y" (y1<Cy1 ? Cy1 : y1) " W" 2 " H" (y2>Cy2 ? Cy2 : y2)-(y1<Cy1 ? Cy1 : y1),outline4
	
	GoSub, SetOulineLevel
	Return
}

SetOulineLevel:
	If Not outline1
		Loop, 4
			WinGet, outline%A_Index%, ID, % "outline" A_Index " ahk_class AutoHotkeyGUI"
	; thanks Chris! - http://www.autohotkey.com/forum/topic5672.html&highlight=getnextwindow
	hwnd_above := DllCall("GetWindow", "uint", WinHWND, "uint", 0x3) ; get window directly above "WinHWND"
	While(hwnd_above=outline1 || hwnd_above=outline2 || hwnd_above=outline3 || hwnd_above=outline4 || hwnd_above=GuiHWND) ; don't use 5 AHK GUIs
		hwnd_above := DllCall("GetWindow", "uint", hwnd_above, "uint", 0x3)
	; thanks Lexikos! - http://www.autohotkey.com/forum/topic22763.html&highlight=setwindowpos
	Loop, 4 { ; set 4 "outline" GUI's directly below "hwnd_above"
		DllCall("SetWindowPos", "uint", outline%A_Index%, "uint", hwnd_above
			, "int", 0, "int", 0, "int", 0, "int", 0
			, "uint", 0x13) ; NOSIZE | NOMOVE | NOACTIVATE ( 0x1 | 0x2 | 0x10 )
		WinSet, Transparent, 255, % outline%A_Index%
	}
Return


Status_timer_act:
timer_dot_count++
if (timer_dot_count = 1)
{
	GuiControl,text,Info_Progress	,% Status_timer_Text "."
	Progress,,% Status_timer_Text "."
}
else if (timer_dot_count = 2)
{
	GuiControl,text,Info_Progress	,% Status_timer_Text ".."
	Progress,,% Status_timer_Text ".."
}
else
{
	GuiControl,text,Info_Progress	,% Status_timer_Text "..."
	Progress,,% Status_timer_Text "..."
	timer_dot_count=0
}
return

Status_timer(show_info)
{
	global Status_timer_Text:=show_info
	global timer_dot_count:=0
	GuiControl,text,Info_Progress	,% show_info
	Progress,,% show_info
	SetTimer,Status_timer_act,500
}


UriEncode(Uri, Enc = "UTF-8") 
{ 
   StrPutVar(Uri, Var, Enc) 
   f := A_FormatInteger 
   SetFormat, IntegerFast, H 
   Loop 
   { 
      Code := NumGet(Var, A_Index - 1, "UChar") 
      If (!Code) 
         Break 
      If (Code >= 0x30 && Code <= 0x39 ; 0-9 
         || Code >= 0x41 && Code <= 0x5A ; A-Z 
         || Code >= 0x61 && Code <= 0x7A) ; a-z 
         Res .= Chr(Code) 
      Else 
         Res .= "%" . SubStr(Code + 0x100, -1) 
   } 
   SetFormat, IntegerFast, %f% 
   Return, Res 
} 

UriDecode(Uri, Enc = "UTF-8") 
{ 
   Pos := 1 
   Loop 
   { 
      Pos := RegExMatch(Uri, "i)(?:%[\da-f]{2})+", Code, Pos++) 
      If (Pos = 0) 
         Break 
      VarSetCapacity(Var, StrLen(Code) // 3, 0) 
      StringTrimLeft, Code, Code, 1 
      Loop, Parse, Code, `% 
         NumPut("0x" . A_LoopField, Var, A_Index - 1, "UChar") 
      StringReplace, Uri, Uri, `%%Code%, % StrGet(&Var, Enc), All 
   } 
   Return, Uri 
} 

StrPutVar(Str, ByRef Var, Enc = "") 
{ 
   Len := StrPut(Str, Enc) * (Enc = "UTF-16" || Enc = "CP1200" ? 2 : 1) 
   VarSetCapacity(Var, Len, 0) 
   Return, StrPut(Str, &Var, Enc) 
}


;------------------------------------------------------------------------------
; Acc.ahk Standard Library
; by Sean
; *Note: Modified ComObjEnwrap params from (9,pacc) --> (9,pacc,1)
; *Note: Changed ComObjUnwrap to ComObjValue in order to avoid AddRef
;------------------------------------------------------------------------------
Acc_Init()
{
	Static	h
	If Not	h
		h:=DllCall("LoadLibrary","Str","oleacc","Ptr")
}
Acc_ObjectFromWindow(hWnd, idObject = -4)
{
	Acc_Init()
	If	DllCall("oleacc\AccessibleObjectFromWindow", "Ptr", hWnd, "UInt", idObject&=0xFFFFFFFF, "Ptr", -VarSetCapacity(IID,16)+NumPut(idObject==0xFFFFFFF0?0x46000000000000C0:0x719B3800AA000C81,NumPut(idObject==0xFFFFFFF0?0x0000000000020400:0x11CF3C3D618736E0,IID,"Int64"),"Int64"), "Ptr*", pacc)=0
	Return	ComObjEnwrap(9,pacc,1)
}