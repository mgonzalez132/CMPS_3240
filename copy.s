	.file	"example_fact.c"
	.text
	.section	.rodata
.LC0:
	.string	"Thirteenth Fibonnaci number is ! = %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
    movl    $13, %ebx   /*counter*/
	movl	$0, %edi    /*a number*/
    movl    $1, %esi    /*b number*/
	call	my_fact
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.globl	my_fact
	.type	my_fact, @function
my_fact:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsi
	movl	%edi, -4(%rbp)   /* -4rsp = a*/
	cmpl	$1, %ebx
	jg	.L4
	movl	$1, %eax
	jmp	.L5       /*clean up*/
.L4:             
	subl	$1, %ebx   /*counter-1*/
    movl    %esi,-8(%rbp)
	movl	-4(%rbp), %eax   
    call	my_fact
    addl	-8(%rbp),%esi
	movl    %esi, %eax 
    
.L5:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	my_fact, .-my_fact
	.ident	"GCC: (Debian 8.3.0-6) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
