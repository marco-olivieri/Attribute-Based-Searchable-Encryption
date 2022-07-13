#include <stdint.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <math.h>
#include "pbc/pbc.h"
#include "pbc/pbc_test.h"

#define N_ATTR 5

pbc_param_t params;
pairing_t pairing;
element_t p1, p2, base, _exp, mul1, mul2, gt1;
element_t p_res, exp_res, mul_res, gt_exp_res;

int i, j, n, k, l;
int min, sec;
int n_process, linspace;
double t_start, t_finish_prc, t_start_main, t_finish_main;
int v_proc[18];

// funzione per generare vettore dei processi paralleli
void create_proc_vector(int* v){
    *v = 1;
    *(v + 1) = 5;
    *(v + 2) = 10;
    linspace = 100;
    for (i = 3; i < 13; i++){
        *(v + i) = linspace; 
        linspace += 100;   
    }
}

int main(int argc, char **argv) {

    // decommentare e dare in input da terminale un file .param per inizializzare con altri parametri
    // pbc_demo_pairing_init(pairing, argc, argv);

    // inizializzazione pairing con curva ellittica di tipo A
    int qbits = 512;
    int rbits = 160;
    pbc_param_init_a_gen(params, rbits, qbits);
    pairing_init_pbc_param(pairing, params);

    // controllo sulle dimensioni elementi di G1, G2, GT e Z
    printf("G1 length: %d bytes\n", pairing_length_in_bytes_G1(pairing));
    printf("G2 length: %d bytes\n", pairing_length_in_bytes_G2(pairing));
    printf("GT length: %d bytes\n", pairing_length_in_bytes_GT(pairing));
    printf("Z length: %d bytes\n", pairing_length_in_bytes_Zr(pairing));

    // inizializzazione elementi di G1, G2 e Z
    element_init_G1(p1, pairing);
    element_init_G1(base, pairing);

    element_init_G2(p2, pairing);

    element_init_GT(gt1, pairing);
    element_init_GT(gt_exp_res, pairing);
    element_init_GT(p_res, pairing);

    element_init_Zr(_exp, pairing);
    element_init_Zr(mul1, pairing);
    element_init_Zr(mul2, pairing);
    element_init_Zr(mul_res, pairing);
    element_init_Zr(exp_res, pairing);

    create_proc_vector(v_proc);

    t_start_main = pbc_get_time();

    // esecuzione a turno, di v_proc[k] processi paralleli
    int len_v = sizeof(v_proc)/sizeof(int);
    for (k = 0; k < len_v; k++){
        n_process = v_proc[k];
        printf("\nN. processi: %d\n", n_process);

        // esecuzione di 100 cicli con "n_process" processi in parallelo per ogni elemento di v_proc
        for (n = 0; n < 100; n++){

            printf("***\n");
            t_start = pbc_get_time();

            // generazione n processi paralleli
            for (j = 0; j < n_process; ++j) {
                if (fork() == 0) {
                    double ttime_prc;

                    double t_start_prc = pbc_get_time() - t_start;

                    element_random(p1);
                    element_random(p2);
                    element_random(base);
                    element_random(_exp);
                    element_random(mul1);
                    element_random(mul2);
                    element_random(gt1);

                    // Search Wang2021 (Tse = 1*E + 2*P + 1*Mg)
                    element_pow_zn(exp_res, base, _exp);
                    element_pairing(p_res, p1, p2);
                    element_pairing(p_res, p1, p2);
                    element_mul(p2, p1, p1);
                    
                    // Search H.Wang2020 (Tse = 2*P + (N-1)*Mg)
                    /*
                    element_pairing(p_res, p1, p2);
                    element_pairing(p_res, p1, p2);
                    for (i=0; i<N_ATTR-1; i++){
                        element_mul(p2, p1, p1);
                    }
                    */
                    
                   // Search Zheng2014 (Tse = (2*N + 3)*P + N*E_T)
                   /*
                    for (i=0; i<2*N_ATTR+3; i++){
                        element_pairing(p_res, p1, p2);
                    }
                    for (i=0; i<N_ATTR; i++){
                        element_pow_zn(gt_exp_res, gt1, _exp);
                    }
                    */

                    t_finish_prc = pbc_get_time() - t_start;
                    ttime_prc = t_finish_prc - t_start_prc;

                    printf("%d,%f,%f,%f\n", j+1, t_start_prc, t_finish_prc, ttime_prc);
                
                    exit(0);
                }
            }

            // si aspetta che tutti i processi generati nel precedente ciclo for abbiano terminato
            int status;
            for (i = 0; i < n_process; ++i){
                wait(&status);
            }
        }  
    }

    element_clear(p1);
    element_clear(p2);
    element_clear(_exp);
    element_clear(base);
    element_clear(mul1);
    element_clear(mul2);
    element_clear(exp_res);
    element_clear(p_res);
    element_clear(mul_res);

    pairing_clear(pairing);

    t_finish_main = pbc_get_time();
    min = floor((t_finish_main-t_start_main)/60);
    sec = floor((t_finish_main-t_start_main)-(min*60));
    printf("total time elapsed: %d min %d s\n", min, sec);
 
    return 0;
}
