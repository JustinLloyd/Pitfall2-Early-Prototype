					IF		!DEF(__MATH_I__)
__MATH_I__			SET		1


; subtract 8 bit register from 16-bit register
SUB8:				MACRO
					FAIL	"SUB8 Macro not written"
					ENDM


;********************************************************************
; NAME: SUB8I (macro)												*
; I/P:	parameter 1	-- 16-bit register pair (BC, DE, HL)			*
;		parameter 2	-- 8-bit immediate value						*
; AUTH:	JLloyd -- 99/05/07											*
;																	*
; This macro subtracts an immediate 8-bit value to a 16-bit			*
; register pair. It determines which register pair (BC, DE, HL) to	*
; subtract from and calls the appropriate macro that handles those	*
; registers. It preserves all registers (except F) that it uses as	*
; temporary storage.												*
;																	*
;********************************************************************

SUB8I:				MACRO
__p1				EQUS	STRTRIM(STRLWR("\1"))					; convert parameter 1 to lower case
__p2				EQUS	STRTRIM(STRLWR("\2"))					; convert parameter 2 to lower case
					IF		(STRCMP("{__p1}","bc")==0)				; is parameterr 1 = bc register?
						SUB8I_BC	\2,P							; yes, so subtract 8-bit immediate from bc
					ENDC

					IF		(STRCMP("{__p1}","de")==0)				; is paramater 1 = de register?
						SUB8I_DE	\2,P							; yes, so subtract 8-bit immediate from de
					ENDC

					IF		(STRCMP("{__p1}","hl")==0)				; is parameter 1 = hl register?
						SUB8I_HL	\2,P							; yes, so subtract 8-bit immediate from hl
					ENDC

					PURGE	__p1,__p2								; remove temp symbols from symbol table
					ENDM


;********************************************************************
; NAME: SUB8IR (macro)												*
; I/P:	parameter 1	-- 16-bit register pair (BC, DE, HL)			*
;		parameter 2	-- 8-bit immediate value						*
; AUTH:	JLloyd -- 99/05/07											*
;																	*
; This macro subtracts an immediate 8-bit value to a 16-bit			*
; register pair. It determines which register pair (BC, DE, HL) to	*
; subtract from and calls the appropriate macro that handles those	*
; registers. It destroys the BC or HL register pair.				*
;																	*
;********************************************************************

SUB8IR:				MACRO
__p1				EQUS	STRTRIM(STRLWR("\1"))					; convert parameter 1 to lower case
__p2				EQUS	STRTRIM(STRLWR("\2"))					; convert parameter 2 to lower case
					IF		(STRCMP("{__p1}","bc")==0)				; is parameterr 1 = bc register?
						SUB8I_BC	\2,NP							; yes, so subtract 8-bit immediate from bc
					ENDC

					IF		(STRCMP("{__p1}","de")==0)				; is paramater 1 = de register?
						SUB8I_DE	\2,NP							; yes, so subtract 8-bit immediate from de
					ENDC

					IF		(STRCMP("{__p1}","hl")==0)				; is parameter 1 = hl register?
						SUB8I_HL	\2,NP							; yes, so subtract 8-bit immediate from hl
					ENDC

					PURGE	__p1,__p2								; remove temp symbols from symbol table
					ENDM


ADD8:				MACRO
					FAIL	"ADD8 Macro not written yet"
					ENDM


;********************************************************************
; NAME: ADD8I (macro)												*
; I/P:	parameter 1	-- 16-bit register pair (BC, DE, HL)			*
;		parameter 2	-- 8-bit immediate value						*
; AUTH:	JLloyd -- 99/05/07											*
;																	*
; This macro adds an immediate 8-bit value to a 16-bit register		*
; pair. It determines which register pair (BC, DE, HL) to add to	*
; and calls the appropriate macro that handles those registers.		*
; It preserves all registers (except F) that it uses as temporary	*
; storage.															*
;																	*
;********************************************************************

ADD8I:				MACRO
__p1				EQUS	STRTRIM(STRLWR("\1"))					; convert parameter 1 to lower case
__p2				EQUS	STRTRIM(STRLWR("\2"))					; convert parameter 2 to lower case
					IF		(STRCMP("{__p1}","bc")==0)				; is parameter 1 = bc register?
																	; yes, so add 8-bit immediate to bc
					ADD8I_BC	\2,P
					ENDC

					IF		(STRCMP("{__p1}","de")==0)				; is parameter 1 = de register?
																	; yes, so add 8-bit immediate to de
						ADD8I_DE	\2,P
					ENDC

					IF		(STRCMP("{__p1}","hl")==0)				; is parameter 1 = hl register?
																	; yes, so add 8-bit immediate to hl
					ADD8I_HL	\2,P
					ENDC

					PURGE	__p1,__p2								; remove temp symbols from symbol table
					ENDM


