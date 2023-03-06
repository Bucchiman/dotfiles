/*
 * FileName:     mystrcmp
 * Author: 8ucchiman
 * CreatedDate:  2023-03-02 00:11:33 +0900
 * LastModified: 2023-03-02 00:39:39 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>
#include "../../mylib.h"
//#define MACRO

int mystrcmp(const char* s1, const char* s2) {
    int i=0;
    while (s1[i] == s2[i]) {
        i++;
    }
    if (s1[i] > s2[i]) {
        return 1;
    }
    else if (s1[i] < s2[i]) {
        return -1;
    }
    else {
        return 0;
    }
}


#ifdef MACRO
int main(int argc, char* argv[]){
    printf("%d\n", mystrcmp("abz", "acaa"));
    printf("%d\n", mystrcmp("abc", "abcc"));
    printf("%d\n", mystrcmp("A", "a"));
    
    return 0;
}
#endif
