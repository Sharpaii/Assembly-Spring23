/*;=========== Identification ===========
; Name: Madeline Sharpe
; Email: madeline_sharpe@csu.fullerton.edu
; CWID: 885824037
; Course: CPSC240-07 (Assignment 3)
; Copyright (C) 2023 Madeline Sharpe

;=========== Information ===========
; This program is free software, you can redistribute it and or modify it
; under the terms of the GNU General Public License version 3
; A copy of the GNU General Public License version 3 is available here: https://www.gnu.org/licenses/

; Program name: Non-deterministic Random Numbers
; Files in program: executive.asm, fill_random_array.asm, isnan.asm, show_array.asm, quick_sort.c, main.c, r.sh
; System requirements: Linux on an x86 machine
; Programming languages: x86 Assembly, C++ and BASH
; Date program development began: Mar 10, 2023
; Date finished: Mar 12, 2023
; Status: Finished

; Purpose: This program uses executive.asm in c to run

; File name: main.c
; Language: x86 Assembly
; No data passed to this module. Module passes string back to C++.

; Translation information
; Compile this file: gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11
; Link with other files: gcc -m64 -no-pie -o final-main.out executive.o fill_random_array.o main.o isnan.o show_array.o quick_sort.o -std=c11
; ./final-main.out is the executable
;***********************************************************************************************/
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern char* executive();

int main(int argc, char* argv[])
{
  printf("Welcome to Random Products, LLC\n");
  printf("This software is maintained by Madeline Sharpe\n");
  const char* name = executive();
  printf("\nOh, %s. We hope you enjoyed your arrays. Do come again.\n", name);
  printf("A zero will be returned to the operating system.\n");
}