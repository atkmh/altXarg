// array.h

#ifndef ARRAY_H
#define ARRAY_H

#include "unsafearray.h"

template <class T>
class array:public unsafearray
{

public:

	array( unsigned long newcellcount ): ( sizeof( T ), newcellcount )
	{
	};

	void set( unsigned long i, const T& const c )
	{
		unsafearray::set( i, &c );
	}

	void get( unsigned long i, T& c ) const
	{
		T dummy;

		unsafearray::get( i, &dummy );
		c = dummy;
	}

	T& operator[] (unsigned long i)
	{
		return *(T*)(data + i * cellsize);
	}

	void print( ostream& os ) const
	{
		T c;
	
		os << "[ ";
		for ( unsigned long int i = 0; i<cellcount; i++ )
		{
			c = (*(array*)this)[ i ];
			os << c;
			if (i < cellcount-1)
			  os << " ";
		}
		os << " ]";
	}
};

//ostream& operator<<( ostream& os, const array<T>& a );


#endif
