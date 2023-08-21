#!/bin/bash

#Program: Hypotenus
#Author: Madeline Sharpe
#Copyright (C) 2023 Madeline Sharpe

#Thank you Johnson Tong for your help and guidance in the program

#Clear any previously compiled outputs
rm *.o
rm *.out

echo "Assemble perimeter.asm"
nasm -f elf64 -l hypotenuse.lis -o hypotenuse.o hypotenuse.asm

echo "compile rectangle.c using gcc compiler standard 2011"
gcc -c -Wall -m64 -no-pie -o triangle.o triangle.c -std=c11

echo "Link object files using the gcc Linker standard 2011"
gcc -m64 -no-pie -o final-hypotenuse.out hypotenuse.o triangle.o -std=c11

echo "Run the Rectange Program:"
./final-hypotenuse.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "Script file terminated."