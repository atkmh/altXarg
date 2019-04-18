// wksafe.cpp.  
// This file formerly one of the test source files in the wkdir subdir on zippy.
// test.cc 10/27/92
// 
//
// 09/22/97 
// this file now wkauto.cpp

#include <stdio.h>      
#include "unsfaray.h"
#include "safearay.h" 
#include "autoaray.h"
//#include "character.h" 

//#include "complex.h"
//#include "seq.h"
#define newl '\n'    
#define setnewl	cout << newl
 #define printarray( a ) \
 { \
	char d; \
 \
	for( int i = 0; i<a.getcellcount(); i++ ) \
	{ \
		a.get( i, &d ); \
		cout << "a[ " << i << " ] = " << d << newl; \
	} \
}  


#define charset set

	
// Local Prototypes 

//void Pause( void );
//void testunsafe( void );
//void testsafe( void );
//void testsequence( void ); 

void testauto( void ); 

 

void main( void )
{
//	testunsafe();
//	testsafe();
	testauto();
//	testsequence();
}


/***********************************************************
 *  Testunsafe commented out

void testunsafe(void)
{
	unsfaray a( sizeof( char ), 5 );
	
	char c = 'c';
	char d = 'd';

	a.set( 3, &c );
	 //printarray( a );

	a.set( 7, &c );
	 //printarray( a );

	a.swap( 3, 4 );
	 //printarray( a );

	a.move( 1, 4 );
	 //printarray( a );

	a.setcellcount( 3 );
	//printarray( a );

	cout << "cellcount = " << a.getcellcount() << newl;

	a.deletecell( 0 );
	//printarray( a );

	cout << "d = " << d << newl;
	a.set( 2, &d );
	//printarray( a );
	a.insertcell( 0 );
	//printarray( a );

	unsfaray b( sizeof(char), 5 );
	b = a;
	//printarray( b );

	b = b;
	//printarray( b );
}

*  End of Comment out testunsafe
************************************************/


/***********************************************
* Comment out testsafe
void testsafe( void )
{
	safearay a( sizeof( char ), 5 );
	
	char c = 'c';
	char d = 'd';
    cout << "a.set( 3, &c );" ; setnewl;
	a.set( 3, &c );
	//printarray( a );
    
    setnewl;              
    cout << "a.set( 7, &c );"; setnewl;
	a.set( 7, &c );
	//printarray( a ); 
	
	

	
	setnewl;
	cout <<"a.swap( 3, 4 );"; setnewl;
	a.swap( 3, 4 );  //09/21/97 will this error? 

	
	setnewl;
    cout <<"a.swap( 3, 7 );"; setnewl;
	a.swap( 3, 7 );  // this should not

	
	setnewl;
    cout <<"a.swap( 3, 8 );"; setnewl;	
	a.swap( 8, 4 );  // this shoud
	//printarray( a );





	setnewl;
    cout <<"a.move( 1, 4 );"; setnewl;
	a.move( 1, 4 );  
	
	setnewl;
    cout <<"a.move( -1, 4 );"; setnewl;	
	a.move( -1, 4 );
	//printarray( a );

	a.setcellcount( 3 );
	//printarray( a );

	cout << "cellcount = " << a.getcellcount() << newl;

	a.deletecell( 0 );
	//printarray( a );

	cout << "d = " << d << newl;
	a.set( 2, &d );
	//printarray( a );
	a.insertcell( 0 );
	//printarray( a );
      }  
* End of comment out testsafe()
**********************************************/
      
