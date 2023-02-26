/*
 * +-+
 * |+|
 * +-+
 */

#include<stdio.h>

__global__ void mykernel(void) {
}

int main(void) {
  printf("Hello, World from CUDA!\n");
  mykernel<<<1, 1>>>();
  return 0;
}
