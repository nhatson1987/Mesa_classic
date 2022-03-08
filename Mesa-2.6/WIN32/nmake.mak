.SILENT:

help:
	more < <<
usage: nmake[.exe] /f nmake.mak [options] [target]
where: [target] may be any one of the following ...
    (default)... shows this text
    libfiles.... builds all library variations and test programs
    update...... builds all variations and copies target files
                 to permanent storage locations
    clean....... deletes all intermediate files
    distclean - deletes all intermediate files and all end-executables,
                restoring directory heirarchy to 'distribution' state.
    all - builds all targets
    ---- build options -----------------
    MESAVER ................. (2.6) - version of MesaLib().tar.gz to build
    MESADEMOVER ............. (2.6) - version of MesaDemos().tar.gz to build
    NOCONSOLE .... [1 | 0] .. (0) ..- Disable console output of progs
    DEBUG ........ [1 | 0] .. (0) ..- Build for debugging
	USE_MMX ...... [1 | 0] .. (0) ..- Enable use of Intel MMX opcodes
    USE_CTRDLL.... [1 | 0] .. (0) ..- Enable use of MSVCRT.DLL for CRTL in
    GD_NO_PROGS... [1 | 0] .. (0) ..- Disable diff generation for MesaDemos.
                   preference to statically linking in the CRTL. Makes for
                   smaller files *but* requires MSVCRT.DLL at runtime.
    STATIC_MESA... [1 | 0] .. (0) ..- Meaningful only when building executables.
        Indicates to the nmake.mak that exe files should be linked with
        static link libs (mesa|mesaglu|mesaglut|mesaaux|mesatk).lib instead
        of the default DLL import libs.  This directive trickes down into
        a compiler macro definition which itself directs the mesa "gl.h" file
        to redefine APIENTRY, CALLBACK, and WINGDIAPI.
    ALLWARNINGS... [1 | 0] .. (0) ..- Enable all compiler warnings, by default
                   the following compile time warnings are disabled:
        C4244: '=' : conversion from 'type1' to 'type2',
               possible loss of data
        C4018: '<' : signed/unsigned mismatch
        C4305: '=' : truncation from 'type1' to 'type2'
        C4013: 'function' undefined; assuming extern returning int
        C4761: integral size mismatch in argument; conversion supplied
		C4273: 'identifier' : inconsistent DLL linkage. dllexport assumed
        C4101: 'identifier' : unreferenced local variable

        ... additionally, if you manually set the MESA_WARNQUIET CPPOPT
            definition greater than 1 then these additional warnings are
            turned off also:

        C4146: unary minus operator applied to unsigned type,
               result still unsigned

    ---- special targets ---------------
    libfiles ........................ all *.lib and *.dll files
    tests ..........(req libfiles)... all test executables
    progs ..........(req libfiles)... all demonstration executables
    progs.samples / progs.demos /
    progs.book / progs.3dfx.demos ... individual demo program group builds
    gendiffs ........................ generates complete diffs between
                   original distribution and locally modified source files.
    gendiffs.clr .................... cleans up behind gendiffs target.

    ---- convenience targets -----------
    allstatic ....................... builds all "standard" static lib files.
    alldynamic ...................... builds all "standard" dynamic lib files,
                                      excluding hardware accelerator versions.
    allfx ........................... builds all 3Dfx Glide bound lib files.

    ---- individual targets ------------
    mesa, mesaglu, mesaaux, mesatk,
    mesaglut ........................ static lib builds of respective code.

    mesa32, mesaglu32, mesaaux32,
    mesatk32, mesaglut32 ............ dynamic lib builds of respective code.

    opengl32, glu32, aux32, tk32,
    glut32 .......................... alias lib builds of respective code.

    fxmesa32, fxmesaglu32, fxmesaaux32,
    fxmesatk32, fxmesaglut32 ........ dynamic lib builds for use on top of
                                      3Dfx Glide runtime.
                                      For use on 3Dfx Voodoo based hardware.

    s3mesa32 ........................ dynamic lib build for use on top of
                                      S3 'S3Tk' runtime.
                                      For use on S3 Virge based hardware.

    ---- makefile Author notes ------------------
    Mesa originated as a project of and is currently maintained by Brian Paul
    (brianp@elastic.avid.com). Please look the the "canonical" internet sites
    for detailed information and source distributions, either at:

        http://www.ssec.wisc.edu/~brianp/Mesa.html

        <or>

        ftp://iris.ssec.wisc.edu/pub/Mesa

    This makefile suite built against MS Visual C++ 5.0 SP3 and tested on
    WindowsNT 4.0 SP3, WindowsNT 5.0b1, and Windows95 OSR 2.0.

    ---- change history -------------------------
    2/6/98 - taj - added support for MSVC 4 build (required addition to
         nmake.mif file and sensing of _NMAKE_VER macro).
    2/2/98 - taj - corrected "alldlls" target to be "alldynamic"
                   80 column text display cleanup of nmake.mak
    1/18/98 - taj - checked with Mesa 2.6beta4 release, added S3MESA.DLL
         build files. Note that I can not vouch for the usability of
         S3MESA.DLL as I have no Virge-based hardware to test it upon.
