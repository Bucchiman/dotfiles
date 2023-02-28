#include<windows.h>

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR lpCmdLine, int nCmdShow) {
    MessageBox(NULL, TEXT("Kitty on your lap"), TEXT("message for you"), MB_OK);
    return 0;
}
