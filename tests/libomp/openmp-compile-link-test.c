#include <omp.h>
#include <stdio.h>

int main(int argc, char **argv) {
  int nthreads = omp_get_num_threads();
  printf("Num Threads: %d\n", nthreads);
  return 0;
}