<<

# ----- Default / primary configuration stuff ---------------------------------

# Makefile elections, may be selected by command line but here are the defaults
#
# MESAVER     - Mesa version, currently 2.6 for core/2. for aux/tk/demos.
# NOCONSOLE   - when 1, builds executables for Windowed runtime
#

!IF "$(NOCONSOLE)" == ""
NOCONSOLE=0
!ENDIF

!IF "$(NOCONSOLE)" == "1"
DOGUI=1
!ELSE
DOGUI=0
!ENDIF

# Currently, Mesa is at rev 2.6 ...
#
!IF "$(MESAVER)" == ""
MESAVER=2.6
!ENDIF

# For Ted's use in local builds ...
#
!IF EXIST (..\..\Mesa-2.6tj\readme.win32)
MESAVER=2.6tj
!ENDIF

# used in building all of the resource files for the Mesa DLLs
#
!IF "$(MESAFILEVER)" == ""
MESAFILEVER=2,6,0,0
!ENDIF

# Currently, MesaDemos are at rev 2.6 ..
#
!IF "$(MESADEMOVER)" == ""
MESADEMOVER=2.6
!ENDIF

# For Ted's use in local builds ...
#
!IF EXIST (..\..\Mesa-2.6tj\samples\makefile)
MESADEMOVER=2.6tj
!ENDIF

# used in building all of the resource files for the Aux & Tk DLLs
#
!IF "$(MESADEMOFILEVER)" == ""
MESADEMOFILEVER=2,6,0,0
!ENDIF

# Set to 1 to enable building with MMX instructions on VC5
#
!IF "$(USE_MMX)" == ""
USE_MMX=0
!ENDIF

# Set to 1 to enable building against MSVCRT.DLL instead of LIBC.LIB
#
!IF "$(USE_CRTDLL)" == ""
USE_CRTDLL=0
!ENDIF

!IF "$(GD_NO_PROGS)" == ""
GD_NO_PROGS=0
!ENDIF

#---------------------------------------------------------------------
# shouldn't need to play beyond here ...
#---------------------------------------------------------------------

!IF "$(LIBBASE)" == ""
LIBBASE=mesa
!ENDIF

!IF "$(DLLBASE)" == ""
DLLBASE=$(LIBBASE)
!ENDIF

!IF "$(EXEFSERIES_UP)" == ""
EXEFSERIES_UP=1
!ENDIF

!IF "$(EXEFILE)" == ""
EXEFILE=-
!ENDIF

!IF "$(ALLWARNINGS)" == ""
ALLWARNINGS=0
!ENDIF

!IF "$(STATIC_MESA)" == ""
STATIC_MESA=0
!ENDIF

!IF (("$(DEBUG)" == "1") && ("$(USE_CRTDLL)" == "1"))
LIBTYPE=d-d
NORELEASE=1
NOSTATIC=1
!ELSEIF (("$(DEBUG)" == "1") && ("$(USE_CRTDLL)" == "0"))
LIBTYPE=d-s
NORELEASE=1
NODYNAMIC=1
!ELSEIF (("$(DEBUG)" == "0") && ("$(USE_CRTDLL)" == "1"))
LIBTYPE=r-d
NODEBUG=1
NOSTATIC=1
!ELSE
LIBTYPE=r-s
NODEBUG=1
NODYNAMIC=1
DEBUG=0
!ENDIF

