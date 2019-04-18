// unsafearray.cc 10/22/92

#include "unsafearray.h"
#include "error.h"
#include <string.h>

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
