// eqthing.h 11/4/92

#ifndef EQTHING_H
#define EQTHING_H

#include "thing.h"

class eqthing: public thing
{

public:

	eqthing( char* name ):thing( name )
	{
	}

	~eqthing()
	{
	}

	virtual boolean operator==( const eqthing& ) const = 0;

	boolean operator!=( const eqthing& t ) const
	{
		  if (*this==t)
		  	return TRUE;
		  	
		  else return FALSE;
		
		//return !(*this==t);
	}

};

#endif
