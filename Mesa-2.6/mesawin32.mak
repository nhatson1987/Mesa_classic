# Be sure to modify the definitions in this file to agree with your
# systems installation.
#  NOTE: be sure that the install directories use '\' not '/' for paths.


# import libraries install directory

LIBINSTALL     = D:\DevStudio\VC\lib

# Win95 dll directory
#DLLINSTALL     = C:\Windows\System

# WinNT dll directory
DLLINSTALL     = C:\WinNT\System32

EXES     = $(SRCS:.c=.exe)
OBJS     = $(SRCS:.c=.obj)

# default rule
default : $(EXES)

LOCALFLAGS = -I$(TOP)/include -TC -Ze
LOCALDEFS = -DNO_PARALLEL -DNO_STEREO -DPC_HEADER -D__WIN32__
 
.c.obj : 
        $(cc) $(cflags) $(cvars) $(cdebug) $(LOCALFLAGS) $(LOCALDEFS) $<

$(PROJECT).dll : $(OBJS)
        $(link) $(dlllflags) /WARN:0 $(ldebug) -def:$(PROJECT).def $(EXTRALIBS) $(guilibs) $(OBJS) -out:$(PROJECT).dll


# cleanup rules
clean   :
        @del *.obj
        @del *.pdb
        @del *.ilk
        @del *.ncb
        @del *.pch
        @del *.idb
        @del *~
        @del *.exp

clobber : 
        @del *.exe
        @del *.dll
        @del *.lib

# inference rules
$(EXES) : $*.obj
        $(link) $(lflags) $(ldebug) $(EXTRALIBS) $(guilibs) -out:$@ $**

