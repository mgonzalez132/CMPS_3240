	.file	"example_fact.c"
	.text
	.section	.rodata
.LC0:
	.string	"Thirteenth Fibonnaci number is %d\n"
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
    /* movl    $13, %ebx  ... counter isn't needed*/
	movl	$13, %edi    /* This is the input argument register */
    /* movl    $1, %esi    */
	call	my_fact
	/* movl	%eax, -4(%rbp) ... compiler did this I don't think it's needed */
	/* movl	-4(%rbp), %eax ... same here */
	movl	%eax, %esi /* Output of your function should be in %eax */
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
	subq	$32, %rsp       /* This needs to be RSP not RSI */
	movl	%edi, -4(%rbp)  /* -4rsp = a ... Good */
	cmpl	$1, %edi        /* EBX isn't being used at this point, I think you meant EDI */
	jg	.L4
	movl	$1, %eax
	jmp	.L5       /*clean up*/
.L4:             
    movl    -4(%rbp), %edi  /* Here is an example of how to 'refresh' the input argument register from the stack*/
	subl	$1, %edi        /* Maybe there's some confusion here, input argument register is EDI */
    /* movl    %esi,-8(%rbp)
	movl	-4(%rbp), %eax ... Not sure why there's so many statements here */   
    call	my_fact /* This only takes one argument via RDI */
    addl	%eax, -8(%rbp) /* Place the return value onto the stack */
    movl    -4(%rbp), %edi  /* Get the original value of 'n' */
    subl    $1, %edi
    call    my_fact
    addl    -8(%rbp), %eax
    
.L5:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	my_fact, .-my_fact
	.ident	"GCC: (Debian 8.3.0-6) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
