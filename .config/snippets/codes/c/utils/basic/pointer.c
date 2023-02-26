/*
 * FileName:     pointer
 * Author: 8ucchiman
 * CreatedDate:  2023-02-26 12:47:08 +0900
 * LastModified: 2023-02-26 13:10:57 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>

/*
 * ポインタ変数宣言とポインタ変数が指すアドレスの中身の参照
 * は区別する
 *
 * int* p: int*型の変数pを宣言(int[4Byte]/int*[8Byte])
 * *p: ポインタ変数pが指し示すアドレスの中身
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
 * address            +---- 2000      +---- 1000  
 *                 &b |            &x |
 *  value   2000 <----+ +-- 1000 <----+ +--- 3 <-+
 *                      |               |        |
 * variable  a   <------+    b   <------+    x   |
 *           |       *a              *b          |
 *           +-----------------------------------+  *(*a)
 */

int main(int argc, char* argv[]){
    int i = 17;
    int *p = &i;
    printf("address of i: %p\n", &i);
    printf("value of p: %p\n", p);
    printf("value of *p: %d\n", *p);
    return 0;
}
