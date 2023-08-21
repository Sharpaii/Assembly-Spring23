//******************************************************************************************************************************
//* Program name: "Hypotenuse".  This program takes in the two lengts of a triangle using user input and returns the           *
//* hypotenuse. Copyright (C) 2023 Madeline Sharpe                                                                             *
//* Thank you Johnson Tong for your help and guidance!                                                                         * 
//******************************************************************************************************************************

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern double hypotenuse();

int main(int argc, char* argv[])
{
  double h = 0.0;
  h = hypotenuse();
  printf("\033[0;33m The main file received this number: %.12lf, and will keep it for now. We hoped you enjoyed your right angles. Have a good day. A zero will be sent to youroperating system.\n", h);
  return 0;
}