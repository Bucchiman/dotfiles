/*
 * FileName:     mystrncpy
 * Author: 8ucchiman
 * CreatedDate:  2023-03-01 00:57:42 +0900
 * LastModified: 2023-03-01 01:04:07 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>
#include <stdlib.h>
#define MACRO


char* mystrncpy(char* s1, const char* s2, const int n) {
    for (int i=0; i<n; i++) {
        s1[i] = s2[i];
    }
    s1[n] = '\0';
    return s1;
}

#ifdef MACRO
int main(int argc, char* argv[]){
    int n = 3;
    char ori_str[7] = "hello\n";
    char *to_str, *p;
    to_str = (char*) malloc(7*sizeof(char));
    p = mystrncpy(to_str, ori_str, n);
    printf("ori_str: %p -- %s", ori_str, ori_str);
    printf("to_str: %p -- %s\n", to_str, to_str);
    printf("p: %p -- %p\n", p, p);
    return 0;
}
#endif
