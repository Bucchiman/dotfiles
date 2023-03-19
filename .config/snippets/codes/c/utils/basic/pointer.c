/*
 * FileName:     pointer
 * Author: 8ucchiman
 * CreatedDate:  2023-02-26 12:47:08 +0900
 * LastModified: 2023-03-18 20:54:33 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>

/*
 * ポインタ変数宣言とポインタ変数が指すアドレスの中身の参照
 * は区別する
 *
 * int* p: int*型の変数pを宣言(int[4Byte]/int*[8Byte])
 * *p: ポインタ変数pが指し示すアドレスの中身
 * e.g. int* p;
 *      p = &i;
 *
 * ポインタのポインタ
 *
 * int** a;
 * int* b;
 * int x;
 *
 * x=&b;
 * b=&x;
 *
 * address            +---> 2000      +---> 1000  
 *                 &b |            &x |
 *  value   2000 -----+ +-> 1000 -----+ +->  3 <-+
 *                      |               |        |
 * variable  a   -------+    b   -------+    x   |
 *           |       *a              *b          |
 *           +-----------------------------------+  *(*a)
 *
 * char型のポインタ
 * char name[] = "bucchiman";
 * printf("name = %p\n", name);                 // name = 0xbff5391b
 * printf("&name[0] = %p\n", &name[0]);         // &name[0] = 0xbff5391b
 * printf("name printed as %%s is %s\n", name); // name printed as %s is bucchiman
 * printf("*name = %c\n", *name);               // *name = b
 * printf("name[0] = %c\n", name[0]);           // name[0] = b
 * -> nameはポインタ, nameの値はname[0]のアドレス
 *
 * char* name[];
 * -> name[0]はポインタ, name[0]の値はname[0][0]のアドレス
 *
 */

int main(int argc, char* argv[]){
    int i = 17;
    int *p = &i;
    printf("address of i: %p\n", &i);
    printf("value of p: %p\n", p);
    printf("value of *p: %d\n", *p);
    return 0;
}
