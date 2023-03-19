/*
 * FileName:     mystrsubst
 * Author: 8ucchiman
 * CreatedDate:  2023-03-02 00:24:35 +0900
 * LastModified: 2023-03-04 14:28:50 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>
#include <stdlib.h>
#include "../../mylib.h"
//#define MACRO


char* mystrsubst(const char* s1, int start, int end) {
    char* substring = (char*) malloc((end-start)*sizeof(char));
    for (int i=start; i<end; i++) {
        substring[i] = s1[i];
    }
    substring[end] = '\0';
    return substring;
}

#ifdef MACRO
int main(int argc, char* argv[]){
    
    return 0;
}
#endif
