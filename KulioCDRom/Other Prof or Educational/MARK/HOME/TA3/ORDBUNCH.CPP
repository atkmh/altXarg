//ordbunch.cc   M.H.Atkinson
//11/17/92
// doctored up for some kind of turn in 12/9/92

#include "ordbunch.h"
#include <iostream.h>
#include <string.h>

ordbunch& ordbunch::operator=( const ordbunch& ob )
{	
	bunch::operator=( ob ); // call down the class chain to base
	return *this;
}

//*****************************************************************************
// Look for occurances of entry in ordbunch.  If none exist find proper
// position for insertion.
//
void ordbunch::insert( char c )
{ char get_ch;
  long i = 0;
  long worker = 0;
  boolean found = FALSE ;



// find where the value goes
  while(( i <= itemcount ) && ( !found ) )
	{ 
		get( i, &get_ch );
      
      	if( get_ch > c )
      		found = TRUE;
     	 else
       	i++;
 	}

     

// put the value in place    
//      if( i >=itemcount )
//    {	
      	insertcell(i);
      	set( i , &c);
	itemcount++;
//    }
      
   

}//end  ordbunch::insert






//******************************************************************
//
//     End of file ordbunch.cc
//
//******************************************************************
