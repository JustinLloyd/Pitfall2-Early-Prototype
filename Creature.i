					IF		!DEF(__CREATURE_I__)
__CREATURE_I__		SET		1
					INCLUDE "Object.i"

					RSSET	m_object_SIZEOF
m_creature_type		RB		1
m_creature_anim		RB		1
m_creature_firstMove	RB	1
m_creature_moveTable	RB	2
m_creature_cycleTable	RB	2
					ENDC
