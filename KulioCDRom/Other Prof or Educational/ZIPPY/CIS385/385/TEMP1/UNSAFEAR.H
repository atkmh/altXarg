//unsafearray.h 11/5/92

#ifndef UNSAFEARRAY_H
#define UNSAFEARRAY_H

#include <iostream.h>
#include "error.h"

class unsafearray
{
typedef char byte;			// one byte type

protected:

	void* data;			// allocated memory for cells
	int cellsize;			// bytes per cell
	unsigned long cellcount;	// number of allocated cells

public:

	unsafearray( long newcellsize, long newcellcount )
	{
		cellsize = newcellsize;
		cellcount = newcellcount;
		if ( !(data = new char[ cellcount * cellsize ]))
			error( "unsafearray::unsafearray out of memory" )	;
	}

	unsafearray& operator=( const unsafearray& a );
		// copy a to *this

	unsafearray( const unsafearray& a )
	{
		*this = a;
	}

	virtual ~unsafearray()
	{
		delete [] data;
	}

	void set( long i, const void* e );
		// place element e into cell i

	void get( long i, void* e ) const;
		// place contents of cell i into e

	void setcellcount( long newcount );
		// set cellcount to newcount, retaining as much of
		// previous data as possible

	long getcellcount( void ) const;
		// return cellcount

//	virtual void print( ostream& os ) const
//	{
//		os << "cannot print an unsafearray";
//	}

	void swap( long i, long j );
		// swap contents of cells i and j

	void move( long i, long j );
		// copy contents of cell j to cell i

	void deletecell( long i );
		// remove cell i by shifting all greater cells down
		// the cellcount is unchanged

	void insertcell( long i );
		// insert new cell i by shifting all greater cells up
		// the cellcount is unchagned, so last cell is lost
};

#endif
