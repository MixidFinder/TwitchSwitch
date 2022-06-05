;/*
;  TwitchSwitch - Title achievement switch on twitch for TheBaartem
;  https://www.twitch.tv/thebaartem
;  Author  : MixidFinder
;  Version : 1.1
;  Date    : 2022-06-05
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

Gui +AlwaysOnTop
Gui Add, Text,, Название стрима:
Gui Add, Edit, vTitle
Gui Add, Button, default, Apply
Gui Add, Text,, z - Achievement
Gui Add, Text,, x - Event
Gui Add, Text,, c - Collectibles
Gui Add, Text,, v - Mem
Gui Add, Text,, b - YouTube
Gui Show,, Twitch Switch

ButtonApply:
    Gui, Submit, NoHide 
    titleCount := RegExReplace(Title, ".*?(\d+).*", "$1")
    titleCount2 := titleCount
	Return

z::!z
z::
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

x::!x
x::
Event:
SendRaw, 
(LTrim
/marker Event

)
Sleep, 3000
Return

c::!c
c::
Collectibles:
SendRaw, 
(LTrim
/marker Collectibles

)
Sleep, 3000
Return

v::!v
v::
Mem:
SendRaw, 
(LTrim
/marker Memt

)
Sleep, 3000
Return

b::!b
b::
YouTube:
SendRaw, 
(LTrim
/marker YouTube

)
Sleep, 3000
Return

F8::!F8
F8::Pause

F9::!F9
F9::ExitApp

GuiClose:
	ExitApp
