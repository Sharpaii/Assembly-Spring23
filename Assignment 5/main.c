//;=========== Identification ===========
//; Name: Madeline Sharpe
//; Email: madeline.s.sharpe@gmail.com
//; CWID: 885824037
//; Course: CPSC240-07 (Assignment 5)
//; Copyright (C) 2023 Madeline Sharpe

//;=========== Information ===========
//; This program is free software, you can redistribute it and or modify it
//; under the terms of the GNU General Public License version 3
//; A copy of the GNU General Public License version 3 is available here: https://www.gnu.org/licenses/

//; Program name: Data Validation (Baseline)
//; Files in program: manager.asm, main.c, r.sh
//; System requirements: Linux on an x86 machine
//; Programming languages: x86 Assembly, C++ and BASH
//; Date program development began: Apr 27, 2023
//; Date finished: May 1, 2023
//; Status: Finished

//; Purpose: Runs asm program using C++

//; File name: manager.asm
//; Language: x86 Assembly
//; No data passed to this module. Module passes string back to C++.

//; Translation information
//; Compile this file: gcc -c -Wall -m64 -no-pie -o main.o  main.c -std=c11
//; Link with other files: g++ -m64 -no-pie -o final-main.out manager.o main.o -std=c++11
//;***********************************************************************************************

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern unsigned long long int manager();

int main(int argc, char* argv[])
{
    unsigned long long int num = manager();
    printf("Thank you for using this program. Have a great day.\n");
    printf("The driver program received this number %llu. A zero will be returned to the OS. Bye.\n", num);
}