/*
 * FileName:     heapmemory
 * Author: 8ucchiman
 * CreatedDate:  2023-02-21 12:30:13 +0900
 * LastModified: 2023-02-21 12:36:52 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>
#include <stdlib.h>
void func01();
int* func02(int a);

void func01() {
    int a = 10;
    int *b = func02(a);
    free(b);        // ヒープメモリ開放
}

int* func02(int a) {
    int *tmp = (int*) malloc(sizeof(int));  // ヒープメモリ確保
    *tmp = a*20;
    return tmp;
}

int main(int argc, char* argv[]){
    func01();
    return 0;
}
