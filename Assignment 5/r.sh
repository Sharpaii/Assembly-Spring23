#!/bin/bash

#Program: Data Validation (Baseline)
#Author: Madeline Sharpe
#Copyright (C) 2023 Madeline Sharpe

#Clear any previously compiled outputs
rm *.o
rm *.out
rm *.lis

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "compile main.c using gcc compiler standard 2011"
gcc -c -Wall -m64 -no-pie -o main.o  main.c -std=c11

echo "Link object files using the gcc Linker standard 2011"
g++ -m64 -no-pie -o final-main.out manager.o main.o -std=c++11

echo "Run the Main Program:"
./final-main.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "Script file terminated."