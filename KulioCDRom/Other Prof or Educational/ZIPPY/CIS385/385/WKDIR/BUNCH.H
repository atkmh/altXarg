// bunch.h 11/8/92

#ifndef BUNCH_H
#define BUNCH_H

#include "autoarray.h"
#include "eqthing.h"
#include "mytypes.h"
#include <iostream.h>

class bunch: public autoarray, public eqthing
{

protected:

	long itemcount;

public:

	bunch(): autoarray( sizeof( thing* ), 10, 10 ), eqthing( "bunch" )
	{
		itemcount = 0;
	}

	
	bunch( const bunch& b ): autoarray( b ), eqthing( "bunch" )
	{
		itemcount = b.itemcount;
	}

	~bunch()
	{ }

	bunch& operator=( const bunch& b );
	void insert( eqthing* t );
	void remove( eqthing* t );
	void removeall();
	boolean member( eqthing* t ) const;
	void print( ostream& os ) const;
	thing* copy() const;
	eqthing* geti( long i ) const;
	boolean operator==( const eqthing& t ) const;

};

ostream& operator <<( ostream& os, bunch& b);

#endif
