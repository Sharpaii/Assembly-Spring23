;=========== Identification ===========
; Name: Madeline Sharpe
; Email: madeline.s.sharpe@gmail.com
; CWID: 885824037
; Course: CPSC240-07 (Assignment 4)
; Date: Apr 15, 2023
; Copyright (C) 2023 Madeline Sharpe

;=========== Information ===========
; This program is free software, you can redistribute it and or modify it
; under the terms of the GNU General Public License version 3
; A copy of the GNU General Public License version 3 is available here: https://www.gnu.org/licenses/

; Program name: Benchmark
; Files in program: manager.asm, getradicand.asm, get_clock_freq.asm, main.c, r.sh
; System requirements: Linux on an x86 machine
; Programming languages: x86 Assembly, C++ and BASH
; Date program development began: Apr 12, 2023
; Date finished: Apr 15, 2023
; Status: Finished

; Purpose: This program checks how many tics it takes to get the square root of a number x amount of times as well as the tics per one completions

; File name: manager.asm
; Language: x86 Assembly
; No data passed to this module. Module passes string back to C++.

; Translation information
; Compile this file: nasm -f elf64 -l manager.lis -o manager.o manager.asm
; Link with other files: g++ -m64 -no-pie -o final-main.out manager.o main.o getradicand.o get_clock_freq.o -std=c++11
;***********************************************************************************************

;=========== Declarations ===========
extern printf
extern scanf

extern getradicand
extern get_clock_freq

global manager

segment .data
    str_format: db "%s", 0              ;Format indicating a null-terminated string, c-string
    one_int_format db "%d", 0           ;Format indicating int
    one_float_format db "%lf",0         ;Format indicating float
    space: db " ", 0                    ;Space character

    welcome1:       db "Welcome to Square Root Benchmarks by Madeline Sharpe", 10, 10, 0
    welcome2:       db "For customer service contact me at madeline_sharpe@csu.fullerton.edu", 10, 10, 0
    msg_cpu:        db "Your CPU is %s", 10, 10, 0
    msg_maxClock:   db "Your max clock speed is %d MHz", 10, 10, 0
    msg_root:       db "The square root of %lf is %lf", 10, 10, 0
    prompt1:        db "Next enter the number of times iteration should be performed: ", 0
    msg_time:       db "The time on the clock is %llu tics", 10, 10, 0
    msg_progress:   db "The bench mark of the sqrtsd instruction is in progress.", 10, 10, 0
    msg_complete:   db "The time on the clock is %llu tics and the benchmark is completed.",10, 10, 0
    msg_elap_time:  db "The elapsed time was %llu tics", 10, 10, 0
    msg_root_time:  db "The time for one square root computation is %lf tics which equals %lf ns.", 10, 0

segment .bss
    cpu_name resb 100
    clock_speed resq 100
    iterations resq 10000000

segment .text

manager:
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

;=========== Print to Console "Welcome to Square Root Benchmarks by Madeline Sharpe" ===========  
    mov rax, 0                  
    mov rdi, str_format             
    mov rsi, welcome1          
    call printf   

;=========== Print to Console "For customer service contact me at madeline_sharpe@csu.fullerton.edu" ===========  
    mov rax, 0                  
    mov rdi, str_format             
    mov rsi, welcome2          
    call printf 

;=========== Get CPU Name ===========  
    mov r15, 0x80000002
    mov rax, r15
    cpuid

    mov [cpu_name], rax         ;gets first 4 char
    mov [cpu_name +4], rbx
    mov [cpu_name +8], rcx
    mov [cpu_name +12], rdx

    mov r15, 0x80000003
    mov rax, r15
    cpuid

    mov [cpu_name +16], rax
    mov [cpu_name +20], rbx
    mov [cpu_name +24], rcx
    mov [cpu_name +28], rdx

    mov r15, 0x80000004
    mov rax, r15
    cpuid

    mov [cpu_name +32], rax
    mov [cpu_name +36], rbx
    mov [cpu_name +40], rcx
    mov [cpu_name +44], rdx

