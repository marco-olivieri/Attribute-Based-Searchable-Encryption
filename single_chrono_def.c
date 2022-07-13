#include <stdint.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include "pbc/pbc.h"
#include "pbc/pbc_test.h"

#define N_ATTR 5

pairing_t pairing;
element_t x, y, a, b, r, r2, base;
element_t exponent, mul_res_G, mul_res_Z, exp_res_G, exp_res_Z;

const int n = 200;
const int N = 200;
int i, j;
int processes;
double t_start, t_finish;

typedef struct TimesGZ_struct{
    double pairing;
    double exp_G;
    double exp_Z;
    double mul_G;
    double mul_Z;
} TimesGZ;

TimesGZ times_GZ;

int main(int argc, char **argv) {

    pbc_demo_pairing_init(pairing, argc, argv);

    element_init_G1(x, pairing);
    element_init_G1(mul_res_G, pairing);
    element_init_G1(exp_res_Z, pairing);
    element_init_G1(exp_res_G, pairing);

    element_init_G2(y, pairing);

    element_init_GT(r, pairing);
    element_init_GT(r2, pairing);

    element_init_Zr(exponent, pairing);
    element_init_Zr(base, pairing);
    element_init_Zr(mul_res_Z, pairing);
    element_init_Zr(exp_res_Z, pairing);
    element_init_Zr(a, pairing);
    element_init_Zr(b, pairing);
    
    // 1 process
    t_start = pbc_get_time();
    
    for (j=0; j<N; j++){

        double ttotalpair = 0.0;
        double ttotalexp_Z = 0.0;
        double ttotalexp_G = 0.0;
        double ttotalmul_G = 0.0;
        double ttotalmul_Z = 0.0;
        double t0, t1;

        for (i=0; i<n; i++) {
            element_random(a);
            element_random(b);
            element_random(x);
            element_random(y);
            element_random(exponent);
            element_random(base);

            // evaluating time for exponentials in G (G^Z_p)
            t0 = pbc_get_time();
            element_pow_zn(exp_res_G, x, exponent); // exp_res = x^(exponent)
            t1 = pbc_get_time();
            //element_printf("%B ^ %B = %B\n\n", x, exponent, exp_res);
            ttotalexp_G += t1 - t0;

            // evaluating time for exponentials in Z_p (Z_p^Z_p)
            t0 = pbc_get_time();
            element_pow_zn(exp_res_Z, base, exponent); // exp_res = base^(exponent)
            t1 = pbc_get_time();
            //element_printf("%B ^ %B = %B\n\n", base, exponent, exp_res_Z);
            ttotalexp_Z += t1 - t0;

            // evaluating time for multiplication in G
            t0 = pbc_get_time();
            element_mul(mul_res_G, y, x); // mul_res_G = x * y
            t1 = pbc_get_time();
            ttotalmul_G += t1 - t0;

            // evaluating time for multiplication in Z_p
            t0 = pbc_get_time();
            element_mul_zn(mul_res_Z, a, b); // mul_res_Z = a * b
            t1 = pbc_get_time();
            ttotalmul_Z += t1 - t0;

            //element_printf("x = %B\n", x);
            //element_printf("y = %B\n", y);
            //element_printf("e(x,y) = %B\n", r);

        }

        times_GZ.pairing = ttotalpair / n;
        times_GZ.exp_G = ttotalexp_G / n;
        times_GZ.exp_Z = ttotalexp_Z / n;
        times_GZ.mul_G = ttotalmul_G / n;
        times_GZ.mul_Z = ttotalmul_Z / n;
    }
   
    t_finish = pbc_get_time();

    printf("\n");
    printf("average exp time in Z = %.7f ms\n", times_GZ.exp_Z*1000);
    printf("average exp time in G = %.7f ms\n", times_GZ.exp_G*1000);
    printf("average pairing time = %.7f ms\n", times_GZ.pairing*1000);
    printf("average multiplication time in G = %.7f ms\n", times_GZ.mul_G*1000);
    printf("average multiplication time in Z = %.7f ms\n\n", times_GZ.mul_Z*1000);
    printf("Time elapsed: %f s\n\n", t_finish-t_start);

    element_clear(x);
    element_clear(y);
    element_clear(a);
    element_clear(b);
    element_clear(r);
    element_clear(r2);
    element_clear(exp_res_G);
    element_clear(exp_res_Z);
    element_clear(mul_res_G);
    element_clear(mul_res_Z);
    element_clear(exponent);
    element_clear(base);

    pairing_clear(pairing);

    return 0;
}