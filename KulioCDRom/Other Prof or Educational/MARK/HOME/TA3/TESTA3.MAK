# Microsoft Visual C++ generated build script - Do not modify

PROJ = TESTA3
DEBUG = 1
PROGTYPE = 3
CALLER = 
ARGS = 
DLLS = 
D_RCDEFINES = -d_DEBUG
R_RCDEFINES = -dNDEBUG
ORIGIN = MSVC
ORIGIN_VER = 1.00
PROJPATH = G:\TEST\MHA\MARK\HOME\TA3\
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
CFLAGS_D_WTTY = /nologo /W3 /FR /G2 /Zi /D_DEBUG /Od /AM /Mq /Fd"TESTA3.PDB"
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
		UNSFARAY.SBR \
		SAFEARAY.SBR \
		AUTOARAY.SBR \
		BUNCH.SBR \
		ORDBUNCH.SBR \
		COMPLEX.SBR \
		WKAUTO.SBR


ERROR_DEP = g:\test\mha\mark\home\ta3\error.h


UNSFARAY_DEP = g:\test\mha\mark\home\ta3\unsfaray.h \
	g:\test\mha\mark\home\ta3\error.h


SAFEARAY_DEP = g:\test\mha\mark\home\ta3\safearay.h \
	g:\test\mha\mark\home\ta3\unsfaray.h \
	g:\test\mha\mark\home\ta3\error.h


AUTOARAY_DEP = g:\test\mha\mark\home\ta3\autoaray.h \
	g:\test\mha\mark\home\ta3\safearay.h \
	g:\test\mha\mark\home\ta3\unsfaray.h \
	g:\test\mha\mark\home\ta3\error.h


BUNCH_DEP = g:\test\mha\mark\home\ta3\bunch.h \
	g:\test\mha\mark\home\ta3\autoaray.h \
	g:\test\mha\mark\home\ta3\safearay.h \
	g:\test\mha\mark\home\ta3\unsfaray.h \
	g:\test\mha\mark\home\ta3\error.h \
	g:\test\mha\mark\home\ta3\mytypes.h


ORDBUNCH_DEP = g:\test\mha\mark\home\ta3\ordbunch.h \
	g:\test\mha\mark\home\ta3\bunch.h \
	g:\test\mha\mark\home\ta3\autoaray.h \
	g:\test\mha\mark\home\ta3\safearay.h \
	g:\test\mha\mark\home\ta3\unsfaray.h \
	g:\test\mha\mark\home\ta3\error.h \
	g:\test\mha\mark\home\ta3\mytypes.h


COMPLEX_DEP = g:\test\mha\mark\home\ta3\complex.h


WKAUTO_DEP = g:\test\mha\mark\home\ta3\unsfaray.h \
	g:\test\mha\mark\home\ta3\error.h \
	g:\test\mha\mark\home\ta3\safearay.h \
	g:\test\mha\mark\home\ta3\autoaray.h \
	g:\test\mha\mark\home\ta3\complex.h


all:	$(PROJ).EXE $(PROJ).BSC

ERROR.OBJ:	ERROR.CPP $(ERROR_DEP)
	$(CPP) $(CFLAGS) $(CPPUSEPCHFLAG) /c ERROR.CPP

UNSFARAY.OBJ:	UNSFARAY.CPP $(UNSFARAY_DEP)
	$(CPP) $(CFLAGS) $(CPPUSEPCHFLAG) /c UNSFARAY.CPP

SAFEARAY.OBJ:	SAFEARAY.CPP $(SAFEARAY_DEP)
	$(CPP) $(CFLAGS) $(CPPUSEPCHFLAG) /c SAFEARAY.CPP

AUTOARAY.OBJ:	AUTOARAY.CPP $(AUTOARAY_DEP)
	$(CPP) $(CFLAGS) $(CPPUSEPCHFLAG) /c AUTOARAY.CPP

BUNCH.OBJ:	BUNCH.CPP $(BUNCH_DEP)
	$(CPP) $(CFLAGS) $(CPPUSEPCHFLAG) /c BUNCH.CPP

ORDBUNCH.OBJ:	ORDBUNCH.CPP $(ORDBUNCH_DEP)
	$(CPP) $(CFLAGS) $(CPPUSEPCHFLAG) /c ORDBUNCH.CPP

COMPLEX.OBJ:	COMPLEX.CPP $(COMPLEX_DEP)
	$(CPP) $(CFLAGS) $(CPPUSEPCHFLAG) /c COMPLEX.CPP

WKAUTO.OBJ:	WKAUTO.CPP $(WKAUTO_DEP)
	$(CPP) $(CFLAGS) $(CPPUSEPCHFLAG) /c WKAUTO.CPP


$(PROJ).EXE::	ERROR.OBJ UNSFARAY.OBJ SAFEARAY.OBJ AUTOARAY.OBJ BUNCH.OBJ ORDBUNCH.OBJ \
	COMPLEX.OBJ WKAUTO.OBJ $(OBJS_EXT) $(DEFFILE)
	echo >NUL @<<$(PROJ).CRF
ERROR.OBJ +
UNSFARAY.OBJ +
SAFEARAY.OBJ +
AUTOARAY.OBJ +
BUNCH.OBJ +
ORDBUNCH.OBJ +
COMPLEX.OBJ +
WKAUTO.OBJ +
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
