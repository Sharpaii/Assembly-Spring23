;=========== Identification ===========
; Name: Madeline Sharpe
; Email: madeline.s.sharpe@gmail.com
; CWID: 885824037
; Course: CPSC240-07 Assignment 1
; Copyright (C) 2023 Madeline Sharpe

;=========== Declarations ===========
extern printf
extern scanf
global append

segment .data

segment .bss

segment .text

append:
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

mov r15, rdi                                                ;Hold param for array A
mov r14, rsi                                                ;Hold param for array A size
mov r13, rdx                                                ;Hold param for result_array
mov r12, rcx                                                ;Hold param for array B size
mov r11, r8                                                 ;Hold param for result array

mov r10, 0
beginLoop:
    cmp r10, r14
    je endLoop 
    movsd xmm15, [r15 + 8*r10]
    movsd [r13 + 8*r10], xmm15
    inc r10
    jmp beginLoop
endLoop:

mov r9, 0
beginLoop2:
    cmp r9, r11
    je endLoop2
    movsd xmm15, [r12 + 8 * r9]
    movsd [r13 + 8 * r10], xmm15
    inc r9
    inc r10
    jmp beginLoop2
endLoop2:

pop rax
mov rax, r10


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

