;=========== Identification ===========
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

; Purpose: This program generates random numbers for the user.

; File name: executive.asm
; Language: x86 Assembly
; No data passed to this module. Module passes string back to C++.

; Translation information
; Compile this file: nasm -f elf64 -l executive.lis -o executive.o executive.asm
; Link with other files: gcc -m64 -no-pie -o final-main.out executive.o fill_random_array.o main.o isnan.o show_array.o quick_sort.o -std=c11
; ./final-main.out is the executable
;***********************************************************************************************


;=========== Declarations ===========
extern printf
extern scanf
extern fgets
extern stdin
extern strlen
extern qsort

extern fill_random_array
extern show_array
extern quick_sort

INPUT_LEN equ 256           ;Max bytes of name, title, response
LARGE_BOUNDARY equ 64
SMALL_BOUNDARY equ 16

global executive

segment .data
    align SMALL_BOUNDARY        ;Align next data items on 16-byte boundary, every data item will be separated by 16 bytes

    format: db "%s", 0           ;Format indicating a null-terminated string, c-string
    one_int_format db "%d", 0 ;Format indicating float

    ask_name: db "Please enter your name: ", 0
    ask_title: db "Please enter your title (Mr,Ms,Sargent,Chief,Project Leader,etc): ", 0
    welcome1: db "Nice to meet you ", 0
    space: db " ", 0 ; space character
    welcome2: db `\nThis program will generate 64-bit IEEE float numbers.`, 10, 0
    prompt1: db "How many numbers do you want. Today’s limit is 100 per customer. ", 0
    prompt2: db "Your numbers have been stored in an array. Here is that array.", 10, 10, 0
    header_row: db "IEEE754            Scientific Decimal", 10, 0
    prompt3: db `\nThe array is now being sorted.`, 10, 10, 0
    prompt4: db "Here is the updated array.", 10, 10, 0

    exit1: db `\nGood bye `, 0
    exit2: db ", you are welcome any time.", 10, 0

    align LARGE_BOUNDARY    

segment .bss
    title: resb INPUT_LEN       ;Reserve 256 bytes for title given by user
    name: resb INPUT_LEN        ;Reserve 256 bytes for name given by user
    myArray: resq 100

segment .text

executive:
;=========== Backup Registers ===========
    push rbp        ;Push memory address of base of previous stack frame onto stack top
    mov rbp, rsp    ;Copy value of stack pointer into base pointer
    push rdi        ;Backup rdi
    push rsi        ;Backup rsi
    push rdx        ;Backup rdx
    push rcx        ;Backup rcx
    push r8         ;Backup r8
    push r9         ;Backup r9
    push r10        ;Backup r10
    push r11        ;Backup r11
    push r12        ;Backup r12
    push r13        ;Backup r13
    push r14        ;Backup r14
    push r15        ;Backup r15
    push rbx        ;Backup rbx
    pushf           ;Backup rflags

;=========== Print to Console "Please enter your name:" ===========  
    mov rax, 0                  
    mov rdi, format             
    mov rsi, ask_name           
    call printf                 

;=========== Gets user input and puts into name ===========      
    mov rax, 0                  
    mov rdi, name               
    mov rsi, INPUT_LEN          
    mov rdx, [stdin]            
    call fgets                  
    
    mov rax, 0                  
    mov rdi, name               
    call strlen                 
  
    sub rax, 1                  ;Length is stored in rax
    mov byte [name + rax], 0    ;Replace the byte where '\n' exits with '\0'

;=========== Print to Console "Please enter your title (Mr,Ms,Sargent,Chief,Project Leader,etc):" ===========  
    mov rax, 0
    mov rdi, format
    mov rsi, ask_title
    call printf

;=========== Gets user input and puts into title ===========
    mov rax, 0
    mov rdi, title
    mov rsi, INPUT_LEN 
    mov rdx, [stdin]
    call fgets

    mov rax, 0
    mov rdi, title
    call strlen
    sub rax, 1
    mov byte [title + rax], 0

;=========== Print to Console "Nice to meet you [title] [name]" ===========
    mov rax, 0
    mov rdi, format
    mov rsi, welcome1
    call printf

    mov rax, 0
    mov rdi, format
    mov rsi, title
    call printf

    mov rax, 0 
    mov rdi, format
    mov rsi, space
    call printf

    mov rax, 0
    mov rdi, format
    mov rsi, name 
    call printf 

;=========== Print to Console "This program will generate 64-bit IEEE float numbers." ===========  
    mov rax, 0
    mov rdi, format
    mov rsi, welcome2
    call printf

;=========== Print to Console "How many numbers do you want. Today’s limit is 100 per customer." ===========  
    mov rax, 0
    mov rdi, format
    mov rsi, prompt1
    call printf

;=========== Gets user input and puts into array_size ===========
    push qword 0
    push qword 0
    mov rax, 0
    mov rdi, one_int_format
    mov rsi, rsp
    call scanf
    mov r14, [rsp]
    pop rax
    pop rax

;=========== Input how many cells in array length r14 ===========
    push qword 0
    mov rax, 0
    mov rdi, myArray
    mov rsi, r14
    call fill_random_array
    mov r15, rax
    pop rax

;=========== Print to Console "Your numbers have been stored in an array. Here is that array." ===========  
    mov rax, 0
    mov rdi, format
    mov rsi, prompt2
    call printf

;=========== Print to Console Table's Header Row ===========  
    mov rax, 0
    mov rdi, format
    mov rsi, header_row
    call printf

;=========== Display cells in array length r14 ===========

    push qword 0
    mov rax, 0
    mov rdi, myArray
    mov rsi, r14
    call show_array
    pop rax

;=========== Print to Console "The array is now being sorted." ===========  
    mov rax, 0
    mov rdi, format
    mov rsi, prompt3
    call printf

;=========== Use quick_sort.c to sort the array ===========  
    mov rdi, myArray
    mov rsi, r14 
    mov rdx, 8
    mov rcx, quick_sort
    call qsort

;=========== Print to Console "Here is the updated array." =========== 
    mov rax, 0
    mov rdi, format
    mov rsi, prompt4
    call printf

;=========== Print to Console Table's Header Row ===========  
    mov rax, 0
    mov rdi, format
    mov rsi, header_row
    call printf

;=========== Display cells in array length r14 ===========

    push qword 0
    mov rax, 0
    mov rdi, myArray
    mov rsi, r14
    call show_array
    pop rax


;=========== Print to Console "Good bye [title].  You are welcome any time." ===========    

    mov rax, 0
    mov rdi, format
    mov rsi, exit1
    call printf

    mov rax, 0
    mov rdi, format
    mov rsi, title
    call printf

    mov rax, 0
    mov rdi, format
    mov rsi, exit2
    call printf

;=========== Return name for main.cpp to use ===========    
    mov rax, name

;=========== Restore R Registers ===========
  popf          ;Restore rflags
  pop rbx       ;Restore rbx
  pop r15       ;Restore r15
  pop r14       ;Restore r14
  pop r13       ;Restore r13
  pop r12       ;Restore r12
  pop r11       ;Restore r11
  pop r10       ;Restore r10
  pop r9        ;Restore r9
  pop r8        ;Restore r8
  pop rcx       ;Restore rcx
  pop rdx       ;Restore rdx
  pop rsi       ;Restore rsi
  pop rdi       ;Restore rdi


  pop rbp       ;Restore rbp

  ret