// array.cc

#include "all.h"
//#include "array.h"

//#include "error.h"


typedef unsafearray inherited;
/*
template <class T>
void array<T>:: set( unsigned long i, const T& const c )
{
	inherited::set( i, &c );
}

template <class T>
void array<T>::get( unsigned long i, T& c ) const
{
	T dummy;

	inherited::get( i, &dummy );
	c = dummy;
}

template <class T>
T& array<T>::operator[] (unsigned long i)
{
	return *(T*)(data + i * cellsize);
}

template <class T>
void array<T>::print( ostream& os ) const
{
	T c;

	os << "[ ";
	for ( unsigned long int i = 0; i<cellcount; i++ )
	{
		c = (*(array<T>*)this)[ i ];
		os << c;
		if (i < cellcount-1)
		  os << " ";
	os << " ]";
}

ostream& operator<<( ostream& os, const array<T>& a )
{
	a.print( os );
	return os;
}
*/


// ****************************************************************************

// autoarray.cc 10/21/92

//#include "autoarray.h"

typedef safearray inherited;

void autoarray::set( long i, void* e )
{
	if (i>=cellcount)
		setcellcount( i+1+increment );
	inherited::set( i, e );
}

void autoarray::move( long i, long j )
{

	if (i>=cellcount)
		setcellcount( i+1+increment );
	inherited::swap( i, j );
}

void autoarray::shrinkcellcount( long i )
{
	if (i < cellcount-increment-1)
		setcellcount( i+1 );
}

autoarray& autoarray::operator=( const autoarray& a )
{
	inherited::operator=( a );
	increment = a.increment;
	return *this;
}


// ****************************************************************************


// character.cc 11/4/92

//#include "character.h"

ostream& operator<<( ostream& os, const character& c )
{
	c.print( os );
	return os;
}

// ****************************************************************************


// comparablething.cc 10/26/92

//#include "comparablething.h"


// complex.cc 10/24/92

//#include "mytypes.h"
//#include "complex.h"

void complex::print_paren( ostream& s ) const
{
    s << '(' << re << ',' << im << ')';
}

void complex::print_math( ostream& s ) const
{
  if (im == 0)
    cout << re;
  else
  {
    if (re != 0)
      cout << re;
    double temp_im = im;
    if (temp_im >0)
    {
      if (re != 0)
	cout << '+';
    }
    else
    {
      cout << '-';
      temp_im = -im;
    }
    if (temp_im !=1)
      cout << temp_im;
    cout << 'i';
  }
}

complex complex::operator+( complex z )
{
	return complex( re+z.re, im+z.im );
}

complex complex::operator-( complex z )
{
	return complex( re-z.re, im-z.im );
}

complex complex::operator-()
{
	return complex( -re, -im );
}

complex complex::operator*( complex z )
{
	return complex( re*z.re-im*z.im, re*z.im+im*z.re );
}

complex complex::operator/( complex z )
{
	double denom = z.re*z.re+z.im*z.im;

	return complex( (re*z.re+im*z.im)/denom, (-re*z.im+im*z.re)/denom );
}

ostream& operator<<( ostream& s, const complex& x )
{
	x.print( s );
	return s;
}


// ****************************************************************************


// equatablething.cc 10/26/92

//#include "equatablething.h"
// error.cc 10/20/92

//#include <iostream.h>
//#include <stdlib.h>
//#include "error.h"

#define newl '\n'

void error( char* message )
{
	cerr << message << newl;
	exit( 1 );
}
// safearray.cc 10/21/92

//#include "safearray.h"

typedef unsafearray inherited;

void safearray::set( long i, void* e )
{
	if (i<0 || i>=cellcount)
		error( "safearray::set subscript out of range" );
	inherited::set( i, e );
}

void safearray::get( long i, void* e ) const
{
	if (i<0 || i>=cellcount)
		error( "safearray::get subscript out of range" );
	inherited::get( i, e );
}

void safearray::move( long i, long j )
{
	if (i<0 || i>=cellcount || j<0 || j>=cellcount)
		error( "safearray::move subscript out of range" );
	inherited::move( i, j );
}
void safearray::swap( long i, long j )
{
	if (i<0 || i>=cellcount || j<0 || j>=cellcount)
		error( "safearray::swap subscript out of range" );
	inherited::swap( i, j );
}

void safearray::insertcell( long i )
{
	if (i<0 || i>=cellcount)
		error( "safearray::insertcell subscript out of range" );
	inherited::insertcell( i );
}

void safearray::deletecell( long i )
{
	if (i<0 || i>=cellcount)
		error( "safearray::deletecell subscript out of range" );
	inherited::deletecell( i );
}

safearray& safearray::operator=( const safearray& a )
{
	inherited::operator=( a );
	return *this;
}


// ****************************************************************************


