//  set.h        M.H. Atkinson 11/17/92


#ifndef SET_H

#define SET_H

#include "bunch.h"

#include "mytypes.h"

#include <iostream.h>

/*
	no constructor is required.			It uses the bunch constructor.
	no destructor is required.			It uses the bunch destructor.
	no copy constructor is required.	It used the one in bunch.

*/

class set: public bunch
{

protected:

 
public:
	

	long cardinality () const;
		// Returns the cardinality of set 

	void copyset( const set&  );
		// Copies s to set    

	void deleteelement( const char  );
		// Deletes element e from set  

	set difference( const set&  ) const;
		//   *this-check_set  

	boolean equalsets( const set&  ) const;
		// Returns TRUe if set equals s   

	void insertelement( const char );
		// Inserts e into set   

	set intersection( const set&  ) const;
		// Returns intersection of set and s    

	void makeempty();
		// Makes set empty    

	boolean member( char  ) const;
		// Returns TRUe if e is a member 
		// of set s, otherwise FALse    

	char pickmember() const;
	 	// If set is not empty, returns a member of set    
		// If set is empty, send out of range msg 

	boolean subset( const set&  ) const;
		// Returns TRUe if set is a subset 
		// of s, otherwise FALse    

	set set_union( const set&  ) const;
		// Returns union of set and s    

	void print( ostream&  ) const;
};	
#endif
// *************************************************************
// 
//       this is the end of file set.h
// 
// **************************************************************
