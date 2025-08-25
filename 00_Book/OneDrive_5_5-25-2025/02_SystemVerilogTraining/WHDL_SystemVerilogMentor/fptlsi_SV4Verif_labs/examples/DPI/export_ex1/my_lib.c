#include "dpi_types.h"

int my_C_task() {
  int num;
  printf("Starting C task\n");
  init_rand();
  num = SVrand();
  printf ("Got %d from SV\n",num);
  return 0;
}

