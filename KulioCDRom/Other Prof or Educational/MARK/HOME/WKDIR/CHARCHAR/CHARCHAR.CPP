// character.cc 11/4/92

#include "charchar.h"

ostream& operator<<( ostream& os, const charchar& c )
{
	c.print( os );
	return os;
}
