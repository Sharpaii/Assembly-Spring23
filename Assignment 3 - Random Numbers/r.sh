#!/bin/bash

#Program: Non-deterministic Random Numbers
#Author: Madeline Sharpe
#Copyright (C) 2023 Madeline Sharpe

#Clear any previously compiled outputs
rm *.o
rm *.out
rm *.lis

echo "Assemble executive.asm"
nasm -f elf64 -l executive.lis -o executive.o executive.asm

echo "Compile fill_random_array.asm"
nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm

echo "Compile isnan.asm"
nasm -f elf64 -l isnan.lis -o isnan.o isnan.asm

echo "Compile show_array.asm"
nasm -f elf64 -l show_array.lis -o show_array.o show_array.asm

echo "Compile quick_sort.c using the g++ compiler standard 2011"
gcc -c -Wall -m64 -no-pie -o quick_sort.o quick_sort.c -std=c11

echo "compile main.c using gcc compiler standard 2011"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11

echo "Link object files using the gcc Linker standard 2011"
gcc -m64 -no-pie -o final-main.out executive.o fill_random_array.o main.o isnan.o show_array.o quick_sort.o -std=c11


echo "Run the Main Program:"
./final-main.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "Script file terminated."
