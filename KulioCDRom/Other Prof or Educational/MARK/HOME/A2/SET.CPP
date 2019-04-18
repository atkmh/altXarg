// file name is set.cc
// these are all the member functions for SETS class
/*
        Added to by M. H. Atkinsom

        Last modification:9-29-92
*/  
#include <iostream.h>
#include "set.h"


int SETS::CardFcn( )
{	return Cardinality ;
}
 	
void SETS::CopySet( SETS& S2 ) const // rember there is an implied object S1
{	int i;

	S2.Cardinality = Cardinality;				//  S2.Cardinality = "S1".Cardinality
	for (i=0; i<Cardinality; i++)
		S2.contents[ i ] = contents[ i ];		// S2.contents[ i ] = "S1".contents[ i ];
}

void SETS::DeleteElement( SetElement E )
{	Boolean Found;
	int i;

	Found = FALSE;
	i = 0;
	while ((i < Cardinality) && !Found)
	{// Found = contents[ i ] == E;
	    if(contents[ i ] == E)
	    	Found = TRUE;
		if (!Found)
			i++;
	}
	if (Found)
	{	while (i < Cardinality)
		{	contents[ i ] = contents[ i+1 ];
			i++;
		}
		Cardinality--;
	}
}

void SETS::Difference( SETS S2, SETS& S3) // S1 is implied
{	int i;

	S3.MakeEmpty();
	for (i=0; i<Cardinality; i++)
		if (!S2.Member( contents[ i ] ) )
		{	S3.contents[ S3.Cardinality ] = contents[ i ];
			S3.Cardinality++;
		}
}

Boolean SETS::EqualSet( SETS S2 )// S1 is implied
{	int i;
	Boolean Equal;

	if (Cardinality != S2.Cardinality)
		Equal = FALSE;
	else
	{	Equal = TRUE;  	i = 0;
		while ((i < Cardinality) && Equal)
		{if (!S2.Member( contents[ i ] ))
				Equal = FALSE;
		 i++;
		}
	}
	return( Equal );
}

void SETS::InsertElement( SetElement E  )
{	if (!Member( E ))
		contents[ Cardinality++ ] = E;
}
 
void SETS::Intersection( SETS S2, SETS& S3 )
{	int i;

	S3.MakeEmpty();
	for (i=0; i<S2.Cardinality; i++)
		if (Member( S2.contents[ i ] ))
		{	S3.contents[ S3.Cardinality ] = S2.contents[ i ];
			S3.Cardinality++;
		}
}

void SETS::MakeEmpty() 	// There are no arguments.The object
{  Cardinality = 0  ;         	// is the implied argument 'this'
}

Boolean SETS::Member( SetElement E) const
{	Boolean Found= FALSE;
	int   i=0 ;

	// Found = FALSE;
	// i = 0;
	while ((i < Cardinality) && !Found)
	{//	Found = contents[ i ] == E; 
		if (contents[ i ] == E) 
			Found = TRUE;
		if (!Found)
			i++;
	}
	return( Found );
}

void SETS::PickMember(  SetElement& E)
{
	E = contents[ 0 ];
}

/***************************************************************************************
* SubSet                                               
*                                                            Return boolean 
************************************************************************************** */
Boolean SETS::SubSet( SETS S2 )
{	int i;
	Boolean Sub = FALSE;              // made formal initialization here

	if ( Cardinality > S2.Cardinality)
			return( Sub );                     // with above initialisation removed
	else 											// Sub = FALSE: and substitute return(sub);
	{	
		Sub = TRUE;    
		i = 0;
		while ((i < Cardinality) && Sub)
		{ 
			 if (!S2.Member(contents[ i ] ))
				Sub = FALSE;
			i++;
		} // end while
	} // end else
	return( Sub );
}

void SETS::Union( const SETS& S2, SETS& S3 ) const  
{	int i;
    CopySet( S3);
	for (i=0; i<S2.Cardinality; i++)
		if (!Member( S2.contents[ i ] ))
		{	S3.contents[ S3.Cardinality ] = S2.contents[ i ];
			S3.Cardinality++;
		}
}

void SETS::DisplaySet() const
{   int i = 0;	
	cout << "{ ";
	while(i < Cardinality)
        { cout << contents[i++]; cout << " "; }
	cout << " }";
}

// seta = setb should mean operator=(seta,setb)
   SETS operator<(  SETS& set_a , const SETS& set_b )   
   {     set_b.CopySet( set_a );      //  copy setb onto seta !
  	return set_a ;
   }

SETS operator+( const SETS& sa , SETS& sb)
{  SETS temp;
  sa.Union(sb,temp);
  return temp;
}

SETS operator-(const SETS& set_a, SETS& set_b)
{  SETS temp;
  set_b.Difference( set_a ,temp );
  return temp ;
}

SETS operator*( SETS& a, SETS& b)
{ SETS temp;
  a.Intersection(b,temp);
  return temp;
}

Boolean operator==( SETS& s1, SETS s2  )
{
  return s1.EqualSet(s2); 
}

SETS& operator+( SETS& s1, const SetElement& ch)
{
 s1.InsertElement(ch);
  return s1;
}

SETS& operator-( SETS& s1, const SetElement& ch)
{
  s1.DeleteElement(ch);
  return s1;
}






// ************************************************************
// ******************** END OF FILE SET.CC ********************
// ************************************************************
  
