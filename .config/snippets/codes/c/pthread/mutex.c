/*
 * FileName:     mutex
 * Author: 8ucchiman
 * CreatedDate:  2023-02-22 15:23:13 +0900
 * LastModified: 2023-03-01 00:15:30 +0900
 * Reference: 8ucchiman.jp
 */


/*
 *    +------------+
 *    | room       |
 *    |  thread 1  |  x <----------thread2
 *    |            |
 *    +------------+
 */


#include <pthread.h>
#include <unistd.h>
#include <stdio.h>

pthread_mutex_t lock;
int j;

void *do_process() {
    pthread_mutex_lock(&lock);  // lockをかける
    int i = 0;

    j++;

    while(i < 5){
        printf("%d", j);
        sleep(10000000);

        i++;
    }

    printf("...Done\n");

    pthread_mutex_unlock(&lock);  // lock解除
}

int main(int argc, char* argv[]) {
    int err;
    pthread_t t1, t2;

    if (pthread_mutex_init(&lock, NULL) != 0) {
        printf("Mutex initialization failed.\n");
        return 1;
    }

    j = 0;

    pthread_create(&t1, NULL, do_process, NULL);
    pthread_create(&t2, NULL, do_process, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    pthread_mutex_destroy(&lock);

    return 0;
}