# See nmake.mif file for documentations of these settings
NOPCH=1
H_FILES=

# Root source directory for primary Mesa lib files, check first that we are
# "in" the mesa source tree, then go extreme after that.
!IF EXIST (..\src\Makefile)
MESAROOT=..
!ELSEIF EXIST (..\..\mesa-$(MESAVER)\src\Makefile)
MESAROOT=..\..\mesa-$(MESAVER)
!ELSE
MESAROOT=..\mesa-$(MESAVER)
!ENDIF

# Root source directory for Tk/Aux/Demos/etc - may be alternative directory
!IF EXIST (..\samples\Makefile)
MESADEMOROOT=..
!ELSEIF EXIST (..\..\mesa-$(MESADEMOVER)\samples\Makefile)
MESADEMOROOT=..\..\mesa-$(MESADEMOVER)
!ELSE
MESADEMOROOT=..\mesa-$(MESADEMOVER)
!ENDIF

INCDIR_L=$(MESAROOT)\include
INCDIRSFX=gl
CLEANSUPS=*.rc *.def *.ncb libs
CPPOPTS=/D__MSC__ /D__WIN32__ /DWINDOWS_NT /DNO_PARALLEL /DNO_STEREO

!IF "$(STATIC_MESA)" == "1"
CPPOPTS=/D_STATIC_MESA $(CPPOPTS)
!ENDIF

!IF "$(ALLWARNINGS)" != "1"
CPPOPTS=$(CPPOPTS) /DMESA_MINWARN
!ENDIF

# ----- Standard meta build rules ---------------------------------------------

all: opengl32 glu32 aux32 tk32 glut32 mesa32fx s3mesa progs

clean: cleanroot cleanprogs

cleanprogs:
	nmake /nologo /f nmake.mak EXEFILE=progs.3dfx.demos clrxfileseries
	nmake /nologo /f nmake.mak EXEFILE=progs.book clrxfileseries
	nmake /nologo /f nmake.mak EXEFILE=progs.demos clrxfileseries
	nmake /nologo /f nmake.mak EXEFILE=progs.samples clrxfileseries

# ----- link libraries build rules --------------------------------------------

STATICLIBLIST=mesa.lib mesaglu.lib mesatk.lib mesaaux.lib

DYNAMICLIBLIST=mesa32.dll mesaglu32.dll mesatk32.dll mesaaux32.dll mesaglut32.dll\
	opengl32.dll glu32.dll tk32.dll aux32.dll glut32.dll\
	fxmesa32.dll s3mesa32.dll

$(STATICLIBLIST:.lib= ):
	set STATIC_MESA=$(STATIC_MESA)
	set DEBUG=$(DEBUG)
	set USE_CRTDLL=$(USE_CRTDLL)
	set USE_MMX=$(USE_MMX)
	set STATIC_MESA=1
	nmake /nologo /f nmake.mak EXEFILE=- LIBBASE=$* libupr

$(DYNAMICLIBLIST:.dll= ):
	set STATIC_MESA=$(STATIC_MESA)
	set DEBUG=$(DEBUG)
	set USE_CRTDLL=$(USE_CRTDLL)
	set USE_MMX=$(USE_MMX)
	set STATIC_MESA=0
	nmake /nologo /f nmake.mak EXEFILE=- LIBBASE=$* dllupr

update: headers $(STATICLIBLIST:.lib=.up) $(DYNAMICLIBLIST:.dll=.up)

$(STATICLIBLIST:.lib=.up):
	set STATIC_MESA=$(STATIC_MESA)
	set DEBUG=$(DEBUG)
	set USE_CRTDLL=$(USE_CRTDLL)
	set USE_MMX=$(USE_MMX)
	set STATIC_MESA=0
	nmake /nologo /f nmake.mak EXEFILE=- LIBBASE=$* libup

$(DYNAMICLIBLIST:.dll=.up):
	set STATIC_MESA=$(STATIC_MESA)
	set DEBUG=$(DEBUG)
	set USE_CRTDLL=$(USE_CRTDLL)
	set USE_MMX=$(USE_MMX)
	set STATIC_MESA=0
	nmake /nologo /f nmake.mak EXEFILE=- LIBBASE=$* dllup

