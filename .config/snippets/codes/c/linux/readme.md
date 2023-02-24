<!-- FileName: readme
 Author: 8ucchiman
 CreatedDate: 2023-02-21 12:45:50 +0900
 LastModified: 2023-02-21 12:50:49 +0900
 Reference: 8ucchiman.jp
-->


# multithread
## スレッド生成
```c
    int pthread_create(pthread_t* thread, const pthread_attr_t* attr,
                       void* (*start_routine)(void *), void* arg);
```

## スレッド待機
```c
    int pthread_join(pthread_t th, void **thread_return);
```
