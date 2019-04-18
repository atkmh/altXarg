// character.h 11/6/92

#ifndef CHARCHAR_H
#define CHARCHAR_H

#include "compthin.h"
#include "error.h"

class charchar: public compthin
{
protected:

  char data;

public:

	charchar( char c ): compthin( "charchar" )
	{
		data = c;
	}

	charchar( const charchar& c ): compthin( c )
	{
		data = c.data;
	}

	~charchar()
	{
	}

	void print( ostream& os ) const
	{
		os << data;
	}

	boolean operator==( const eqthing& t ) const
	{
		if(t.isa( myclass ) && data == ((const charchar &)t).data) 
			return TRUE;
			
		else return FALSE;
		
		
		//return t.isa( myclass ) && data == ((const charchar &)t).data;
	}

	boolean operator>( const compthin& t) const
	{    boolean equal = TRUE;
	
         if (t.isa( myclass ))
         {
              if(data > ((const charchar &)t).data)
              	return equal;
              else equal= FALSE;
         }
         else
			error( "charchar::operator= cannot compare to non charchar" );
  		return equal;	



		//boolean equal;
		//if (t.isa( myclass ))
		//	equal = data > ((const charchar &)t).data;
		//else
		//	error( "charchar::operator= cannot compare to non charchar" );
  		//return equal;
	}

	thing* copy() const
	{
		return new charchar(*this);
	}
};

ostream& operator<<( ostream& os, const charchar& c );

#endif
