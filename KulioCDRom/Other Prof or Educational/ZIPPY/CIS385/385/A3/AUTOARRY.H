// autoarray.h 10/21/92

#ifndef AUTOARRAY_H
#define AUTOARRAY_H

#include "safearray.h"

class autoarray: public safearray
{

protected:

	int increment;

public:

	autoarray( long newcellsize, long newcellcount=0, int newincrement = 10 ):safearray( newcellsize, newcellcount )
	{
		increment = newincrement;
	}

	autoarray( const autoarray& a ):safearray( a )
	{
		increment = a.increment;
	}

	~autoarray()
	{
		delete [] data;
	}

	autoarray& operator=( const autoarray& a );
		// copy a to *this

	void set( long i, void* e );
		// copies e to cell i
		// extends the array to hold cell i if needed
	
	void move( long i, long j );
		// copies cell j to cell i
		// extends the array to hold cell i if needed

	void shrinkcellcount( long i );
		// reduces cellcount so that it holds i
		// no reduction is done if i is within increment of cellcount
};

#endif
