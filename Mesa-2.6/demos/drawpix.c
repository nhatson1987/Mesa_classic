/* drawpix.c */

/*
 * glDrawPixels demo/test/benchmark
 * 
 * Brian Paul   September 25, 1997
 *
 * This file is in the public domain.
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <GL/glut.h>

#include "../util/readtex.c"  /* a hack, I know */


#define IMAGE "girl.rgb"

static int ImgWidth, ImgHeight;
static GLenum ImgFormat;
static GLubyte *Image = NULL;

static int Xpos, Ypos;
static int SkipPixels, SkipRows;
static int DrawWidth, DrawHeight;
static int Scissor = 0;
static float Xzoom, Yzoom;



static void Reset()
{
   Xpos = Ypos = 20;
   DrawWidth = ImgWidth;
   DrawHeight = ImgHeight;
   SkipPixels = SkipRows = 0;
   Scissor = 0;
   Xzoom = Yzoom = 1.0;
}


static void Display( void )
{
   glClear( GL_COLOR_BUFFER_BIT );

#if 0
   glRasterPos2i(Xpos, Ypos);
#else
   /* This allows negative raster positions: */
   glRasterPos2i(0, 0);
   glBitmap(0, 0, 0, 0, Xpos, Ypos, NULL);
#endif

   glPixelStorei(GL_UNPACK_SKIP_PIXELS, SkipPixels);
   glPixelStorei(GL_UNPACK_SKIP_ROWS, SkipRows);

   glPixelZoom( Xzoom, Yzoom );

   if (Scissor)
      glEnable(GL_SCISSOR_TEST);

   glDrawPixels(DrawWidth, DrawHeight, ImgFormat, GL_UNSIGNED_BYTE, Image);

   glDisable(GL_SCISSOR_TEST);

   glutSwapBuffers();
}


static void Benchmark( void )
{
   int startTime, endTime;
   int draws = 500;
   double seconds, pixelsPerSecond;

   printf("Benchmarking...\n");
   /* GL set-up */
   glPixelStorei(GL_UNPACK_SKIP_PIXELS, SkipPixels);
   glPixelStorei(GL_UNPACK_SKIP_ROWS, SkipRows);
   glPixelZoom( Xzoom, Yzoom );
   if (Scissor)
      glEnable(GL_SCISSOR_TEST);

   /* Run timing test */
   draws = 0;
   startTime = glutGet(GLUT_ELAPSED_TIME);
   do {
      glDrawPixels(DrawWidth, DrawHeight, ImgFormat, GL_UNSIGNED_BYTE, Image);
      draws++;
      endTime = glutGet(GLUT_ELAPSED_TIME);
   } while (endTime - startTime < 4000);   /* 4 seconds */

   /* GL clean-up */
   glDisable(GL_SCISSOR_TEST);

   /* Results */
   seconds = (double) (endTime - startTime) / 1000.0;
   pixelsPerSecond = draws * DrawWidth * DrawHeight / seconds;
   printf("Result:  %d draws in %f seconds = %f pixels/sec\n",
          draws, seconds, pixelsPerSecond);
}


static void Reshape( int width, int height )
{
   glViewport( 0, 0, width, height );
   glMatrixMode( GL_PROJECTION );
   glLoadIdentity();
   glOrtho( 0.0, width, 0.0, height, -1.0, 1.0 );
   glMatrixMode( GL_MODELVIEW );
   glLoadIdentity();

   glScissor(width/4, height/4, width/2, height/2);
}


