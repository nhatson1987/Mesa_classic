/* winpos.c */

/*
 * Example of how to use the GL_MESA_window_pos extension.
 *
 * Brian Paul
 *
 * This file is in the public domain.
 */


#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "GL/glut.h"

#include "../util/readtex.c"  /* a hack, I know */


#ifndef M_PI
#  define M_PI 3.14159265
#endif

#define IMAGE "../samples/1.rgb"



static GLubyte *Image;
static int ImgWidth, ImgHeight;
static GLenum ImgFormat;



static void draw( void )
{
   GLfloat angle;
   char *extensions;

   extensions = (char *) glGetString( GL_EXTENSIONS );
   if (strstr( extensions, "GL_MESA_window_pos")==NULL) {
      printf("Sorry, GL_MESA_window_pos extension not available.\n");
      return;
   }

   glClear( GL_COLOR_BUFFER_BIT );

   for (angle = -45.0; angle <= 135.0; angle += 10.0) {
      GLfloat x = 50.0 + 200.0 * cos( angle * M_PI / 180.0 );
      GLfloat y = 50.0 + 200.0 * sin( angle * M_PI / 180.0 );

      /* Don't need to worry about the modelview or projection matrices!!! */
#ifdef GL_MESA_window_pos
      glWindowPos2fMESA( x, y );
#endif
      glDrawPixels( ImgWidth, ImgHeight, ImgFormat, GL_UNSIGNED_BYTE, Image );
   }
}




static void key( unsigned char key, int x, int y )
{
   switch (key) {
      case 27:
         exit(0);
   }
}



/* new window size or exposure */
static void reshape( int width, int height )
{
   glViewport(0, 0, (GLint)width, (GLint)height);
}


static void init( void )
{
   Image = LoadRGBImage( IMAGE, &ImgWidth, &ImgHeight, &ImgFormat );
   if (!Image) {
      printf("Couldn't read %s\n", IMAGE);
      exit(0);
   }
}


int main( int argc, char *argv[] )
{
   glutInitWindowPosition(0, 0);
   glutInitWindowSize(500, 500);
   glutInitDisplayMode( GLUT_RGB );

   if (glutCreateWindow("winpos") <= 0) {
      exit(0);
   }

   init();

   glutReshapeFunc( reshape );
   glutKeyboardFunc( key );
   glutDisplayFunc( draw );
   glutMainLoop();
   return 0;
}
