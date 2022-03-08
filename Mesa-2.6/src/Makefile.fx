!include <win32.mak>

CFLAGS        = $(cvarsdll) /Ox /G5 /Gz \
                /D__MSC__ /DFX /D__WIN32__ /DWIN32 /I..\include

OBJS	      = accum.obj \
		alpha.obj \
		alphabuf.obj \
                api1.obj api2.obj \
		attrib.obj \
		bitmap.obj \
		blend.obj \
		clip.obj \
                colortab.obj \
		context.obj \
		copypix.obj \
		depth.obj \
		dlist.obj \
		dosmesa.obj \
		drawpix.obj \
		enable.obj \
		eval.obj \
		feedback.obj \
		fog.obj \
		get.obj \
                hash.obj \
		image.obj \
		light.obj \
		lines.obj \
		logic.obj \
		masking.obj \
		mmath.obj \
		matrix.obj \
		misc.obj \
		pb.obj \
		pixel.obj \
		pointers.obj \
		points.obj \
		polygon.obj \
		quads.obj \
		rastpos.obj \
		readpix.obj \
		rect.obj \
		scissor.obj \
		shade.obj \
		span.obj \
		stencil.obj \
		teximage.obj \
		texobj.obj \
		texstate.obj \
		texture.obj \
		triangle.obj \
		varray.obj \
		vb.obj \
		vbfill.obj \
		vbrender.obj \
		vbxform.obj \
		winpos.obj \
                xform.obj \
                fxwgl.obj fxmesa1.obj fxmesa2.obj fxmesa3.obj fxmesa4.obj fxmesa5.obj fxmesa6.obj

PROGRAM       = ..\lib\OpenGL32.DLL

all:		$(PROGRAM)

$(PROGRAM):     $(OBJS) 
                $(link) $(dlllflags) /out:$(PROGRAM) \
                 /def:fxOpenGL.def $(OBJS) $(guilibsdll) \
                 glide2x.lib >link.log

