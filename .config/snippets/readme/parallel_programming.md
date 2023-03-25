<!-- FileName: parallel_programming
 Author: 8ucchiman
 CreatedDate: 2023-03-19 12:53:07 +0900
 LastModified: 2023-03-25 16:46:12 +0900
 Reference: 8ucchiman.jp
-->


# syncronization
## レースコンディション
複数のプロセスが並行して共有リソースにアクセスした結果引き起こされる、予期しない異常な状態のこと
```
                                                    +---------------------------+
                read v   write (v+1)                |  read v    write (v+1)    |
  process A  -------------------------------------- |---------------------------|-->
                  ^         |                       |    ^           |          |
             0   0|         v 1                     |  2 |         3 v          |
  共有変数 v -------------------------------------- |---------------------------|-->
                                  1 |        ^ 2    |      2 |        3  ^      |
                                    v        |      |        v           |      |
  process B  ---------------------------------------|---------------------------|-->
                                  read v  write(v+1)|   read v       write (v+1)|
                                                    +---------------------------+
```


## アトミック処理
不可分操作と呼ぶ。
複数回のメモリアクセスが必要な操作が組み合わされた処理
- 定義

その処理の途中状態はシステム的に観測することができず、もしその処理が失敗した場合、完全に処理前の状態に復元される。


### CAS(compare and swap)
下のコードは一般的にアトミックではない。
compareとswapが別れているためである。
```c
  bool compare_and_swap(uint64_t* p, uint64_t val, uint64_t newval) {
    if (*p != val) {
      return false;
    }
    *p = newval;
    return true;
  }
```

```assembler
  compq   %rsi, (%rdi) ; %rsi == (%rdi)
```

compare and swapをアトミック処理で実行したい場合、組み込み関数である__sync_bool_compare_and_swap関数が用意されている。
```c
  bool compare_and_swap(uint64_t* p, uint64_t val, uint64_t newval) {
    return __sync_bool_compare_and_swap(p, val, newval);
  }
```

### TAS(test and set)
ポインタpの指す値がtrueなら単にリターン、falseの場合はpの指すメモリの値をtrueに設定してfalseをリターン
```c
  bool test_and_set(bool* p) {
    if (*p) {
      return true;
    }
    else {
      *p = true;
      return false;
    }
  }
```

アトミック版のTASは__sync_lock_test_and_set関数を使う。
```c
  type __sync_lock_test_and_set(type* p, type val) {
    type tmp = *p;
    *p = val;
    return tmp;
  }
```
```c
  bool test_and_set(volatile bool* p) {
    return __sync_lock_test_and_set(p, 1);
  }
```

TASのフラグを開放する場合は、__sync_lock_release関数を使う
```c
  void tas_release(volatile bool* p) {
    return __sync_lock_release(p);
  }
```

### Load-Link / Store-Conditional
ARMなどのCPUではLoad-Link/Store-Connditional(LL/SC)命令がアトミック処理の実装に用いられる。
LL命令はメモリ読み込みを行う命令、読み込む際にそのメモリを排他的に読み込むように指定する。(つまり他のプロセスがメモリ読み込みをしないようにする)
SC命令はメモリ書き込みを行う命令であり、LL命令で指定したメモリへの書き込みが他のCPUによって行われていない場合のみに書き込みが成功する。
```
                load-link v                       store-conditional (v+1)
  process A  ---------------------------------------------------------------------->
                    ^                                      |
             0     0|                                      v  fail
  共有変数 v ----------------------------------------------x----------------------->
                          0|            ^ 1
                           v            |
  process B  ---------------------------------------------------------------------->
                        read v     write (v+1)
 
```

## ミューテックス
MUTual EXclusion (mutex)、排他実行という同期処理の方法。

- bad mutex
```c
  // bac_mutex
  bool lock = false; // 共有変数

  void some_func() {
    retry:
      if (!lock) {
        lock = true;  // ロック獲得
        // クリティカルセクション
      }
      else {
        goto retry;
      }
      lock = false;   // ロック解放
  }
```

