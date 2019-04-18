// sequence.cc 11/5/92

#include "sequence.h"
#include <string.h>
#include "error.h"

typedef autoarray inherited;

void sequence::insert( long i, equatablething* t )
{
	if (0 <= i && i <= itemcount )
	{
		thing* temp = t->copy();
	  
		insertcell( i );
		set( i, &temp );
		itemcount++;
	}
	else
		error( "sequence::insert index out of bounds" );
}

void sequence::remove( long i )
{
	thing* temp;

	if (0 <= i && i < itemcount )
	{
		temp = geti( i );
		delete temp;
		deletecell( i );
		itemcount--;
		shrinkcellcount( itemcount );
	}
	else
		error( "sequence::remove index out of bounds" );
}

void sequence::removeall()
{
	long int i;
	thing* temp;

	for (i=0; i<itemcount; i++)
	{
		temp = geti( i );
		delete temp;
	}

	itemcount = 0;
	shrinkcellcount( 0 );
}

void sequence::print( ostream& os ) const
{
	long int i;
	thing* temp;

	os << "{ ";
	for (i=0; i<itemcount; i++)
	{
		get( i, &temp );
		temp->print( os );
		if (i < itemcount-1)
			os << ' ';
	}
	os << " }";
}

equatablething* sequence::geti( long i) const
{
	equatablething* t;
	if (0 <= i && i < itemcount )
		get( i, &t );
	else
		error( "sequence::geti index out of bounds" );
	return t;
}

sequence& sequence::operator=( const sequence& s )
{
	inherited::operator=( s );
	itemcount = 0;
	for (long i = 0; i<s.itemcount; i++)
	{
		equatablething* tp;

		tp = (equatablething*) (s.geti( i ));
		insert( i, tp );
	}

	return *this;
}

thing* sequence::copy() const
{
	sequence* sp = new sequence;

	*sp = *this;

	return sp;
}

ostream& operator<<( ostream& os, sequence& s )
{
	s.print( os );
	return os;
}

boolean sequence::operator==( const equatablething& t ) const
{
	boolean equal;

	if (this == &t)
		equal = TRUE;
	else if (t.isa( myclass ))
	{
		if (itemcount == ((sequence*)&t)->itemcount)
		{
			equal = TRUE;
			for (long i = 0; (i<itemcount) && equal; i++)
				if (*geti( i ) != *(((sequence*)&t)->geti( i )))
					equal = FALSE;
		}
		else
			equal = FALSE;
	}
	else
		equal = FALSE;
	return equal;
}