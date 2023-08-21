;=========== Identification ===========
; Name: Madeline Sharpe
; Email: madeline.s.sharpe@gmail.com
; CWID: 885824037
; Course: CPSC240-07 Assignment 1
; Copyright (C) 2023 Madeline Sharpe

;=========== Declarations ===========
extern printf
extern scanf
global magnitude

segment .data
prompt1 db "This program will manage your arrays of 64-bit floats",10, 0

float_format db "%lf", 0

segment .bss

segment .text

magnitude:

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

push qword 0

mov r15, rdi                                                ;Hold param for array
mov r14, rsi                                                ;Hold param for array size

mov rax, 2
mov rdx, 0
cvtsi2sd xmm15, rdx
cvtsi2sd xmm14, rdx

mov r13, 0
beginLoop:
    cmp r13, r14
    je endLoop
    movsd xmm15, [r15 + 8*r13]
    mulsd xmm15, xmm15
    addsd xmm14, xmm15
    inc r13
    jmp beginLoop
endLoop:

sqrtsd xmm15, xmm14

pop rax
movsd xmm0, xmm15


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

