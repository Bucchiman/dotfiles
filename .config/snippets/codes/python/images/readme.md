<!-- FileName: readme
 Author: 8ucchiman
 CreatedDate: 2023-03-02 11:21:50 +0900
 LastModified: 2023-03-02 11:57:10 +0900
 Reference: 8ucchiman.jp
-->


# フーリエ変換
## 一般的な波形におけるフーリエ変換

```
    +--------+              +--------------+
    |空間領域| <----------> |空間周波数領域|
    +--------+              +--------------+
    e.g. 距離空間           e.g. 信号がどのような周波数成分か
         X線画像
```

```
   ^                        -----------------> 空間軸
   | _       _              +--------------+
   |  \     / \             |  |  |  |  |  |
   |   \   /                |  |  |  |  |  |
   |    \_/                 |  |  |  |  |  |
   |                        |  |  |  |  |  |
   +-----------> time       +--------------+
```


任意の周期波形は、振幅、周波数、位相が異なる多くの正弦波を重ね合わせることによって表せられる。
これらを横軸-周波数, 縦軸-振幅 or 位相として表したとき次のようになる


```
   振幅
   ^ \
   | \
   | \
   |  \
   |  \
   |   \
   |   \
   |   \
   |    \
   |     \__
   |        ----
   |            ----------------
   +------------------------------> 周波数
   
```


これは直感と合うグラフだと思う。下のような矩形波形に対して様々な正弦波で表そうとすると、
振幅の小さく、周波数が高い(つまり周期が長い)波形で細かな微調整をする必要がある。


```
                                            振幅
    ^                                        ^ \
    |                                        | \
    |                                        | \
    |                                        |  \
    |         +-----------+         ------>  |  \
    |         |           |                  |   \
    |         |           |                  |   \
    |         |           |         <------  |   \
    |         |           |                  |    \
    |_________+           +______            |     \__
    |                                        |        ----
    |                                        |            ----------------
    +---------------------------->           +------------------------------> 周波数
   
```

## 画像におけるフーリエ変換
画像では、二次元離散フーリエ変換で周波数空間に変換できる。
しかし、二次元では、計算コストが高いため、FFT(Fast Fourier Transform)というアルゴリズムを用いる。

```

    +-----------------+       +-----------------+        +---------+       +---------+
    |                 |       |                 |        |         |       |         |
    |                 |       |                 |        |         |       |         |
    |                 |  -->  |                 |  -->   |         |  -->  |         |
    |                 |  FFT  |                 |  転置  |         |  FFT  |         |
    +-----------------+       +-----------------+        |         |       |         |
         入力画像                                        |         |       |         |
                                                         |         |       |         |
                                                         |         |       |         |
                                                         +---------+       +---------+
```
