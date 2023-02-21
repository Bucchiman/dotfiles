/*
 * FileName:     detach_thread
 * Author: 8ucchiman
 * CreatedDate:  2023-02-21 11:21:00 +0900
 * LastModified: 2023-02-21 11:44:30 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>
#define METHOD00 0
#define METHOD01 1

/*
 * デタッチスレッド: スレッドの終了処理に自動的にスレッド用のリソースを解法する手法
 * method00
 *  pthread_create関数呼び出し時のアトリビュート(第2引数)で指定する方法
 * method01
 *  pthread_detach関数を呼び出す方法
 *
 *  pthread_create(&thread, &attr, thread_func, (void*) i)
 *  第一引数: pthread_t型
 *  第二引数: pthread_attr_t型
 *  第三引数: (void *)型のthread_func
 *  第四引数: (void *)型のthread_funcの引数
 */


#if METHOD00
void *thread_func(void* arg) {
    for (int i=0; i<5; i++) {
        printf("i=%d\n", i);
        sleep(1);
    }
    return NULL;
}

int main(int argc, char* argv[]){
    // アトリビュートの初期化
    pthread_attr_t attr;
    if (pthread_attr_init(&attr) != 0) {
        perror("pthread_attr_init");
        return -1;
    }
    
    // デタッチスレッド設定
    if (pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED) != 0) {
        perror("pthread_attr_setdetachstate");
        return -1;
    }


    // アトリビュートを指定してスレッド生成
    pthread_t th;
    if (pthread_create(&th, &attr, thread_func, NULL) != 0) {
        perror("pthread_create");
        return -1;
    }

    // アトリビュート破棄
    if (pthread_attr_destroy(&attr) != 0) {
        perror("pthread_attr_destroy");
        return -1;
    }
    sleep(7);

    return 0;
}
#endif


#if METHOD01
void *thread_func(void* arg) {
    pthread_detach(pthread_self());
    for (int i=0; i<5; i++) {
        printf("i=%d\n", i);
        sleep(1);
    }
    return NULL;
}

int main(int argc, char* argv[]){
    // アトリビュートの初期化
    pthread_attr_t attr;
    if (pthread_attr_init(&attr) != 0) {
        perror("pthread_attr_init");
        return -1;
    }
    
    // デタッチスレッド設定
    if (pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED) != 0) {
        perror("pthread_attr_setdetachstate");
        return -1;
    }


    // アトリビュートを指定してスレッド生成
    pthread_t th;
    if (pthread_create(&th, &attr, thread_func, NULL) != 0) {
        perror("pthread_create");
        return -1;
    }

    // アトリビュート破棄
    if (pthread_attr_destroy(&attr) != 0) {
        perror("pthread_attr_destroy");
        return -1;
    }
    sleep(7);

    return 0;
}
#endif
