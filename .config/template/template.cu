/*
 * FileName:     {{_file_name_}}
 * Author:       {{_author_}}
 * CreatedDate:  {{_date_}}
 * LastModified: 2023-02-26 13:30:39 +0900
 * Reference:    8ucchiman.jp
 * Description:  ---
 */


#include <stdio.h>
#define MACRO
#define cudaCheckErrors(msg) \
    do { \
        cudaError_t __err = cudaGetLastError(); \
        if (__err != cudaSuccess) { \
            fprintf(stderr, "Fatal error: %s (%s at %s: %d)\n", \
                    msg, cudaGetErrorString(__err), \
                    __FILE__, __LINE__); \
            fprintf(stderr, "*** FAILED - ABORTING\n"); \
            exit(1); \
        } \
    } while (0)

__global__ void hoge(void *arguments) {

}


#ifdef MACRO
int main(int argc, char* argv[]){
    {{_cursor_}}
    hoge<<numBlocks, threadsperblock>>>((void*) hoge);
    return 0;
}
#endif
