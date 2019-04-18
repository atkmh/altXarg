// seq.h 11/5/92

#ifndef SEQ_H
#define SEQ_H

#include "autoarray.h"
#include "mytypes.h"
#include <iostream.h>
#include "eqthing.h"

class seq: public autoarray, public eqthing
{

protected:

	long itemcount;

public:

	seq(): autoarray( sizeof( thing* ), 10, 10 ), eqthing( "seq" )
	{
		itemcount = 0;
	}

	~seq()
	{
	}

	seq( const seq& s ): autoarray( s ), eqthing( "seq" )
	{
		itemcount = s.itemcount;
	}

	seq& operator=( const seq& b );
	void insert( long i, eqthing* t );
	void remove( long i );
	void removeall();
	void print( ostream& os ) const;
	eqthing* geti( long i ) const;
	thing* copy() const;
	boolean operator==( const eqthing& t ) const;
};

ostream& operator<<( ostream& os, seq& s );

#endif
