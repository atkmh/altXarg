@echo off
rem 
rem 
rem 
rem 

pkzip a:\mailarc.zip	c:\mark\mail\*.cca

echo testing zip file, making ziptest.txt
pkunzip -t a:*.zip > a:\ziptest.txt
echo checking for warnings in zittest.txt
echo grep -i warning a:\ziptest.txt
grep -i warning a:\ziptest.txt