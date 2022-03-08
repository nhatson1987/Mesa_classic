# Microsoft Developer Studio Project File - Name="MesaGLUT32" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 5.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=MesaGLUT32 - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "mesaglut32.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "mesaglut32.mak" CFG="MesaGLUT32 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "MesaGLUT32 - Win32 Release" (based on\
 "Win32 (x86) Dynamic-Link Library")
!MESSAGE "MesaGLUT32 - Win32 Debug" (based on\
 "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "MesaGLUT32 - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release\MesaGLUT32"
# PROP BASE Intermediate_Dir "Release\MesaGLUT32"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release\MesaGLUT32"
# PROP Intermediate_Dir "Release\MesaGLUT32"
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
# ADD LINK32 MesaGLU32.lib Mesa32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386 /out:"Release\MesaGLUT32.dll" /implib:"Release\MesaGLUT32.lib" /libpath:".\Release"
# SUBTRACT LINK32 /pdb:none

!ELSEIF  "$(CFG)" == "MesaGLUT32 - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug\MesaGLUT32"
# PROP BASE Intermediate_Dir "Debug\MesaGLUT32"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug\MesaGLUT32"
# PROP Intermediate_Dir "Debug\MesaGLUT32"
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
# ADD LINK32 MesaGLU32.lib Mesa32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /incremental:no /map /debug /machine:I386 /out:"Debug\MesaGLUT32.dll" /implib:"Debug\MesaGLUT32.lib" /pdbtype:sept /libpath:".\Debug"
# SUBTRACT LINK32 /pdb:none

!ENDIF 

# Begin Target

# Name "MesaGLUT32 - Win32 Release"
# Name "MesaGLUT32 - Win32 Debug"
# Begin Source File

SOURCE="..\src-glut\glut_8x13.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_9x15.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_bitmap.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_bwidth.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_cindex.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_cmap.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_cursor.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_dials.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_dstr.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_event.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_ext.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_fullscrn.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_get.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_hel10.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_hel12.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_hel18.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_init.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_input.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_mesa.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_modifier.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_mroman.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_overlay.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_roman.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_shapes.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_space.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_stroke.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_swap.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_swidth.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_tablet.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_teapot.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_tr10.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_tr24.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_util.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_vidresize.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_warp.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_win.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\glut_winmisc.c"
# End Source File
# Begin Source File

SOURCE=.\mesaglut32.def
# End Source File
# Begin Source File

SOURCE=.\mesaglut32.rc
# End Source File
# Begin Source File

SOURCE=.\nmake.mak

!IF  "$(CFG)" == "MesaGLUT32 - Win32 Release"

# Begin Custom Build
InputPath=.\nmake.mak

BuildCmds= \
	nmake /f nmake.mak MesaGLUT32.deffile MesaGLUT32.rcfile

"MesaGLUT32.def" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"MesaGLUT32.rc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)
# End Custom Build

!ELSEIF  "$(CFG)" == "MesaGLUT32 - Win32 Debug"

# Begin Custom Build
InputPath=.\nmake.mak

BuildCmds= \
	nmake /f nmake.mak MesaGLUT32.deffile MesaGLUT32.rcfile

"MesaGLUT32.def" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"MesaGLUT32.rc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE="..\src-glut\win32_glx.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\win32_menu.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\win32_util.c"
# End Source File
# Begin Source File

SOURCE="..\src-glut\win32_x11.c"
# End Source File
# End Target
# End Project
