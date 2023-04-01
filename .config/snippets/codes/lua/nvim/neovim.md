<!-- FileName: neovim
 Author: 8ucchiman
 CreatedDate: 2023-03-31 00:07:06 +0900
 LastModified: 2023-04-01 19:12:30 +0900
 Reference: 8ucchiman.jp
-->


# neovim

## Ex


### autocmd
[ref](https://vim-jp.org/vimdoc-ja/autocmd.html)
- :autocmd BufEnter *.txt lua print("Hello World from 8ucchiman")

テキストファイルを編集するときluaコマンドが実行される

```
    :autocmd [Event] [file pattern] [command]
```

#### Event

- BufNewFile
