#!/bin/bash

#Name: Madeline Sharpe
#Email: madeline.s.sharpe@gmail.com
#CWID: 885824037
#Course: CPSC240-07 (Midterm)
#Date: Mar 22, 2023
#Copyright (C) 2023 Madeline Sharpe

#Clear any previously compiled outputs
rm *.o
rm *.out
rm *.lis

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Compile input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Compile reverse.asm"
nasm -f elf64 -l reverse.lis -o reverse.o reverse.asm

echo "Compile display_array.c using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++11 -o display_array.o display_array.cc

echo "compile main.c using gcc compiler standard 2017"
gcc -c -Wall -m64 -no-pie -o main.o  main.c -std=c11

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o final-main.out manager.o input_array.o main.o reverse.o display_array.o -std=c++11

echo "Run the Main Program:"
./final-main.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "Script file terminated."