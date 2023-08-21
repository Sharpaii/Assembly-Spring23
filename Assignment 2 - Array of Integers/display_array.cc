#include <iostream>

extern "C" void display_array(double arr[], int arr_size);

void display_array(double arr[], int arr_size) {
  printf("\n");
  for (int i = 0; i < arr_size; i++)
  {
    printf("%.05lf   ", arr[i]);
  }
  printf("\n");
}