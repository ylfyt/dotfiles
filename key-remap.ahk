; Mapping arrow key using o k l ;
<!k:: Send {left}
<!l:: Send {down}
<!o:: Send {up}
<!;:: Send {right}

; LAlt+V or LAlt+C : Switch right and left virtual desktop
<!c:: Send ^#{left}
<!v:: Send ^#{right}

RAlt:: Send ^#{left}
RCtrl:: Send ^#{Right}

; Disable pgup pgdn
PgUp::Return
PgDn::Send +!f

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