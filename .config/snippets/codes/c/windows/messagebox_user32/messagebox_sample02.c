#include<windows.h>

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR lpCmdLine, int nCmdShow) {
    CHAR chStr[128];
    wsprintf(chStr, "InstanceHandle: %d", hInstance);
    MessageBox(NULL, chStr, TEXT("Kitty on your lap"), MB_OK);
    return 0;
}
