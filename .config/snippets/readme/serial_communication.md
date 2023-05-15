<!--
 FileName:      serial_communication
 Author:        8ucchiman
 CreatedDate:   2023-05-15 14:21:37
 LastModified:  2023-01-25 10:56:12 +0900
 Reference:     8ucchiman.jp
 Description:   https://tonkun-tech.com/serial-uart-csi-i2c/
-->


# UART
`非同期式`

UARTの端子には、送信用のTXと受信用のRXがある。
両デバイスから同時に送信ができる(全二重通信)。

```
     deviceA            deviceA
    +--------+         +--------+
    |        |         |        |
    |      TX|---------|RX      |
    |        |         |        |
    |      RX|---------|TX      |
    |        |         |        |
    +--------+         +--------+

```

## 通信方式


```
High --------+      +----------------------------------------------
             |      |      |      |      |      |      |      |      |      |
             | STT  | bit0   bit1   bit2   bit3   bit4   bit5   bit6   bit7   PBIT  STP
             +-----+


```
