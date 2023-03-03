/*
 * FileName:     mystrncmp
 * Author: 8ucchiman
 * CreatedDate:  2023-03-02 00:19:29 +0900
 * LastModified: 2023-03-02 01:03:51 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>
#include <stdlib.h>
#include "../../mylib.h"
#define MACRO

int mystrncmp(const char* s1, const char* s2, const int n) {
    char* s1_substr = mysubstring(s1, 0, n);
    char* s2_substr = mysubstring(s2, 0, n);
    printf("%s, %s\n", s1_substr, s2_substr);
    int flag = mystrcmp((const char*)s1_substr, (const char*)s2_substr);
    free(s1_substr);
    free(s2_substr);
    return flag;
}

#ifdef MACRO
int main(int argc, char* argv[]){
    printf("%d\n", mystrncmp("abz", "acaa", 2));
    printf("%d\n", mystrncmp("abc", "abcc", 2));
    printf("%d\n", mystrncmp("a", "aa", 2));
    return 0;
}
#endif
