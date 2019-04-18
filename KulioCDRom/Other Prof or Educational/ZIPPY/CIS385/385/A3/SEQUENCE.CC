// sequence.cc 10/29/92

#include "sequence.h"
#include <string.h>

typedef autoarray inherited;

sequence::sequence(): inherited( sizeof( char ), 10, 10 )
{
	itemcount = 0;
}

sequence::~sequence()
{
}

void sequence::insert( long i, char c )
{
	if (0<=i && i<=itemcount)
	{
		if (itemcount == cellcount)
			set( itemcount, &c );
		insertcell( i );
		set( i, &c );
		itemcount++;
	}
	else
		error( "sequence::insert subscript out of range" );
}

void sequence::remove( long i )
{
	if (0<=i && i<itemcount)
	{
		deletecell( i );
		itemcount--;
		shrinkcellcount( itemcount );
	}
	else
		error( "sequence::remove subscript out of range" );
}

void sequence::removeall()
{
	itemcount = 0;
	shrinkcellcount( 0 );
}

void sequence::print( ostream& os )
{
	long int i;
	char temp;

	os << "{ ";
	for (i=0; i<itemcount; i++)
	{
		get( i, &temp );
		os << temp;
		if (i < itemcount-1)
			os << ' ';
	}
	os << " }";
}

char sequence::geti( long i) const
{
	char c;
	if (0<=i && i<itemcount)
		get( i, &c );
	else
		error( "sequence::geti subscript out of range" );
	return c;
}

sequence& sequence::operator=( const sequence& s )
{
	inherited::operator=( s );
	itemcount = s.itemcount;
	return *this;
}
