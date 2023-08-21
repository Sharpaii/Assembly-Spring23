#!/bin/bash

#Program: Hypotenus
#Author: Madeline Sharpe
#Copyright (C) 2023 Madeline Sharpe

#Thank you Johnson Tong for your help and guidance in the program

#Clear any previously compiled outputs
rm *.o
rm *.out
rm *.lis

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Compile input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Compile magnitude.asm"
nasm -f elf64 -l magnitude.lis -o magnitude.o magnitude.asm

echo "Compile append.asm"
nasm -f elf64 -l append.lis -o append.o append.asm

echo "Compile display_array.c using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o display_array.o display_array.cc

echo "compile main.c using gcc compiler standard 2017"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c17

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o final-main.out manager.o input_array.o main.o append.o magnitude.o display_array.o -std=c++17

echo "Run the Main Program:"
./final-main.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "Script file terminated."