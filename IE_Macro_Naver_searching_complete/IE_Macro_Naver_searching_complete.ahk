﻿#include COM_L.ahk
#include IE_Macro_By_Tag_L.ahk
COM_Init()
return

^q::exitapp

F3::
if Get_pwb(pwb)
{
	네이버아이디=Hello World
	네이버비밀번호=
	/*
	method=click()
	method_value=
	method_usage_type:=1
	tag_type=IMG
	tag_option_name=id
	tag_option_value=lv1_img
	tag_search_count:=1
	tag_search_Exact:=1
	frame=IFRAME=loginframe
	*/

	method=value
	method_value=%네이버아이디%
	method_usage_type:=1
tag_type=INPUT
tag_option_name=name
tag_option_value=query
tag_search_count:=1
tag_search_Exact:=1
	IE_Macro( pwb , method , method_value , method_usage_type , tag_type , tag_option_name, tag_option_value , tag_search_count, tag_search_Exact , frame)
	
	method=click()
	method_value=
	method_usage_type:=1
	tag_type=SPAN
	tag_option_name=index
	tag_option_value=10
	tag_search_count:=1
	tag_search_Exact:=1

	IE_Macro( pwb , method , method_value , method_usage_type , tag_type , tag_option_name, tag_option_value , tag_search_count, tag_search_Exact , frame)
	
	
	method=value
	method_value=%네이버비밀번호%
	method_usage_type:=1
	tag_type=INPUT
	tag_option_name=name
	tag_option_value=pw
	tag_search_count:=1
	tag_search_Exact:=1
	frame=IFRAME=loginframe
	IE_Macro( pwb , method , method_value , method_usage_type , tag_type , tag_option_name, tag_option_value , tag_search_count, tag_search_Exact , frame)
	
	method=click()
	method_value=
	method_usage_type:=1
	tag_type=INPUT
	tag_option_name=className
	tag_option_value=submit
	tag_search_count:=1
	tag_search_Exact:=1
	frame=IFRAME=loginframe
	IE_Macro( pwb , method , method_value , method_usage_type , tag_type , tag_option_name, tag_option_value , tag_search_count, tag_search_Exact , frame)
	
	frame=IFRAME=loginframe
	if IE_Loading_Check(pwb, frame)
		msgbox 네이버 로그인 완료!
	COM_Release(pwb)
}
return