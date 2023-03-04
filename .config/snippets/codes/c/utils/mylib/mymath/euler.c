/*
 * FileName:     euler
 * Author: 8ucchiman
 * CreatedDate:  2023-02-25 18:40:37 +0900
 * LastModified: 2023-02-26 12:32:20 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>
#include "../../mylib.h"


void euler() {
    /*
     * (x(t+h) - x(t)) / h = f(x, t)
     * x(t+h) = x(t) + f(x, t) * h
     *                 ------   ---
     *                  dxdt    delta
     *
     *  eulerはtaylor展開の第2項まで
     *  x(t+delta) = x(t) + dx(t)dt * delta + 1/2 d^2x(t)dt^2 * delta^2 + 1/3! d^3x(t)dt^3 * delta^3 + ...
     */
    double x = 100.0;
    double delta = 0.1;
    double end_time = 10;
    for (double t=0.0; t<=end_time; t=t+delta) {
        printf("%10lf,%20lf\n", t, x);
        double dxdt = 2 * x;
        x += dxdt * delta;
    }
}

void implicit_euler() {
    /*
     * euler             dx(t)dt = f(x, t) -> x(n+1) = xn + f(xn, tn) * delta
     * implicit euler    dx(t)dt = f(x, t) -> x(n+1) = xn + f(x(n+1), tn) * delta
     * 差分方程式の右辺に未知のデータが含まれる
     */
}



int main(int argc, char* argv[]){
    euler();   
    return 0;
}
