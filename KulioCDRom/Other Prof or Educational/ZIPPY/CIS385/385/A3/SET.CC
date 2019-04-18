// set.cc  M.H.Atkinson 11/17/92
// doctored up for some kind of turn in 12/9/92

#include "set.h"
#include <iostream.h>
#include <string.h>

long set::cardinality () const { return itemcount; }

void set::copyset( const set& s ) {  operator=( s ); }

void set::deleteelement( const char e ) { remove(e);}
	
set set::difference( const set& check_set ) const
{
	set rtn_set;
	long card = cardinality();
	char ch;
	
	for(long i=0; i<=card;i++)
	{	
		ch = check_set.geti(i);
	
		if( !(member(ch) ) )
		{	
			rtn_set.insertelement(ch);
		}
	}
	return rtn_set;
}

		
boolean set::equalsets( const set& s ) const
{	boolean eq = TRUE;
	long card,s_card;
	
	//	card = cardinality();		//**** if all this works correctly
	//	s_card = s.cardinality();	// **  swich it all back and 
								//try the other way
	
	if( (card = cardinality()) != s.cardinality())
		return !eq; // return !TRUE == FALSE
	
	else
	{	for(long i=0;i<=card;i++)
		{	if( geti(i) != s.geti(i) )
			{	return !eq; 		// return -> !TRUE == FALSE
				
			} 
		}
	}
	return eq;
} 

void set::insertelement( const char e ) {insert(e);}

set set::intersection( const set& check_set ) const
{
	set rtn_set;
	long card = cardinality();
	char ch;
	
	for(long i=0; i<=card;i++)
	{	
		ch = check_set.geti(i);
	
		if( member(ch)  )
		{	
			rtn_set.insertelement(ch);
		}
	}
	return rtn_set;
}


		
void set::makeempty() { removeall();} // bunch::removeall()

boolean set::member( char ch) const
{	boolean ans = bunch::member(ch);
	return ans;
}

		
char set::pickmember() const { return geti(0); }

		
boolean set::subset( const set& s ) const
{				// we are asking  set s < set this
				//				 s	  subset  this
	boolean ans = TRUE;
	long card, s_card;
	
	//	s_card = s.cardinality();
	//	card = cardinality();
		
	if( (s_card = s.cardinality() ) > cardinality() ) 
		return !ans;
	else
	{	char temp_ch;
		
		for( int i=0; i<= s_card; i++)
		{	temp_ch = s.geti(i);
			if(!member(temp_ch))
				return !ans;
		}
	}
	return ans;
}

set set::set_union( const set& check_set ) const
{
	set rtn_set = *this; 	// put in all of this to start with
							// and then check the check_set for membership
							
	long cs_card = ( check_set.cardinality() - 1 );
	char ch;
	
	
  for(long i=0; i<=cs_card;i++)
  { ch = check_set.geti(i);
//     cout << "getting char " << i << " = " << ch << "from check_set" << '\n';
		//ch = check_set.geti(i);
	
  //    cout << "checking for membership" << '\n';
		if( ! ( rtn_set.member(ch) ) )
		{	//cout << "inserting " << ch << "into rtn_set" << '\n';
			rtn_set.insertelement(ch);
		}
	}
	return rtn_set;
}



void set::print( ostream& os) const
{ bunch::print(os);} // would not work without the bunch::


//************************************************************
//
//        this is the end of file  set.cc
//
//*************************************************************
