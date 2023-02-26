<!-- FileName: readme
 Author: 8ucchiman
 CreatedDate: 2023-02-26 20:41:00 +0900
 LastModified: 2023-02-26 22:30:48 +0900
 Reference: 8ucchiman.jp
-->


* 関数の修飾子

関数の宣言に修飾子をつけてkernel関数(deviceで実行される関数)とhost関数を区別する

 - __global__

hostから呼び出されてdeviceで実行される

返り値なし

 - __device__

deviceから呼び出されてdeviceで実行

再帰関数不可

 - __host__

hostから呼び出されてhostで実行

** __global__
修飾子省略可
```cuda
    mykernel <<<Dg, Db>>> (arguments); # <<<Dg, Db>>>はthread数の指定
```

各スレッドは、kernel関数内の同じ命令を実行するが、扱うデータが異なる(SIMD: Single Instruction Multiple Data)

** threadの定義
kernel関数はスレッド単位で並列に実行される
```cuda
    <<<Dg, Db>>> grid, thread
```

```cuda
    dim3 Dg(xdiv, ydiv, zdiv);
    dim3 Db(xdiv, ydiv, zdiv);
    mykernel <<<Dg, Db>>>();
```

```cuda
    dim3 Dg(1, 2, 1);
    dim3 Db(4, 4, 1);
    #
    # +=============
    # =+----+-----+=
    # =-////--////-=
    # =-////--////-=
    # =-////--////-=
    # =+----++----+=
    # +=============
    #
    # +=============
    # =+----+-----+=
    # =-////--////-=
    # =-////--////-=
    # =-////--////-=
    # =+----++----+=
    # +=============
    #
    # =: grid
    # -: block
    # /: thread
```

* CPU/GPU間のデータ転送
** デバイスメモリの確保
```cuda
    cudaError_t cudaMalloc(void** devptr, size_t count)
    // devptr: デバイスメモリのアドレスのポインタ
    // count:  領域のサイズ
```

```cuda
    double* dev;
    cudaMalloc((void**)&dev, sizeof(double)*512)
```

** データ転送
```cuda
    cudaError_t cudaMemcpy(void* dat, const void* src, size_t count, enum cudaMemcpyKind kind)
    // dat: 転送先のアドレス
    // src: 転送元のアドレス
    // count: 領域のサイズ
    // kind: 転送サイズを指定する定数
    //     cudaMemcpyHostToDevice(host memoryからdevice memoryへ)
    //     cudaMemcpyDeviceToHost(device memoryからhost memoryへ)
    //     cudaMemcpyDeviceToDevice(device memoryからdevice memoryへ)
```

```cuda
    cudaMemcpy(dev, host, sizeof(double)*512, cudaMemcpyHostToDevice);
```

** デバイスメモリ解放
```cuda
    cudaError_t cudaFree(void* devptr)
    // devptr: デバイスメモリのアドレスのポインタ
```


* the basis of the programming in CUDA

```cuda
    メモリ確保         cudaMalloc((void**)devptr, sizeof(double)*512);
    データ転送         cudaMemcpy(host, device, sizeof(double)*512, cudaMemcpyHostToDevice);
    スレッド数定義     dim3 Dg(512, 2, 1);
    kernel呼び出し     mykernel <<<Dg, Db>>>();
    データ転送         cudaMemcpy(device, host, sizeof(double)*512, cudaMemcpyDeviceToHost);
    メモリ解放         cudaFree(device);
```

* thread index

```cuda
    # grid内のblockのDim定義
    gridDim.x = 2
    gridDim.y = 3
    # block内のthreadのDim定義
    blockDim.x = 6
    blockDim.y = 4

    #    +================+
    #         0       1
    #    =+------+-------+=
    #      012345  012345
    #   0=-//////--//////-=
    # 0 1=-//////--//////-=
    #   2=-//////--//////-=
    #   3=-//////--//////-=
    #    =+------++------+=
    #    =+------++------+=
    #   0=-//////--//////-=
    # 1 1=-//////--//////-=
    #   2=-//////--//////-=
    #   3=-//////--//////-=
    #    =+------++------+=
    #    =+------++------+=
    #   0=-//////--//////-=
    # 2 1=-//////--//////-=
    #   2=-//////--//////-=
    #   3=-//////--//////-=
    #    =+------++------+=
    #    +================+

    threadIdx.x = 2
    threadIdx.y = 1
    blockIdx.x = 1
    blockIdx.y = 1

    #    +================+
    #         0       1
    #    =+------+-------+=
    #      012345  012345
    #   0=-//////--//////-=
    # 0 1=-//////--//////-=
    #   2=-//////--//////-=
    #   3=-//////--//////-=
    #    =+------++------+=
    #    =+------++------+=
    #   0=-//////--//////-=
    # 1 1=-//////--//*///-=
    #   2=-//////--//////-=
    #   3=-//////--//////-=
    #    =+------++------+=
    #    =+------++------+=
    #   0=-//////--//////-=
    # 2 1=-//////--//////-=
    #   2=-//////--//////-=
    #   3=-//////--//////-=
    #    =+------++------+=
    #    +================+

```