```
                    if(!lock)          lock = true        +--------------------+
  process A  ---------------------------------------------|                    |--->
                        ^                 |               |   race condition   |
             false      | false           v true          |   複数プロセスが   |
  共有変数 v ---------------------------------------------|   同時にクリティ   |--->
                              | false            ^ true   |   カルセクションに |
                              v                  |        |   入る             |
  process B  ---------------------------------------------|                    |--->
                           if(!lock)         lock = true  +--------------------+
```

- good mutex
```c
  // good_mutex
  bool lock = false;   // 共有変数

  void some_func () {
    retry:
      if (!test_and_set(&lock)) {    // 検査とロック獲得
        // clitical section
      }
      else {
        goto retry;
      }
      tas_release(&lock);   // ロック解放
  }
```

```
                            if(!TAS(&lock))
  process A  ------------------------------------------------>
                             ^
                             |
              false    false v true
  共有変数 v ------------------------------------------------>
                                     true |
                                          |
                                          v
  process B  ------------------------------------------------>
                                      if(!TAS(&lock))
```

### スピンロック
先程の例はロックが獲得できるまでループを繰り返した。
このようなリソースの空きをポーリングして確認するようなロックの獲得方法をスピンロックという。
スピンロック用のAPIはロック獲得用とロック解放用の2つが提供され、それらは以下のソースコードのように記述される。
```c
  // 共有変数へのポインタを受け取り、TASを用いてロックを獲得できるまでループ
  void spinlock_acquire(bool* lock) {
    while (test_and_set(lock));
  }

  // 単純に共有変数を引数としてtas_release関数を呼び出しているのみ
  void spinlock_release(bool* lock) {
    tas_release(lock);
  }
```

アトミック命令は実行速度上のペナルティが大きい。
そこで共有変数をチェックするループを挟むことで改良することができる。

```c
  void spinlock_acquire(bool* lock) {
    for(;;) {
      while(*lock) {
        if (!test_and_set(lock)) {
          break;
        }
      }
    }
  }

  void spinlock_release(bool* lock) {
    tas_release(lock);
  }
```

```c
  bool lock = false;

  void some_func() {
    for(;;) {
      spinlock_acquire(&lock);    // ロック獲得
      // クリティカルセクション
      spinlock_release(&lock);
    }
  }
```

### Pthreadsのミューテックス(*実装)
```c
  #include <stdio.h>
  #include <stdlib.h>
  #include <pthread.h>

  pthread_mutex_t mut = PTHREAD_MUTEX_INITIALIZER;    // ミューテックス用の変数mutを定義, 初期化

  // スレッド用の関数
  void* some_func(void* arg) {
    // pthread_mutex_lockにミューテックス用の共有変数mutのポインタを渡しロック獲得
    if (pthread_mutex_lock(&mut) != 0) {
      perror("pthread_mutex_lock");
      exit(-1);
    }
    // クリティカルセクション

    // pthread_mutex_unlock関数にmutへのポインタを渡してロック解放
    if (pthread_mutex_unlock(&mut) != 0) {
      perror("pthread_mutex_unlock");
      exit(-1);
    }

    return NULL;
  }

  int main(int argc, char* argv[]) {
    // スレッド生成
    pthread_t th1, th2;
    if (pthread_create(&th1, NULL, some_func, NULL) != 0) {
      perror("pthread_create");
      return -1;
    }
    if (pthread_create(&th2, NULL, some_func, NULL) != 0) {
      perror("pthrea_create");
      return -1;
    }

    // スレッドの終了を待機
    if (pthread_join(th1, NULL) != 0) {
      perror("pthread_join");
      return -1;
    }

    if (pthread_join(th2, NULL) != 0) {
      perror("pthrea_join");
      return -1;
    }

    // ミューテックスオブジェクトを解放
    // これをしないとメモリリークを引き起こすｊ
    if (pthread_mutex_destroy(&mut) != 0) {
      perror("pthread_mutex_destroy");
      return -1;
    }
  }

```

