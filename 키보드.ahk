#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; ijkl을 방향키로, uo를 home/end로, spacebar를 백스페이스바 사용하기
{
"global": {
"check_for_updates_on_startup": true,
"show_in_menu_bar": true,
"show_profile_name_in_menu_bar": false
},
"profiles": [
{
"complex_modifications": {
"parameters": {
"basic.simultaneous_threshold_milliseconds": 50,
"basic.to_delayed_action_delay_milliseconds": 500,
"basic.to_if_alone_timeout_milliseconds": 1000,
"basic.to_if_held_down_threshold_milliseconds": 500,
"mouse_motion_to_scroll.speed": 100
},
"rules": []
},
"devices": [
{
"disable_built_in_keyboard_if_exists": false,
"fn_function_keys": [],
"identifiers": {
"is_keyboard": true,
"is_pointing_device": false,
"product_id": 628,
"vendor_id": 1452
},
"ignore": false,
"manipulate_caps_lock_led": true,
"simple_modifications": []
}
],
"fn_function_keys": [
{
"from": {
"key_code": "f1"
},
"to": {
"consumer_key_code": "display_brightness_decrement"
}
},
{
"from": {
"key_code": "f2"
},
"to": {
"consumer_key_code": "display_brightness_increment"
}
},
{
"from": {
"key_code": "f3"
},
"to": {
"key_code": "mission_control"
}
},
{
"from": {
"key_code": "f4"
},
"to": {
"key_code": "launchpad"
}
},
{
"from": {
"key_code": "f5"
},
"to": {
"key_code": "illumination_decrement"
}
},
{
"from": {
"key_code": "f6"
},
"to": {
"key_code": "illumination_increment"
}
},
{
"from": {
"key_code": "f7"
},
"to": {
"consumer_key_code": "rewind"
}
},
{
"from": {
"key_code": "f8"
},
"to": {
"consumer_key_code": "play_or_pause"
}
},
{
"from": {
"key_code": "f9"
},
"to": {
"consumer_key_code": "fastforward"
}
},
{
"from": {
"key_code": "f10"
},
"to": {
"consumer_key_code": "mute"
}
},
{
"from": {
"key_code": "f11"
},
"to": {
"consumer_key_code": "volume_decrement"
}
},
{
"from": {
"key_code": "f12"
},
"to": {
"consumer_key_code": "volume_increment"
}
}
],
"name": "Default macOS",
"parameters": {
"delay_milliseconds_before_open_device": 1000
},
"selected": false,
"simple_modifications": [],
"virtual_hid_keyboard": {
"country_code": 0,
"mouse_key_xy_scale": 100
}
},
{
"complex_modifications": {
"parameters": {
"basic.simultaneous_threshold_milliseconds": 50,
"basic.to_delayed_action_delay_milliseconds": 500,
"basic.to_if_alone_timeout_milliseconds": 1000,
"basic.to_if_held_down_threshold_milliseconds": 500,
"mouse_motion_to_scroll.speed": 100
},
"rules": [
{
"description": "Caps Lock = Hyper",
"manipulators": [
{
"from": {
"key_code": "caps_lock",
"modifiers": {
"optional": [
"any"
]
}
},
"to": [
{
"set_variable": {
"name": "hyper_mod",
"value": 1
}
}
],
"to_after_key_up": [
{
"set_variable": {
"name": "hyper_mod",
"value": 0
}
}
],
"type": "basic"
}
]
},
{
"description": "Hyper + {I, J, K, L} = {↑, ←, ↓, →}",
"manipulators": [
{
"conditions": [
{
"name": "hyper_mod",
"type": "variable_if",
"value": 1
}
],
"from": {
"key_code": "i",
"modifiers": {
"optional": [
"shift"
]
}
},
"to": [
{
"key_code": "up_arrow"
}
],
"type": "basic"
},
{
"conditions": [
{
"name": "hyper_mod",
"type": "variable_if",
"value": 1
}
],
"from": {
"key_code": "j",
"modifiers": {
"optional": [
"shift"
]
}
},
"to": [
{
"key_code": "left_arrow"
}
],
"type": "basic"
},
{
"conditions": [
{
"name": "hyper_mod",
"type": "variable_if",
"value": 1
}
],
"from": {
"key_code": "k",
"modifiers": {
"optional": [
"shift"
]
}
},
"to": [
{
"key_code": "down_arrow"
}
],
"type": "basic"
},
{
"conditions": [
{
"name": "hyper_mod",
"type": "variable_if",
"value": 1
}
],
"from": {
"key_code": "l",
"modifiers": {
"optional": [
"shift"
]
}
},
"to": [
{
"key_code": "right_arrow"
}
],
"type": "basic"
},
{
"conditions": [
{
"name": "hyper_mod",
"type": "variable_if",
"value": 1
}
],
"from": {
"key_code": "spacebar",
"modifiers": {
"optional": [
"shift"
]
}
},
"to": [
{
"key_code": "delete_or_backspace"
}
],
"type": "basic"
}
]
},
{
"description": "Hyper + {U, O} = {Home, End}",
"manipulators": [
{
"conditions": [
{
"name": "hyper_mod",
"type": "variable_if",
"value": 1
}
],
"from": {
"key_code": "u",
"modifiers": {
"optional": [
"shift"
]
}
},
"to": [
{
"key_code": "home"
}
],
"type": "basic"
},
{
"conditions": [
{
"name": "hyper_mod",
"type": "variable_if",
"value": 1
}
],
"from": {
"key_code": "o",
"modifiers": {
"optional": [
"shift"
]
}
},
"to": [
{
"key_code": "end"
}
],
"type": "basic"
}
]
}
]
},
"devices": [
{
"disable_built_in_keyboard_if_exists": false,
"fn_function_keys": [],
"identifiers": {
"is_keyboard": true,
"is_pointing_device": false,
"product_id": 628,
"vendor_id": 1452
},
"ignore": false,
"manipulate_caps_lock_led": true,
"simple_modifications": [
{
"from": {
"key_code": "fn"
},
"to": {
"key_code": "left_option"
}
},
{
"from": {
"key_code": "left_option"
},
"to": {
"key_code": "fn"
}
}
]
}
],
"fn_function_keys": [
{
"from": {
"key_code": "f1"
},
"to": {
"consumer_key_code": "display_brightness_decrement"
}
},
{
"from": {
"key_code": "f2"
},
"to": {
"consumer_key_code": "display_brightness_increment"
}
},
{
"from": {
"key_code": "f3"
},
"to": {
"key_code": "mission_control"
}
},
{
"from": {
"key_code": "f4"
},
"to": {
"key_code": "launchpad"
}
},
{
"from": {
"key_code": "f5"
},
"to": {
"key_code": "illumination_decrement"
}
},
{
"from": {
"key_code": "f6"
},
"to": {
"key_code": "illumination_increment"
}
},
{
"from": {
"key_code": "f7"
},
"to": {
"consumer_key_code": "rewind"
}
},
{
"from": {
"key_code": "f8"
},
"to": {
"consumer_key_code": "play_or_pause"
}
},
{
"from": {
"key_code": "f9"
},
"to": {
"consumer_key_code": "fastforward"
}
},
{
"from": {
"key_code": "f10"
},
"to": {
"consumer_key_code": "mute"
}
},
{
"from": {
"key_code": "f11"
},
"to": {
"consumer_key_code": "volume_decrement"
}
},
{
"from": {
"key_code": "f12"
},
"to": {
"consumer_key_code": "volume_increment"
}
}
],
"name": "CAPSLOCK + IJKL",
"parameters": {
"delay_milliseconds_before_open_device": 1000
},
"selected": true,
"simple_modifications": [
{
"from": {
"key_code": "right_command"
},
"to": {
"key_code": "f18"
}
}
],
"virtual_hid_keyboard": {
"country_code": 0,
"mouse_key_xy_scale": 100
}
}
]
}