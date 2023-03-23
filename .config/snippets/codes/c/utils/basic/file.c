/*
 * FileName:     file
 * Author: 8ucchiman
 * CreatedDate:  2023-03-04 14:31:12 +0900
 * LastModified: 2023-03-04 16:40:06 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>
#include <stdlib.h>
#include "../mylib.h"
#define MACRO
#define CHAR_LEN 100
#define MAX_WORDS 100

/*
 * char* name;
 * name変数はポインタ -> nameの値はアドレス
 *
 * char* argv[];
 * argv[1]変数はポインタ -> argv[1]の値はアドレス
 *
 *
 */


void file(char* argv[]) {
    FILE *fp;
    char* input_file;
    input_file = &argv[1][0];
    if ((fp = fopen(input_file, "r")) != NULL) {

    }
    int l;
    char** words = (char**) malloc(MAX_WORDS*sizeof(char*));

    while ((l = getc(fp)) != EOF) {
        char* tmp_char = (char*)malloc(CHAR_LEN*sizeof(char));
        printf("%c\n", l);
    }
    fclose(fp);
}



#ifdef MACRO
int main(int argc, char* argv[]){
    FILE *fp;
    char* input_file;
    input_file = &argv[1][0];
    file(argv);

    return 0;
}
#endif
