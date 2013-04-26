					IF		!DEF(__STATICDATA_I__)
__STATICDATA_I__	SET		1

					RSSET	m_object_SIZEOF
m_static_addr		RB		2										; 
m_static_index		RB		1										; 
m_static_attr		RB		1										; 
m_static_SIZEOF		RB		0										; size of the static obj structure in bytes

					PRINTT	"Static specific data is "
					PRINTV	m_static_SIZEOF-m_object_SIZEOF
					PRINTT	" bytes. "
					PRINTT	"Static Object Size is "
					PRINTV	m_static_SIZEOF
					PRINTT	" bytes.\n"

k_MAX_STATICS		EQU		1
					ENDC
