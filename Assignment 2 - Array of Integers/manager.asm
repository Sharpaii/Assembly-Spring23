;=========== Identification ===========
; Name: Madeline Sharpe
; Email: madeline.s.sharpe@gmail.com
; CWID: 885824037
; Course: CPSC240-07 Assignment 1
; Copyright (C) 2023 Madeline Sharpe

;=========== Declarations ===========
extern printf
extern scanf
extern stdin
extern clearerr
extern input_array
extern display_array
extern magnitude
extern append

global manager

segment .data

prompt1 db `This program will manage your arrays of 64-bit floats`,10, 0
prompt2 db `For array A enter a sequence of 64-bit floats seperated by white space.`, 10, 0
prompt3 db `For array B enter a sequence of 64-bit floats seperated by white space.`, 10, 0
prompt4 db `After the last input press enter followed by Control+D:`, 10, 0
prompt5 db `Arrays A and B have been appended and given the name A⊕ B.`, 10, 0

return_arrayA db `These number were received and placed into array A:`, 0
return_arrayB db `These number were received and placed into array B:`, 0
return_result_array db `A⊕ B contains: `, 0

return_magnitudeA db `The magnitude of array A is: %.10lf`,10, 0
return_magnitudeB db `The magnitude of array B is: %lf`,10, 0
return_magnitudeResult db `The magnitude of A⊕ B is: %lf`, 10, 0


one_float_format db "%lf",0

max equ 20

segment .bss
array_A resq max
array_B resq max
result_array resq max

segment .text

manager:
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

;This program will manage your arrays of 64-bit floats
push qword 0
mov rax, 0
mov rdi, prompt1
call printf
pop rax

;For array A enter a sequence of 64-bit floats separated by white space  
push qword 0
mov rax, 0
mov rdi, prompt2
call printf
pop rax

;After the last input press enter followed by Control+D 
push qword 0
mov rax, 0
mov rdi, prompt4
call printf
pop rax

;=========== Fill Array A Using input_array.asm ===========
push qword 0
mov rax, 0
mov rdi, array_A
mov rsi, max
call input_array
mov r15, rax
pop rax

;These number were received and placed into array A
push qword 0
mov rax, 0
mov rdi, return_arrayA
call printf
pop rax

;=========== Output Array A to User using display_array.cc ===========
push qword 0
mov rax, 0
mov rdi, array_A
mov rsi, r15
call display_array
pop rax

;=========== Set Failbit to 0 ===========
mov rax, 0
mov rdi, [stdin]
call clearerr

;=========== Compute Array A Magnitude Using magnitude.asm ===========
push qword 0
mov rax, 0
mov rdi, array_A
mov rsi, r15
call magnitude
movsd xmm15, xmm0
pop rax

;The magnitude of array A is
push qword 0
mov rax, 1
mov rdi, return_magnitudeA
movsd xmm0, xmm15
call printf
pop rax

;For array B enter a sequence of 64-bit floats separated by white space 
push qword 0
mov rax, 0
mov rdi, prompt3
call printf
pop rax

;After the last input press enter followed by Control+D
push qword 0
mov rax, 0
mov rdi, prompt4
call printf
pop rax

;=========== Fill Array B Using input_array.asm ===========
push qword 0
mov rax, 0
mov rdi, array_B
mov rsi, max
call input_array
mov r14, rax
pop rax

;These number were received and placed into array B:
push qword 0
mov rax, 0
mov rdi, return_arrayB
call printf
pop rax

;=========== Output Array B to User display_array.cc ===========
push qword 0
mov rax, 0
mov rdi, array_B
mov rsi, r14
call display_array
pop rax

;=========== Compute Array B Magnitude Using magnitude.asm ===========
push qword 0
mov rax, 0
mov rdi, array_B
mov rsi, r15
call magnitude
movsd xmm15, xmm0
pop rax

;The magnitude of array B is
push qword 0
mov rax, 1
mov rdi, return_magnitudeB
movsd xmm0, xmm15
call printf
pop rax

;Arrays A and B have been appended and given the name A⊕B
push qword 0
mov rax, 0
mov rdi, prompt5
call printf
pop rax

;=========== Compute Array A ⊕ B Using append.asm ===========
push qword 0
mov rdi, array_A
mov rsi, r15
mov rdx, result_array
mov rcx, array_B
mov r8, r14
call append
mov r15, rax
pop rax

;A⊕B contains 
push qword 0
mov rax, 0
mov rdi, return_result_array
call printf
pop rax

;=========== Display result arrays using display_array.cc ===========
push qword 0
mov rax, 0
mov rdi, result_array
mov rsi, r15
call display_array
pop rax


;=========== Compute Array A ⊕ B Magnitude Using magnitude.asm ===========
push qword 0
mov rax, 0
mov rdi, result_array
mov rsi, r15
call magnitude
movsd xmm15, xmm0
pop rax

;The magnitude of  A⊕B is
push qword 0
mov rax, 1
mov rdi, return_magnitudeResult
movsd xmm0, xmm15
call printf
pop rax


pop rax

movsd xmm0, xmm15                                           ;Send to main function

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