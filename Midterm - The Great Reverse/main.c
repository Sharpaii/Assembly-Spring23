//=========== Identification ===========
// Name: Madeline Sharpe
// Email: madeline.s.sharpe@gmail.com
// CWID: 885824037
// Course: CPSC240-07 (Midterm)
// Date: Mar 22, 2023
// Copyright (C) 2023 Madeline Sharpe
//======================================

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern char* manager();

int main(int argc, char* argv[])
{
  printf("Welcome to the great reverse by Madeline Sharpe\n");
  const char* name = manager();
  printf("\nGood-bye %s\n", name);
  printf("Have a nice weekend.  Zero will be returned to the operating system.  Bye\n");
}