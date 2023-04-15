Reference: https://zenn.dev/botamotch/articles/46bd760b44c6a2

```
example-plugin
  ├── plugin
  │  └── example.vim
  ├── autoload
  │  └── example.vim
  └── lua
     └── example
        ├── init.lua
        └── hello.lua
```

# plugin/example.vim
プラグインロード時、読み込まれるファイル
- 初期化関数の実行
- コマンド公開
- Vim/Neovim本体のバージョンチェック
- プラグインが二重に読み込まれるのを回避

# autoload/example.vim
VimScriptによる関数登録

ファイル名#関数名という命名規則に従う。

# lua/example/*.lua
Mテーブルにメソッドを追加してモジュールとして公開する。

# 実行
```vim
    :set runtimepath+=.
    :source plugin/example_plugin.vim
```