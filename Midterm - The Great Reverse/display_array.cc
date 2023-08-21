//=========== Identification ===========
// Name: Madeline Sharpe
// Email: madeline.s.sharpe@gmail.com
// CWID: 885824037
// Course: CPSC240-07 (Midterm)
// Date: Mar 22, 2023
// Copyright (C) 2023 Madeline Sharpe
//======================================

#include <iostream>

extern "C" void display_array(double arr[], int arr_size);

void display_array(double arr[], int arr_size) {
  for (int i = 0; i < arr_size; i++)
  {
    printf("%.01lf\n", arr[i]);
  }
  printf("\n");
}