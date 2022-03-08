# Microsoft Developer Studio Project File - Name="MesaTk" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 5.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=MesaTk - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "mesatk.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "mesatk.mak" CFG="MesaTk - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "MesaTk - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "MesaTk - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe

!IF  "$(CFG)" == "MesaTk - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release\MesaTk"
# PROP BASE Intermediate_Dir "Release\MesaTk"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release\MesaTk"
# PROP Intermediate_Dir "Release\MesaTk"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /G5 /W3 /Gi- /GX /O2 /I "..\include" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "__MSC__" /D "__WIN32__" /D "WINDOWS_NT" /D "NO_PARALLEL" /D "NO_STEREO" /YX /FD /c
# SUBTRACT CPP /Z<none>
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"Release\MesaTk.lib"

!ELSEIF  "$(CFG)" == "MesaTk - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug\MesaTk"
# PROP Intermediate_Dir "Debug\MesaTk"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /Z7 /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /G5 /W3 /Gi- /GX /Zi /Od /I "..\include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "__MSC__" /D "__WIN32__" /D "WINDOWS_NT" /D "NO_PARALLEL" /D "NO_STEREO" /YX /FD /c
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"Debug\MesaTk.lib"

!ENDIF 

# Begin Target

# Name "MesaTk - Win32 Release"
# Name "MesaTk - Win32 Debug"
# Begin Source File

SOURCE="..\src-tk\font.c"
# End Source File
# Begin Source File

SOURCE="..\src-tk\image.c"
# End Source File
# Begin Source File

SOURCE="..\src-tk\shapes.c"
# End Source File
# Begin Source File

SOURCE="..\src-tk\tkwndws.c"
# End Source File
# End Target
# End Project
