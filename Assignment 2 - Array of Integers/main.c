#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern double manager();

int main(int argc, char* argv[])
{
  printf("Welcome to Arrays of Integers\n");
  printf("Brougt to you by Madeline Sharpe\n");
  double answer = manager();
  printf("The main has received this number %.10lf and will keep it.\n", answer);
  printf("Main will return 0 to the operating system. Bye.\n");
}