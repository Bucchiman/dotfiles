/*
 * FileName:     sample
 * Author: 8ucchiman
 * CreatedDate:  2023-02-22 15:42:47 +0900
 * LastModified: 2023-02-22 15:45:29 +0900
 * Reference: 8ucchiman.jp
 */


#include <stdio.h>
#include <stdlib.h>
#include <threads.h>
#define THREAD_COUNT 5


int run(void *arg) {
    int i = *(int*)arg;  // Copy the arg

    free(arg);  // Done with this

    printf("THREAD %d: running!\n", i);

    return i;
}

int main(int argc, char* argv[]) {
    thrd_t t[THREAD_COUNT];

    int i;

    printf("Launching threads...\n");
    for (i = 0; i < THREAD_COUNT; i++) {

        // Get some space for a per-thread argument:

        int *arg = malloc(sizeof *arg);
        *arg = i;

        thrd_create(t + i, run, arg);
    }
}
