#include<windows.h>

#if false
int WINAPI WinMain(HINSTANCE hInstance,
                   HINSTANCE hPrevInstance,
                   PSTR lpCmdLine,
                   int nCmdShow){
    MessageBox(NULL, lpCmdLine, TEXT("Kitty"), MB_ICONINFORMATION);
    return 0;
}
#endif

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR pCmdLine, int nCmdShow){
    MessageBox(NULL, GetCommandLine(), TEXT("Kitty"), MB_ICONINFORMATION);
    return 0;
}
