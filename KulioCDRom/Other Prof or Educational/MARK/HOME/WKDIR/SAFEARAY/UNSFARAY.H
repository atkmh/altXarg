//unsafearray.h 11/5/92

#ifndef UNSFARAY_H
#define UNSFARAY_H

#include <iostream.h>   
#include <string.h>  // added 9/18/1997 to accomodate msvc memmove requirements
#include "error.h"

class unsfaray
{
typedef char byte;			// one byte type

protected:

	void* data;			// allocated memory for cells
//	int cellsize;			// bytes per cell 
  long cellsize;
//	unsigned long cellcount;	// number of allocated cells
  long cellcount;

public:

	unsfaray( long newcellsize,  long newcellcount )
	{
		cellsize = newcellsize;
		cellcount = newcellcount;
		if ( !(data = new char[ cellcount * cellsize ]))
			error( "unsfaray::unsfaray out of memory" )	;
	}

	unsfaray& operator=( const unsfaray& a );
		// copy a to *this

	unsfaray( const unsfaray& a )
	{
		*this = a;
	}

	virtual ~unsfaray()
	{
		delete [] data;
	}

	void set( long i, const void* e );
		// place element e into cell i

	void get( long i, void* e ) const;
		// place contents of cell i into e

	void setcellcount( long newcellcount );  
		// 9/19/1997 changed var name newcount to newcellcount.  MHA
		// set cellcount to newcount, retaining as much of
		// previous data as possible

	long getcellcount( void ) const;
		// return cellcount

//	virtual void print( ostream& os ) const
//	{
//		os << "cannot print an unsfaray";
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
