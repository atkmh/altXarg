// autoarray.cc 10/21/92
// autoaray.cpp  09/22/97


#include "autoaray.h"

// typedef safearay inherited;

void autoaray::set( long i, void* e )
{
	if (i>=cellcount)
		setcellcount( i+1+increment );
	safearay::set( i, e );
}

void autoaray::move( long i, long j )
{

	if (i>=cellcount)
		setcellcount( i+1+increment );
	safearay::swap( i, j );
}

void autoaray::shrinkcellcount( long i )
{
	if (i < cellcount-increment-1)
		setcellcount( i+1 );
}

autoaray& autoaray::operator=( const autoaray& a )
{
	safearay::operator=( a );
	increment = a.increment;
	return *this;
}
