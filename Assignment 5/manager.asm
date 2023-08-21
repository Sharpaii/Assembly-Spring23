;=========== Identification ===========
; Name: Madeline Sharpe
; Email: madeline.s.sharpe@gmail.com
; CWID: 885824037
; Course: CPSC240-07 (Assignment 5)
; Copyright (C) 2023 Madeline Sharpe

;=========== Information ===========
; This program is free software, you can redistribute it and or modify it
; under the terms of the GNU General Public License version 3
; A copy of the GNU General Public License version 3 is available here: https://www.gnu.org/licenses/

; Program name: Data Validation (Baseline)
; Files in program: manager.asm, main.c, r.sh
; System requirements: Linux on an x86 machine
; Programming languages: x86 Assembly, C++ and BASH
; Date program development began: Apr 27, 2023
; Date finished: May 1, 2023
; Status: Finished

; Purpose: Program gets user input of angle and term, gets sin(angle) term times, outputs tics taken to perform function

; File name: manager.asm
; Language: x86 Assembly
; No data passed to this module. Module passes string back to C++.

; Translation information
; Compile this file: nasm -f elf64 -l manager.lis -o manager.o manager.asm
; Link with other files: g++ -m64 -no-pie -o final-main.out manager.o main.o -std=c++11
;***********************************************************************************************

;=========== Declarations ===========
extern printf
extern scanf
extern stdin
extern fgets
extern strlen
extern sin

INPUT_LEN equ 256

global manager

segment .data
    str_format: db "%s", 0              ; Format indicating a null-terminated string, c-string
    one_int_format db "%d", 0           ; Format indicating int
    one_float_format db "%lf",0         ; Format indicating float
    space: db " ", 0                    ; Space character
    new_line: db "", 10, 0              ; New Line

    intro:          db "This program Sine Function Benchmark is maintained by Madeline Sharpe", 10, 0
    msg_name:       db "Please enter your name: ", 0
    welcome:        db "It is nice to meet you ", 0
    msg_angle:      db ". Please enter an angle number in degrees: ", 0
    msg_terms:      db "Thank you. Please enter the number of terms in a Taylor series to be computed: ", 0
    msg_compute:    db "Thank you. The Taylor series will be used to compute the sine of your angle." 10, 0
    msg_completed:  db "The computation completed in %llu tics and the computed value is %lf", 10, 0

segment .bss
    name: resb INPUT_LEN        ;Reserve 256 bytes for name given by user
    iteration: resq 1000

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

;=========== Print to Console "This program Sine Function Benchmark is maintained by Madeline Sharpe" ===========  
    mov rax, 0                  
    mov rdi, str_format             
    mov rsi, intro         
    call printf   

;=========== Print to Console "Please enter your name:" ===========  
    mov rax, 0                  
    mov rdi, str_format             
    mov rsi, msg_name         
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

;=========== Print to Console "It is nice to meet you [name]" ===========  
    mov rax, 0                  
    mov rdi, str_format             
    mov rsi, welcome         
    call printf  

    mov rax, 0
    mov rdi, str_format
    mov rsi, name
    call printf

;=========== Print to Console ". Please enter an angle number in degrees: " ===========  
    mov rax, 0
    mov rdi, str_format
    mov rsi, msg_angle
    call printf

;=========== Gets user input for angle, stores in xmm15 ===========
    push qword 0
    push qword 0
    mov rax, 0
    mov rdi, one_float_format
    mov rsi, rsp
    call scanf
    movsd xmm15, [rsp]              ; Stores angle in xmm15
    pop rax
    pop rax

;=========== Print to Console "Thank you. Please enter the number of terms in a Taylor series to be computed: " ===========  
    mov rax, 0
    mov rdi, str_format
    mov rsi, msg_terms
    call printf

;=========== Gets user input for terms (n), stores in r15 ===========
    push qword 0
    push qword 0
    mov rax, 0
    mov rdi, one_int_format
    mov rsi, rsp
    call scanf
    mov r15, [rsp]              ; Stores terms in r15
    pop rax
    pop rax

;=========== Print to Console "Thank you. The Taylor series will be used to compute the sine of your angle." ===========  
    mov rax, 0
    mov rdi, str_format
    mov rsi, msg_compute
    call printf

;=========== Get time and copy to r14 =========== 
    xor rax, rax
    xor rdx, rdx
    cpuid
    rdtsc
    shl rax, 32
    add rdx, rax
    mov r14, rdx   

;=========== Convert to Degrees =========== 
    mov r12, 180
    cvtsi2sd xmm9, r12
    divsd xmm15, xmm9                   ; mul angle by 180

    mov rax, 0x400921FB54442D18         ; pi
    push rax
    movsd xmm0, [rsp]                   ; set xmm0 to pi
    pop rax

    mulsd xmm15, xmm0

;=========== Taylor Series =========== 

    mov r12, 0
    beginLoop:
        cmp r12, r15
        je exitLoop
        
        push qword 0
        mov rax, 1
        movsd xmm0, xmm15
        call sin
        movsd xmm8, xmm0

        pop rax
        
        inc r12
        jmp beginLoop
    exitLoop
    
        
;=========== Get time and copy to r13 ===========
    xor rax, rax
    xor rdx, rdx
    cpuid
    rdtsc
    shl rax, 32
    add rdx, rax
    mov r13, rdx

;=========== Subtract r14 from r13, store in r13  =========== 
    sub r13, r14

;=========== Print to Console "The computation completed in <elapsed_time> tics and the computed value is <sin(angle)>" ===========  
    push qword 0
    push qword 0
    mov rax, 2
    mov rdi, msg_completed
    mov rsi, r13
    movsd xmm0, xmm8          
    call printf
    pop rax
    pop rax

    mov rax, r13

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