;=========== Print to Console "Your CPU is <cpu_name>" ===========  
    push qword 0
    push qword 0
    mov rax, 1
    mov rdi, msg_cpu
    mov rsi, cpu_name
    call printf
    pop rax
    pop rax

;=========== Get Max Clock Speed ===========
    call get_clock_freq

;=========== Print to Console "Your max clock speed is <msg_maxClock> MHz" ===========  
    push qword 0
    push qword 0
    mov rax, 1
    mov rdi, msg_maxClock
    mov rsi, clock_speed
    call printf
    pop rax
    pop rax

;=========== Call getradicand =========== 
    push qword 0
    push qword 0
    mov rax, 0
    call getradicand
    movsd xmm15, xmm0           ;store radicand in xmm15
    pop rax
    pop rax

;=========== Square Root <radicand> ===========
    sqrtsd xmm14, xmm15

;=========== Print to Console "The square root of <xmm15> is <xmm14>" =========== 
    push qword 0
    push qword 0
    mov rax, 2
    mov rdi, msg_root
    movsd xmm0, xmm15
    movsd xmm1, xmm14              
    call printf
    pop rax
    pop rax

;=========== Print to Console "Next enter the number of times iteration should be performed:" ===========  
    mov rax, 0                  
    mov rdi, str_format             
    mov rsi, prompt1          
    call printf  

;=========== Get user input for iteration ===========
    push qword 0
    push qword 0
    mov rax, 0
    mov rdi, one_float_format
    mov rsi, rsp
    call scanf
    mov r14, [rsp]
    mov [iterations], r14
    pop rax
    pop rax

;=========== Get time and copy to r14 ===========  
    xor rax, rax
    xor rdx, rdx
    cpuid
    rdtsc
    shl rax, 32
    add rdx, rax
    mov r14, rdx                

;=========== Print to Console "The time on the clock is <r14> tics =========== 
    push qword 0
    push qword 0
    mov rax, 1
    mov rdi, msg_time
    mov rsi, r14                
    call printf
    pop rax
    pop rax

;=========== Print to Console "The bench mark of the sqrtsd instruction is in progress." ===========  
    mov rax, 0                  
    mov rdi, str_format             
    mov rsi, msg_progress          
    call printf 

;=========== Loop sqrtsd ===========
    mov r12, 0
    beginLoop:
        cmp r12, iterations
        je exitLoop

        sqrtsd xmm14, xmm15

        inc r12
        jmp beginLoop
    exitLoop:

;=========== Get time and copy to r13 ===========
    xor rax, rax
    xor rdx, rdx
    cpuid
    rdtsc
    shl rax, 32
    add rdx, rax
    mov r13, rdx

;=========== Print to Console "The time on the clock is <r13> tics and the benchmark is completed" ===========
    push qword 0
    push qword 0
    mov rax, 1
    mov rdi, msg_complete
    mov rsi, r13                
    call printf
    pop rax
    pop rax

;=========== Subtract r13 from r14 for elapsed time ===========
    sub r13, r14

;=========== Print to Console "The elapsed time was <r14> tics" ===========
    push qword 0
    push qword 0
    mov rax, 1
    mov rdi, msg_elap_time
    mov rsi, r13               
    call printf
    pop rax
    pop rax

;=========== Divide elapsed time by iterations ===========
    cvtsi2sd xmm15, r14
    mov rax, iterations
    cvtsi2sd xmm14, rax
    divsd xmm15, xmm14

;=========== Convert Tics to Ns ===========
    mov rax, 100
    cvtsi2sd xmm13, rax
    mulsd xmm15, xmm13

;=========== Print to Console "The time for one square root computation is <one compute> tics which equals <> ns." ===========
    push qword 0
    push qword 0
    mov rax, 2
    mov rdi, msg_root_time
    movsd xmm0, xmm15
    movsd xmm1, xmm14             
    call printf
    pop rax
    pop rax

;=========== Push <one compute> in ns to main.c
    movsd xmm0, xmm14


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