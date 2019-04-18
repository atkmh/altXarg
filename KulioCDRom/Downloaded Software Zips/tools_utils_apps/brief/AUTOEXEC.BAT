\dos\386MAX\386load size=43360 flexframe prog=\C700\BIN\SMARTDRV.EXE 2048
PATH=C:\BRIEF;c:\wb;c:\C700\BIN;c:\bin;C:\DOS;C:\UTIL
Set LIB=C:\C700\LIB
@Set INCLUDE=C:\C700\INCLUDE
@Set HELPFILES=C:\C700\HELP\*.HLP
@Set INIT=C:\C700\INIT
mode CON rate=28 delay=1
@set DIRCMD=/L
@
@rem Setup PVCS project
@set project=T2
@
\dos\386MAX\386load size=6400 flexframe prog=doskey >NUL
@mode co80
@REM mode CON lines=50   (10/07/92)
@prompt $t$h$h$h $p$g
c
@call \brief\brief.bat
@doskey
@dir \kermit\*.
