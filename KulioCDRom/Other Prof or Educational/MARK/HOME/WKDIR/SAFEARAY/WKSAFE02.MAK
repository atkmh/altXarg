# Microsoft Visual C++ generated build script - Do not modify

PROJ = WKSAFE02
DEBUG = 1
PROGTYPE = 3
CALLER = 
ARGS = 
DLLS = 
D_RCDEFINES = -d_DEBUG
R_RCDEFINES = -dNDEBUG
ORIGIN = MSVC
ORIGIN_VER = 1.00
PROJPATH = G:\TEST\MHA\MARK\HOME\WKDIR\SAFEARAY\
USEMFC = 0
CC = cl
CPP = cl
CXX = cl
CCREATEPCHFLAG = 
CPPCREATEPCHFLAG = 
CUSEPCHFLAG = 
CPPUSEPCHFLAG = 
FIRSTC =             
FIRSTCPP =             
RC = rc
CFLAGS_D_WTTY = /nologo /W3 /FR /G2 /Zi /D_DEBUG /Od /AM /Mq /Fd"WKSAFE02.PDB"
CFLAGS_R_WTTY = /nologo /W3 /FR /G2 /DNDEBUG /Gs /Ox /AM /Mq
LFLAGS_D_WTTY = /NOLOGO /ONERROR:NOEXE /NOD /PACKC:57344 /CO /ALIGN:16
LFLAGS_R_WTTY = /NOLOGO /ONERROR:NOEXE /NOD /PACKC:57344 /ALIGN:16
LIBS_D_WTTY = oldnames libw mlibcewq
LIBS_R_WTTY = oldnames libw mlibcewq
RCFLAGS = /nologo
RESFLAGS = /nologo
RUNFLAGS = 
OBJS_EXT = 
LIBS_EXT = 
!if "$(DEBUG)" == "1"
CFLAGS = $(CFLAGS_D_WTTY)
LFLAGS = $(LFLAGS_D_WTTY)
LIBS = $(LIBS_D_WTTY)
MAPFILE = nul
RCDEFINES = $(D_RCDEFINES)
DEFFILE=C:\MSVC\BIN\CL.DEF
!else
CFLAGS = $(CFLAGS_R_WTTY)
LFLAGS = $(LFLAGS_R_WTTY)
LIBS = $(LIBS_R_WTTY)
MAPFILE = nul
RCDEFINES = $(R_RCDEFINES)
DEFFILE=C:\MSVC\BIN\CL.DEF
!endif
!if [if exist MSVC.BND del MSVC.BND]
!endif
SBRS = ERROR.SBR \
		SAFEARAY.SBR \
		UNSFARAY.SBR \
		WKSAFE.SBR


ERROR_DEP = g:\test\mha\mark\home\wkdir\safearay\error.h


SAFEARAY_DEP = g:\test\mha\mark\home\wkdir\safearay\safearay.h \
	g:\test\mha\mark\home\wkdir\unsfaray\unsfaray.h \
	g:\test\mha\mark\home\wkdir\unsfaray\error.h


UNSFARAY_DEP = g:\test\mha\mark\home\wkdir\safearay\unsfaray.h \
	g:\test\mha\mark\home\wkdir\safearay\error.h


WKSAFE_DEP = g:\test\mha\mark\home\wkdir\unsfaray\unsfaray.h \
	g:\test\mha\mark\home\wkdir\unsfaray\error.h \
	g:\test\mha\mark\home\wkdir\safearay\safearay.h


all:	$(PROJ).EXE $(PROJ).BSC

ERROR.OBJ:	ERROR.CPP $(ERROR_DEP)
	$(CPP) $(CFLAGS) $(CPPUSEPCHFLAG) /c ERROR.CPP

SAFEARAY.OBJ:	SAFEARAY.CPP $(SAFEARAY_DEP)
	$(CPP) $(CFLAGS) $(CPPUSEPCHFLAG) /c SAFEARAY.CPP

UNSFARAY.OBJ:	UNSFARAY.CPP $(UNSFARAY_DEP)
	$(CPP) $(CFLAGS) $(CPPUSEPCHFLAG) /c UNSFARAY.CPP

WKSAFE.OBJ:	WKSAFE.CPP $(WKSAFE_DEP)
	$(CPP) $(CFLAGS) $(CPPUSEPCHFLAG) /c WKSAFE.CPP


$(PROJ).EXE::	ERROR.OBJ SAFEARAY.OBJ UNSFARAY.OBJ WKSAFE.OBJ $(OBJS_EXT) $(DEFFILE)
	echo >NUL @<<$(PROJ).CRF
ERROR.OBJ +
SAFEARAY.OBJ +
UNSFARAY.OBJ +
WKSAFE.OBJ +
$(OBJS_EXT)
$(PROJ).EXE
$(MAPFILE)
c:\msvc\lib\+
c:\msvc\mfc\lib\+
$(LIBS)
$(DEFFILE);
<<
	link $(LFLAGS) @$(PROJ).CRF
	$(RC) $(RESFLAGS) $@


run: $(PROJ).EXE
	$(PROJ) $(RUNFLAGS)


$(PROJ).BSC: $(SBRS)
	bscmake @<<
/o$@ $(SBRS)
<<
