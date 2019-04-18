//chararrayasst.h 10/27/92

#ifndef CHARARRAYASST_H
#define CHARARRAYASST_H

#include "chararray.h"

class chararrayasst
{
	chararray* cap;
	long index;

public:

	chararrayasst( chararray* newcap, long newindex )
	{
		cap = newcap;
		index = newindex;
	}

	char operator=( const char c )	// a[ i ] = 'c'
	{
		cap->set( index, c );
		return c;
	}

	operator char()				// ch = a[ i ]
	{
		char temp;

		cap->get( index, temp );
		return temp;
	}
};

#endif
