;/*
;  TwitchSwitch - Title achievement switch on twitch for TheBaartem
;  https://www.twitch.tv/thebaartem
;  Author  : MixidFinder
;  Version : 1.0
;  Date    : 2022-05-29
;*/
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window
SendMode Input
SetTitleMatchMode 2
#WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1

;Gui +AlwaysOnTop
Gui Add, Text,, Название стрима:
Gui Add, Edit, vTitle
Gui Add, Button, default, Apply
Gui Show,, Twitch Switch
Return 

GuiClose:
	ExitApp

ButtonApply:
    Gui, Submit, NoHide 
    titleCount := RegExReplace(Title, ".*?(\d+).*", "$1")
    titleCount2 := titleCount
	Return

MButton::
Achievement:
SendRaw, 
(LTrim
/marker Achievement

)
Sleep, 30
titleCount2 += 1
titleFin := RegExReplace(Title, titleCount, titleCount2)
Sleep, 30
Clipboard := titleFin
Send, 
(LTrim
{!}title ^v

)
Sleep, 30
Clipboard :=
Sleep, 3000
Return

XButton1::
Event:
SendRaw, 
(LTrim
/marker Event

)
Sleep, 3000
Return

XButton2::
Collectibles:
SendRaw, 
(LTrim
/marker Collectibles

)
Sleep, 3000
Return

WheelDown::
Mem:
SendRaw, 
(LTrim
/marker Memt

)
Sleep, 3000
Return

WheelUp::
YouTube:
SendRaw, 
(LTrim
/marker YouTube

)
Sleep, 3000
Return


F8::ExitApp

F12::Pause
