<!--
 FileName:      optical_flow
 Author:        8ucchiman
 CreatedDate:   2023-05-22 15:15:18
 LastModified:  2023-01-25 10:56:12 +0900
 Reference:     8ucchiman.jp
 Description:   ---
-->


# Optical flow
`フレーム間の画素の変異を二次元ベクトルで表現するもの` `移動物体の検出, カメラの動き推定`

## 勾配法
連続する2枚の画像での対象物の移動量が微小であることを前提とする。
画像上の画素$(x, y)$の時刻$t$における画素値を$I(x, y, t)$とし、時間$\Delta t$の間にその画素が$(\Delta x, \Delta y)$だけ移動したとする。
移動量は微小であると仮定したとき次の式が成り立つ。
$I(x, y, t) = I(x+\Delta x, y+\Delta y, t+\Delta t)$

この時、右辺をテイラー展開する。
$I(x, y, t) = I(x+\Delta x, y+\Delta y, t+\Delta t)$
$I(x, y, t) = I(x, y, t) + \frac{\partial I}{\partial x}\Delta x + \frac{\partial I}{\partial y}\Delta y + \frac{\partial I}{\partial t}\Delta t$
$0 = \frac{\partial I}{\partial x}\Delta x + \frac{\partial I}{\partial y}\Delta y + \frac{\partial I}{\partial t}\Delta t$
$0 = \frac{\partial I}{\partial x}\frac{\partial x}{\partial t} + \frac{\partial I}{\partial y}\frac{\partial y}{\partial t} + \frac{\partial I}{\partial t}$


画素の移動、オプティカルフローを$(u, v) = (\frac{\partial x}{\partial t}, \frac{\partial y}{\partial t})$とする。
画素値の偏微分を$I_x, I_y$とするとき次のように書ける。

$0 = \frac{\partial I}{\partial x}\frac{\partial x}{\partial t} + \frac{\partial I}{\partial y}\frac{\partial y}{\partial t} + \frac{\partial I}{\partial t}$
$0 = I_{x}u + I_{y}v$

# Lucas-Kanade
`近傍画素では同一のオプティカルフローが得られると仮定` `未知数: オプティカルフロー$(u, v) = (\frac{\partial x}{\partial t}, \frac{\partial y}{\partial t})$`

近傍$m=n\times n$の画素について未知数(u, v)に対する複数の拘束式が得られる。
$0 = I_{x_{11}}u + I_{y_{11}}v$
$0 = I_{x_{12}}u + I_{y_{12}}v$
$\vdots$
$0 = I_{x_{nn}}u + I_{y_{nn}}v$

$\Leftrightarrow$

$ \begin{pmatrix} I_{x_{11}} & I_{y_{11}} \\
                  I_{x_{12}} & I_{y_{12}} \\
                  \vdots \\
                  I_{x_{nn}} & I_{y_{nn}}
                  \end{pmatrix}
                  \begin{pmatrix} u & v \end{pmatrix}
$
$ Gf+b = 0$

以下のように擬似逆行列を用いて最小2乗誤差で最適な(u, v)が求まる

$f = -(G^TG)^{-1}G^Tb$
