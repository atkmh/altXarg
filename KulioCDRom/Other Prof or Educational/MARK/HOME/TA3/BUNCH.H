// bunch.h 11/8/92   M.H.Atkinson
// bunch.h 11/14/92

#ifndef BUNCH_H

#define BUNCH_H

#include "autoaray.h"

#include "mytypes.h"

#include <iostream.h>

class bunch: public autoaray
{

public:
	long ipos;     // item position used in finding and deleating
	long itemcount;		// I made this public for debugging help
	              
 	bunch(); 
 	
	~bunch();
	
	bunch( const bunch& b ): autoaray( b )
	{
		itemcount = b.itemcount;
	}

	bunch& operator=( const bunch& b ); 
		// so that we can invoke a copy at declaration
		
	void insert( char c );
		// so that we can put things into out bunch

	
	void find(char c );
		// locate first occurance of argument set ipos
		
			
	void remove( char c );
		// to remove a thing from the bunch
		
	void removeall();
		// to empth the whole bunch all at once
		
	boolean member( char c ) const;
		// for checking if c is in bunch
		
	void print( ostream& os ) const;
		// for printing everything in the bunch
		
	char geti( long i) const;
		// added for the set functions
		
};

#endif
