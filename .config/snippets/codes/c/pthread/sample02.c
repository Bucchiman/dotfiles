/*
 * FileName:     sample02
 * Author: 8ucchiman
 * CreatedDate:  2023-02-22 15:37:00 +0900
 * LastModified: 2023-02-22 15:48:17 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>


void *run(void *arg) {
    int i = *(int*)arg;
    free(arg);
    printf("THREAD %d: running!\n", i);
}


int main(int argc, char* argv[]){
    pthread_t t[5];
    for (int i=0; i<5; i++) {
        int *arg = malloc(sizeof *arg);
        *arg = i;
        pthread_create(&t[i], NULL, &run, arg);
    }
    return 0;
}
