#!/bin/bash

#Program: Benchmark
#Author: Madeline Sharpe
#Copyright (C) 2023 Madeline Sharpe

#Clear any previously compiled outputs
rm *.o
rm *.out
rm *.lis

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Compile getradicand.asm"
nasm -f elf64 -l getradicand.lis -o getradicand.o getradicand.asm

echo "Compile get_clock_freq.asm"
nasm -f elf64 -l get_clock_freq.lis -o get_clock_freq.o get_clock_freq.asm

#echo "Compile get_clock_freq.c using the g++ compiler standard 2011"
#g++ -c -Wall -no-pie -m64 -std=c++11 -o get_clock_freq.o get_clock_freq.cc

echo "compile main.c using gcc compiler standard 2011"
gcc -c -Wall -m64 -no-pie -o main.o  main.c -std=c11

echo "Link object files using the gcc Linker standard 2011"
g++ -m64 -no-pie -o final-main.out manager.o main.o getradicand.o get_clock_freq.o -std=c++11

echo "Run the Main Program:"
./final-main.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "Script file terminated."