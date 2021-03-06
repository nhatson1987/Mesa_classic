// CubeMap.cpp
// OpenGL SuperBible
// Demonstrates a applying a cube map to an object (sphere) using
// texgen, and using the same map for the skybox applying the coordinates
// manually.
// Program by Richard S. Wright Jr.

#include "../../shared/gltools.h"	// OpenGL toolkit
#include "../../shared/glframe.h"   // Camera class
#include <math.h>

GLFrame    frameCamera;             // The camera

// Six sides of a cube map
const char *szCubeFaces[6] = { "pos_x.tga", "neg_x.tga", "pos_y.tga", "neg_y.tga", "pos_z.tga", "neg_z.tga" };

GLenum  cube[6] = {  GL_TEXTURE_CUBE_MAP_POSITIVE_X,
                     GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
                     GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
                     GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
                     GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
                     GL_TEXTURE_CUBE_MAP_NEGATIVE_Z };

        
//////////////////////////////////////////////////////////////////
// This function does any needed initialization on the rendering
// context. 
void SetupRC()
    {
    GLbyte *pBytes;
    GLint iWidth, iHeight, iComponents;
    GLenum eFormat;
    int i;
       
    // Cull backs of polygons
    glCullFace(GL_BACK);
    glFrontFace(GL_CCW);
    glEnable(GL_CULL_FACE);
    glEnable(GL_DEPTH_TEST);
        
    // Set up texture maps        
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_R, GL_CLAMP_TO_EDGE);        
  
    // Load Cube Map images
    for(i = 0; i < 6; i++)
        {        
        // Load this texture map
        glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_GENERATE_MIPMAP, GL_TRUE);
        pBytes = gltLoadTGA(szCubeFaces[i], &iWidth, &iHeight, &iComponents, &eFormat);
        glTexImage2D(cube[i], 0, iComponents, iWidth, iHeight, 0, eFormat, GL_UNSIGNED_BYTE, pBytes);
        free(pBytes);
        }
        
    glTexGeni(GL_S, GL_TEXTURE_GEN_MODE, GL_REFLECTION_MAP);
    glTexGeni(GL_T, GL_TEXTURE_GEN_MODE, GL_REFLECTION_MAP);
    glTexGeni(GL_R, GL_TEXTURE_GEN_MODE, GL_REFLECTION_MAP);
    
    // Enable cube mapping, and set texture environment to decal
    glEnable(GL_TEXTURE_CUBE_MAP);
    glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);
    }



///////////////////////////////////////////////////////////
// Draw the skybox. This is just six quads, with texture
// coordinates set to the corners of the cube map
void DrawSkyBox(void)
    {
    GLfloat fExtent = 15.0f;
    
    glBegin(GL_QUADS);
        //////////////////////////////////////////////
        // Negative X
        glTexCoord3f(-1.0f, -1.0f, 1.0f);
        glVertex3f(-fExtent, -fExtent, fExtent);
        
        glTexCoord3f(-1.0f, -1.0f, -1.0f);
        glVertex3f(-fExtent, -fExtent, -fExtent);
        
        glTexCoord3f(-1.0f, 1.0f, -1.0f);
        glVertex3f(-fExtent, fExtent, -fExtent);
        
        glTexCoord3f(-1.0f, 1.0f, 1.0f);
        glVertex3f(-fExtent, fExtent, fExtent);


        ///////////////////////////////////////////////
        //  Postive X
        glTexCoord3f(1.0f, -1.0f, -1.0f);
        glVertex3f(fExtent, -fExtent, -fExtent);
        
        glTexCoord3f(1.0f, -1.0f, 1.0f);
        glVertex3f(fExtent, -fExtent, fExtent);
        
        glTexCoord3f(1.0f, 1.0f, 1.0f);
        glVertex3f(fExtent, fExtent, fExtent);
        
        glTexCoord3f(1.0f, 1.0f, -1.0f);
        glVertex3f(fExtent, fExtent, -fExtent);
 

        ////////////////////////////////////////////////
        // Negative Z 
        glTexCoord3f(-1.0f, -1.0f, -1.0f);
        glVertex3f(-fExtent, -fExtent, -fExtent);
        
        glTexCoord3f(1.0f, -1.0f, -1.0f);
        glVertex3f(fExtent, -fExtent, -fExtent);
        
        glTexCoord3f(1.0f, 1.0f, -1.0f);
        glVertex3f(fExtent, fExtent, -fExtent);
        
        glTexCoord3f(-1.0f, 1.0f, -1.0f);
        glVertex3f(-fExtent, fExtent, -fExtent);


        ////////////////////////////////////////////////
        // Positive Z 
        glTexCoord3f(1.0f, -1.0f, 1.0f);
        glVertex3f(fExtent, -fExtent, fExtent);
        
        glTexCoord3f(-1.0f, -1.0f, 1.0f);
        glVertex3f(-fExtent, -fExtent, fExtent);
        
        glTexCoord3f(-1.0f, 1.0f, 1.0f);
        glVertex3f(-fExtent, fExtent, fExtent);
        
        glTexCoord3f(1.0f, 1.0f, 1.0f);
        glVertex3f(fExtent, fExtent, fExtent);


        //////////////////////////////////////////////////
        // Positive Y
        glTexCoord3f(-1.0f, 1.0f, 1.0f);
        glVertex3f(-fExtent, fExtent, fExtent);
        
        glTexCoord3f(-1.0f, 1.0f, -1.0f);
        glVertex3f(-fExtent, fExtent, -fExtent);
        
        glTexCoord3f(1.0f, 1.0f, -1.0f);
        glVertex3f(fExtent, fExtent, -fExtent);
        
        glTexCoord3f(1.0f, 1.0f, 1.0f);
        glVertex3f(fExtent, fExtent, fExtent);
  
    
        ///////////////////////////////////////////////////
        // Negative Y
        glTexCoord3f(-1.0f, -1.0f, -1.0f);
        glVertex3f(-fExtent, -fExtent, -fExtent);
        
        glTexCoord3f(-1.0f, -1.0f, 1.0f);
        glVertex3f(-fExtent, -fExtent, fExtent);
        
        glTexCoord3f(1.0f, -1.0f, 1.0f);
        glVertex3f(fExtent, -fExtent, fExtent);
        
        glTexCoord3f(1.0f, -1.0f, -1.0f);
        glVertex3f(fExtent, -fExtent, -fExtent);
    glEnd();
    }

        
