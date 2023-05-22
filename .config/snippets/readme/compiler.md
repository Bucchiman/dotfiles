<!--
 FileName:      compiler
 Author:        8ucchiman
 CreatedDate:   2023-05-19 17:16:21
 LastModified:  2023-01-25 10:56:12 +0900
 Reference:     8ucchiman.jp
 Description:   ---
-->


# コンパイラ設計
静的コンパイラ(大概cコンパイラ)
```
                 +-----------+-----------+----------+
  source code -> | front end | optimizer | back end | -> machine language
                 +-----------+-----------+----------+
```

## front end
- ソースコードをぱーすしてエラー検出
- 入力コードを表す言語固有の抽象構文木(AST, Abstract Syntax Tree)を構築

## optimizer
- 冗長な計算の削除などの変形
- 言語とターゲットから独立


## back end
- コードをターゲットの命令セットに置き換える。
- ターゲットアーキテクチャがサポートする特別な機能をうまく使い良いコードを作る。
- 命令選択、レジスタ確保、命令のスケジュール

## 
