@echo off
rem 
rem 
rem 
rem 
if not exist c:\backup\c_disk.txt goto skipmove
c:\utils\mv c:\backup\c_disk.txt c:\backup\dskimage

:skipmove
c:
cd \
dir /og/oe/s > c:\backup\c_disk.txt


copy c:\*.*	      c:\backup\*.*
copy c:\windows\*.ini c:\backup\ini\*.*
copy c:\windows\*.grp c:\backup\grp\*.*
copy c:\windows\*.pif c:\backup\pif\*.*
del c:\backup\command.com
del c:\backup\wina20.386


xcopy c:\mark\bin\*.* a:\ /s/e

pkzip -rp a:backup.zip		c:\backup\*.*
pkzip -rp a:\evaluatr.zip	c:\mark\evhost\*.*
pkzip -rp a:\lab.zip		c:\mark\lab\*.*
pkzip -rp a:\testdefs.zip	c:\mark\testdefs\*.*
pkzip -rp a:\testdefs.zip	c:\mark\testing\*.*
pkzip -rp a:\weektask.zip	c:\mark\weektask\*.*
pkzip -rp a:\qa.zip		c:\qa\*.*
copy c:\mark\*.* a:\*.*

pkunzip -t a:*.zip > a:\ziptest.txt
grep -i warning a:\ziptest.txt