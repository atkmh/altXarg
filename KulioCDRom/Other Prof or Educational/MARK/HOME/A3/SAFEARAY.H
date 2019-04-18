// safearray.h 11/4/92

#ifndef SAFEARAY_H
#define SAFEARAY_H

//#include "c:\dev16\projx\wkdir\unsfaray\unsfaray.h" 
#include "unsfaray.h"

class safearay: public unsfaray
{

public:

	safearay( long newcellsize, long newcellcount ): unsfaray( newcellsize, newcellcount )
	{
	}

	safearay& operator=( const safearay& a );
		// copy a to *this

	safearay( const safearay& a ): unsfaray( a )
	{
	}

	~safearay()
	{
		delete [] data;
	}

	void set( long i, void* e );
		// copies e to cell i 
		// if i is out of range an error is generated

	void get( long i, void* e ) const;
		// copies contents of cell i to e
		// if i is out of range an error is generated

//	void print( ostream& os ) const
//	{
//		os << "cannot print an unsfaray";
//	}
	void swap( long i, long j );
		// swaps cells i and j
		// if i or j is out of range an error is generated

	void move( long i, long j );
		// copies cell j to cell i
		// if i or j is  out of range an error is generated

	void deletecell( long i );
		// remove cell i by shifting all greater cells down
		// the cellcount is unchanged
		// if i is  out of range an error is generated

	void insertcell( long i );
		// insert new cell i by shifting all greater cells up
		// the cellcount is unchagned, so last cell is lost
		// if i is  out of range an error is generated
};

#endif
