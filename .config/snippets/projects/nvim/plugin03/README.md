Reference: https://www.bedroomcomputing.com/2022/12/2022-1222-nvim-plugin/


```
    /simple_nvim_plugin
    └── lua
        ├── simple_nvim_plugin
        │   └── testModule.lua
        ├── simple_nvim_plugin.lua
        └── run.lua
```

# lua/simple_nvim_plugin
main file
- モジュール読み込み
- 関数宣言
- モジュールの関数呼び出し
- テーブルを返す

M(Moduleの略)テーブルを作り、そこに関数を生やす。
最後にリターン

# lua/simple_nvim_plugin
モジュールを書いていく
testModuleという引数をおうむ返しするだけのモジュール

- テーブル宣言
- 関数宣言
- リターン

こうしたフォルダを一階層増やす理由は、他のプラグインに同名のモジュールがあった際のエラーをなくすため

# lua/run.lua
開発中のデバッグファイル

- キャッシュ削除
- luaは読み込んだモジュールをキャッシュする。それを削除しないとモジュール内のコードの変更が毎回反映されない
- 関数呼び出し
- assert関数によるユニットテスト

# 実行
```vim
    :luafile run.lua
```
