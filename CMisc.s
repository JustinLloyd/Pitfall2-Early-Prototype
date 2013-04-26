	;; File generated by GBDK 2.0, P. Felber & M. Hope, 1995-1998


	;; Ordering of segments for the linker
	.area	_CODE
	.area	_DATA
	.area	_LIT
	.area	_BSS

	.globl	_set_word_x
	.area	_CODE
_start_set_word_x:
_set_word_x:
.L2:
	RET
_end_set_word_x:
	.globl	_set_word_y
_start_set_word_y:
_set_word_y:
.L3:
	RET
_end_set_word_y:
	.globl	_set_byte_x
_start_set_byte_x:
_set_byte_x:
.L4:
	RET
_end_set_byte_x:
	.globl	_set_byte_y
_start_set_byte_y:
_set_byte_y:
.L5:
	RET
_end_set_byte_y:
	.globl	_do_condition
_start_do_condition:
_do_condition:
.L6:
	RET
_end_do_condition:
	.globl	_condition_complete
_start_condition_complete:
_condition_complete:
.L7:
	RET
_end_condition_complete:
	.globl	_condition_is_true
_start_condition_is_true:
_condition_is_true:
.L8:
	RET
_end_condition_is_true:
	.globl	_Test
_start_Test:
_Test:
	LDA	SP,-10(SP)
	PUSH	BC
	CALL	_set_word_x
	LD	A,(.L10+1)
	LD	D,A
	LD	A,(.L10)
	LD	E,A
	LDA	HL,6(SP)
	LD	A,E
	LD	(HL+),A
	LD	(HL),D
	CALL	_set_word_y
	LD	A,(.L11+1)
	LD	D,A
	LD	A,(.L11)
	LD	E,A
	LDA	HL,4(SP)
	LD	A,E
	LD	(HL+),A
	LD	(HL),D
	CALL	_set_byte_x
	LDA	HL,3(SP)
	LD	(HL),#<10
	CALL	_set_byte_y
	LDA	HL,2(SP)
	LD	(HL),#<10
	CALL	_do_condition
	LDA	HL,8(SP)
	LD	A,(HL+)
	LD	D,(HL)
	LD	E,A
	LDA	HL,10(SP)
	LD	A,(HL+)
	LD	B,(HL)
	LD	C,A
	LD	A,D
	ADD	#0x80
	LD	L,A
	LD	A,B
	ADD	#0x80
	CP	L
	JR	NZ,.L14
	LD	A,C
	CP	E
.L14:
	JP	NC,.L12
	CALL	_condition_is_true
.L12:
	CALL	_condition_complete
	LD	A,#<0
	PUSH	AF
	INC	SP
	LD	A,#<0
	PUSH	AF
	INC	SP
	LD	A,#<0
	PUSH	AF
	INC	SP
	LD	A,#<0
	PUSH	AF
	INC	SP
	LD	A,#<0
	PUSH	AF
	INC	SP
	LD	A,#<0
	PUSH	AF
	INC	SP
	CALL	_IsPtInRect
	LDA	SP,6(SP)
.L9:
	POP	BC
	LDA	SP,10(SP)
	RET
_end_Test:
	.globl	_IsPtInRect
_start_IsPtInRect:
_IsPtInRect:
	PUSH	BC
	LDA	HL,12(SP)
	LD	A,(HL+)
	LD	D,(HL)
	LD	E,A
	LDA	HL,4(SP)
	LD	A,(HL+)
	LD	B,(HL)
	LD	C,A
	LD	A,E
	SUB	C
	LD	E,A
	LD	A,D
	SBC	B
	LD	D,A
	LD	A,(.L18+1)
	LD	B,A
	LD	A,(.L18)
	LD	C,A
	LD	A,B
	ADD	#0x80
	LD	L,A
	LD	A,D
	ADD	#0x80
	CP	L
	JR	NZ,.L25
	LD	A,E
	CP	C
.L25:
	JP	NC,.L16
	LD	E,#<0
	JP	.L15
.L16:
	LDA	HL,8(SP)
	LD	A,(HL+)
	LD	D,(HL)
	LD	E,A
	LDA	HL,12(SP)
	LD	A,(HL+)
	LD	B,(HL)
	LD	C,A
	LD	A,E
	SUB	C
	LD	E,A
	LD	A,D
	SBC	B
	LD	D,A
	LD	A,(.L18+1)
	LD	B,A
	LD	A,(.L18)
	LD	C,A
	LD	A,B
	ADD	#0x80
	LD	L,A
	LD	A,D
	ADD	#0x80
	CP	L
	JR	NZ,.L26
	LD	A,E
	CP	C
.L26:
	JP	NC,.L19
	LD	E,#<0
	JP	.L15
.L19:
	LDA	HL,14(SP)
	LD	A,(HL+)
	LD	D,(HL)
	LD	E,A
	LDA	HL,6(SP)
	LD	A,(HL+)
	LD	B,(HL)
	LD	C,A
	LD	A,E
	SUB	C
	LD	E,A
	LD	A,D
	SBC	B
	LD	D,A
	LD	A,(.L18+1)
	LD	B,A
	LD	A,(.L18)
	LD	C,A
	LD	A,B
	ADD	#0x80
	LD	L,A
	LD	A,D
	ADD	#0x80
	CP	L
	JR	NZ,.L27
	LD	A,E
	CP	C
.L27:
	JP	NC,.L21
	LD	E,#<0
	JP	.L15
.L21:
	LDA	HL,10(SP)
	LD	A,(HL+)
	LD	D,(HL)
	LD	E,A
	LDA	HL,14(SP)
	LD	A,(HL+)
	LD	B,(HL)
	LD	C,A
	LD	A,E
	SUB	C
	LD	E,A
	LD	A,D
	SBC	B
	LD	D,A
	LD	A,(.L18+1)
	LD	B,A
	LD	A,(.L18)
	LD	C,A
	LD	A,B
	ADD	#0x80
	LD	L,A
	LD	A,D
	ADD	#0x80
	CP	L
	JR	NZ,.L28
	LD	A,E
	CP	C
.L28:
	JP	NC,.L23
	LD	E,#<0
	JP	.L15
.L23:
	LD	E,#<1
.L15:
	POP	BC
	RET
_end_IsPtInRect:
	;; _CODE ends
	.area	_LIT
.L18:
	.dw	0
.L11:
	.dw	0x14
.L10:
	.dw	0xa
	;; _LIT ends
	;; End of program
