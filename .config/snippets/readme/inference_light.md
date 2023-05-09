<!--
 FileName:      inference_light
 Author:        8ucchiman
 CreatedDate:   2023-05-09 14:43:01
 LastModified:  2023-01-25 10:56:12 +0900
 Reference:     8ucchiman.jp
 Description:   ---
-->


# Knowledge Distillation

## Soft Targets
$
    L_{ResD}(p(x_t, T), p(z_s, T)) = L_R(p(z_t, T), p(z_s, T))
$
$
    p(z_i, T) = \frac{\exp{\frac{z_i}{T}}}{\sum_j\exp{\frac{z_j}{T}}}
$

- T         : 温度
- $z_t, z_s$: 活性化関数の返還前の教師モデル、生徒モデルの出力
- $L_R$     : 損失関数, KL Divergence等


$L_{ResD(p(z_t, T), p(z_s, T))}$を最小化するようにモデルを学習させる。
温度付きSoftmaxは、分布の出力をソフトにし、確率の低いクラスの情報を残しやすくする。

- Response-Based Knowledge: モデルの出力
- Feature-Based Knowledge : モデルの出力と中間層の特徴マップ
- Relation-Based Knowledge: 層間、データ間の関係性を考慮

* DINO, Noisy Student


## Pruning


