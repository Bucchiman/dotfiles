<!--
 FileName:      prediction
 Author:        8ucchiman
 CreatedDate:   2023-04-28 14:30:28
 LastModified:  2023-01-25 10:56:12 +0900
 Reference:     https://blog.neko-ni-naritai.com/entry/diff-of-semicolon-and-pipe
 Description:   ---
-->


# 最尤推定
パラメータ$\theta$が決まった時点で、観測したデータとなる分布に近いように$\theta$を決める。

$argmax_{\theta}P(D|\theta)$


- 尤度

確率分布からデータが実際に生起した際の確率



# MAP推定




# $p(x;\theta)$と$p(x|\theta)$の違い
- $p(x;\theta)$: \thetaというパラメータが与えられた下での$p(x)$の評価値
- $p(x|\theta)$: \thetaという条件が与えられた下での$p(x)$の評価値
    パラメータも確率変数として扱う意味合いを込めるのであれば、$p(x|\theta)$
