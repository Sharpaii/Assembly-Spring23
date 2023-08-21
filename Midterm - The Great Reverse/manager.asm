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

extern input_array
extern reverse
extern display_array

INPUT_LEN equ 256           ;Max bytes of name, title, response
LARGE_BOUNDARY equ 64
SMALL_BOUNDARY equ 16

global manager

segment .data
    align SMALL_BOUNDARY        ;Align next data items on 16-byte boundary, every data item will be separated by 16 bytes

    format: db "%s", 0           ;Format indicating a null-terminated string, c-string
    one_int_format db "%d", 0    ;Format indicating int
    one_float_format db "%lf",0  ;Format indicating float

    ask_name: db "Please enter your name: ", 0
    ask_title: db "What is your title: ", 0
    welcome1: db "Welcome ", 0
    space: db " ", 0 ; space character
    welcome2: db `\nThis is our reverse program.`, 10, 0
    prompt1: db "Please enter float numbers seperated by ws and press <enter><control+d> to terminate inputs. ", 0
    prompt2: db "You entered ", 10, 0
    header_row: db "IEEE754            Scientific Decimal", 10, 0
    prompt3: db `The array has `, 0
    prompt4: db " doubles",10, 0
    prompt5: db "The function reverse was called", 10, 10, 0
    prompt6: db "The second array holds these values", 10, 0

    exit1: db `\nGood bye `, 0
    exit2: db ", you are welcome any time.", 10, 0

    max equ 10   

segment .bss
    title: resb INPUT_LEN       ;Reserve 256 bytes for title given by user
    name: resb INPUT_LEN        ;Reserve 256 bytes for name given by user
    full: resb 256
    array_A: resq max
    array_B: resq max

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

;=========== Print to Console "What is your title:" ===========  
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

;=========== Print to Console "Welcome [title] [name]" ===========
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

;=========== Print to Console "This is our reverse program." ===========  
    mov rax, 0
    mov rdi, format
    mov rsi, welcome2
    call printf

;=========== Print to Console "Please enter float numbers seperated by ws and press <enter><control+d> to terminate inputs." ===========  
    mov rax, 0
    mov rdi, format
    mov rsi, prompt1
    call printf

;=========== Fill Array A Using input_array.asm ===========
    push qword 0
    push qword 0
    mov rax, 0
    mov rdi, array_A
    mov rsi, max
    call input_array
    mov r15, rax
    pop rax
    pop rax

;=========== Print to Console "You entered " ===========
    mov rax, 0
    mov rdi, format
    mov rsi, prompt2
    call printf

;=========== Output Array A to User using display_array.cc ===========
    push qword 0
    push qword 0
    mov rax, 0
    mov rdi, array_A
    mov rsi, r15
    call display_array
    pop rax
    pop rax

;=========== Print to Console "The aray has " ===========
    mov rax, 0
    mov rdi, format
    mov rsi, prompt3
    call printf   

    mov rax, 0
    mov rdi, one_int_format
    mov rsi, r15
    call printf

;=========== Print to Console " doubles" ===========
    mov rax, 0
    mov rdi, format
    mov rsi, prompt4
    call printf   

;=========== Print to Console "The function reverse was called" ===========
    mov rax, 0
    mov rdi, format
    mov rsi, prompt5
    call printf  

;=========== Fill Array A Using reverse.asm ===========
    push qword 0
    push qword 0
    mov rdi, array_A
    mov rsi, r15
    mov rdx, array_B
    call reverse
    mov r14, rax
    pop rax
    pop rax

;=========== Print to Console "The second array holds these values" ===========
    mov rax, 0
    mov rdi, format
    mov rsi, prompt6
    call printf    

;=========== Output Array A to User using display_array.cc ===========
    push qword 0
    push qword 0
    mov rax, 0
    mov rdi, array_B
    mov rsi, r14
    call display_array
    pop rax
    pop rax

;=========== Concatenate Title with Space ===========
    push qword 0
    mov rax, 0
    mov rdi, title
    mov rsi, space
    call strcat
    pop rax

;=========== Concatenate Title with Name ===========
    push qword 0
    mov rax, 0
    mov rdi, title
    mov rsi, name
    call strcat
    pop rax


;=========== Return name for main.cpp to use ===========    
    mov rax, title

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