## セマフォ
ミューテックスはロックを獲得できるプロセスは最大で1つであった。
セマフォ(semaphore)では最大Nプロセスまで同時にロックを獲得できる。
```c
  void semaphore_acquire(volatile int* cnt) {
    for (;;) {
      while (*cnt >= NUM);
      __sync_fetch_and_add(cnt, 1);
      if (*cnt <= NUM) {
        break;
      }
      __sync_fetch_and_sub(cnt, 1);
    }
  }

  void semaphore_release(int *cnt) {
    __sync_fetch_and_sub(cnt, 1);
  }

```

### POSIXセマフォ (**実装)

```c
  #include <pthread.h>    // POSIXセマフォはPthreadsライブラリをインクルード、リンクするとコンパイル可能
  #include <fcntl.h>
  #include <sys/stat.h>
  #include <semaphore.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <unistd.h>

  #define NUM_THREADS 10
  #define NUM_LOOP 10

  int count = 0;         // グローバル変数count

  // スレッド用関数
  void *th(void* arg) {
    // スレッド内で名前付きセマフォを開く
    sem_t* s = sem_open("/mysemaphore", 0);
    if (s == SEM_FAILED) {
      perror("sem_open");
      exit(1);
    }
    for (int i=0; i<NUM_LOOP; i++) {
      // sem_wait関数でロックを獲得できるまで待機
      if (sem_wait(s) == -1) {
        perror("sem_wait");
        exit(1);
      }

      // カウンタをアトミックにインクリメント
      __sync_fetch_and_add(&count, 1);
      printf("count = %d\n", count);

      // 10ms スリープ
      usleep(10000):

      // カウンタをアトミックにデクリメント
      __sync_fetch_and_sub(&count, 1);

      //セマフォの値を増やしクリティカルセクションを抜ける
      if (sem_post(s) == -1) {
        perror("sem_post");
        exit(1);
      }

    }
    if (sem_close(s) == -1) {
      perror("sem_close");
    }
    return NULL;
  }
  int main(int argc, char* argv[]) {
    // 名前付きセマフォを開く。無い場合は生成
    // 自分とグループが利用可能なセマフォで、
    // クリティカルセクションへ入れるプロセスの上限は3
    set_t* s = sem_open("/mysemaphore", O_CREATE, 0660, 3);
    if (s == SEM_FAILED) {
      perror("sem_open");
      return 1;
    }

    // スレッド生成
    pthread_t v[NUM_TRHEADS];
    for (int i=0; i<NUM_THEADS; i++) {
      pthread_create(&v[i], NULL, th, NULL);
    }

    // join
    for (int i=0; i<NUM_THREADS; i++) {
      pthread_join(v[i], NULL);
    }

    // セマフォを破棄
    if (sem_unlink("/mysemaphore") == -1) {
      perror("sem_unlink");
    }
    return 0;
  }
```

## 条件変数
ある条件が満たされない間、プロセスを待機しておき、条件が満たされた場合に待機中のプロセスを実行したい場合がある。

e.g.  信号機

- 赤信号 -> 待機状態
- 青信号 -> 発信

```c
  #include <stdbool.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <pthread.h>

  pthread_mutex_t mut = PTHREAD_MUTEX_INITIALIZER;
  pthread_cond_t cond = PTHREAD_COND_INITIALIZER;

  voilatile bool ready = false;
  char buf[256];

  void* producer(void* arg) {
    printf("producer: ");
    fgets(buf, sizeof(buf), stdin);     // 入力を受け取る

    pthread_mutex_lock(&mut);
    ready = true;

    if (pthread_cond_broadcast(&cond) != 0) {
      perror("pthread_cond_broadcast");
      exit(-1);
    }

    pthread_mutex_unlock(&mut);
    return NULL;
  }

  void* consumer(void* arg) {
    pthread_mutex_lock(&mut);

    while(!ready) {
      if (pthread_cond_wait(&cond, &mut) != 0) {
        perror("pthread_cond_wait");
        exit(-1);
      }
    }

    pthread_mutex_unlock(&mut);
    printf("consumer: %s\n", buf);
    return NULL;
  }

  int main(int argc, char* argv[]) {
    // スレッド生成
    pthread_t pr, cn;
    pthread_create(&pr, NULL, producer, NULL);
    pthread_create(&cn, NULL, producer, NULL);

    // スレッドの終了を待機
    pthread_join(pr, NULL);
    pthread_join(cn, NULL);

    // ミューテックスオブジェクトを解放
    pthread_mutex_destroy(&mut);

    if (pthread_cond_destroy(&cond) != 0) {
      perror("pthread_cond_destroy");
      return -1;
    }

    return 0;
  }
```

