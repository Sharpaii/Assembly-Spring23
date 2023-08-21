;=========== Identification ===========
; Name: Madeline Sharpe
; Email: madeline.s.sharpe@gmail.com
; CWID: 885824037
; Course: CPSC240-07 Assignment 1
; Copyright (C) 2023 Madeline Sharpe

;=========== Declarations ===========
extern printf
extern scanf
global hypotenuse


segment .data
welcome db `\033[0;32mWelcome to Pythagoras’ Math Lab programmed by Madeline Sharpe`,10,0
welcome2 db "Please contact me at madeline_sharpe@csu.fullerton.edu if you need assistance.", 10, 0

prompt1 db `Enter the length of the first side of the triangle: \033[0m`, 0
prompt2 db `\033[0;32mEnter the length of the second side of the triangle: \033[0m`, 0
prompt3 db `\033[0;32mThank you. You entered two sides: %lf and %lf`, 10, 0
prompt4 db "The length of the hypotenuse is %lf", 10, 0
prompt5 db `\033[0;32mNegative values not allowed. Try again: \033[0m`, 0

one_float_format db "%lf",0
two_float_format db "%lf, %lf", 10, 0
three_float_format db "%lf %lf %lf", 0

zero_float dq 0.0



segment .bss

segment .text

hypotenuse:
;=========== Backup Registers ===========
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

;=========== Console Output ===========
push qword 0
mov rax, 0
mov rdi, welcome
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, welcome2
call printf
pop rax

;=========== Input Length1 ===========
push qword 0
mov rax, 0
mov rdi, prompt1
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm15, [rsp]
pop rax

;=========== Length1 Loop ===========
loop1:
movsd xmm4, qword [zero_float]
ucomisd xmm15, xmm4
jb isNeg1
jmp continue1

isNeg1:
push qword 0
mov rax, 0
mov rdi, prompt5
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm15, [rsp]
pop rax

jmp loop1
continue1:

;=========== Input Length2 ===========
push qword 0
mov rax, 0
mov rdi, prompt2
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm14, [rsp]
pop rax

;=========== Length2 Loop ===========
loop2:
movsd xmm4, qword [zero_float]
ucomisd xmm14, xmm4
jb isNeg2
jmp continue2

isNeg2:
push qword 0
mov rax, 0
mov rdi, prompt5
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm14, [rsp]
pop rax

jmp loop2
continue2:

;=========== Return Input ===========
push qword 0
mov rax, 2
mov rdi, prompt3
movsd xmm0, xmm15
movsd xmm1, xmm14
call printf
pop rax

;=========== Calculate Hypotenuse ===========
; a^2 + b^2 = c^2
; c = sqrt(a^2 + b^2)
movsd xmm13, xmm15                                          ;preserve length 1
movsd xmm12, xmm14                                          ;preserve length 2
mulsd xmm13, xmm13                                          ; a^2
mulsd xmm12, xmm12                                          ; b^2
movsd xmm11, xmm13                                          ;preserve a^2
addsd xmm11, xmm12                                          ;a^2 + b^2
sqrtsd xmm10, xmm11                                         ;sqrt

;=========== Return a^2 and b^2 [TEST] ===========
;push qword 0
;mov rax, 2
;mov rdi, two_float_format
;movsd xmm0, xmm13
;movsd xmm1, xmm12
;call printf
;pop rax

;=========== Return a^2 + b^2 [TEST] ===========
;push qword 0
;mov rax, 1
;mov rdi, one_float_format
;movsd xmm0, xmm11
;call printf
;pop rax

;=========== Return Hypotenuse ===========
push qword 0
mov rax, 1
mov rdi, prompt4
movsd xmm0, xmm10
call printf
pop rax

pop rax

movsd xmm0, xmm10                                           ;Send to main function

;===== Restore R Registers ===================================================================
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