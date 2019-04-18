// compthing.h 11/4/92

#ifndef compthing_H
#define compthing_H

#include "eqthing.h"

class compthing: public eqthing
{

public:

	compthing( char* name):eqthing( name )
	{
	}

	~compthing()
	{
	}

	virtual boolean operator>( const compthing& ) const = 0;

	boolean operator>=( const compthing& t) const
	{
		return *this>t || *this==t;
	}

	boolean operator<( const compthing& t) const
	{
		return !(*this>=t);
	}

	boolean operator<=( const compthing& t) const
	{
		return !(*this>t);
	}
};

#endif
