
#include <windows.h>
#pragma comment(lib,"User32.lib")


#include "../include/GLFW/glfw3.h"

int CALLBACK
WinMain(HINSTANCE hInstance,
	HINSTANCE hPrevInstance,
	LPSTR lpCmdLine,
	int nCmndShow)
{
    if(!glfwInit)
	MessageBoxA(0, "Message Box!", "Terrific Engine",
		   MB_OK|MB_ICONINFORMATION);


	return(0);
}
