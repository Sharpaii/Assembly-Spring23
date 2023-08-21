//;=========== Identification ===========
//; Name: Madeline Sharpe
//; Email: madeline.s.sharpe@gmail.com
//; CWID: 885824037
//; Course: CPSC240-07 (Assignment 4)
//; Date: Apr 15, 2023
//; Copyright (C) 2023 Madeline Sharpe

//;=========== Information ===========
//; This program is free software, you can redistribute it and or modify it
//; under the terms of the GNU General Public License version 3
//; A copy of the GNU General Public License version 3 is available here: https://www.gnu.org/licenses/

//; Program name: Benchmark
//; Files in program: manager.asm, getradicand.asm, get_clock_freq.asm, main.c, r.sh
//; System requirements: Linux on an x86 machine
//; Programming languages: x86 Assembly, C++ and BASH
//; Date program development began: Apr 12, 2023
//; Date finished: Apr 15, 2023
//; Status: Finished

//; Purpose: Runs manager.asm in a c file

//; File name: main.c
//; Language: x86 Assembly
//; No data passed to this module. Module passes string back to C++.

//; Translation information
//; Compile this file: gcc -c -Wall -m64 -no-pie -o main.o  main.c -std=c11
//; Link with other files: g++ -m64 -no-pie -o final-main.out manager.o main.o getradicand.o get_clock_freq.o -std=c++11
//;***********************************************************************************************

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern double manager();

int main(int argc, char* argv[])
{
  double ns = manager();
  printf("The main function has received this number %lf and will keep it for future reference.\n", ns);
  printf("The main function will return a zero to the operating system.");
}