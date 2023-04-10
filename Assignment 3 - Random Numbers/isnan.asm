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

; Purpose: This program checks if a number is nan

; File name: is_nan.asm
; Language: x86 Assembly
; No data passed to this module. Module passes string back to C++.

; Translation information
; Compile this file: nasm -f elf64 -l isnan.lis -o isnan.o isnan.asm
; Link with other files: gcc -m64 -no-pie -o final-main.out executive.o fill_random_array.o main.o isnan.o show_array.o quick_sort.o -std=c11
; ./final-main.out is the executable
;***********************************************************************************************

;=========== Declarations ===========
global isnan

segment .data

float_format db "%lf", 0

segment .bss

segment .text

isnan:

;Prolog ===== Insurance for any caller of this assembly module ========================================================
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

mov r15, rdi                                                ;r12 is the number to check
shl r15, 1                                                  
shr r15, 53                                                 ;now the 11 bits are far right

cmp r15, 2047

je nan
mov rax, 0
jmp done
nan:
mov rax, 1
done:


;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret

