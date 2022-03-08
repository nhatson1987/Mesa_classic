# Makefile for core library for VMS
# contributed by Jouk Jansen  joukj@crys.chem.uva.nl


.first
	define gl [-.include.gl]

.include [-]mms-config.

##### MACROS #####

VPATH = RCS

INCDIR = [-.include]
LIBDIR = [-.lib]
CFLAGS = /include=$(INCDIR)/define=(FBIND=1)

CORE_SOURCES = accum.c alpha.c alphabuf.c api1.c api2.c attrib.c bitmap.c \
	blend.c clip.c colortab.c context.c copypix.c depth.c \
	dlist.c drawpix.c enable.c eval.c feedback.c fog.c \
	get.c hash.c image.c light.c lines.c logic.c masking.c matrix.c \
	misc.c mmath.c pb.c pixel.c points.c pointers.c polygon.c \
	quads.c rastpos.c readpix.c rect.c scissor.c shade.c span.c \
	stencil.c teximage.c texobj.c texstate.c texture.c triangle.c \
	varray.c winpos.c vb.c vbfill.c vbrender.c vbxform.c xform.c

DRIVER_SOURCES = glxapi.c fakeglx.c realglx.c xfonts.c \
	xmesa1.c xmesa2.c xmesa3.c xmesa4.c \
	osmesa.c svgamesa.c \
	fxmesa1.c fxmesa2.c fxmesa3.c fxmesa4.c fxmesa5.c fxmesa6.c

OBJECTS = accum.obj,alpha.obj,alphabuf.obj,api1.obj,api2.obj,attrib.obj,bitmap.obj,\
	blend.obj,clip.obj,colortab.obj,context.obj,copypix.obj,depth.obj,\
	dlist.obj,drawpix.obj,enable.obj,eval.obj,feedback.obj,fog.obj,\
	get.obj,hash.obj,image.obj,light.obj,lines.obj,logic.obj,masking.obj,matrix.obj,\
	misc.obj,mmath.obj,pb.obj,pixel.obj,points.obj,pointers.obj,polygon.obj,\
	quads.obj,rastpos.obj,readpix.obj,rect.obj,scissor.obj,shade.obj,span.obj,\
	stencil.obj,teximage.obj,texobj.obj,texstate.obj,texture.obj,triangle.obj,\
	varray.obj,winpos.obj,vb.obj,vbfill.obj,vbrender.obj,vbxform.obj,xform.obj,\
	glxapi.obj,fakeglx.obj,realglx.obj,xfonts.obj,\
	xmesa1.obj,xmesa2.obj,xmesa3.obj,xmesa4.obj,\
	osmesa.obj,svgamesa.obj,fxmesa1.obj,fxmesa2.obj,fxmesa3.obj,\
	fxmesa4.obj,fxmesa5.obj

##### RULES #####


##### TARGETS #####

# Make the library
$(LIBDIR):$(GL_LIB) : $(OBJECTS)
	$(MAKELIB) $(GL_LIB) $(OBJECTS)
	rename $(GL_LIB)* $(LIBDIR)

clean :
	purge
	delete *.obj;*

.include mms_depend.

