// autoarray.h 11/4/92
// autoaray.h  09/22/97 MHA

#ifndef AUTOARAY_H
#define AUTOARAY_H

#include "safearay.h"

class autoaray: public safearay
{

protected:

	int increment;

public:

	autoaray( long newcellsize, long newcellcount=0, int newincrement = 10 ): safearay( newcellsize, newcellcount )
	{
		increment = newincrement;
	}

	autoaray( const autoaray& a ): safearay( a )
	{
		increment = a.increment;
	}

	~autoaray()
	{
	}

//	void print( ostream& os ) const
//	{
//		os << "cannot print an autoraray";
//	}

	autoaray& operator=( const autoaray& a );
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
