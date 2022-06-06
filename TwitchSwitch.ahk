;/*
;  TwitchSwitch - Title achievement switch on twitch for TheBaartem
;  https://www.twitch.tv/thebaartem
;  Author  : MixidFinder
;  Version : 1.2
;  Date    : 2022-06-06
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
Gui Add, Text, x10 y6 w93 h13, Название стрима:
Gui Add, Edit, x10 y25 w231 h21
Gui Add, Button, x10 y52 w38 h23, Apply
Gui Add, Text, x10 y81 w76 h13, z - Achievement
Gui Add, Text, x10 y102 w42 h13, x - Event
Gui Add, Text, x100 y81 w70 h13, m - Collectibles
Gui Add, Text, x61 y102 w38 h13, n - Mem
Gui Add, Text, x108 y102 w59 h13, b - YouTube
Gui Add, Text, x176 y102 w51 h13, F8 - Pause
Gui Add, Text, x188 y81 w38 h13, F9 - Exit

Gui Show, w258 h128, Twitch Switch

F8::Suspend

F9::!F9
F9::ExitApp

ClipPutText(Text, uLocale = 0x419)
{
    static CF_LOCALE := 16, GMEM_MOVEABLE := 2
    TextLen := StrLen(Text)
    If (A_IsUnicode) {
        cbTextBuf := TextLen * 2 + 2
        uFormat := 13   ; CF_UNICODETEXT
    }
    Else {
        cbTextBuf := TextLen + 1
        uFormat := 1    ; CF_TEXT
    }
    hText := DllCall("GlobalAlloc", "uint", GMEM_MOVEABLE, "ptr", cbTextBuf, "ptr")
    hLocale := DllCall("GlobalAlloc", "uint", GMEM_MOVEABLE, "ptr", 4, "ptr")
    If (!hText || !hLocale) {
        ErrorMsg := "Ошибка выделения памяти."
        Goto, Error
    }
    pText := DllCall("GlobalLock",  "ptr", hText, "ptr")
    pLocale := DllCall("GlobalLock", "ptr", hLocale, "ptr")
    StrPut(Text, pText), NumPut(uLocale, pLocale + 0, 0, "uint")
    DllCall("GlobalUnlock", "ptr", hText), DllCall("GlobalUnlock", "ptr", hLocale)
    Opened := DllCall("OpenClipboard", "ptr", 0)
    If (!Opened) {
        ErrorMsg := "Не удалось открыть буфер обмена."
        Goto, Error
    }
    If !DllCall("EmptyClipboard") {
        ErrorMsg := "Не удалось очистить буфер обмена."
        Goto, Error
    }
    If (!DllCall("SetClipboardData", "uint", uFormat, "ptr", hText, "ptr")
    || !DllCall("SetClipboardData", "uint", CF_LOCALE, "ptr", hLocale, "ptr")) {
        ErrorMsg := "Ошибка при записи в буфер обмена."
        Goto, Error 
    }
    DllCall("CloseClipboard")
    Return True
Error:
    If Opened
        DllCall("CloseClipboard")
    If hText
        DllCall("GlobalFree", "ptr", hText)
    If hLocale
        DllCall("GlobalFree", "ptr", hLocale)
    MsgBox,, %A_ThisFunc%, %ErrorMsg%
    Return False
}

ClipGetText(uCodePage = 1251)
{
    static CF_TEXT := 1, CF_UNICODETEXT := 13
    uFormat := 0
    If !DllCall("OpenClipboard", "ptr", 0) {
        MsgBox,, %A_ThisFunc%, Не удалось открыть буфер обмена.
        Return False
    }
    Loop
    {
        uFormat := DllCall("EnumClipboardFormats", "uint", uFormat)
        If (uFormat = 0 || uFormat = CF_UNICODETEXT || uFormat = CF_TEXT)
            Break
    }
    If (uFormat = 0) {
        DllCall("CloseClipboard")
        MsgBox,, %A_ThisFunc%, Нет текста в буфере обмена.
        Return False
    }
    hText := DllCall("GetClipboardData", "uint", uFormat, "ptr")
    pText := DllCall("GlobalLock", "ptr", hText, "ptr")
    If (A_IsUnicode) {
        If (uFormat = CF_UNICODETEXT)
            Text := StrGet(pText)
        Else {
            cbText := DllCall("lstrlenA", "ptr", pText) + 1
            cchText := DllCall("MultiByteToWideChar", "uint", uCodePage, "int", 0
                        , "ptr", pText, "uint", cbText, "ptr", 0, "uint", 0)
            VarSetCapacity(Text, cchText * 2)
            DllCall("MultiByteToWideChar", "uint", uCodePage, "int", 0
                        , "ptr", pText, "uint", cbText, "ptr", &Text, "uint", cchText)
            VarSetCapacity(Text, -1)
        }
    }
    Else {
        If (uFormat = CF_TEXT)
            Text := StrGet(pText)
        Else {
            cchText := DllCall("lstrlenW", "ptr", pText) + 1
            cbText := DllCall("WideCharToMultiByte", "uint", uCodePage, "int", 0
                        , "ptr", pText, "uint", cchText, "ptr", 0, "uint", 0, "ptr", 0, "ptr", 0)
            VarSetCapacity(Text, cbText)
            DllCall("WideCharToMultiByte", "uint", uCodePage, "int", 0
                        , "ptr", pText, "uint", cchText, "ptr", &Text, "uint", cbText, "ptr", 0, "ptr", 0)
            VarSetCapacity(Text, -1)
        }
    }
    DllCall("GlobalUnlock", "ptr", hText)
    DllCall("CloseClipboard")
    Return Text
}

ButtonApply:
    Gui, Submit, NoHide 
    titleCount := RegExReplace(Title, ".*?(\d+).*", "$1")
    titleCount2 := titleCount
    titleText := ClipGetText()
    ClipPutText(titleText)
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
titleFin := RegExReplace(titleText, titleCount, titleCount2)
Sleep, 30
ClipPutText(titleFin)
Sleep, 30
Send, 
(LTrim
{!}title ^v

)
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

m::!m
m::
Collectibles:
SendRaw, 
(LTrim
/marker Collectibles

)
Sleep, 3000
Return

n::!n
n::
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

GuiClose:
	ExitApp