/*********************************************
*
*	Testauto currently being tested
*
*********************************************/
void testauto( void )
{
	autoaray a( sizeof( char ), 5 );
	          
	char c = 'c';
//	char d = 'd';   
    char d;
    
    setnewl;
    cout << "work with Autoaray" ; 
      
  	setnewl;
    cout <<"a.set( 3, &c );"; setnewl;
	a.set( 3, &c );
	printarray( a );

	
	
  	setnewl;
    cout <<"a.set( 7, &c );"; setnewl;	
	a.set( 7, &c );
	printarray( a );   
	
	
	
  	setnewl;
    cout <<"a.swap( 3, 4 );"; setnewl;
	a.swap( 3, 4 );
	
  	setnewl;
    cout <<"a.swap( 3, 7 );"; setnewl;	
	a.swap( 3, 7 );
		
  	setnewl;
    cout <<"a.swap( 8, 4 );"; setnewl;
	a.swap( 8, 4 );
	printarray( a );





  	setnewl;
    cout <<"a.move( 1, 4 );"; setnewl;
    a.move( 1, 4 );
	
  	setnewl;
    cout <<"a.move( -1, 4 );"; setnewl;	
	a.move( -1, 4 );
	//printarray( a );

	
  	setnewl;
    cout <<"a.setcellcount( 3 );"; setnewl;		
	a.setcellcount( 3 );
	printarray( a );

	cout << "cellcount = " << a.getcellcount() << newl;

	
	
  	setnewl;
    cout <<"a.deletecell( 0 );"; setnewl;	
	a.deletecell( 0 );
	printarray( a );

    d='d';
	cout << "d = " << d << newl;


  	setnewl;
    cout <<"a.set( 2, &d );"; setnewl;
	a.set( 2, &d );
	printarray( a );
	
  	setnewl;
    cout <<"a.insertcell( 0 );"; setnewl;
	a.insertcell( 0 );
	printarray( a );

  	setnewl;
    cout <<"a.insertcell( 20 );"; setnewl;
	a.insertcell( 20 );
	printarray( a );



  	setnewl;
    cout <<"autoaray b = a;"; setnewl;  
	autoaray b = a;
	
	
  	setnewl;
    cout <<"b.set( 0, &d );"; setnewl;
	b.set( 0, &d );
	//printarray( b );
	//printarray( a );
	
	
  	setnewl;
    cout <<"	autoaray f( sizeof( char ), 23 );"; setnewl;
	autoaray f( sizeof( char ), 23 );
	
  	setnewl;
    cout <<"f = b;"; setnewl;
	f = b;
	//printarray( f );

	//printarray( f )
	
  	setnewl;
    cout <<"f.shrinkcellcount( 1 );"; setnewl;
	f.shrinkcellcount( 1 );
	//printarray( f );

}  


/*********************************************
*
*	Testsequence commented out.
void testsequence()
{	seq a;

	a.insert( 0, &complex( 1,2 ) );
	a.insert( 1, &complex( 2,5 ) );
	a.insert( 0, &complex( 0, 1 ) );
//	a.insert( 5, &complex( -9 ) );
	a.insert( 1, &character( 'p' ) );
	cout << "a = " << a << newl;

	seq b;
	b.insert( 0, &character( 'h' ) );
	cout << "b = " << b << newl;

	cout << "copy of b" << newl;
	seq c;
	c = b;
	cout << "c = " << c << newl;
	b.insert( 0, &character( '+' ) );
	cout << "c after b changed = " << c << newl;
	thing* t = b.copy();
	t->print( cout );
	cout << newl;

	cout << "b = " << b << "c = " << c << newl;
	cout << "b==c " << (b==c) << newl;
	cout << "b==b " << (b==b) << newl;
	c = b;
	cout << "b = " << b << "c = " << c << newl;
	cout << "b==c " << (b==c) << newl;

	cout << "sequence of sequences" << newl;
	seq z;
	z.insert( 0, &b );
	z.insert( 1, &a );
	cout << z << newl;

	z.removeall();
	z.insert( 0, &complex( 1,9 ) );
	z.insert( 0, &character( 'h' ) );
	cout << z << endl;

	z.remove(0);
	cout<<z<<newl;
}
*/

/**************************************************************
*     Pauses for user to press RETURN key because CONSOLE*
*     window does not scroll.
**************************************************************/	
void Pause( void )
{
	char dummy;
	
	cout << '\n';
	cout << "press RETURN to continue." << '\n';
	scanf( "%c", &dummy );
	fflush( stdin );
}

