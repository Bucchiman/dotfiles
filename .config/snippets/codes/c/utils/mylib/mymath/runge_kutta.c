/*
 * FileName:     runge_kutta
 * Author: 8ucchiman
 * CreatedDate:  2023-02-25 19:07:23 +0900
 * LastModified: 2023-02-26 12:32:49 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>
#include "../../mylib.h"

double dxdt(double x, double y, double time) {
    return -0.000001 * x * y + 0.0003 * x;
}
double dydt(double x, double y, double time) {
    return 0.000001 * x * y - 0.1 * y;
}


void runge_kutta() {
    /*
     *  x(t+delta) = x(t) + dx(t)dt * delta + 1/2 d^2x(t)dt^2 * delta^2 + 1/3! d^3x(t)dt^3 * delta^3 + ...
     *
     *  dx(t)dt = f(x, t)
     *  k1 = f(xn, tn)
     *  k2 = f(xn+h/2*k1, tn+h/2)
     *  k3  f(xn+h/2*k2, tn+h/2)
     *  k4 = f(xn+hk3, tn+h)
     *  x(n+1) = xn + (k1+2k2+2k3+k4)h/6
     */
    double x = 0.65;
    double y = 0.35;
    double delta = 0.1;
    double end_time = 50.0;
    for (double t=0.0; t<=end_time; t=t+delta) {
        printf("%lf, %lf, %lf\n", t, x, y);
        double kx1 = dxdt(x, y, t);
        double kx2 = dxdt(x+delta/2.0*kx1, y, t+delta/2.0);
        double kx3 = dxdt(x+delta/2.0*kx2, y, t+delta/2.0);
        double kx4 = dxdt(x+delta*kx3, y, t+delta);
        double ky1 = dydt(x, y, t);
        double ky2 = dydt(x, y+delta/2.0*ky1, t+delta/2.0);
        double ky3 = dydt(x, y+delta/2.0*ky2, t+delta/2.0);
        double ky4 = dydt(x, y+delta*ky3, t+delta);
        x = x + (kx1+2*kx2+2*kx3+kx4) * delta / 6.0;
        y = y + (ky1+2*ky2+2*ky3+ky4) * delta / 6.0;
    }
}

int main(int argc, char* argv[]){
    runge_kutta();
    return 0;
}
