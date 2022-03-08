# Microsoft Developer Studio Project File - Name="fxMesa32" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 5.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=fxMesa32 - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "fxmesa32.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "fxmesa32.mak" CFG="fxMesa32 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "fxMesa32 - Win32 Release" (based on\
 "Win32 (x86) Dynamic-Link Library")
!MESSAGE "fxMesa32 - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "fxMesa32 - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release\fxMesa32"
# PROP BASE Intermediate_Dir "Release\fxMesa32"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release\FxMesa32"
# PROP Intermediate_Dir "Release\FxMesa32"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /G5 /MT /W3 /GX /O2 /I "..\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "__MSC__" /D "__WIN32__" /D "WINDOWS_NT" /D "NO_PARALLEL" /D "NO_STEREO" /D "FX" /D "FX_SILENT" /YX /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /o NUL /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /o NUL /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386
# ADD LINK32 glide2x.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386 /out:"Release\fxMesa32.dll" /implib:"Release\fxMesa32.lib" /libpath:".\Release"
# SUBTRACT LINK32 /pdb:none

!ELSEIF  "$(CFG)" == "fxMesa32 - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug\fxMesa32"
# PROP BASE Intermediate_Dir "Debug\fxMesa32"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug\FxMesa32"
# PROP Intermediate_Dir "Debug\FxMesa32"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /G5 /MTd /W3 /Gm /GX /Zi /Od /I "..\include" /D "_DEBUG" /D "FX" /D "FX_SILENT" /D "WIN32" /D "_WINDOWS" /D "__MSC__" /D "__WIN32__" /D "WINDOWS_NT" /D "NO_PARALLEL" /D "NO_STEREO" /YX /FD /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /o NUL /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /o NUL /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /debug /machine:I386 /pdbtype:sept
# ADD LINK32 glide2x.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /incremental:no /map /debug /machine:I386 /out:"Debug\fxMesa32.dll" /implib:"Debug\fxMesa32.lib" /pdbtype:sept /libpath:".\Debug"
# SUBTRACT LINK32 /pdb:none

!ENDIF 

# Begin Target

# Name "fxMesa32 - Win32 Release"
# Name "fxMesa32 - Win32 Debug"
# Begin Source File

SOURCE=..\src\accum.c
# End Source File
# Begin Source File

SOURCE=..\src\alpha.c
# End Source File
# Begin Source File

SOURCE=..\src\alphabuf.c
# End Source File
# Begin Source File

SOURCE=..\src\api1.c
# End Source File
# Begin Source File

SOURCE=..\src\api2.c
# End Source File
# Begin Source File

SOURCE=..\src\attrib.c
# End Source File
# Begin Source File

SOURCE=..\src\bitmap.c
# End Source File
# Begin Source File

SOURCE=..\src\blend.c
# End Source File
# Begin Source File

SOURCE=..\src\clip.c
# End Source File
# Begin Source File

SOURCE=..\src\colortab.c
# End Source File
# Begin Source File

SOURCE=..\src\context.c
# End Source File
# Begin Source File

SOURCE=..\src\copypix.c
# End Source File
# Begin Source File

SOURCE=..\src\depth.c
# End Source File
# Begin Source File

SOURCE=..\src\dlist.c
# End Source File
# Begin Source File

SOURCE=..\src\drawpix.c
# End Source File
# Begin Source File

SOURCE=..\src\enable.c
# End Source File
# Begin Source File

SOURCE=..\src\eval.c
# End Source File
# Begin Source File

SOURCE=..\src\feedback.c
# End Source File
# Begin Source File

SOURCE=..\src\fog.c
# End Source File
# Begin Source File

SOURCE=..\src\fxmesa1.c
# End Source File
# Begin Source File

SOURCE=..\src\fxmesa2.c
# End Source File
# Begin Source File

SOURCE=..\src\fxmesa3.c
# End Source File
# Begin Source File

