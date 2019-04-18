// set.h 10/22/92
 
#ifndef SET_H
#define SET_H

#include <iostream.h>
#include <string.h>
#include "bunch.h"

const int MAX_CARDINALITY = 256;

class set: public bunch
{

public:

	set(): bunch()
	{
	}

	set( const set& S ): bunch(S)
	{
	}

	set( const char* str )
	{
		long i;
		long len = strlen( str );

		for (i=0; i<len; i++)
			InsertElement( str[ i ] );
	}

	~set()
	{
	}

	long Cardinality () const;
		/* Returns the cardinality of set */ 

	void CopySet( const set& S );
		/* Copies S to set */ 

	void DeleteElement( const char E );
		/* Deletes element E from set */ 

	set Difference( const set& S ) const;
		/* Returns set-S */ 

	boolean EqualSets( const set& S ) const;
		/* Returns TRUE if set equals S */

	void InsertElement( const char E );
		/* Inserts E into set */

	set Intersection( const set& S ) const;
		/* Returns intersection of set and S */ 

	void MakeEmpty();
		/* Makes set empty */ 

	boolean Member( const char E ) const;
		/* Returns TRUE if E is a member of set, otherwise FALSE */ 

	char PickMember() const;
		/* If set is not empty, returns a member of set */ 
		/* If set is empty, returns undefined */ 

	boolean SubSet( const set& S ) const;
		/* Returns TRUE if set is a subset of S, otherwise FALSE */ 

	set Union( const set& S ) const;
		/* Returns union of set and S */ 

	void Print( ostream& ) const;
		/* write out set in the form { e e e e e } */

	set& operator=( const set& T)
	{
		CopySet( T );
		return *this;
	}
};

inline ostream& operator<<( ostream& os, const set& S )
{
	S.Print( os );
	return os;
}
	/* write out set S using the form os << S */

inline const set operator+( const set& S, const set& T )
{
	return S.Union( T );
}

inline const set operator*( const set& S, const set& T )
{
	return S.Intersection( T );
}

inline const set operator-( const set& S, const set& T )
{
	return S.Difference( T );
}

inline const boolean operator<=( const set& S, const set& T )
{
	return S.SubSet( T );
}

inline const boolean operator>=( const set& S, const set& T )
{
	return T.SubSet( S );
}

inline const boolean operator<( const set& S, const set& T )
{
	return S.SubSet( T ) && !S.EqualSets( T );
}

inline const boolean operator>( const set& S, const set& T )
{
	return T.SubSet( S ) && !T.EqualSets( S );
}

inline const boolean operator==( const set& S, const set& T )
{
	return S.EqualSets( T );
}

inline set& operator+( set& S, const char C )
{
	S.InsertElement( C );
	return S;
}

inline set& operator+( set& S, const char* Str )
{
	long StrLen = strlen( Str );

	for (long i = 0; i<StrLen; i++)
		S.InsertElement( Str[ i ] );
	return S;
}

inline set& operator-( set& S, const char C )
{
	S.DeleteElement( C );
	return S;
}

inline boolean operator<( const char C, const set S )
{
	return S.Member( C );
}

inline boolean operator>( const set S, const char C )
{
	return S.Member( C );
}

inline set& operator=( set& S, const set& T)
{
	S.CopySet( T );
	return S;
}

inline set& operator!( set& S )
{
	S.MakeEmpty();
	return S;
}

#endif /* ifndef CHARSET_H */
