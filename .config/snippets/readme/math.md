<!--
 FileName:      math
 Author:        8ucchiman
 CreatedDate:   2023-04-26 15:58:05
 LastModified:  2023-01-25 10:56:12 +0900
 Reference:     http://www.math.s.chiba-u.ac.jp/~yasuda/Chiba/Lec/senkei23U8.pdf
 Description:   ---
-->


# 2次形式

$F(x, y) = ax^2+2hxy+by^2$
$F(x, y) = \begin{pmatrix} x & y \end{pmatrix}\begin{pmatrix} a & h \\ h & b \end{pmatrix} \begin{pmatrix}x \\ y \end{pmatrix}$

ここで
$u=\begin{pmatrix}x \\ y\end{pmatrix}$
$A = \begin{pmatrix} a & h \\ h & b\end{pmatrix}$
と置くと、
$F(x, y) = u^\top Au$

と書ける。


# ヘッセ行列

$H(f) = \nabla_i\nabla_jf(x)$
$H(f) = \frac{\partial^2}{\partial x_i \partial x_j}f(x)$
$
H(f) = 
    \begin{pmatrix}
    \frac{\partial^2f}{\partial x_i^2} & \frac{\partial^2f}{\partial x_1\partial x_2} & \cdots & \frac{\partial^2f}{\partial x_1\partial x_n} \\
    \frac{\partial^2f}{\partial x_2\partial x_1} & \frac{\partial^2f}{\partial x_2^2} & \cdots & \frac{\partial^2f}{\partial x_2\partial x_n} \\
    \vdots & \vdots & \ddots & \vdots \\
    \frac{\partial^2f}{\partial x_n\partial x_1} & \frac{\partial^2}{\partial x_n\partial x_2} & \cdots & \frac{\partial^2f}{\partial x_n^2}
    \end{pmatrix}
$



# 最急降下法
1. 出発点x_0を選択
2. $\nabla f(x_k) = 0$ならば計算終了。そうでなければ、
$d_k = -\nabla f(x_k)$
とする
3. ステップ幅$\alpha$を定め、次の点を求める。
$x_{k+1} = x_k + \alpha d_k$


# ニュートン法
1. 出発点x_0を選択
2. $\nabla f(x_k) = 0$ならば計算終了。そうでなければ、
$\nabla^2f(x_k)d = -\nabla f(x_k)$
の解$d_k$を求める。
3.$x_{k+1} = x_k + d_k$として、更新




# ラグランジュの未定乗数
`制約付き最適化問題`
```
    min f(x)
    subject to g_i(x) < 0
```

## KKT条件
- $\nabla f(x) + \sum\lambda\nabla g(x) = 0$
- $\lambda g(x) = 0$


## e.g.
```
    min f(x_1, x_2) = -x_1-2x_2
    subject to g(x_1, x_2) = x^2_1 + x^2_2-6t < 0
```