static void Key( unsigned char key, int x, int y )
{
   switch (key) {
      case ' ':
         Reset();
         break;
      case 'w':
         if (DrawWidth > 0)
            DrawWidth--;
         break;
      case 'W':
         DrawWidth++;
         break;
      case 'h':
         if (DrawHeight > 0)
            DrawHeight--;
         break;
      case 'H':
         DrawHeight++;
         break;
      case 'p':
         if (SkipPixels > 0)
             SkipPixels--;
         break;
      case 'P':
         SkipPixels++;
         break;
      case 'r':
         if (SkipRows > 0)
             SkipRows--;
         break;
      case 'R':
         SkipRows++;
         break;
      case 's':
         Scissor = !Scissor;
         break;
      case 'x':
         Xzoom -= 0.1;
         break;
      case 'X':
         Xzoom += 0.1;
         break;
      case 'y':
         Yzoom -= 0.1;
         break;
      case 'Y':
         Yzoom += 0.1;
         break;
      case 'b':
         Benchmark();
         break;
      case 27:
         exit(0);
         break;
   }
   glutPostRedisplay();
}


static void SpecialKey( int key, int x, int y )
{
   switch (key) {
      case GLUT_KEY_UP:
         Ypos += 1;
         break;
      case GLUT_KEY_DOWN:
         Ypos -= 1;
         break;
      case GLUT_KEY_LEFT:
         Xpos -= 1;
         break;
      case GLUT_KEY_RIGHT:
         Xpos += 1;
         break;
   }
   glutPostRedisplay();
}


static void Init( GLboolean ciMode )
{
   printf("GL_VERSION = %s\n", glGetString(GL_VERSION));
   printf("GL_RENDERER = %s\n", glGetString(GL_RENDERER));

   Image = LoadRGBImage( IMAGE, &ImgWidth, &ImgHeight, &ImgFormat );
   if (!Image) {
      printf("Couldn't read %s\n", IMAGE);
      exit(0);
   }

   if (ciMode) {
      /* Convert RGB image to grayscale */
      GLubyte *indexImage = malloc( ImgWidth * ImgHeight );
      GLint i;
      for (i=0; i<ImgWidth*ImgHeight; i++) {
         int gray = Image[i*3] + Image[i*3+1] + Image[i*3+2];
         indexImage[i] = gray / 3;
      }
      free(Image);
      Image = indexImage;
      ImgFormat = GL_COLOR_INDEX;

      for (i=0;i<255;i++) {
         float g = i / 255.0;
         glutSetColor(i, g, g, g);
      }
   }

   printf("Loaded %d by %d image\n", ImgWidth, ImgHeight );

   glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
   glPixelStorei(GL_UNPACK_ROW_LENGTH, ImgWidth);

   Reset();
}


static void Usage(void)
{
   printf("Keys:\n");
   printf("       SPACE  Reset\n");
   printf("     Up/Down  Move image up/down\n");
   printf("  Left/Right  Move image left/right\n");
   printf("           w  Decrease glDrawPixels width\n");
   printf("           W  Increase glDrawPixels width\n");
   printf("           h  Decrease glDrawPixels height\n");
   printf("           H  Increase glDrawPixels height\n");
   printf("           p  Decrease GL_UNPACK_SKIP_PIXELS\n");
   printf("           P  Increase GL_UNPACK_SKIP_PIXELS\n");
   printf("           r  Decrease GL_UNPACK_SKIP_ROWS\n");
   printf("           R  Increase GL_UNPACK_SKIP_ROWS\n");
   printf("           s  Toggle GL_SCISSOR_TEST\n");
   printf("           b  Benchmark test\n");
   printf("         ESC  Exit\n");
}


int main( int argc, char *argv[] )
{
   GLboolean ciMode = GL_FALSE;

   if (argc > 1 && strcmp(argv[1], "-ci")==0) {
      ciMode = GL_TRUE;
   }

   glutInit( &argc, argv );
   glutInitWindowPosition( 0, 0 );
   glutInitWindowSize( 500, 400 );

   if (ciMode)
      glutInitDisplayMode( GLUT_INDEX | GLUT_DOUBLE );
   else
      glutInitDisplayMode( GLUT_RGB | GLUT_DOUBLE );

   glutCreateWindow(argv[0]);

   Init(ciMode);
   Usage();

   glutReshapeFunc( Reshape );
   glutKeyboardFunc( Key );
   glutSpecialFunc( SpecialKey );
   glutDisplayFunc( Display );

   glutMainLoop();
   return 0;
}
