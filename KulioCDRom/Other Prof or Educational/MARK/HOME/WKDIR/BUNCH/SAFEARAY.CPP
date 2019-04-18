// safearray.cc 10/21/92

#include "safearay.h"

// typedef unsfaray inherited; // previously used as a generic name to indicate
//                                functional origin  

void safearay::set( long i, void* e )
{
	if (i<0 || i>=cellcount)
		error( "safearay::set subscript out of range" );
	//inherited::set( i, e );
	unsfaray::set( i, e );
}

void safearay::get( long i, void* e ) const
{
	if (i<0 || i>=cellcount)
		error( "safearay::get subscript out of range" );
	//inherited::get( i, e ); 
	unsfaray::get( i, e );
}

void safearay::move( long i, long j )
{
	if (i<0 || i>=cellcount || j<0 || j>=cellcount)
		error( "safearay::move subscript out of range" );
	//inherited::move( i, j );
	unsfaray::move( i, j);
}
void safearay::swap( long i, long j )
{
	if (i<0 || i>=cellcount || j<0 || j>=cellcount)
		error( "safearay::swap subscript out of range" );
	//inherited::swap( i, j );
	unsfaray::swap( i, j);
}

void safearay::insertcell( long i )
{
    if (i<0 || i>=cellcount)
       error( "safearay::insertcell subscript out of range" );
    else
       unsfaray::insertcell( i );   //inherited::insertcell( i );

}

void safearay::deletecell( long i )
{
	if (i<0 || i>=cellcount)
		error( "safearay::deletecell subscript out of range" );
	//inherited::deletecell( i );
	unsfaray::deletecell( i );
}

safearay& safearay::operator=( const safearay& a )
{
	//inherited::operator=( a );
	unsfaray::operator=( a );
	return *this;
}

