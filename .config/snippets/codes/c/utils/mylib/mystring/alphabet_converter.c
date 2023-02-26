/*
 * FileName:     alphabet_converter
 * Author: 8ucchiman
 * CreatedDate:  2023-02-25 17:58:20 +0900
 * LastModified: 2023-02-25 18:24:17 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>

#define Ascii 65
#define ascii 97
#define num_alpha 26
#define increment 32


char alphabet_converter(char alphabet) {
    if ( Ascii <= alphabet && alphabet <= Ascii + num_alpha ) {
        alphabet += increment;
    }
    else if ( ascii <= alphabet && alphabet <= ascii + num_alpha ) {
        alphabet -= increment;
    }
    return alphabet;
}

int main(int argc, char* argv[]){
    while(1) {
        char alphabet = alphabet_converter(getchar());
        if (alphabet != EOF) {
            printf("%c", alphabet);
        }
        else {
            return 0;
        }
    }
    return 0;
}
