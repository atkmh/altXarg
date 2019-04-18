// array.h

#ifndef ARRAY_H
#define ARRAY_H

//#include "unsafearray.h"

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

// ****************************************************************************

// autoarray.h 11/4/92

#ifndef AUTOARRAY_H
#define AUTOARRAY_H

//#include "safearray.h"

class autoarray: public safearray
{

protected:

	int increment;

public:

	autoarray( long newcellsize, long newcellcount=0, int newincrement = 10 ): safearray( newcellsize, newcellcount )
	{
		increment = newincrement;
	}

	autoarray( const autoarray& a ): safearray( a )
	{
		increment = a.increment;
	}

	~autoarray()
	{
	}

//	void print( ostream& os ) const
//	{
//		os << "cannot print an autorarray";
//	}

	autoarray& operator=( const autoarray& a );
		// copy a to *this

	void set( long i, void* e );
		// copies e to cell i
		// extends the array to hold cell i if needed
	
	void move( long i, long j );
		// copies cell j to cell i
		// extends the array to hold cell i if needed

	void shrinkcellcount( long i );
		// reduces cellcount so that it holds i
		// no reduction is done if i is within increment of cellcount
};

#endif

// ****************************************************************************

// character.h 11/6/92

#ifndef CHARACTER_H
#define CHARACTER_H

//#include "comparablething.h"
//#include "error.h"

class character: public comparablething
{
protected:

	char data;

public:

	character( char c ): comparablething( "character" )
	{
		data = c;
	}

	character( const character& c ): comparablething( c )
	{
		data = c.data;
	}

	~character()
	{
	}

	void print( ostream& os ) const
	{
		os << data;
	}

	boolean operator==( const equatablething& t ) const
	{
		return t.isa( myclass ) && data == ((const character &)t).data;
	}

	boolean operator>( const comparablething& t) const
	{
		boolean equal;

		if (t.isa( myclass ))
			equal = data > ((const character &)t).data;
		else
			error( "character::operator= cannot compare to non character" );

		return equal;
	}

	thing* copy() const
	{
		return new character(*this);
	}
};

ostream& operator<<( ostream& os, const character& c );

#endif

// ****************************************************************************

// comparablething.h 11/4/92

#ifndef COMPARABLETHING_H
#define COMPARABLETHING_H

//#include "equatablething.h"

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

// ****************************************************************************

// complex.h 11/4/92

#ifndef COMPLEX_H
#define COMPLEX_H

//#include "equatablething.h"

class complex: public equatablething
{

protected:

	double re, im;

public:

	complex( double r, double i): equatablething( "complex" )
	{
		re = r;
		im = i;
	}

	complex( double r ): equatablething( "complex" )
	{
		re = r;
		im = 0;
	}

	complex( const complex& c): equatablething( c )
	{
		*this = c;
	}

	void print_paren( ostream& s) const;
	void print_math( ostream& s) const;

	complex operator+( complex );
	complex operator-( complex );
	complex operator-();
	complex operator*( complex );
	complex operator/( complex );

	void print( ostream& s ) const
	{
		print_math( s );
	}

	boolean operator==( const equatablething& c ) const
	{
		return  c.isa( myclass ) && re == ((const complex&)c).re && im == ((const complex&)c).im;
	}

	thing* copy() const
	{
		return new complex( re, im );
	}

};

ostream& operator<<( ostream& s, const complex& x );

#endif

// ****************************************************************************

// equatablething.h 11/4/92

#ifndef EQUATABLETHING_H
#define EQUATABLETHING_H

//#include "thing.h"

class equatablething: public thing
{

public:

	equatablething( char* name ):thing( name )
	{
	}

	~equatablething()
	{
	}

	virtual boolean operator==( const equatablething& ) const = 0;
	boolean operator!=( const equatablething& t ) const
	{
		return !(*this==t);
	}

};

#endif

// ****************************************************************************

// error.h 10/20/92

#ifndef ERROR_H
#define ERROR_H

void error( char* message );

#endif

// ****************************************************************************

// mytypes.h 10/20/92

#ifndef MYTYPES_H
#define MYTYPES_H

typedef enum {FALSE, TRUE} boolean;

#endif

// ****************************************************************************

