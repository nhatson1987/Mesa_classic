# Microsoft Developer Studio Project File - Name="GLU32" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 5.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=GLU32 - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "glu32.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "glu32.mak" CFG="GLU32 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "GLU32 - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "GLU32 - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "GLU32 - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release\MesaGLU32"
# PROP BASE Intermediate_Dir "Release\MesaGLU32"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release\MesaGLU32"
# PROP Intermediate_Dir "Release\MesaGLU32"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /G5 /MT /W3 /GX /O2 /I "..\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "__MSC__" /D "__WIN32__" /D "WINDOWS_NT" /D "NO_PARALLEL" /D "NO_STEREO" /YX /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /o NUL /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /o NUL /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386
# ADD LINK32 OpenGL32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386 /out:"Release\GLU32.dll" /implib:"Release\GLU32.lib" /libpath:".\Release"
# SUBTRACT LINK32 /pdb:none

!ELSEIF  "$(CFG)" == "GLU32 - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug\MesaGLU32"
# PROP BASE Intermediate_Dir "Debug\MesaGLU32"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug\MesaGLU32"
# PROP Intermediate_Dir "Debug\MesaGLU32"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /G5 /MTd /W3 /Gm /GX /Zi /Od /I "..\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "__MSC__" /D "__WIN32__" /D "WINDOWS_NT" /D "NO_PARALLEL" /D "NO_STEREO" /YX /FD /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /o NUL /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /o NUL /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /debug /machine:I386 /pdbtype:sept
# ADD LINK32 OpenGL32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /incremental:no /map /debug /machine:I386 /out:"Debug\GLU32.dll" /implib:"Debug\GLU32.lib" /pdbtype:sept /libpath:".\Debug"
# SUBTRACT LINK32 /pdb:none

!ENDIF 

# Begin Target

# Name "GLU32 - Win32 Release"
# Name "GLU32 - Win32 Debug"
# Begin Source File

SOURCE="..\src-glu\glu.c"
# End Source File
# Begin Source File

SOURCE=.\GLU32.def
# End Source File
# Begin Source File

SOURCE=.\GLU32.rc
# End Source File
# Begin Source File

SOURCE="..\src-glu\mipmap.c"
# End Source File
# Begin Source File

SOURCE=.\nmake.mak

!IF  "$(CFG)" == "GLU32 - Win32 Release"

# Begin Custom Build
InputPath=.\nmake.mak

BuildCmds= \
	nmake /f nmake.mak GLU32.deffile GLU32.rcfile

"GLU32.def" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"GLU32.rc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)
# End Custom Build

!ELSEIF  "$(CFG)" == "GLU32 - Win32 Debug"

# Begin Custom Build
InputPath=.\nmake.mak

BuildCmds= \
	nmake /f nmake.mak GLU32.deffile GLU32.rcfile

"GLU32.def" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"GLU32.rc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE="..\src-glu\nurbs.c"
# End Source File
# Begin Source File

SOURCE="..\src-glu\nurbscrv.c"
# End Source File
# Begin Source File

SOURCE="..\src-glu\nurbssrf.c"
# End Source File
# Begin Source File

SOURCE="..\src-glu\nurbsutl.c"
# End Source File
# Begin Source File

SOURCE="..\src-glu\polytest.c"
# End Source File
# Begin Source File

SOURCE="..\src-glu\project.c"
# End Source File
# Begin Source File

SOURCE="..\src-glu\quadric.c"
# End Source File
# Begin Source File

SOURCE="..\src-glu\tess.c"
# End Source File
# Begin Source File

SOURCE="..\src-glu\tesselat.c"
# End Source File
# End Target
# End Project
