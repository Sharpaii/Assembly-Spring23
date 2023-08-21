;=========== Identification ===========
; Name: Madeline Sharpe
; Email: madeline.s.sharpe@gmail.com
; CWID: 885824037
; Course: CPSC240-07 (Midterm)
; Date: Mar 22, 2023
; Copyright (C) 2023 Madeline Sharpe

;=========== Declarations ===========
extern printf
extern scanf
extern strcat
extern fgets
extern stdin
extern strlen
extern round
;extern popcnt

INPUT_LEN equ 256           ;Max bytes of name, title, response
LARGE_BOUNDARY equ 64
SMALL_BOUNDARY equ 16

global manager

segment .data
    align SMALL_BOUNDARY        ;Align next data items on 16-byte boundary, every data item will be separated by 16 bytes

    format: db "%s", 0           ;Format indicating a null-terminated string, c-string
    one_int_format db "%d", 0    ;Format indicating int
    one_float_format db "%lf",0  ;Format indicating float

    return_int: db "Answer: %d", 10, 0
    return_float: db "Answer: %lf", 10, 0

    max equ 10   

segment .bss

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

;=========== Question 10 ===========  
    mov r15, 111
    cvtsi2sd xmm15, r15
    mov r14, 2
    cvtsi2sd xmm14, r14

    divsd xmm15, xmm14
    
    push qword 0
    push qword 0
    mov rax, 1
    movsd xmm0, xmm15
    mov rdi, 1
    call round
    movsd xmm15, xmm0
    pop rax
    pop rax


;=========== Print to Console ===========  
    ;mov rax, 0                  
    ;mov rdi, format             
    ;mov rsi, return           
    ;call printf    

    push qword 0
    push qword 0
    mov rax, 1
    mov rdi, return_float
    movsd xmm0, xmm15
    call printf
    pop rax
    pop rax




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