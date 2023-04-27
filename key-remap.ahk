^!r::Reload  ; Ctrl+Alt+R

; Mapping arrow key using o k l ;
<!k:: Send {left}
<!l:: Send {down}
<!o:: Send {up}
<!;:: Send {right}

; LAlt+V or LAlt+C : Switch right and left virtual desktop
; <!c:: Send ^#{left}
; <!v:: Send ^#{right}

NumpadMult:: Send ^#{left}
NumpadSub:: Send ^#{Right}

; Disable pgup pgdn
PgUp::Return
PgDn::Send +!f

; >^]::send {LWin down}{LCtrl down}{Left}{LCtrl up}{LWin up}

; LAlt+C or LAlt+doubleC : Switch right and left virtual desktop
/*
LAlt & c::
KeyWait, c
KeyWait, c, D, T0.20
If ErrorLevel = 1
 Send ^#{right}
Else
 Send ^#{left}
Return
*/

Ins::Send,  {PrintScreen}

NumpadUp::Send {Volume_Up}
NumpadDown::Send {Volume_Down}
NumpadLeft::Send {Media_Prev}
NumpadRight::Send {Media_Next}
NumpadPgdn::Send {Volume_Mute}
NumpadClear::Send {Media_Play_Pause}