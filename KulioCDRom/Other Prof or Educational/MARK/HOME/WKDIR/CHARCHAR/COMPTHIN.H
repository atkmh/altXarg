// compthing.h 11/4/92

#ifndef COMPTHIN_H
#define COMPTHIN_H

#include "eqthing.h"

class compthin: public eqthing
{

public:

	compthin( char* name):eqthing( name )
	{
	}

	~compthin()
	{
	}

	virtual boolean operator>( const compthin& ) const = 0;

	boolean operator>=( const compthin& t) const
	{
	   if(*this>t || *this==t)
	   return TRUE;
	   
	   else
	   return FALSE ;
	
	//	return *this>t || *this==t;
	}                                         

	boolean operator<( const compthin& t) const
	{
		if(*this>=t)  return FALSE;
		
		else return TRUE;
		
		
		//return !(*this>=t);
	}

	boolean operator<=( const compthin& t) const
	{
		   if(*this>t) return FALSE;
		   
		   else return TRUE;
		
		
		
		//return !(*this>t);
	}
};

#endif
