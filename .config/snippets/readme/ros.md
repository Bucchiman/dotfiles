<!-- FileName: ros
 Author: 8ucchiman
 CreatedDate: 2023-03-09 14:31:21 +0900
 LastModified: 2023-03-16 15:51:41 +0900
 Reference: 8ucchiman.jp
-->


# camerainfo
camera.yamlは以下のようになる
```
    image_width: 640
    image_height: 480
    camera_name: camera
    camera_matrix:
      rows: 3
      cols: 3
      data: [318.898697, 0, 311.613177, 0, 319.855587, 291.248501, 0, 0, 1]
    distortion_model: plumb_bob
    distortion_coefficients:
      rows: 1
      cols: 5
      data: [0.016615, -0.025819, 0.002167, 0.003753, 0]
    rectification_matrix:
      rows: 3
      cols: 3
      data: [1, 0, 0, 0, 1, 0, 0, 0, 1]
    projection_matrix:
      rows: 3
      cols: 4
      data: [315.782593, 0, 314.915759, 0, 0, 318.99234, 293.472369, 0, 0, 0, 1, 0]
```

## camera_matrix
元画像のカメラ行列を表す3x3の行列

```
        | fx 0  cx |   | 318.898697 0           311.613177 |
    K = | 0  fy cy | = | 0          319.855587  291.248501 |
        | 0  0  0  |   | 0          0           1          |
```

## distortion_model
レンズ歪みのモデルを選択

## distortion_coefficients
レンズひずみパラメータD
```
    D = | k1, k2, p1, p2, k3 | = | 0.016615, -0.025819, 0.002167, 0.003753, 0 |
```

## rectification_matrix
回転行列

イメージとしてカメラの取付誤差に対応
Rとして表現される
```
        | 1 0 0 |
    R = | 0 1 0 |
        | 0 0 1 |
```

## projection_matrix
投影行列とも呼ばれる補正画像のカメラ行列
```
        | fx'  0  cx'  tx |   | 315.782593 0          314.915759  0 |
    P = | 0   fy' cy'  ty | = | 0          318.99234  293.472369  0 |
        | 0    0  1    0  |   | 0          0            1         0 |
```

## table

|行列|記号   |パラメータ名          |種類|説明|
|----|-------|----------------------|----|----|
|K   |cx,cy  |principal point       |内部|元画像の画素座標上でのレンズ中心
|K   |fx,fy  |focal length          |内部|元画像の1m先のものが画素座標系でどれくらいの大きさに見えるか
|D   |k1,k2  |radial distortion     |内部|放射方向でのレンズ歪みパラメータ
|D   |p1,p2  |tangential distortion |内部|接線方向でのレンズ歪みパラメータ
|R   |       |rotation matrix       |内部|第１カメラと平行になるように補正する行列
|P   |cx',cy'|principal point       |内部|補正画像の画素座標上でのレンズ中心
|P   |fx',fy'|focal length          |内部|補正画像の1m先の1mのものが画素座標系でどのくらい大きさに見えるか
|P   |tx,ty  |normalized translation|外部|第１カメラとの平行距離を表すパラメータ

/* 内部: カメラ単体のキャリブレーションで推定可能なパラメータ
/* 外部: 外部パラメータを表す。他のカメラや取付位置との相対位置関係で決まる値


# understanding nodes

## ros2 run
```
    ros2 run <package_name> <executable_name>
```

```
    ros2 run turtulesim turtlesim_node
```

## ros2 node list
```
