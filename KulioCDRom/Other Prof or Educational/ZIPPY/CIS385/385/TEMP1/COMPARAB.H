// comparablething.h 11/4/92

#ifndef COMPARABLETHING_H
#define COMPARABLETHING_H

#include "equatablething.h"

class comparablething: public equatablething
{

public:

	comparablething( char* name):equatablething( name )
	{
	}

	~comparablething()
	{
	}

	virtual boolean operator>( const comparablething& ) const = 0;

	boolean operator>=( const comparablething& t) const
	{
		return *this>t || *this==t;
	}

	boolean operator<( const comparablething& t) const
	{
		return !(*this>=t);
	}

	boolean operator<=( const comparablething& t) const
	{
		return !(*this>t);
	}
};

#endif
