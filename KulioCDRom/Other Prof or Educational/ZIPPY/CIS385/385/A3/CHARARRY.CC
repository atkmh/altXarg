// chararray.c 10/21/92

#include "chararray.h"
#include <ctype.h>
#include "error.h"
#include "chararrayasst.h"

typedef unsafearray inherited;

void chararray:: set( long int i, const char& const c )
{
	inherited::set( i, &c );
}

void chararray::get( long int i, char& c ) const
{
	char dummy;

	inherited::get( i, &dummy );
	c = dummy;
}
/*
char& chararray::operator[] (long i)
{
	return *(char*)(data + i * cellsize);
}
*/
chararrayasst chararray::operator[] (long i)
{
	return chararrayasst( this, i );
}

void chararray::print( ostream& os ) const
{
	char c;

	os << "[ ";
	for ( long int i = 0; i<cellcount; i++ )
	{
		c = (*(chararray*)this)[ i ];
		if (isprint( c ))
			os << c;
		else
			os << '.';
	}
	os << " ]";
}

ostream& operator<<( ostream& os, const chararray& ca )
{
	ca.print( os );
	return os;
}

chararray& chararray::operator=( const chararray& a )
{
	inherited::operator=( a );
	return *this;
}
