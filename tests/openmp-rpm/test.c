int main(int argc, char **argv) {
  int res = 1;
#pragma omp parallel
#pragma omp single
  res = 0;
  return res;
}