libfiles: $(STATICLIBLIST:.lib= ) $(DYNAMICLIBLIST:.dll= )

allstatic: mesa mesaglu mesatk mesaaux

alldynamic: mesa32 mesaglu32 mesatk32 mesaaux32 mesaglut32\
	opengl32 glu32 tk32 aux32 glut32

fxmesa: fxmesa32

s3mesa: s3mesa32

# ----- For use by the DevStudio project for building DEF and RC files --------

$(DYNAMICLIBLIST:.dll=.deffile):
	set STATIC_MESA=$(STATIC_MESA)
	set DEBUG=$(DEBUG)
	set USE_CRTDLL=$(USE_CRTDLL)
	set USE_MMX=$(USE_MMX)
	set STATIC_MESA=0
	nmake /nologo /f nmake.mak EXEFILE=- LIBBASE=$* $*.def

$(DYNAMICLIBLIST:.dll=.rcfile):
	set STATIC_MESA=$(STATIC_MESA)
	set DEBUG=$(DEBUG)
	set USE_CRTDLL=$(USE_CRTDLL)
	set USE_MMX=$(USE_MMX)
	set STATIC_MESA=0
	nmake /nologo /f nmake.mak EXEFILE=- LIBBASE=$* $*.rc

# ----- test/demo program build ruiles ----------------------------------------
# NOTE: These require previous builds of the mesa libs, et. al., but are not
# made dependent upon their presence to facilitate SPEED of nmake processing.

progs: progs.book progs.demos progs.samples progs.3dfx.demos

progs.3dfx.demos progs.book progs.demos progs.samples:
	set STATIC_MESA=$(STATIC_MESA)
	set DEBUG=$(DEBUG)
	set USE_CRTDLL=$(USE_CRTDLL)
	set USE_MMX=$(USE_MMX)
	set STATIC_MESA=$(STATIC_MESA)
	nmake /nologo /f nmake.mak EXEFILE=$@ exefileseries

# ----- program/lib specific options ------------------------------------------

!IF "$(EXEFILE)" == "-"  # building a lib of some form ...

INTDIRSFX = $(LIBBASE)
SRCALT1=.\$(MESAROOT)\src
!INCLUDE .\rules\lib.$(LIBBASE)

!ELSEIF "$(EXEFILE)" != "" # building a set of executables ...

ALTLIBPATH=.\libs
INTDIRSFX=$(EXEFILE)
SUPLIBSROOT=.\rules\$(EXEFILE)

!IF EXIST (.\rules\$(EXEFILE))
!INCLUDE .\rules\$(EXEFILE)
!ENDIF

# Use possibly redefined SRCALT1 here to copy executables
# to their respective source directories ...

BINDIR   = $(SRCALT1)

!ENDIF # EXEFILE keyed selection

# ----- diff generation -------------------------------------------------------

MESABASEVER=2.6
MESADEMOBASEVER=2.6
MESALIBTAR=MesaLib-2.6beta6.tar.gz
MESADEMOTAR=MesaDemos-2.6beta6.tar.gz

..\..\Mesa-$(MESABASEVER)\readme: ..\..\$(MESALIBTAR)
	echo.
	echo Unpacking $(MESALIBTAR) ...
	echo.
	cd ..\..
	tar xvfz $(MESALIBTAR)
	cd Mesa-$(MESAVER)\win32

..\..\Mesa-$(MESADEMOBASEVER)\samples\readme: ..\..\$(MESADEMOTAR)
	echo.
	echo Unpacking $(MESADEMOTAR) ...
	echo.
	cd ..\..
	tar xvfz $(MESADEMOTAR)
	cd Mesa-$(MESAVER)\win32

..\..\diffs.txt: nmake.mak
	cd ..\..
	if exist diffs.txt if not exist diffs-prev.txt ren diffs.txt diffs-prev.txt
	rem <<diffs.txt

These diffs generated with GNU diff 2.7 compiled for Win32(x86).

Original unchanged files "$(MESALIBTAR)" and
"$(MESADEMOTAR)" unpacked. Duplicate directories "Mesa-$(MESAVER)"
and "Mesa-$(MESADEMOVER)" used for changes and build source.

