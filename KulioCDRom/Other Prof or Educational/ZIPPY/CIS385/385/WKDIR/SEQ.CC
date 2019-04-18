// seq.cc 11/5/92

#include "seq.h"
#include <string.h>
#include "error.h"

typedef autoarray inherited;

void seq::insert( long i, eqthing* t )
{
	if (0 <= i && i <= itemcount )
	{
		thing* temp = t->copy();
	  
		insertcell( i );
		set( i, &temp );
		itemcount++;
	}
	else
		error( "seq::insert index out of bounds" );
}

void seq::remove( long i )
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
		error( "seq::remove index out of bounds" );
}

void seq::removeall()
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

void seq::print( ostream& os ) const
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

eqthing* seq::geti( long i) const
{
	eqthing* t;
	if (0 <= i && i < itemcount )
		get( i, &t );
	else
		error( "seq::geti index out of bounds" );
	return t;
}

seq& seq::operator=( const seq& s )
{
	inherited::operator=( s );
	itemcount = 0;
	for (long i = 0; i<s.itemcount; i++)
	{
		eqthing* tp;

		tp = (eqthing*) (s.geti( i ));
		insert( i, tp );
	}

	return *this;
}

thing* seq::copy() const
{
	seq* sp = new seq;

	*sp = *this;

	return sp;
}

ostream& operator<<( ostream& os, seq& s )
{
	s.print( os );
	return os;
}

boolean seq::operator==( const eqthing& t ) const
{
	boolean equal;

	if (this == &t)
		equal = TRUE;
	else if (t.isa( myclass ))
	{
		if (itemcount == ((seq*)&t)->itemcount)
		{
			equal = TRUE;
			for (long i = 0; (i<itemcount) && equal; i++)
				if (*geti( i ) != *(((seq*)&t)->geti( i )))
					equal = FALSE;
		}
		else
			equal = FALSE;
	}
	else
		equal = FALSE;
	return equal;
}
