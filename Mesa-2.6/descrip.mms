# Makefile for Mesa for VMS
# contributed by Jouk Jansen  joukj@crys.chem.uva.nl


all :
	if f$search("lib.dir") .eqs. "" then create/directory [.lib]
	set default [.src]
	mms
	set default [-.src-glu]
	mms
	set default [-.src-glut]
	mms
	set default [-.demos]
	mms
# PIPE is avalailable on VMS7.0 and higher. For lower versions split the
#command in two conditional command.   JJ
	if f$search("[-]SRC-TK.DIR") .nes. "" then pipe set default [-.src-tk] ; mms
	if f$search("[-]SRC-AUX.DIR") .nes. "" then pipe set default [-.src-aux] ; mms
	if f$search("[-]SRC-DEMOS.DIR") .nes. "" then pipe set default [-.src-demos] ; mms
