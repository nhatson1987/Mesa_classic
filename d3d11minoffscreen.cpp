#define WIN32_LEAN_AND_MEAN

#include <d3d11.h>
#pragma comment(lib, "d3d11")

#include <wincodec.h> // for saving the image: Windows Imaging Components (WIC)
#pragma comment(lib, "windowscodecs")

#include <atlbase.h> // CComPtr will facilitate the work with pointers (RAII)

// // binary_t helper for loading binary resources from disk
#include <vector>
#include <fstream>  // ifstream
#include <iterator> // istream_iterator
struct binary_t : std::vector<unsigned char>
{
	binary_t(const char path[]) : vector( // constructor takes the path to the binary file
		std::istream_iterator<value_type>(std::ifstream(path, std::ios::binary) >> std::noskipws),
		std::istream_iterator<value_type>())
	{}
};


int main()
{
	static const UINT IMAGE_WIDTH=640, IMAGE_HEIGHT=480, NUM_POINTS=4;

	// create a Direct3D device and context
	// - to know what is happening on the graphics card, you can enable:
	// Debug -> Graphics -> DirectX Control Panel -> Debug Layer -> Force On (force debug layer)

	CComPtr<ID3D11Device> dev; 
	CComPtr<ID3D11DeviceContext> ctx;
	::D3D11CreateDevice(nullptr, D3D_DRIVER_TYPE_HARDWARE, 0, 0, nullptr, 0, D3D11_SDK_VERSION, &dev, 0, &ctx);

	CComPtr<ID3D11Texture2D> target, image; // create the output texture and output image
	D3D11_TEXTURE2D_DESC desc = {};
	desc.Width  = IMAGE_WIDTH;                 // image dimensions
	desc.Height = IMAGE_HEIGHT;
	desc.ArraySize = 1;                        // need to set (third texture dimension?) ...
	desc.SampleDesc.Count = 1;                 // multiple sampling
	desc.Format = DXGI_FORMAT_R8G8B8A8_UNORM;  // or e.g. DXGI_FORMAT_R8G8B8A8_UNORM_SRGB;
	desc.BindFlags = D3D11_BIND_RENDER_TARGET; // what do we need this texture for
	dev->CreateTexture2D(&desc, nullptr, &target);

	desc.BindFlags = 0;
	desc.Usage = D3D11_USAGE_STAGING;
	desc.CPUAccessFlags = D3D11_CPU_ACCESS_READ;
	dev->CreateTexture2D(&desc, nullptr, &image);

	
	// create a texture view and set it as "output" from the shader
	CComPtr<ID3D11RenderTargetView> view;
	dev->CreateRenderTargetView(target, nullptr, &view); // do not specify D3D11_RENDER_TARGET_VIEW_DESC, dimensions will be copied from texture
	ctx->OMSetRenderTargets(1, &view.p, nullptr); // if we need a depth buffer then ID3D11DepthStencilState still needs to be set

	// ustawiamy viewport

	D3D11_VIEWPORT viewport = {};
	viewport.Width  = IMAGE_WIDTH;
	viewport.Height = IMAGE_HEIGHT;
	viewport.MaxDepth = D3D11_MAX_DEPTH; // you have to set
	ctx->RSSetViewports(1, &viewport);

	// load and set up shaders
	// - we can compile them from source :: D3D10CompileShader (), which would require linking from d3d10.lib
	// - VS since 2012 allows you to build shaders, you can set the creation of a header with executable code in the form of a character array
	// - here we load the code of the compiled shader from the * .cso (compiled shader object) file and create the shader
	CComPtr<ID3D11VertexShader> vertex_shader;
	const binary_t vertex_code = "VertexShader.cso";
	dev->CreateVertexShader(vertex_code.data(), vertex_code.size(), nullptr, &vertex_shader);
	ctx->VSSetShader(vertex_shader, nullptr, 0);


	CComPtr<ID3D11PixelShader>  pixel_shader;
	const binary_t pixel_code = "PixelShader.cso";
	dev->CreatePixelShader(pixel_code.data(), pixel_code.size(), nullptr, &pixel_shader);
	ctx->PSSetShader(pixel_shader, nullptr, 0);

	ctx->IASetPrimitiveTopology(D3D11_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP); // we will draw triangles with "dribble"
	
	// rwe draw

	ctx->Draw(NUM_POINTS, 0); // draw four vertices (no input, the shader will calculate the coordinates)

	// rinse :)

	ctx->Flush(); // this is important, instead of IDXGISwapchain :: Present ();

	// copy the pixels from the resulting texture to the image from which we can read them

	ctx->CopyResource(image, target); // better not to get confused here - copy from right to left

	// we map resource to memory to get to image pixels - IMPORTANT to unmap it later!
	D3D11_MAPPED_SUBRESOURCE resource = {};
	static const UINT resource_id = D3D11CalcSubresource(0, 0, 0);
	ctx->Map(image, resource_id, D3D11_MAP_READ, 0, &resource);
	resource.pData;

	// create a WIC factory and bitmap from memory mapped

	CoInitialize(nullptr); // important to initialize COM
	CComPtr<IWICImagingFactory> factory;
	factory.CoCreateInstance(CLSID_WICImagingFactory, nullptr, CLSCTX_INPROC_SERVER);

	CComPtr<IWICBitmap> bitmap;
	factory->CreateBitmapFromMemory(
		IMAGE_WIDTH, IMAGE_HEIGHT, 
		GUID_WICPixelFormat32bppRGBA, resource.RowPitch, resource.DepthPitch, 
		(BYTE*)resource.pData, &bitmap);
	ctx->Unmap(image, resource_id); // don't forget to unmap the resource


	// initialize the encoder and the PNG stream
	CComPtr<IWICStream> stream;
	CComPtr<IWICBitmapEncoder> encoder;
	CComPtr<IWICBitmapFrameEncode> frame;

	factory->CreateStream(&stream);
	stream->InitializeFromFilename(L"image.png", GENERIC_WRITE);

	factory->CreateEncoder(GUID_ContainerFormatPng, nullptr, &encoder);
	encoder->Initialize(stream, WICBitmapEncoderNoCache);
	encoder->CreateNewFrame(&frame, nullptr);
	frame->Initialize(nullptr);

	frame->WriteSource(bitmap, nullptr); // do not pass WICRect, whole image will be saved

	frame->Commit();
	encoder->Commit();

	
	// it would be preferable to deinitialize COM, but destroy all WIC objects first
	// CoUninitialize ();

	return 0;
}