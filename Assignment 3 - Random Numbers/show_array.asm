extern printf
global show_array

segment .data
    format: db `0x%016lx %18.13e`, 10, 0      

segment .bss

segment .text

show_array:
    push rbp
    mov  rbp,rsp
    push rdi            ;Backup rdi
    push rsi            ;Backup rsi
    push rdx            ;Backup rdx
    push rcx            ;Backup rcx
    push r8             ;Backup r8
    push r9             ;Backup r9
    push r10            ;Backup r10
    push r11            ;Backup r11
    push r12            ;Backup r12
    push r13            ;Backup r13
    push r14            ;Backup r14
    push r15            ;Backup r15
    push rbx            ;Backup rbx
    pushf               ;Backup rflags



    mov r15, rdi        ;copy array into r15
    mov r14, rsi        ;copy array size into r14

    mov r13, 0
    beginLoop:
        cmp r13, r14
        je exitLoop

        push qword 0
        mov rax, 1
        mov rdi, format
        mov rsi, [r15 + r13 * 8]
        movsd xmm0, [r15 + 8 * r13]
        call printf
        pop rax

        inc r13
        jmp beginLoop
    exitLoop:




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

