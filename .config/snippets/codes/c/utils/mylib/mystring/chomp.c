/*
 * FileName:     chomp
 * Author: 8ucchiman
 * CreatedDate:  2023-02-26 13:29:12 +0900
 * LastModified: 2023-02-26 13:45:12 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>
#include <stdlib.h>
#include "mystrlen.c"
#define MACRO


void chomp(char* text) {
    /*
     * fgets関数の場合、標準入力では、改行も含まれる
     * chomp関数でEOFうめ
     */
    int length = 0;
    while (text[length] != '\0') {
        if (text[length] == '\n') {
            text[length] = '\0';
        }
        length++;
    }
}


#ifdef MACRO
int main(int argc, char* argv[]){
    int MAX_LENGTH = 256;
    char* text = (char*)malloc(MAX_LENGTH*sizeof(char*));
    if (argc == 1) {
        fgets(text, MAX_LENGTH, stdin);
        chomp(text);
        printf("%d\n", mystrlen(text));
    }
    else {
        for (int i=1; i<argc; i++) {
            chomp(argv[i]);
            printf("%d\n", mystrlen(argv[i]));
        }
    }
    return 0;
}
#endif
