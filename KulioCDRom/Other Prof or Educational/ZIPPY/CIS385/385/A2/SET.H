//set.h
/*
        Added to by M. H. Atkinsom

        Last modification:9-29-92
*/
#ifndef SETS_H
#define SETS_H

#include <iostream.h>
typedef enum{ FALSE,TRUE } Boolean;
typedef char SetElement;

  
class SETS 
{
	const int MAX_CARDINALITY = 256;

	int Cardinality;
	int size;
	SetElement *contents;

public:

	SETS()
	  {
	    Cardinality = 0 ;
	    contents = new SetElement[size = MAX_CARDINALITY];
	  }
		/* default constructor declaration */ 

	SETS(int sz)
	  {
	    Cardinality = 0;
	    contents = new SetElement[size = sz];
	  }

	SETS(char *P, int len)
	{
		Cardinality = 0;
		contents = new SetElement[ len ];
		while( Cardinality < len )
		{	contents[Cardinality++] = (*P)++;
		}
	}



	SETS( const SETS& S )// this takes care of the object that gets
	  {                  // poped off the sack at fcn return.
			       
	    Cardinality = S.Cardinality;
	    contents = new SetElement[ size = S.size ];
	    for( int i = 0; i < Cardinality ; i++ )
	      contents[ i ] = S.contents[ i ];
	  }
	
       int CardFcn( );
                /* Returns the cardinality
                   of implied object S1 */


        void  CopySet( SETS& S2 ) const;
                /* Returns set S2 containing
                 the same elements as
                 the implied set S1 */

	void DeleteElement( SetElement E);
		/* Deletes element E from implied set S 
		   leaving other elements of S unchanged */ 

	void Difference( SETS S2, SETS& S3 );
		/* Returns difference of implied 
		   S1 and S2 (i.e. S1-S2) in S3 */ 

	Boolean EqualSet( SETS S2 );
		/* Returns TRUE if implied S1 
		   equals S2, otherwise returns FALSE */ 

	void InsertElement( SetElement E);
		/* Inserts element E into the
		   implied set S1 leaving other
		   elements unchanged */ 

	void Intersection( SETS S2, SETS& S3 );
		/* Returns intersection of
		   implied S1 and S2 in S3 */ 

	void MakeEmpty();
		/* Returns an empty set */ 

	Boolean Member( SetElement E ) const;
		/* Returns TRUE if E is 
		   a member of implied S, 
		   otherwise returns FALSE */ 

	void PickMember(SetElement& E );
		/* If implied S is not empty,
		   returns a member of implied S
		   as E. E If implied S is empty,
		   returns undefined E. */ 

	Boolean SubSet( SETS S2 );
		/* Returns TRUE if implied S1
		   is a subset of S2, otherwise
		   returns FALSE */ 
	
	void Union( const SETS& S2, SETS& S3 ) const;
		/* Returns union of implied
		   S1 and S2 in S3 */ 
		
	void DisplaySet () const ;
		/* puts out to the screen
		   all the chars in the set */

}; /* end of Class SETS  notice the bracket and semicolon  */


   SETS operator=( SETS& , const SETS& );         // set assignment

   SETS operator+(const SETS&, SETS&);            // set Union

   SETS operator-(const SETS&, SETS&);            // set difference

   SETS operator*( SETS&, SETS& );                // set Intersection

   Boolean operator==( SETS&, SETS );             // set Equality

   SETS& operator+( SETS&, const SetElement&);    // insert char in set

   SETS& operator-( SETS&, const SetElement&);    // delete char from set
 


// ************************************************************
// ******************** END OF FILE SET.h  ********************
// ************************************************************
#endif
