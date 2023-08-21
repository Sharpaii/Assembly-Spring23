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

; Purpose: Get max speed of computers

; File name: get_clock_freq.asm
; Language: x86 Assembly
; No data passed to this module. Module passes string back to C++.

; Translation information
; Compile this file: nasm -f elf64 -l get_clock_freq.lis -o get_clock_freq.o get_clock_freq.asm
; Link with other files: g++ -m64 -no-pie -o final-main.out manager.o main.o getradicand.o get_clock_freq.o -std=c++11
;***********************************************************************************************

;=========== Declarations ===========

global get_clock_freq

segment .data

segment .bss
    clock_speed resq 100

segment .text

get_clock_freq:
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

;=========== Get Max Clock Speed =========== 
    mov r15, 0x16000002
    mov rax, r15
    cpuid

    mov [clock_speed], rax
    mov [clock_speed +4], rbx
    mov [clock_speed +8], rcx
    mov [clock_speed +12], rdx

    mov rax, [clock_speed]

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