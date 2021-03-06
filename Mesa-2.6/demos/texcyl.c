/* texcyl.c */

/*
 * Textured cylinder demo: lighting, texturing, reflection mapping.
 * Brian Paul  May 1997
 * This program is in the public domain.
 */


#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <GL/glut.h>

#include "../util/readtex.c"   /* I know, this is a hack. */


#define LIT 1
#define TEXTURED 2
#define REFLECT 3
#define ANIMATE 10
#define QUIT 100

static GLuint CylinderObj = 0;
static GLboolean Animate = GL_TRUE;

static GLfloat Xrot = 0.0, Yrot = 0.0, Zrot = 0.0;
static GLfloat DXrot = 1.0, DYrot = 2.5;


static void Idle( void )
{
   if (Animate) {
      Xrot += DXrot;
      Yrot += DYrot;
      glutPostRedisplay();
   }
}


static void Display( void )
{
   glClear( GL_COLOR_BUFFER_BIT );

   glPushMatrix();
   glRotatef(Xrot, 1.0, 0.0, 0.0);
   glRotatef(Yrot, 0.0, 1.0, 0.0);
   glRotatef(Zrot, 0.0, 0.0, 1.0);
   glScalef(5.0, 5.0, 5.0);
   glCallList(CylinderObj);

   glPopMatrix();

   glutSwapBuffers();
}


static void Reshape( int width, int height )
{
   glViewport( 0, 0, width, height );
   glMatrixMode( GL_PROJECTION );
   glLoadIdentity();
   glFrustum( -1.0, 1.0, -1.0, 1.0, 10.0, 100.0 );
   glMatrixMode( GL_MODELVIEW );
   glLoadIdentity();
   glTranslatef( 0.0, 0.0, -70.0 );
}


static void SetMode(GLuint m)
{
   /* disable everything */
   glDisable(GL_LIGHTING);
   glDisable(GL_TEXTURE_2D);
   glDisable(GL_TEXTURE_GEN_S);
   glDisable(GL_TEXTURE_GEN_T);

   /* enable what's needed */
   if (m==LIT) {
      glEnable(GL_LIGHTING);
   }
   else if (m==TEXTURED) {
      glEnable(GL_TEXTURE_2D);
   }
   else if (m==REFLECT) {
      glEnable(GL_TEXTURE_2D);
      glEnable(GL_TEXTURE_GEN_S);
      glEnable(GL_TEXTURE_GEN_T);
   }
}


static void ModeMenu(int entry)
{
   if (entry==ANIMATE) {
      Animate = !Animate;
   }
   else if (entry==QUIT) {
      exit(0);
   }
   else {
      SetMode(entry);
   }
   glutPostRedisplay();
}


static void Key( unsigned char key, int x, int y )
{
   switch (key) {
      case 27:
         exit(0);
         break;
   }
   glutPostRedisplay();
}


static void SpecialKey( int key, int x, int y )
{
   float step = 3.0;

   switch (key) {
      case GLUT_KEY_UP:
         Xrot += step;
         break;
      case GLUT_KEY_DOWN:
         Xrot -= step;
         break;
      case GLUT_KEY_LEFT:
         Yrot += step;
         break;
      case GLUT_KEY_RIGHT:
         Yrot -= step;
         break;
   }
   glutPostRedisplay();
}


static void Init( void )
{
   GLUquadricObj *q = gluNewQuadric();
   CylinderObj = glGenLists(1);
   glNewList(CylinderObj, GL_COMPILE);

   glTranslatef(0.0, 0.0, -1.0);

   /* cylinder */
   gluQuadricNormals(q, GL_SMOOTH);
   gluQuadricTexture(q, GL_TRUE);
   gluCylinder(q, 0.6, 0.6, 2.0, 24, 1);

   /* end cap */
   glTranslatef(0.0, 0.0, 2.0);
   gluDisk(q, 0.0, 0.6, 24, 1);

   /* other end cap */
   glTranslatef(0.0, 0.0, -2.0);
   gluQuadricOrientation(q, GLU_INSIDE);
   gluDisk(q, 0.0, 0.6, 24, 1);

   glEndList();
   gluDeleteQuadric(q);

   /* lighting */
   glEnable(GL_LIGHTING);
   {
      GLfloat gray[4] = {0.2, 0.2, 0.2, 1.0};
      GLfloat white[4] = {1.0, 1.0, 1.0, 1.0};
      GLfloat teal[4] = { 0.0, 1.0, 0.8, 1.0 };
      glMaterialfv(GL_FRONT, GL_DIFFUSE, teal);
      glLightfv(GL_LIGHT0, GL_AMBIENT, gray);
      glLightfv(GL_LIGHT0, GL_DIFFUSE, white);
      glEnable(GL_LIGHT0);
   }

   /* setup texturing */
#ifdef LINEAR_FILTER
   /* linear filtering looks much nicer but is much slower for Mesa */
   glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
   glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
#else
   glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
   glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
#endif

   glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);
   glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_FASTEST);

   glTexGeni(GL_S, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);
   glTexGeni(GL_T, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);

   if (!LoadRGBMipmaps("reflect.rgb", GL_RGB)) {
      printf("Error: couldn't load texture image\n");
      exit(1);
   }

   glEnable(GL_CULL_FACE);  /* don't need Z testing for convex objects */

   SetMode(LIT);
}


int main( int argc, char *argv[] )
{
   glutInit( &argc, argv );
   glutInitWindowSize( 400, 400 );

   glutInitDisplayMode( GLUT_RGB | GLUT_DOUBLE );

   glutCreateWindow(argv[0] );

   Init();

   glutReshapeFunc( Reshape );
   glutKeyboardFunc( Key );
   glutSpecialFunc( SpecialKey );
   glutDisplayFunc( Display );
   glutIdleFunc( Idle );

   glutCreateMenu(ModeMenu);
   glutAddMenuEntry("Lit", LIT);
   glutAddMenuEntry("Textured", TEXTURED);
   glutAddMenuEntry("Reflect", REFLECT);
   glutAddMenuEntry("Toggle Animation", ANIMATE);
   glutAddMenuEntry("Quit", QUIT);
   glutAttachMenu(GLUT_RIGHT_BUTTON);

   glutMainLoop();
   return 0;
}