----------------------------------------------------------------------
File change list : Mesa Core (mesa, glu, glut)
            "diff -Bbwirq Mesa-$(MESABASEVER) Mesa-$(MESAVER)"
----------------------------------------------------------------------

<<KEEP
	echo diff -Bbwirq Mesa-$(MESABASEVER) Mesa-$(MESAVER)
	-diff -Bbwirq Mesa-$(MESABASEVER) Mesa-$(MESAVER) >> diffs.txt
!IF (("$(MESABASEVER)" != "$(MESADEMOBASEVER)") && ("$(GD_NO_PROGS)" != "1"))
	rem <<$(TEMP)\diffs.sfx

----------------------------------------------------------------------
File change list : Mesa Demos (aux, tk, demo, samples, book, 3dfx)
            "diff -Bbwirq Mesa-$(MESADEMOBASEVER) Mesa-$(MESADEMOVER)"
----------------------------------------------------------------------

<<KEEP
	type $(TEMP)\diffs.sfx >> diffs.txt
	echo diff -Bbwirq Mesa-$(MESADEMOBASEVER) Mesa-$(MESADEMOVER)
	-diff -Bbwirq Mesa-$(MESADEMOBASEVER) Mesa-$(MESADEMOVER) >> diffs.txt
!ENDIF
	rem <<$(TEMP)\diffs.sfx

----------------------------------------------------------------------
Detailed change list : Mesa Core (mesa, glu, glut)
                "diff -Bbwirc Mesa-$(MESABASEVER) Mesa-$(MESAVER)"
----------------------------------------------------------------------

<<KEEP
	type $(TEMP)\diffs.sfx >> diffs.txt
	echo diff -Bbwirc Mesa-$(MESABASEVER) Mesa-$(MESAVER)
	-diff -Bbwirc Mesa-$(MESABASEVER) Mesa-$(MESAVER) >> diffs.txt
!IF (("$(MESABASEVER)" != "$(MESADEMOBASEVER)") && ("$(GD_NO_PROGS)" != "1"))
	rem <<$(TEMP)\diffs.sfx

----------------------------------------------------------------------
Detailed change list : Mesa Demos (aux, tk, demo, samples, book, 3dfx)
                "diff -Bbwirc Mesa-$(MESADEMOBASEVER) Mesa-$(MESADEMOVER)"
----------------------------------------------------------------------

<<KEEP
	type $(TEMP)\diffs.sfx >> diffs.txt
	echo diff -Bbwirc Mesa-$(MESADEMOBASEVER) Mesa-$(MESADEMOVER)
	-diff -Bbwirc Mesa-$(MESADEMOBASEVER) Mesa-$(MESADEMOVER) >> diffs.txt
!ENDIF
	rem <<$(TEMP)\diffs.sfx

----------------------------------------------------------------------
end of diffs
----------------------------------------------------------------------
<<KEEP
	type $(TEMP)\diffs.sfx >> diffs.txt
	cd Mesa-$(MESAVER)\win32

!IF "$(GD_NO_PROGS)" == "1"
gendiffs: ..\..\Mesa-$(MESABASEVER)\readme
	nmake /nologo /f nmake.mak GD_NO_PROGS=$(GD_NO_PROGS) ..\..\diffs.txt
!ELSE
gendiffs: cleanprogs ..\..\Mesa-$(MESABASEVER)\readme\
	..\..\Mesa-$(MESADEMOBASEVER)\samples\readme
	nmake /nologo /f nmake.mak GD_NO_PROGS=$(GD_NO_PROGS) ..\..\diffs.txt
!ENDIF

gendiffs.clr:
	cd ..
	echo Clearing Mesa-$(MESABASEVER) ...
	rm -rf Mesa-$(MESABASEVER)
!IF "$(MESABASEVER)" != "$(MESADEMOBASEVER)"
	echo Clearing Mesa-$(MESADEMOBASEVER) ...
	rm -rf Mesa-$(MESADEMOBASEVER)
!ENDIF
	cd Mesa-$(MESAVER)\win32

# -----------------------------------------------------------------------------
# ----- get final build rules -------------------------------------------------
# -----------------------------------------------------------------------------
!IF EXIST (nmake.mif)
!INCLUDE nmake.mif
!ELSE
!INCLUDE <nmake.mif>
!ENDIF
# -----------------------------------------------------------------------------

