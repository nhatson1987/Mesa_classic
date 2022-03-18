/*
MIT License

Copyright (c) 2017-2020 Markus Trenkwalder

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

#include "SDL.h"
#include "Rasterizer.h"

using namespace swr;

class PixelShader : public PixelShaderBase<PixelShader> {
public:
	static const bool InterpolateZ = false;
	static const bool InterpolateW = false;
	static const int AVarCount = 3;
	
	static SDL_Surface* surface;

	static void drawPixel(const PixelData &p)
	{
		int rint = (int)(p.avar[0] * 255);
		int gint = (int)(p.avar[1] * 255);
		int bint = (int)(p.avar[2] * 255);
		
		Uint32 color = rint << 16 | gint << 8 | bint;

		Uint32 *buffer = (Uint32*)((Uint8 *)surface->pixels + (int)p.y * surface->pitch + (int)p.x * 4);
		*buffer = color;
	}
};

SDL_Surface* PixelShader::surface;

void drawTriangle(SDL_Surface *screen)
{
	Rasterizer r;
	r.setScissorRect(0, 0, 640, 480);
	r.setPixelShader<PixelShader>();
	PixelShader::surface = screen;

	RasterizerVertex v0, v1, v2;
	
	v0.x = 320;
	v0.y = 100;
	v0.avar[0] = 1.0f;
	v0.avar[1] = 0.0f;
	v0.avar[2] = 0.0f;

	v1.x = 480;
	v1.y = 200;
	v1.avar[0] = 0.0f;
	v1.avar[1] = 1.0f;
	v1.avar[2] = 0.0f;

	v2.x = 120;
	v2.y = 300;
	v2.avar[0] = 0.0f;
	v2.avar[1] = 0.0f;
	v2.avar[2] = 1.0f;

	r.drawTriangle(v0, v1, v2);
}

int main(int argc, char *argv[])
{
	SDL_Init(SDL_INIT_VIDEO);

	SDL_Window *window = SDL_CreateWindow(
		"RasterizerTest",
		SDL_WINDOWPOS_UNDEFINED, 
		SDL_WINDOWPOS_UNDEFINED,
		640, 
		480,
		0
	);

	SDL_Surface *screen = SDL_GetWindowSurface(window);
	srand(1234);

	drawTriangle(screen);

	SDL_UpdateWindowSurface(window);

	SDL_Event e;
	while (SDL_WaitEvent(&e) && e.type != SDL_QUIT);

	SDL_DestroyWindow(window);
	SDL_Quit();

	return 0;
}