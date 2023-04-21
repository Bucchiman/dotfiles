
# 1. GNSS測位計算
### 1.1 ECEF
### 1.2 ENU
### 1.3 衛星データの活用


# 2. Extended Kalman filter
- ノイズの混合した観測データから、ノイズを除去して状態を逐次推定する手法の一つ。
- 状態方程式、観測方程式という2つの方程式をモデル化する。
- x_k, u_k, z_k, w_k, v_k
- f, h, 共分散行列Q_k, R_kは既知とする。
- 状態方程式: x_k = f(x_k-1, u_k) + w_k
- 観測方程式: z_k = h(x_k) + v_k

### 2.1 推定手順

### 2.2 短所
 - 線形の場合、最適解を与えるが、非線形の場合、最適解ではない。
 - 初期値が誤っている場合や、モデルが不適切の場合、推定値が発散していく可能性がある。
 - 逐次的に推定を行うため、一時の観測値の外れ値の影響を受けやすい。
 - 観測ノイズを正規分布とする仮定は、広く開けた場所では成り立つが、都市部などでは成立しない。


# 3. Factor graph
 - ノード: variable vertices, factor vertices
 - エッジ: variable vertices-factor verticesのみ
 - 関数の因数分解。多変数の確率密度関数が因数分解されると、確率変数間の関係がわかりやすくなる?



# term
- ENU : the local East, North, Up coordinate system
- ECEF : the Earth-centered, Earth-fixed coordinate system, that is, geocentric coordinate system
- GNSS : Global Navigation Satellite System.
- GNSS/INS integration
- INS : inertial navigation system
- Kalman filter
- LC integration : loosely coupled integration.
- TC integration : tightly coupled integration.
- UTC integration : ultra-tightly coupled integration.



# kalman filterによるloosely coupled integration
# kalman filterによるtightly coupled integration
# factor graphによるGNSS-INSSintegration



## reference

- https://navi.ion.org/content/68/2/315
- https://www.researchgate.net/publication/355164217_GNSSINS_Integration_Kalman_Filter-Loose_Coupling_Master%27s_degree_course_in_Mobile_Mapping_and_Navigation_Systems_Polytechnic_University_Warsaw
- https://pdfs.semanticscholar.org/139c/f2241ec9a3a4f41eca798385d3612b40432f.pdf?_gl=1*1sckten*_ga*MTIyNDE5ODY5MS4xNjgxMzYxOTkw*_ga_H7P4ZT52H5*MTY4MTM2MTk4OS4xLjAuMTY4MTM2MTk5MS4wLjAuMA..
- https://dc.tsinghuajournals.com/cgi/viewcontent.cgi?article=1250&context=tsinghua-science-and-technology
- https://comm.ee.tut.ac.jp/~takeuchi/lecture/communication/.pdf
- https://smartech.gatech.edu/bitstream/handle/1853/45226/Factor Graphs and GTSAM A Hands-on Introduction GT-RIM-CP%26R-2012-002.pdf?sequence=1&isAllowed=y
- https://dellaert.github.io/files/Indelman13ras.pdf
- https://github.com/TixiaoShan/LIO-SAM
- https://www.jstage.jst.go.jp/article/jacc/54/0/54_0_358/_pdf
- http://opendata.enri.go.jp/~fks442/K_MUSEN/


- https://dc.tsinghuajournals.com/cgi/viewcontent.cgi?article=1250&context=tsinghua-science-and-technology
- https://dynamic-positioning.com/proceedings/dp2017/Sensors-%20Russell%20-%20presentation.pdf
- https://rpg.ifi.uzh.ch/docs/IROS20_Cioffi.pdf
- http://web.stanford.edu/group/scpnt/gpslab/pubs/papers/Alban_IONNTM_2003.pdf


- https://github.com/neufieldrobotics/simple_vslam.git
- https://github.com/neufieldrobotics/simple_vslam/blob/master/docs/tutorial.md
- https://navi.ion.org/content/navi/68/2/315.full.pdf
- https://www.youtube.com/watch?v=f5bIh96SRsk
- https://www.mdpi.com/1424-8220/22/23/9297
- https://gtsam.org/tutorials/intro.html
- https://github.com/borglab/gtsam
