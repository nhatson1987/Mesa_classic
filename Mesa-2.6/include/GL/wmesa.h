/* File name wmesa 
		 for
***************************************************************
*                     WMesa                                   *
*                     version 2.3                             *	
*                                                             *
*                        By                                   *
*                      Li Wei                                 *
*       Institute of Artificial Intelligence & Robotics       *
*       Xi'an Jiaotong University                             *
*       Email: liwei@aiar.xjtu.edu.cn                         * 
*       Web page: http://sun.aiar.xjtu.edu.cn                 *
*                                                             *
*	       July 7th, 1997				                      *	
***************************************************************
*/

/* $Id: wmesa.h,v 1.3 1998/02/04 00:12:04 brianp Exp $ */

/*
 * Mesa 3-D graphics library
 * Version:  2.2
 * Copyright (C) 1995-1997  Brian Paul
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the Free
 * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 * Windows driver by: Mark E. Peterson (markp@ic.mankato.mn.us)
 * Updated by Li Wei (liwei@aiar.xjtu.edu.cn)
 *
 */


/*
 * $Log: wmesa.h,v $
 * Revision 1.3  1998/02/04 00:12:04  brianp
 * changed gl\gl.h to GL/gl.h (Stephane Rehel)
 *
 * Revision 1.2  1998/01/16 02:29:50  brianp
 * minor changes for Windows compilation (Theodore Jump)
 *
 * Revision 1.1  1998/01/16 01:48:47  brianp
 * Initial revision
 *
 * Revision 1.3  1997/04/30 15:51:00  Li Wei (liwei@aiar.xjtu.edu.cn)
 * extern WMesaContext WMesaCreateContext(HWND hWnd,HPALETTE Pal,
 *                                       GLboolean rgb_flag,GLboolean db_flag);
 * changed to
 * extern WMesaContext WMesaCreateContext(HWND hWnd,HPALETTE* pPal,
 *                                      GLboolean rgb_flag,GLboolean db_flag);
 *
 *
 * $Log: wmesa.h,v $
 * Revision 1.3  1998/02/04 00:12:04  brianp
 * changed gl\gl.h to GL/gl.h (Stephane Rehel)
 *
 * Revision 1.2  1998/01/16 02:29:50  brianp
 * minor changes for Windows compilation (Theodore Jump)
 *
 * Revision 1.1  1998/01/16 01:48:47  brianp
 * Initial revision
 *
 * Revision 1.2  1997/02/22 16:48:49  brianp
 * WMesaDestroyContext now takes no arguments
 *
 * Revision 1.1  1996/09/13 01:26:41  brianp
 * Initial revision
 *
 */



#ifndef WMESA_H
#define WMESA_H


#ifdef __cplusplus
extern "C" {
#endif


#include <windows.h>
#include "GL/gl.h"

#pragma warning (disable:4273)
#pragma warning( disable : 4244 ) /* '=' : conversion from 'const double ' to 'float ', possible loss of data */
#pragma warning( disable : 4018 ) /* '<' : signed/unsigned mismatch */
#pragma warning( disable : 4305 ) /* '=' : truncation from 'const double ' to 'float ' */
#pragma warning( disable : 4013 ) /* 'function' undefined; assuming extern returning int */
#pragma warning( disable : 4761 ) /* integral size mismatch in argument; conversion supplied */
#pragma warning( disable : 4273 ) /* 'identifier' : inconsistent DLL linkage. dllexport assumed */
#if (MESA_WARNQUIET>1)
#	pragma warning( disable : 4146 ) /* unary minus operator applied to unsigned type, result still unsigned */
#endif

/*
 * This is the WMesa context 'handle':
 */
typedef struct wmesa_context *WMesaContext;



/*
 * Create a new WMesaContext for rendering into a window.  You must
 * have already created the window of correct visual type and with an
 * appropriate colormap.
 *
 * Input:
 *         hWnd - Window handle
 *         Pal  - Palette to use
 *         rgb_flag - GL_TRUE = RGB mode,
 *                    GL_FALSE = color index mode
 *         db_flag - GL_TRUE = double-buffered,
 *                   GL_FALSE = single buffered
 *
 * Note: Indexed mode requires double buffering under Windows.
 *
 * Return:  a WMesa_context or NULL if error.
 */
extern WMesaContext WMesaCreateContext(HWND hWnd,HPALETTE* pPal,
                                       GLboolean rgb_flag,GLboolean db_flag);


/*
 * Destroy a rendering context as returned by WMesaCreateContext()
 */
/*extern void WMesaDestroyContext( WMesaContext ctx );*/
extern void WMesaDestroyContext( void );


/*
 * Make the specified context the current one.
 */
extern void WMesaMakeCurrent( WMesaContext ctx );


/*
 * Return a handle to the current context.
 */
extern WMesaContext WMesaGetCurrentContext( void );


/*
 * Swap the front and back buffers for the current context.  No action
 * taken if the context is not double buffered.
 */
extern void WMesaSwapBuffers(void);


/*
 * In indexed color mode we need to know when the palette changes.
 */
extern void WMesaPaletteChange(HPALETTE Pal);

extern void WMesaMove(void);



#ifdef __cplusplus
}
#endif


#endif

