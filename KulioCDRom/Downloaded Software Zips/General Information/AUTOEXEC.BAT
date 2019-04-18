rem @ECHO OFF
SET COMSPEC=C:\COMMAND.COM
set TZ=PST+8PDT
C:\WINDOWS\SMARTDRV.EXE /L /X
PROMPT $p$g
PATH c:\pctcp;c:\nwclient;C:\WINDOWS;c:\dos;C:\NETSCAPE;C:\CCMOBILE;
PATH=%PATH%c:\;c:\mark\bin;c:\brief;c:\utils;

choice /c:yn /t:y,3 "? Load the SYBASE OPEN CLIENT ENVIRONMENT "
if errorlevel 2 goto nosyblod
CALL C:\SQL10\BIN\WSYBSET.BAT

:nosyblod
SET TEMP=C:\DOS
LH DOSKEY /insert
rem call brief.bat
choice /c:yn /t:y,2 " Hey-- Load the network drivers and Logon ?????"
if errorlevel 2 goto next

@CALL C:\NWCLIENT\STARTNET
LH /L:1,7520 c:\pctcp\odipkt.com
set pctcp=c:\pctcp\pctcp.ini
LH /L:0;1,3792 /S c:\pctcp\vxdinit.exe

choice /c:yn /t:y,3 "? Capture printers and map servers ? "
if errorlevel 2 goto next

F:
login raven/matkinso < c:\pw.txt

rem login muttley/matkinso  /NS< c:\muttley.pw

map s:=raven\ccmail:
capture l=1 q=LJ-200-TP s=RAVEN ti=30 tabs=4 nb nff
login nvl4/matkinso /NS
login sqa/matkinso /NS

rem map k:=muttley/data:

map g:=nvl4\vol1: 
map h:=nvl4\vol1:
map i:=nvl4\vol1:
g:
cd g:\test\t\ops
h:
cd h:\test\pum\t\sys
i:
cd i:\test\pum\t\380
h:
call loadmark.bat
cd h:\test\pum\t
subst D: C:\ram
C:
:next
echo.
echo.
echo.
choice /c:yn /t:y,5 "? Start Windows ? "
if errorlevel 2 goto end
WIN
:end


