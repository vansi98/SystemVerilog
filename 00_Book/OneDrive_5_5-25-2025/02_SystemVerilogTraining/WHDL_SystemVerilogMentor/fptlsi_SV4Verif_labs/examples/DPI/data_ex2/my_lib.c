#include "dpi_types.h"

int doit( const int val)
{
  int result;
  Double(val,&result);
  printf ("Got value %d from Double\n",result);
  return 0;
}