;********************************************************************
; NAME: ADD8IR (macro)												*
; I/P:	parameter 1	-- 16-bit register pair (BC, DE, HL)			*
;		parameter 2	-- 8-bit immediate value						*
; AUTH:	JLloyd -- 99/05/07											*
;																	*
; This macro adds an immediate 8-bit value to a 16-bit register		*
; pair. It determines which register pair (BC, DE, HL) to add to	*
; and calls the appropriate macro that handles those registers.		*
; It destroys the BC or HL register pair.							*
;																	*
;********************************************************************

ADD8IR:				MACRO
__p1				EQUS	STRTRIM(STRLWR("\1"))					; convert parameter 1 to lower case
__p2				EQUS	STRTRIM(STRLWR("\2"))					; convert parameter 2 to lower case
					IF		(STRCMP("{__p1}","bc")==0)				; is parameter 1 = bc register?
																	; yes, so add 8-bit immediate to bc
					ADD8I_BC	\2,NP
					ENDC

					IF		(STRCMP("{__p1}","de")==0)				; is parameter 1 = de register?
																	; yes, so add 8-bit immediate to de
						ADD8I_DE	\2,NP
					ENDC

					IF		(STRCMP("{__p1}","hl")==0)				; is parameter 1 = hl register?
																	; yes, so add 8-bit immediate to hl
					ADD8I_HL	\2,NP
					ENDC

					PURGE	__p1,__p2								; remove temp symbols from symbol table
					ENDM


SUB16I:				MACRO
					FAIL	"Macro not written"
					ENDM

SUB16:				MACRO
					FAIL	"Macro not written"
					ENDM

ADD16I:				MACRO
					FAIL	"Macro not written"
					ENDM

ADD16:				MACRO
					FAIL	"Macro not written"
					ENDM


;********************************************************************
; NAME: ADD8I_HL (macro)											*
; I/P:	parameter 1	-- 8-bit immediate value to add					*
;		parameter 2	-- "p" to preserve temporary register(s)		*
; REGS:	BC (if not "p"reserved)										*
; SIZE:	xx byte(s)													*
; TIME:	xx T(s)														*
; AUTH:	JLloyd -- 99/05/07											*
;																	*
; This macro adds an immediate 8-bit value to the HL register. It	*
; takes two parameters, an 8-bit immediate addend and a string		*
; containing the letter "p" if the any temporary registers are to	*
; be preserved.														*
;																	*
;********************************************************************

ADD8I_HL:			MACRO
__preserve			EQUS	STRTRIM(STRLWR("\2"))					; convert second parameter to lower case

					IF		(STRCMP("{__preserve}","p")==0)			; should we preserve temp registers?
					PUSH	BC										; yes, so save register						(16T)
					ENDC

					LD		B,$00									; set hi-byte of addend to 0
					LD		C,\1									; set lo-byte of addend to specified 8-bit value
					ADD		HL,BC									; sum addend to current value of HL register

					IF		(STRCMP("{__preserve}","p")==0)			; should we restore a preserved temp register?
					POP		BC										; yes, so restore register					(12T)
					ENDC

					PURGE	__preserve
					ENDM


;********************************************************************
; NAME: ADD8I_BC (macro)											*
; I/P:	parameter 1	-- 8-bit immediate value to add					*
;		parameter 2	-- "p" to preserve temporary register(s)		*
; REGS:	HL (if not "p"reserved)										*
; SIZE:	xx byte(s)													*
; TIME:	xx T(s)														*
; AUTH:	JLloyd -- 99/05/07											*
;																	*
; This macro adds an immediate 8-bit value to the BC register. It	*
; takes two parameters, an 8-bit immediate addend and a string		*
; containing the letter "p" if the any temporary registers are to	*
; be preserved.														*
;																	*
;********************************************************************

ADD8I_BC:			MACRO
__preserve			EQUS	STRTRIM(STRLWR("\2"))					; convert second parameter to lower case
					IF		(STRCMP("{__preserve}","p")==0)			; should we preserve temp registers?
					PUSH	HL										; yes, so save register						(16T)
					ENDC

					LD		H,$00									; set hi-byte of value
					LD		L,(\1)									; set lo-byte of value to specified 8-bit value
					ADD		HL,BC									; add 8-bit number and 16-bit number
					LD		B,H										; copy hi-byte of result
					LD		C,L										; copy lo-byte of result

					IF		(STRCMP("{__preserve}","p")==0)			; should we restore a preserved temp register?
					POP		HL										; yes, so restore register					(12T)
					ENDC

					PURGE	__preserve
					ENDM


;********************************************************************
; NAME: ADD8I_DE (macro)											*
; I/P:	parameter 1	-- 8-bit immediate value to add					*
;		parameter 2	-- "p" to preserve temporary register(s)		*
; REGS:	HL (if not "p"reserved)										*
; SIZE:	xx byte(s)													*
; TIME:	xx T(s)														*
; AUTH:	JLloyd -- 99/05/07											*
;																	*
; This macro adds an immediate 8-bit value to the DE register. It	*
; takes two parameters, an 8-bit immediate addend and a string		*
; containing the letter "p" if the any temporary registers are to	*
; be preserved.														*
;																	*
;********************************************************************

