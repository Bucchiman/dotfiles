/*
 * FileName:     volatile_modifier
 * Author: 8ucchiman
 * CreatedDate:  2023-02-21 11:44:55 +0900
 * LastModified: 2023-02-21 11:49:34 +0900
 * Reference: 8ucchiman.jp
 */


/*
 * volatile修飾子はコンパイラの最適化を制御したメモリアクセスを実現する
 * メモリアクセスはレジスタアクセスに比較して遅いためコンパイラはメモリアクセスを制御するために
 * レジスタにいったんコピーしてから値を利用する。
 * こうしたレジスタコピーによりメモリ上の値を監視しづらくなってしまうため
 * 最適化を制御する必要がある -> volatile修飾子
 */

#include <stdio.h>

int main(int argc, char* argv[]){
    
    return 0;
}
