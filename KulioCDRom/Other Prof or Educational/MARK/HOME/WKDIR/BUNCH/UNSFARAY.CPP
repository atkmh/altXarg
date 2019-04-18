// unsafearray.cc 10/22/92

#include "unsfaray.h"
#include "error.h"
//#include <string.h>
#include <memory.h>

unsfaray& unsfaray::operator=( const unsfaray& a )
{
	if (this != &a)
	{
		cellsize = a.cellsize;
		cellcount = a.cellcount;
		delete [] data;
		if (!(data = new char [ cellcount * cellsize ]))
			error( "unsfaray::unsfaray out of memory" );
		memcpy( data, a.data, (size_t)(cellcount * cellsize) );
	}

	return *this;
}

void unsfaray::set( long i, const void* e )
{
	memcpy( (byte*)data + i * cellsize, e, (size_t)cellsize );
}

void unsfaray::get( long i, void* e ) const
{
	memcpy( e, (byte*)data + i * (size_t)cellsize, (size_t)cellsize );
}

void unsfaray::setcellcount( long newcellcount )
{
	if (newcellcount != cellcount)
	{
		void* temp;

		if (!(temp = new byte [newcellcount * cellsize] ))
			error( "unsfaray::setcount out of memory" );

		memcpy( temp, data, (size_t)(newcellcount<cellcount ? newcellcount : cellcount) * (size_t)cellsize );
		cellcount = newcellcount;
		delete [] data;
		data = temp;
	}
}

void unsfaray:: move( long i, long j )
{
	if (i!=j)
		memcpy( (byte*)data + i * (size_t)cellsize, (byte*)data + j * (size_t)cellsize, (size_t)cellsize );
}

long unsfaray::getcellcount( void ) const
{
	return cellcount;
}

void unsfaray::swap( long i, long j )
{
	if (i!=j)
	{
		void* temp;
		if (!(temp = new byte [cellsize] ))
			error( "unsfaray::swap out of memory" );

		void* iloc = (byte*)data + i * cellsize;
		void* jloc = (byte*)data + j * cellsize;

		memcpy( temp, iloc, (size_t)cellsize );
		memcpy( iloc, jloc, (size_t)cellsize );
		memcpy( jloc, temp, (size_t)cellsize );
		delete temp;
	}
}


void unsfaray::deletecell( long i )
{
	memmove( (byte*)data + i * (size_t)cellsize, (byte*)data + (i+1) * (size_t)cellsize, (cellcount-i-1) * (size_t)cellsize);
}

void unsfaray::insertcell( long i )
{
	memmove( (byte*)data + (i+1) * (size_t)cellsize, (byte*)data + i * (size_t)cellsize, (cellcount-i-1) * (size_t)cellsize );
}
