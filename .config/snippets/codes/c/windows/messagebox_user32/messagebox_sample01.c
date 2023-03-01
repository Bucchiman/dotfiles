#include<windows.h>

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR lpCmdLine, int nCmdShow) {
    int on_button;
    on_button = MessageBox(NULL, TEXT("Do you know Nujabes?"), TEXT(""), MB_YESNO | MB_ICONQUESTION);
    if (on_button == IDYES){
        MessageBox(NULL, TEXT("Brilliant!"), TEXT(""), MB_OK);
    }
    else{
        MessageBox(NULL, TEXT("Oh My God..."), TEXT(""), MB_OK);
    }
    return 0;
}