// safearray.h 11/4/92

#ifndef SAFEARRAY_H
#define SAFEARRAY_H

//#include "unsafearray.h"

class safearray: public unsafearray
{

public:

	safearray( long newcellsize, long newcellcount ): unsafearray( newcellsize, newcellcount )
	{
	}

	safearray& operator=( const safearray& a );
		// copy a to *this

	safearray( const safearray& a ): unsafearray( a )
	{
	}

	~safearray()
	{
		delete [] data;
	}

	void set( long i, void* e );
		// copies e to cell i 
		// if i is out of range an error is generated

	void get( long i, void* e ) const;
		// copies contents of cell i to e
		// if i is out of range an error is generated

//	void print( ostream& os ) const
//	{
//		os << "cannot print an unsafearray";
//	}
	void swap( long i, long j );
		// swaps cells i and j
		// if i or j is out of range an error is generated

	void move( long i, long j );
		// copies cell j to cell i
		// if i or j is  out of range an error is generated

	void deletecell( long i );
		// remove cell i by shifting all greater cells down
		// the cellcount is unchanged
		// if i is  out of range an error is generated

	void insertcell( long i );
		// insert new cell i by shifting all greater cells up
		// the cellcount is unchagned, so last cell is lost
		// if i is  out of range an error is generated
};

#endif

// ****************************************************************************

// sequence.h 11/5/92

#ifndef SEQUENCE_H
#define SEQUENCE_H

//#include "autoarray.h"
//#include "mytypes.h"
#include <iostream.h>
//#include "equatablething.h"

class sequence: public autoarray, public equatablething
{

protected:

	long itemcount;

public:

	sequence(): autoarray( sizeof( thing* ), 10, 10 ), equatablething( "sequence" )
	{
		itemcount = 0;
	}

	~sequence()
	{
	}

	sequence( const sequence& s ): autoarray( s ), equatablething( "sequence" )
	{
		itemcount = s.itemcount;
	}

	sequence& operator=( const sequence& b );
	void insert( long i, equatablething* t );
	void remove( long i );
	void removeall();
	void print( ostream& os ) const;
	equatablething* geti( long i ) const;
	thing* copy() const;
	boolean operator==( const equatablething& t ) const;
};

ostream& operator<<( ostream& os, sequence& s );

#endif

// ****************************************************************************

// thing.h 11/4/92

#ifndef THING_H
#define THING_H

//#include "mytypes.h"
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
		return strcmp( myclass, name ) == 0;
	}
	virtual void print( ostream& os ) const = 0;
	virtual thing* copy() const = 0;
};

#endif

// ****************************************************************************

//unsafearray.h 11/5/92

#ifndef UNSAFEARRAY_H
#define UNSAFEARRAY_H

#include <iostream.h>
//#include "error.h"

class unsafearray
{
typedef char byte;			// one byte type

protected:

	void* data;			// allocated memory for cells
	int cellsize;			// bytes per cell
	unsigned long cellcount;	// number of allocated cells

public:

	unsafearray( long newcellsize, long newcellcount )
	{
		cellsize = newcellsize;
		cellcount = newcellcount;
		if ( !(data = new char[ cellcount * cellsize ]))
			error( "unsafearray::unsafearray out of memory" )	;
	}

	unsafearray& operator=( const unsafearray& a );
		// copy a to *this

	unsafearray( const unsafearray& a )
	{
		*this = a;
	}

	virtual ~unsafearray()
	{
		delete [] data;
	}

	void set( long i, const void* e );
		// place element e into cell i

	void get( long i, void* e ) const;
		// place contents of cell i into e

	void setcellcount( long newcount );
		// set cellcount to newcount, retaining as much of
		// previous data as possible

	long getcellcount( void ) const;
		// return cellcount

//	virtual void print( ostream& os ) const
//	{
//		os << "cannot print an unsafearray";
//	}

	void swap( long i, long j );
		// swap contents of cells i and j

	void move( long i, long j );
		// copy contents of cell j to cell i

	void deletecell( long i );
		// remove cell i by shifting all greater cells down
		// the cellcount is unchanged

	void insertcell( long i );
		// insert new cell i by shifting all greater cells up
		// the cellcount is unchagned, so last cell is lost
};

#endif

































