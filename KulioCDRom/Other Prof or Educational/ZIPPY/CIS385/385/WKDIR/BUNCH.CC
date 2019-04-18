// bunch.cc 10/22/92

#include <iostream.h>
#include "character.h"
#include "bunch.h"
#include <string.h>
#include "error.h"



void bunch::insert( eqthing* t )
{
	if (!member( t ))
	{
		thing* temp = t->copy();
		
		insertcell( itemcount );
		set( itemcount,  &temp );
		itemcount++;
	}
}

void bunch::remove( eqthing* t )
{// cout << "inside remove(eqthing* t)" << '\n';
	long int i;
	boolean found;
	eqthing* temp;

	found = FALSE;
	for (i=0; i<itemcount && !found;)
	{// cout << " " << i;
		temp = geti( i );
	        //temp->print(cout);


	        if ( (*temp) == (*t))
                { found = TRUE;
		// cout << "got compared found breaking and removeing" << '\n';
                }
		else
			i++;
	}
       // cout << '\n';
	if (found)
	{
	    delete temp;
		deletecell( i );
		itemcount--;
		shrinkcellcount( itemcount );
	}
}

void bunch::removeall()
{
	long int i;

	itemcount = 0;
	shrinkcellcount( 0 );
}

boolean bunch::member( eqthing* t ) const
{
	long int i;
	boolean found;
	eqthing* temp;

	found = FALSE;
	for (i=0; i<itemcount && !found; )
	{
		temp = geti( i );
		
		if ( (*t) == (*temp) )
			found = TRUE;
		else
			i++;
	}

	return found;
}

void bunch::print( ostream& os ) const
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

eqthing* bunch::geti( long i) const
{
	eqthing* t;

	get( i, &t );

	return t;
}

thing* bunch::copy() const
{
	bunch* bp = new bunch;

	*bp = *this;

	return bp;
}


bunch& bunch::operator=( const bunch& b )
{
	autoarray::operator=( b );
	itemcount = b.itemcount;
	return *this;
}

ostream& operator<<( ostream& os, bunch& b )
{
  b.print( os );
  return os;
}

boolean bunch::operator==( const eqthing& t ) const
{
	boolean equal;

	if (this == &t)
		equal = TRUE;
	else if (t.isa( myclass ))
	{
		if (itemcount == ((bunch*)&t)->itemcount)
		{
			equal = TRUE;
			for (long i = 0; (i<itemcount) && equal; i++)
				if (*geti( i ) != *(((bunch*)&t)->geti( i )))
					equal = FALSE;
		}
		else
			equal = FALSE;
	}
	else
		equal = FALSE;
	return equal;
}
