<!--
 FileName:      neovim
 Author:        8ucchiman
 CreatedDate:   2023-05-01 12:19:19
 LastModified:  2023-01-25 10:56:12 +0900
 Reference:     8ucchiman.jp
 Description:   ---
-->


# require
- luaの組み込み関数
- `runtimepath`内にある`lua/`フォルダからモジュールを探す
- 多重に実行されるのを防ぐ。もう一度`require()`を実行してもモジュールは更新されない。

# luafile, source runtime
いずれもExコマンド, モジュールには対応しない。
以前に実行されたかどうかにかかわらず実行される。

## luafile
- 現在のウィンドウのディレクトリに対して相対パス、絶対パスをとる。

## source
- 現在のウィンドウのディレクトリに対して相対パス、絶対パスをとる。

## runtime
- `'runtimepath'`オプションを使用してファイルを探す。


# luaeval
- vim scriptの組み込み関数。文字列のLua式のを評価して返す。
