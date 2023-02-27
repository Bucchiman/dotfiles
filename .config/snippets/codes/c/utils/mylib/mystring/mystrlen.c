/*
 * FileName:     mystrlen
 * Author: 8ucchiman
 * CreatedDate:  2023-02-26 13:12:51 +0900
 * LastModified: 2023-02-26 13:39:03 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>
#include <stdlib.h>
//#define MAIN

int mystrlen(char* text) {
    int length = 0;
    while (text[length] != '\0') {
        length++;
    }
    return length;
}


#ifdef MAIN
int main(int argc, char* argv[]){
    int MAX_LENGTH = 256;
    char* text = (char *)malloc(MAX_LENGTH*sizeof(char*));
    fgets(text, MAX_LENGTH, stdin);
    printf("%d\n", mystrlen(text));
    return 0;
}
#endif
