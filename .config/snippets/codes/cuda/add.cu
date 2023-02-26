#include <stdio.h>

__global__ void addMatrix (array) {
  printf("%d\n", threadIdx.x);
}


int main(void) {
  float* array;
  cudaMalloc((void**)&array, sizeof(float)*512*512);
  dim3 Dg(512, 1, 1);
  dim3 Db(512, 1, 1);
  addMatrix <<<Dg, Db>>>(array);
  cudaThreadSynchronize();
  cudaMemcpy(host_matrix, dev_matrix, cudaMemcpyDeviceToHost);

  cudaFree((void*)array);
  return 0;
}