SOURCE=.\fxmesa32.def
# End Source File
# Begin Source File

SOURCE=.\fxmesa32.rc
# End Source File
# Begin Source File

SOURCE=..\src\fxmesa4.c
# End Source File
# Begin Source File

SOURCE=..\src\fxmesa5.c
# End Source File
# Begin Source File

SOURCE=..\src\fxmesa6.c
# End Source File
# Begin Source File

SOURCE=..\src\fxwgl.c
# End Source File
# Begin Source File

SOURCE=..\src\get.c
# End Source File
# Begin Source File

SOURCE=..\src\hash.c
# End Source File
# Begin Source File

SOURCE=..\src\image.c
# End Source File
# Begin Source File

SOURCE=..\src\light.c
# End Source File
# Begin Source File

SOURCE=..\src\lines.c
# End Source File
# Begin Source File

SOURCE=..\src\logic.c
# End Source File
# Begin Source File

SOURCE=..\src\masking.c
# End Source File
# Begin Source File

SOURCE=..\src\matrix.c
# End Source File
# Begin Source File

SOURCE=..\src\misc.c
# End Source File
# Begin Source File

SOURCE=..\src\mmath.c
# End Source File
# Begin Source File

SOURCE=.\nmake.mak

!IF  "$(CFG)" == "fxMesa32 - Win32 Release"

# Begin Custom Build
InputPath=.\nmake.mak

BuildCmds= \
	nmake /f nmake.mak fxmesa32.deffile fxmesa32.rcfile

"fxmesa32.def" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"fxmesa32.rc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)
# End Custom Build

!ELSEIF  "$(CFG)" == "fxMesa32 - Win32 Debug"

# Begin Custom Build
InputPath=.\nmake.mak

BuildCmds= \
	nmake /f nmake.mak fxmesa32.deffile fxmesa32.rcfile

"fxmesa32.def" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)

"fxmesa32.rc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
   $(BuildCmds)
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\osmesa.c
# End Source File
# Begin Source File

SOURCE=..\src\pb.c
# End Source File
# Begin Source File

SOURCE=..\src\pixel.c
# End Source File
# Begin Source File

SOURCE=..\src\pointers.c
# End Source File
# Begin Source File

SOURCE=..\src\points.c
# End Source File
# Begin Source File

SOURCE=..\src\polygon.c
# End Source File
# Begin Source File

SOURCE=..\src\quads.c
# End Source File
# Begin Source File

SOURCE=..\src\rastpos.c
# End Source File
# Begin Source File

SOURCE=..\src\readpix.c
# End Source File
# Begin Source File

SOURCE=..\src\rect.c
# End Source File
# Begin Source File

SOURCE=..\src\scissor.c
# End Source File
# Begin Source File

SOURCE=..\src\shade.c
# End Source File
# Begin Source File

SOURCE=..\src\span.c
# End Source File
# Begin Source File

SOURCE=..\src\stencil.c
# End Source File
# Begin Source File

SOURCE=..\src\teximage.c
# End Source File
# Begin Source File

SOURCE=..\src\texobj.c
# End Source File
# Begin Source File

SOURCE=..\src\texstate.c
# End Source File
# Begin Source File

SOURCE=..\src\texture.c
# End Source File
# Begin Source File

SOURCE=..\src\triangle.c
# End Source File
# Begin Source File

SOURCE=..\src\varray.c
# End Source File
# Begin Source File

SOURCE=..\src\vb.c
# End Source File
# Begin Source File

SOURCE=..\src\vbfill.c
# End Source File
# Begin Source File

SOURCE=..\src\vbrender.c
# End Source File
# Begin Source File

SOURCE=..\src\vbxform.c
# End Source File
# Begin Source File

SOURCE=..\src\winpos.c
# End Source File
# Begin Source File

SOURCE=..\src\xform.c
# End Source File
# End Target
# End Project
