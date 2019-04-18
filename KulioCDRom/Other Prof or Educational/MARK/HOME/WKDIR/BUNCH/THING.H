// thing.h 11/4/92

#ifndef THING_H
#define THING_H

#include "mytypes.h"
#include <iostream.h>
#include <string.h>

class thing
{

protected:

	char* myclass;

public:

	thing( char* newmyclass )
	{
		myclass = newmyclass;
	}

	virtual ~thing()
	{
	}

	thing( const thing& t )
	{
		myclass = t.myclass;
	}

	virtual char* classname()
	{
		return myclass;
	}

	virtual boolean isa (char* name) const
	{       
		if(strcmp( myclass, name ) == 0)
	       return TRUE;
	    else
	    	return FALSE;
	
	//return strcmp( myclass, name ) == 0;
	}
	virtual void print( ostream& os ) const = 0;
	virtual thing* copy() const = 0;
};

#endif

