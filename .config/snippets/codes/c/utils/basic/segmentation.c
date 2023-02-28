/*
 * FileName:     segmentation
 * Author: 8ucchiman
 * CreatedDate:  2023-03-01 00:29:37 +0900
 * LastModified: 2023-03-01 00:42:04 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>
#define MACRO
#define SIZE 100   // 200


/*
 * double = 8Bytes
 * SIZE=100
 * 100*100*100 arrays = 10^6 * 8 Bytes = 8MB
 * SIZE=200
 * 200*200*200 arrays = 8*10^6 * 8 Bytes = 64MB
 * SIZE=200の時8MByteでsegmentation faultが起こる
 * Why?
 * limitコマンドでStackSizeが確認でき、8MBであることがわかる
 * -> SIZE=200でSegFa
 */

#ifdef MACRO
int main(int argc, char* argv[]){
    double pos[SIZE][SIZE][SIZE];
    return 0;
}
#endif
