// set.cc 10/22/92

#include "set.h"

typedef bunch inherited;

long set:: Cardinality() const
{
	return( itemcount );
}

void set::CopySet( const set& S )
{
	inherited::operator=( S );
}

void set::DeleteElement( const char E )
{
	remove( E );
}

set set::Difference( const set& S ) const
{
	set T;

	for (int i=0; i<Cardinality(); i++)
		if (!S.Member( geti( i ) ))
			T.InsertElement( geti( i ) );

	return T;
}

boolean set::EqualSets( const set& S ) const
{
	boolean Equal;

	if (Cardinality() != S.Cardinality())
		Equal = FALSE;
	else
	{
		Equal = TRUE;
		int i = 0;
		while ((i < Cardinality()) && Equal)
		{
			if (!Member( S.geti( i ) ))
				Equal = FALSE;
			i++;
		}
	}
	return( Equal );
}

void set::InsertElement( const char E )
{
	insert( E );
}

set set::Intersection( const set& S ) const
{
	set T;
	int i;

	for (i=0; i<S.Cardinality(); i++)
		if (Member( S.geti( i ) ))
			T.InsertElement( S.geti( i ) );

	return T;
}

void set::MakeEmpty()
{
	removeall();
}

boolean set::Member( const char E ) const
{
	return member( E );
}

char set::PickMember() const
{
	if (Cardinality()>0)
		return geti( 0 );
	else
		return '?';
}

void set::Print( ostream& os ) const
{
	print( os );
}

boolean set::SubSet( const set& S ) const
{
	boolean Sub;
	int i = 0;

	if (Cardinality() > S.Cardinality())
		Sub = FALSE;
	else
	{
		Sub = TRUE;
		while ((i < Cardinality()) && Sub)
		{
			if (!S.Member( geti( i ) ))
				Sub = FALSE;
			i++;
		}
	};
	
	return( Sub );
}

set set::Union( const set& S ) const
{
	set T;
	int i;

	T.CopySet( S );
	for (i=0; i<Cardinality(); i++)
		T.InsertElement( geti( i ) );

	return T;
}


