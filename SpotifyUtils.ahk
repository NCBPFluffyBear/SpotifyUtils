; SpotifyControls.ahk:
; AHK Script to control Spotify using hotkeys
; Copyright (C) 2022  NCBPFluffyBear

DetectHiddenWindows, On
#SingleInstance Force

; Globals
global blacklist_file := "./spotify_blacklist.txt"
global blackList := ""

; Load songs
loadBlacklist()

; Start 1000ms clock
SetTimer, checkSong, 1000

; Get the HWND of the Spotify main window.
getSpotifyHwnd() {
	WinGet, spotifyHwnd, ID, ahk_exe spotify.exe
	Return spotifyHwnd
}

; Send a key to Spotify.
spotifyKey(key) {
	if (WinActive("ahk_exe Spotify.exe")) {
		Send, %key%
	} else {
		spotifyHwnd := getSpotifyHwnd()
		; Chromium ignores keys when it isn't focused.
		; Focus the document window without bringing the app to the foreground.
		ControlFocus, Chrome_RenderWidgetHostHWND1, ahk_id %spotifyHwnd%
		ControlSend, , %key%, ahk_id %spotifyHwnd%
	}
	Return
}

; Play/Pause Toggle
#!s::
{
	spotifyKey("{Space}")
	Return
}

; Next Song
#!d::
{
	spotifyKey("^{Right}")
	Return
}

; Previous Song
#!a::
{
	spotifyKey("^{Left}")
	Return
}

; Seek Forward
#!Right::
{
	spotifyKey("+{Right}")
	Return
}

; Seek Backward
#!Left::
{
	spotifyKey("+{Left}")
	Return
}

; Increase Volume
#!x::
{
	spotifyKey("^{Up}")
	Return
}

; Decrease Volume
#!z::
{
	spotifyKey("^{Down}")
	Return
}

; Show Spotify Window
#!o::
{
	spotifyHwnd := getSpotifyHwnd()
	WinGet, style, Style, ahk_id %spotifyHwnd%
	if (style & 0x10000000) { ; WS_VISIBLE
		WinHide, ahk_id %spotifyHwnd%
	} Else {
		WinShow, ahk_id %spotifyHwnd%
		WinActivate, ahk_id %spotifyHwnd%
	}
	Return
}

; ---------------------------------------------------------------------------SPOTIFY SKIPPER--------------------------------------------------------------
; Hi future me when this script breaks!
; This script:
; 1. Loads in spotify_blacklist.txt as a string
; 2. Splits the string by `n (AHK just uses backtick instead of backslash)

checkSong:
	WinGetTitle, song, ahk_exe Spotify.exe
	if (hasVal(song, blackList)) {
		spotifyKey("^{Right}")
	}
Return

; Adds current song to blacklist file and reload blacklist
#!delete::
	WinGetTitle, song, ahk_exe Spotify.exe
	
	if (hasVal(song, blackList)) {
		SoundPlay, *16
		Return
	}

	FileAppend, %song%`n, %blacklist_file%
	loadBlacklist()
	SoundBeep, 750, 150
	SoundBeep, 500, 150
Return

; Deletes the last line from blacklist file (Like an undo function)
#!backspace::
	FileRead, text, %blacklist_file%
	FileDelete, %blacklist_file%
	FileAppend, % SubStr(text, 1, RegExMatch(text, "\R.*\R?$")-2)"`n", %blacklist_file%
	loadBlacklist()
	SoundBeep, 500, 150
	SoundBeep, 750, 150
Return

#!q::ExitApp

; Accesses global variables defined at the top
loadBlacklist() {
	FileRead, songBlacklist, %blacklist_file% ; Load file
	blackList := StrSplit(songBlacklist, "`n", "`r`") ; Split by newline (AHK Supports arrays)
	return
}

hasVal(needle, haystack) {
	if !(IsObject(haystack)) || (haystack.Length() = 0)
		return 0
	for i, value in haystack {
		if (value = needle) {
			return 1
		}
	}
	return 0
}