## バリア同期
e.g. 小学校の遠足

     移動は必ずクラスの全員が揃ってから行われる。

### スピンロックベースのバリア同期
共有変数を用意し、プロセスがある地点にたどり着いた時点でその共有変数をインクリメントする。
共有変数がインクリメントされ続け、ある一定の数に達したときにバリアを抜けて処理を続行。

- barrierのソースコード
```c
  // 共有変数へのポインタcntをアトミックにインクリメント
  void barrier(volatile int *cnt, int max) {
    __sync_fetch_and_add(cnt, 1);   // 共有変数cntをアトミックにインクリメント
    while (*cnt < max);             // cntの指す値がmaxになるまでループで待機
  }
```

- バリア同期の利用例
```c
  volatile int num = 0;

  void* worker(void* arg) {
    barrier(&num, 10);
  }

  int main(int argc, char* argv[]) {
    for (int i=0; i<10; i++) {
      if (pthread_create(&th[i], NULL, worker, NULL) != 0) {
        perror("pthread_create");
        return -1;
      }
    }

    // joinは省略
    return 0;
  }
```

## Pthreadsを用いたバリア同期 (**実装)

```c
  #include <pthread.h>
  #include <stdio.h>
  #include <stdlib.h>

  pthread_mutex_t barrier_mut = PTHREAD_MUTEX_INITIALIZER;
  pthread_cond_t barrier_cond = PTHRAD_COND_INITIALIER;

  void barrier(volatile int* cnt, int max) {
    if (pthead_mutex_lock(&barrier_mut) != 0) {
      perror("pthread_mutex_lock");
      exit(-1);
    }

    (*cnt)++;

    if (*cnt == max) {
      if (pthread_cond_broadcast(&barrier_cond) != 0) {
        perror("pthread_cond_broadcast");
        exit(-1);
      }
    }
    else {
      do {
        if (pthread_cond_wait(&barrier_cond, &barrier_mut) != 0) {
          perror("pthread_cond_wait");
          exit(-1);
        } while (*cnt < max);
      }

      if (pthread_mutex_unlock(&barrier_mut) != 0) {
        perror("pthread_mutex_unlock");
        exit(-1);
      }
    }
  }
```

## Readers-Writerロック
そもそも、レースコンディションが発生する原因は書き込みを行うからである。
そこで書き込みのみ排他的に行えば良い。
  - Reader 読み込みのみを行うプロセス
  - Writer 読み込みと書き込みのみ行うプロセス

これらのプロセスについて以下の制約を満たすように排他制御を行う。
  - ロックを獲得中のReaderが同時刻に複数(0以上)存在可能
  - ロックを獲得中のWriterは同時刻に最大1つのみ存在可能
  - ReaderとWriterが同時刻にロック獲得状態にならない

### スピンロックベースのRWロック
```c
  /*
   * readerの数をあらわすrcnt
   * writerの数を表すwcnt
   * writerのlock変数lock
   */
  // Reader用ロック獲得関数
  void rwlock_read_acquire(int *rcnt, volatile int* wcnt) { 
    for (;;) {
      while (*wcnt);
      __sync_fetch_and_add(rcnt, 1);
      if (*wcnt == 0) {
        break;
      }
      __sync_fetch_and_sub(rcnt, 1);
    }
  }

  // Reader用ロック解放関数
  void rwlock_read_release(int* rcnt) {
    __sync_fetch_and_sub(rcnt, 1);
  }

  // Writer用ロック獲得関数
  void rwlock_write_acquire(bool* lock, voilatile int* rcnt, int* wcnt) {
    __sync_fetch_and_add(wcnt, 1);
    while(*rcnt);
    spinlock_acquire(lock);
  }

  // Writer用ロック解放関数
  void rwlock_write_release(bool* lock, int* wcnt) {
    spinlock_release(lock);
    __sync_fetch_and_sub(wcnt, 1);
  }
```
