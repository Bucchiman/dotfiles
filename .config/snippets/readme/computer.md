<!-- FileName: computer
 Author: 8ucchiman
 CreatedDate: 2023-03-08 19:25:51 +0900
 LastModified: 2023-03-08 19:56:13 +0900
 Reference: https://qiita.com/kunihirotanaka/items/70d43d48757aea79de2d
            https://okisanjp.hatenablog.jp/entry/2017/01/05/124046
-->




# メモリの状態を確認する
freeコマンド、vmstatコマンドがある
```
    $ free
      >                total        used        free      shared  buff/cache   available
      > Mem:         3956676     1154820      270136        5192     2531720     2512408
      > Swap:        1048576           0     1048576
      >                                      # 空きメモリ270MG    # 2.53MG
      >
      > キャッシュには2種類存在する
      > - ページキャッシュ
      > - バッファキャッシュ
      > e.g. ページキャッシュ: ファイルへデータを書き込んだ時、ページキャッシュにデータが残されるため、次回の読み込み時にはHDDにアクセスすることなくデータを利用できる
      >      バッファキャッシュ: ブロックデバイスを直接アクセスるときに使用されるキャッシュ

    $ vmstat
      > 
```

# キャッシュについて考察する
1. スワップクリア
2. キャッシュクリーン
/proc/sys/vm/drop_cachesに書き込みを行うと、カーネルにクリーンなキャッシュ、dentry, inodeをメモリから追い出して、メモリを解放させることができる。
```bash
    $ echo 1 >/proc/sys/vm/drop_caches
```
このコマンドを打つことで解放される。
dentry, inodeを解放するときは、次のコマンドを打つ。
```bash
    $ echo 2 >/proc/sys/vm/drop_caches
```

ページキャッシュ、dentry, inodeを解放するには次のコマンドを打つ。
```bash
    $ echo 3 >/proc/sys/vm/drop_caches
```


# コマンド
```bash
    $ free
    $ cat /proc/meminfo
    $ flabtop
    $ echo 1 >/proc/sys/vm/drop_caches
    $ echo 2 >/proc/sys/vm/drop_caches
    $ echo 3 >/proc/sys/vm/drop_caches
    $ grep 'Dirty' /proc/meminfo
    $ sync

```
