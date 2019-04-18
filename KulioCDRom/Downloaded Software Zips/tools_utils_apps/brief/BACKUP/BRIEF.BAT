@set bpath=c:\brief\macros
@set bhelp=c:\brief\help
@set bfile=\brief\state.rst
@REM set bcc="!cl -Zs -Gsw -Os -W2 -Zpe -AM %%s.c"
@set bcc="!cemcom -IC:\WB\INCL_480 -L -z -DPETROL -DCG -DCT3 -DJCP -Vp4.2 %%s.c %%s.k"
@set bcm=cm
@set bpackages=c:t;asm,m:r;dok,ext:wp
@set bflags=-aB0i32k3l196Mtu130z -mMARK -mrestore
@set btmp=C:\brief

