	.file	"myalgo.c"
	.text
	.globl	myalgo
	.type	myalgo, @function
myalgo:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movq	%r8, -56(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L3:
	movl	-4(%rbp), %eax
	cltq

	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movdqu	(%rax), %xmm0
	movl	-4(%rbp), %eax
	cltq

	leaq	0(,%rax,4), %rcx
	movq	-40(%rbp), %rax
	addq	%rcx, %rax
    movdqu	(%rax), %xmm1
	#movl	%edx, %ecx
	pmuludq	%xmm0, %xmm1
	movl	-4(%rbp), %eax
	cltq
	
    leaq	0(,%rax,4), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movdqu	(%rax), %xmm0
	movl	-4(%rbp), %eax
	cltq
	
    leaq	0(,%rax,4), %rsi
	movq	-56(%rbp), %rax
	addq	%rsi, %rax
	paddq	%xmm1, %xmm3
	movdqu	%xmm3,(%rax)
	addl	$1, -4(%rbp)
.L2:
	movl	-4(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.L3
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	myalgo, .-myalgo
	.ident	"GCC: (Debian 8.3.0-6) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