// Called to draw scene
void RenderScene(void)
    {
    // Clear the window
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        
    glPushMatrix(); 
        frameCamera.ApplyCameraTransform(); // Move the camera about

        // Sky Box is manually textured
        glDisable(GL_TEXTURE_GEN_S);
        glDisable(GL_TEXTURE_GEN_T);
        glDisable(GL_TEXTURE_GEN_R);        
        DrawSkyBox();

        // Use texgen to apply cube map
        glEnable(GL_TEXTURE_GEN_S);
        glEnable(GL_TEXTURE_GEN_T);
        glEnable(GL_TEXTURE_GEN_R);

        glPushMatrix();
            glTranslatef(0.0f, 0.0f, -3.0f);    
            
            glMatrixMode(GL_TEXTURE);
            glPushMatrix();
            
            // Invert camera matrix (rotation only) and apply to 
            // texture coordinates
            M3DMatrix44f m, invert;
            frameCamera.GetCameraOrientation(m);
            m3dInvertMatrix44(invert, m);
            glMultMatrixf(invert);
            
            gltDrawSphere(0.75f, 41, 41);
            
            glPopMatrix();
            glMatrixMode(GL_MODELVIEW);
        glPopMatrix();

    glPopMatrix();
        
    // Do the buffer Swap
    glutSwapBuffers();
    }



// Respond to arrow keys by moving the camera frame of reference
void SpecialKeys(int key, int x, int y)
    {
    if(key == GLUT_KEY_UP)
        frameCamera.MoveForward(0.1f);

    if(key == GLUT_KEY_DOWN)
        frameCamera.MoveForward(-0.1f);

    if(key == GLUT_KEY_LEFT)
        frameCamera.RotateLocalY(0.1);
      
    if(key == GLUT_KEY_RIGHT)
        frameCamera.RotateLocalY(-0.1);
                        
    // Refresh the Window
    glutPostRedisplay();
    }


///////////////////////////////////////////////////////////
// Called by GLUT library when idle (window not being
// resized or moved)
void TimerFunction(int value)
    {
    // Redraw the scene with new coordinates
    glutPostRedisplay();
    glutTimerFunc(3,TimerFunction, 1);
    }

void ChangeSize(int w, int h)
    {
    GLfloat fAspect;

    // Prevent a divide by zero, when window is too short
    // (you cant make a window of zero width).
    if(h == 0)
        h = 1;

    glViewport(0, 0, w, h);
        
    fAspect = (GLfloat)w / (GLfloat)h;

    // Reset the coordinate system before modifying
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
	
    // Set the clipping volume
    gluPerspective(35.0f, fAspect, 1.0f, 2000.0f);
        
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();    
    }

int main(int argc, char* argv[])
    {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(800,600);
    glutCreateWindow("OpenGL Cube Maps");
    glutReshapeFunc(ChangeSize);
    glutDisplayFunc(RenderScene);
    glutSpecialFunc(SpecialKeys);

    SetupRC();
    glutTimerFunc(33, TimerFunction, 1);

    glutMainLoop();
    
    return 0;
    }