// sequence.cc 11/5/92

//#include "sequence.h"
//#include <string.h>
//#include "error.h"

typedef autoarray inherited;

void sequence::insert( long i, equatablething* t )
{
	if (0 <= i && i <= itemcount )
	{
		thing* temp = t->copy();
	  
		insertcell( i );
		set( i, &temp );
		itemcount++;
	}
	else
		error( "sequence::insert index out of bounds" );
}

void sequence::remove( long i )
{
	thing* temp;

	if (0 <= i && i < itemcount )
	{
		temp = geti( i );
		delete temp;
		deletecell( i );
		itemcount--;
		shrinkcellcount( itemcount );
	}
	else
		error( "sequence::remove index out of bounds" );
}

void sequence::removeall()
{
	long int i;
	thing* temp;

	for (i=0; i<itemcount; i++)
	{
		temp = geti( i );
		delete temp;
	}

	itemcount = 0;
	shrinkcellcount( 0 );
}

void sequence::print( ostream& os ) const
{
	long int i;
	thing* temp;

	os << "{ ";
	for (i=0; i<itemcount; i++)
	{
		get( i, &temp );
		temp->print( os );
		if (i < itemcount-1)
			os << ' ';
	}
	os << " }";
}

equatablething* sequence::geti( long i) const
{
	equatablething* t;
	if (0 <= i && i < itemcount )
		get( i, &t );
	else
		error( "sequence::geti index out of bounds" );
	return t;
}

sequence& sequence::operator=( const sequence& s )
{
	inherited::operator=( s );
	itemcount = 0;
	for (long i = 0; i<s.itemcount; i++)
	{
		equatablething* tp;

		tp = (equatablething*) (s.geti( i ));
		insert( i, tp );
	}

	return *this;
}

thing* sequence::copy() const
{
	sequence* sp = new sequence;

	*sp = *this;

	return sp;
}

ostream& operator<<( ostream& os, sequence& s )
{
	s.print( os );
	return os;
}

boolean sequence::operator==( const equatablething& t ) const
{
	boolean equal;

	if (this == &t)
		equal = TRUE;
	else if (t.isa( myclass ))
	{
		if (itemcount == ((sequence*)&t)->itemcount)
		{
			equal = TRUE;
			for (long i = 0; (i<itemcount) && equal; i++)
				if (*geti( i ) != *(((sequence*)&t)->geti( i )))
					equal = FALSE;
		}
		else
			equal = FALSE;
	}
	else
		equal = FALSE;
	return equal;
}


// ****************************************************************************

// thing.cc 11/4/92

//#include "thing.h"



// ****************************************************************************


// unsafearray.cc 10/22/92

//#include "unsafearray.h"
//#include "error.h"
//#include <string.h>

unsafearray& unsafearray::operator=( const unsafearray& a )
{
	if (this != &a)
	{
		cellsize = a.cellsize;
		cellcount = a.cellcount;
		delete [] data;
		if (!(data = new char [ cellcount * cellsize ]))
			error( "unsafearray::unsafearray out of memory" );
		memcpy( data, a.data, cellcount * cellsize );
	}

	return *this;
}

void unsafearray::set( long i, const void* e )
{
	memcpy( (byte*)data + i * cellsize, e, cellsize );
}

void unsafearray::get( long i, void* e ) const
{
	memcpy( e, data + i * cellsize, cellsize );
}

void unsafearray::setcellcount( long newcellcount )
{
	if (newcellcount != cellcount)
	{
		void* temp;

		if (!(temp = new byte [newcellcount * cellsize] ))
			error( "unsafearray::setcount out of memory" );

		memcpy( temp, data, (newcellcount<cellcount ? newcellcount : cellcount) * cellsize );
		cellcount = newcellcount;
		delete [] data;
		data = temp;
	}
}

void unsafearray:: move( long i, long j )
{
	if (i!=j)
		memcpy( data + i * cellsize, data + j * cellsize, cellsize );
}

long unsafearray::getcellcount( void ) const
{
	return cellcount;
}

void unsafearray::swap( long i, long j )
{
	if (i!=j)
	{
		void* temp;
		if (!(temp = new byte [cellsize] ))
			error( "unsafearray::swap out of memory" );

		void* iloc = data + i * cellsize;
		void* jloc = data + j * cellsize;

		memcpy( temp, iloc, cellsize );
		memcpy( iloc, jloc, cellsize );
		memcpy( jloc, temp, cellsize );
		delete temp;
	}
}

void unsafearray::deletecell( long i )
{
	memmove( data + i * cellsize, data + (i+1) * cellsize, (cellcount-i-1) * cellsize);
}

void unsafearray::insertcell( long i )
{
	memmove( data + (i+1) * cellsize, data + i * cellsize, (cellcount-i-1) * cellsize );
}























