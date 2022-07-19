#include <stdint.h> // for intptr_t
#include "pbc/pbc.h"
#include "pbc/pbc_test.h"

/* PREPROCESSED PAIRINGS & EXPONENTIATIONS (dalla documentazione)

In some applications, the programmer may know that many pairings with the same G1 input 
will becomputed. If so, preprocessing should be used to avoid repeating many calculations 
saving time in thelong run. A variable of type pairing_pp_t should be declared, 
initialized with the fixed G1 element, and then used to compute pairings

If it is known in advance that a particular element will be exponentiated several times 
in the future, time can be saved in the long run by first calling the preprocessing function

*/

int main(int argc, char **argv) {

  pairing_t pairing;
  element_t x, y, a, b, r, r2, base;
  element_t exponent, mul_res, exp_res_G, exp_res_Z; 
  mpz_t base_mpz;
  int i, n;
  double t0, t1, ttotalpair, ttotalmul, ttotalpair_pp, ttotalexp_pp, ttotalexp_G, ttotalexp_Z;
  pairing_pp_t pp;
  element_pp_t exp_pp;

  char arguments[argc];
  printf("%d\n", argc);
  for (i=0; i<30; i++){
    printf("argv[%d] = %s\n", i, argv[i]);
  }

  // Cheat for slightly faster times:
  // pbc_set_memory_functions(malloc, realloc, free);

  pbc_demo_pairing_init(pairing, argc, argv);

  element_init_G1(x, pairing);
  element_init_G1(exp_res_Z, pairing);
  element_init_G1(exp_res_G, pairing);

  element_init_G2(y, pairing);

  element_init_GT(r, pairing);
  element_init_GT(r2, pairing);

  element_init_Zr(exponent, pairing);
  element_init_Zr(base, pairing);
  element_init_Zr(mul_res, pairing);
  element_init_Zr(exp_res_Z, pairing);
  element_init_Zr(a, pairing);
  element_init_Zr(b, pairing);

  n = 1000;
  ttotalpair = 0.0;
  ttotalpair_pp = 0.0;
  ttotalexp_Z = 0.0;
  ttotalexp_G = 0.0;
  ttotalexp_pp = 0.0;
  ttotalmul = 0.0;
  for (i=0; i<n; i++) {
    element_random(a);
    element_random(b);
    element_random(x);
    element_random(y);
    element_random(exponent);
    element_random(base);

    // evaluating time for pre-processed pairings
    pairing_pp_init(pp, x, pairing);
    t0 = pbc_get_time();
    pairing_pp_apply(r, y, pp); // r = e(x,y)
    t1 = pbc_get_time();
    ttotalpair_pp += t1 - t0;
    pairing_pp_clear(pp);
    
    // evaluating time for preprocessed pairings
    t0 = pbc_get_time();
    element_pairing(r2, x, y); // r2 = e(x,y)
    t1 = pbc_get_time();
    ttotalpair += t1 - t0;

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

    /* evaluating time for exponentials (G^G)???
    element_to_mpz(exp_G, x);
    t0 = pbc_get_time();
    element_pow_zn(exp_res_G, x, x); // exp_res_G = x^y
    t1 = pbc_get_time();
    //element_printf("%B ^ %B = %B\n\n", x, x);
    ttotalexp_G += t1 - t0; */

    // evaluating time for pre-processed exponentials
    element_pp_init(exp_pp, x);
    t0 = pbc_get_time();
    element_pp_pow_zn(exp_res_G, exponent, exp_pp); // exp_pp_res = x^(exponent)
    t1 = pbc_get_time();
    ttotalexp_pp += t1 - t0;
    element_pp_clear(exp_pp);

    // evaluating time for multiplication in Z_p
    t0 = pbc_get_time();
    element_mul_zn(mul_res, a, b); // mul_res = a * b
    t1 = pbc_get_time();
    ttotalmul += t1 - t0;


    //element_printf("x = %B\n", x);
    //element_printf("y = %B\n", y);
    //element_printf("e(x,y) = %B\n", r);

    if (element_cmp(r, r2)) {
      printf("BUG!\n");
      exit(1);
    }
  }

  printf("\n");
  printf("average exp time in Z = %.7f ms\n", (ttotalexp_Z*1000) / n);
  printf("average exp time in G = %.7f ms\n", (ttotalexp_G*1000) / n);
  printf("average exp time in G (preprocessed) = %.7f ms\n", (ttotalexp_pp*1000) / n);
  printf("average pairing time = %.7f ms\n", (ttotalpair*1000) / n);
  printf("average pairing time (preprocessed) = %.7f ms\n", (ttotalpair_pp*1000) / n);
  printf("average multiplication time = %.7f ms\n\n", (ttotalmul*1000) / n);

  element_clear(x);
  element_clear(y);
  element_clear(a);
  element_clear(b);
  element_clear(r);
  element_clear(r2);
  element_clear(exp_res_G);
  element_clear(exp_res_Z);
  element_clear(mul_res);
  element_clear(exponent);
  element_clear(base);

  pairing_clear(pairing);

  return 0;
}


/* 
ISTRUZIONI ESECUZIONE FILE:

compilare con comando:
gcc -o <outputfilename> <inputfilename.c> -L. -lgmp -lpbc

successivamente eseguire passando i parametri di una determinata curva ellitica 
presente nella directory "param":
./<filename> <~/Scrivania/ABSE_C/pbc-0.5.14/param/a.param

*/
