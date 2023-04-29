<!--
 FileName:      cg
 Author:        8ucchiman
 CreatedDate:   2023-04-27 17:06:36
 LastModified:  2023-01-25 10:56:12 +0900
 Reference:     8ucchiman.jp
 Description:   ---
-->



# 拡大・縮小

$
  A = \begin{pmatrix}
    a_x & 0 & 0 \\
    0 & a_y & 0 \\
    0 & 0 & a_z
  \end{pmatrix}
$
# 回転
$
  A = \begin{pmatrix}
    \cos{\theta} & -\sin{\theta} & 0 \\
    \sin{\theta} &  \cos{\theta} & 0 \\
    0 & 0 & 1
  \end{pmatrix}
$

# 平行移動
平行移動ができない。
そこで、同次座標系$W$が登場する。

## 同次座標系
同次座標系$\begin{pmatrix} x & y & z & w \end{pmatrix}$と直交座標$\begin{pmatrix} x & y & z \end{pmatrix}$は次のような関係式で成り立つ。

$
\begin{pmatrix} x \\
                y \\
                z \\
                w
\end{pmatrix}

\begin{pmatrix} \frac{x}{w} \\
                \frac{y}{w} \\
                \frac{z}{w}
\end{pmatrix}
$
  A = \begin{pmatrix}
    1 & 0 & 0 & d_x \\
    0 & 1 & 0 & d_y \\
    0 & 0 & 1 & d_z \\
    0 & 0 & 0 & 1
  \end{pmatrix}

$ 
