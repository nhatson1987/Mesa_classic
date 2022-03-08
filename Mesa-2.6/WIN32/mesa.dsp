# Microsoft Developer Studio Project File - Name="Mesa" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 5.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=Mesa - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "mesa.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "mesa.mak" CFG="Mesa - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "Mesa - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "Mesa - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe

!IF  "$(CFG)" == "Mesa - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release\Mesa"
# PROP BASE Intermediate_Dir "Release\Mesa"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release\Mesa"
# PROP Intermediate_Dir "Release\Mesa"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /G5 /W3 /Gi- /GX /O2 /I "..\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "__MSC__" /D "__WIN32__" /D "WINDOWS_NT" /D "NO_PARALLEL" /D "NO_STEREO" /YX /FD /c
# SUBTRACT CPP /Z<none>
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"Release\Mesa.lib"

!ELSEIF  "$(CFG)" == "Mesa - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug\Mesa"
# PROP BASE Intermediate_Dir "Debug\Mesa"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug\Mesa"
# PROP Intermediate_Dir "Debug\Mesa"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /Z7 /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /G5 /W3 /Gi- /GX /Zi /Od /I "..\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "__MSC__" /D "__WIN32__" /D "WINDOWS_NT" /D "NO_PARALLEL" /D "NO_STEREO" /YX /FD /c
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"Debug\Mesa.lib"

!ENDIF 

# Begin Target

# Name "Mesa - Win32 Release"
# Name "Mesa - Win32 Debug"
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

SOURCE=..\src\wmesa.c
# End Source File
# Begin Source File

SOURCE=..\src\xform.c
# End Source File
# End Target
# End Project