ADD8I_DE:			MACRO
__preserve			EQUS	STRTRIM(STRLWR("\2"))					; convert second parameter to lower case

					IF		(STRCMP("{__preserve}","p")==0)			; should we preserve temp registers?
					PUSH	HL										; yes, so save register						(16T)
					ENDC

					LD		H,$00									; set hi-byte of value
					LD		L,\1									; set lo-byte of value to specified 8-bit value
					ADD		HL,DE									; add 8-bit number and 16-bit number
					LD		D,H										; copy hi-byte of result
					LD		E,L										; copy lo-byte of result

					IF		(STRCMP("{__preserve}","p")==0)			; should we restore a preserved temp register?
					POP		HL										; yes, so restore register					(12T)
					ENDC

					PURGE	__preserve
					ENDM


;********************************************************************
; NAME: SUB8I_HL (macro)											*
; I/P:	parameter 1	-- 8-bit immediate value to add					*
;		parameter 2	-- "p" to preserve temporary register(s)		*
; REGS:	BC (if not "p"reserved)										*
; SIZE:	xx byte(s)													*
; TIME:	xx T(s)														*
; AUTH:	JLloyd -- 99/05/07											*
;																	*
; This macro subtracts an immediate 8-bit value from the HL			*
; register. It takes two parameters, an 8-bit immediate value and	*
; a string containing the letter "p" if the any temporary registers	*
; are to be preserved.												*
;																	*
;********************************************************************

SUB8I_HL:			MACRO
__preserve			EQUS	STRTRIM(STRLWR("\2"))					; convert second parameter to lower case

					IF		(STRCMP("{__preserve}","p")==0)			; should we preserve temp registers?
					PUSH	BC										; yes, so save register						(16T)
					ENDC

					LD		B,$FF									; load hi-byte of -ve number				(8T)
					LD		C,($FF-\1)+1							; load lo-byte of -ve number				(8T)
					ADD		HL,BC									; subtract number							(8T)

					IF		(STRCMP("{__preserve}","p")==0)			; should we restore a preserved temp register?
					POP		BC										; yes, so restore register					(12T)
					ENDC

					PURGE	__preserve
					ENDM


;********************************************************************
; NAME: SUB8I_BC (macro)											*
; I/P:	parameter 1	-- 8-bit immediate value to add					*
;		parameter 2	-- "p" to preserve temporary register(s)		*
; REGS:	HL (if not "p"reserved)										*
; SIZE:	7/9 byte(s)													*
; TIME:	32/60 T(s)													*
; AUTH:	JLloyd -- 99/05/07											*
;																	*
; This macro subtracts an immediate 8-bit value from the BC			*
; register. It takes two parameters, an 8-bit immediate value and	*
; a string containing the letter "p" if the any temporary registers	*
; are to be preserved.												*
;																	*
;********************************************************************

SUB8I_BC:			MACRO
__preserve			EQUS	STRTRIM(STRLWR("\2"))					; convert second parameter to lower case

					IF		(STRCMP("{__preserve}","p")==0)			; should we preserve temp registers?
					PUSH	HL										; yes, so save register						(16T)
					ENDC

					LD		H,$FF									; load hi-byte of -ve number				(8T)
					LD		L,($FF-\1)+1							; load lo-byte of -ve number				(8T)
					ADD		HL,BC									; subtract number							(8T)
					LD		B,H										; copy hi-byte of result					(4T)
					LD		C,L										; copy lo-byte of result					(4T)

					IF		(STRCMP("{__preserve}","p")==0)			; should we restore a preserved temp register?
					POP		HL										; yes, so restore register					(12T)
					ENDC

					PURGE	__preserve
					ENDM
					

;********************************************************************
; NAME: SUB8I_DE (macro)											*
; I/P:	parameter 1	-- 8-bit immediate value to add					*
;		parameter 2	-- "p" to preserve temporary register(s)		*
; REGS:	HL (if not "p"reserved)										*
; SIZE:	7/9 byte(s)													*
; TIME:	32/60 T(s)													*
; AUTH:	JLloyd -- 99/05/07											*
;																	*
; This macro subtracts an immediate 8-bit value from the DE			*
; register. It takes two parameters, an 8-bit immediate value and	*
; a string containing the letter "p" if the any temporary registers	*
; are to be preserved.												*
;																	*
;********************************************************************

SUB8I_DE:			MACRO
__preserve			EQUS	STRTRIM(STRLWR("\2"))					; convert second parameter to lower case

					IF		(STRCMP("{__preserve}","p")==0)			; should we preserve temp registers?
					PUSH	HL										; yes, so save register						(16T)
					ENDC

					LD		H,$FF									; load hi-byte of -ve number				(8T)
					LD		L,($FF-\1)+1							; load lo-byte of -ve number				(8T)
					ADD		HL,DE									; subtract number							(8T)
					LD		D,H										; copy hi-byte of result					(4T)
					LD		E,L										; copy lo-byte of result					(4T)

					IF		(STRCMP("{__preserve}","p")==0)			; should we restore a preserved temp register?
					POP		HL										; yes, so restore register					(12T)
					ENDC

					PURGE	__preserve
					ENDM

					ENDC