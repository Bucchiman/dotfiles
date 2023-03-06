/*
 * FileName:     mystrcpy
 * Author: 8ucchiman
 * CreatedDate:  2023-03-01 00:42:54 +0900
 * LastModified: 2023-03-01 23:28:00 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>
#include <stdlib.h>
#include "../../mylib.h"
//#define MACRO

char* mystrcpy(char* s1, const char* s2) {
    for (int i=0; i<mystrlen(s2); i++) {
        s1[i] = s2[i];
    }
    s1[mystrlen(s2)] = '\0';
    return s1;
}

#ifdef MACRO
int main(int argc, char* argv[]){
    char ori_str[7] = "hello\n";
    char* to_str, *p;
    to_str = (char*)malloc(7*sizeof(char));
    p = mystrcpy(to_str, ori_str);
    printf("ori_str: %p -- %s", ori_str, ori_str);
    printf("to_str: %p -- %s", to_str, to_str);
    printf("p: %p -- %s", p, p);
    return 0;
}
#endif
