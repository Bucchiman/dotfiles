/*
 * FileName:     sample01
 * Author: 8ucchiman
 * CreatedDate:  2023-02-20 00:08:07 +0900
 * LastModified: 2023-02-22 15:51:39 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>

#define NUM_THREADS 10 // num threads created


// スレッド用の関数
// スレッド用の関数は
//      void*型の値を受け取り、 // +
//      void*型の値をリターンする // ++
// する必要がある
void *thread_func(void *arg){
    int id = (int)arg;      // +
    for (int i=0; i<5; i++){
        printf("id = %d, i = %d\n", id, i);
        sleep(1);
    }
    return "fisnished!";        // ++
}

int main(int argc, char *argv[]){
    pthread_t v[NUM_THREADS];       // スレッド用のハンドラを保存する配列
    for (int i=0; i<NUM_THREADS; i++){
        // pthread_create
        // Args
        //      first_arg pthread_t型のポインタ
        //      second_arg pthreadの特徴を示すアトリビュート
        //      third_arg スレッド用の関数
        //      forth_arg third_argで渡した関数の引数(void *型にする必要がある)
        // return
        //      0 or others 成功したとき0
        if (pthread_create(&v[i], NULL, thread_func, (void *)i) != 0) {
            perror("pthread_create");
            return -1;
        }
    }

    for (int i=0; i<NUM_THREADS; i++) {
        char *ptr;
        // pthrea_join
        // Args
        //      first_arg pthread_t型の値を受け取る
        //      second_arg (void **)型のスレッドの返り値
        if (pthread_join(v[i], (void **)&ptr) == 0) {
            printf("msg = %s\n", ptr);
        }
        else {
            perror("pthread_join");
            return -1;
        }
    }
    
    return 0;
}
