// test.cc 10/27/92

#include <stdio.h>
#include "character.h"
#include "complex.h"
#include "seq.h"
#define newl '\n'
/* #define printarray( a ) \
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

	// Local Prototypes /
void Pause( void );
void testunsafe( void );
void testsafe( void );
void testauto( void );  */

void testsequence( void );  

int main( void )
{
//	testunsafe();
//	testsafe();
//	testauto();
	testsequence();
}
void testunsafe(void)
{
	unsafearray a( sizeof( char ), 5 );
	
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

	unsafearray b( sizeof(char), 5 );
	b = a;
	//printarray( b );

	b = b;
	//printarray( b );
}

void testsafe( void )
{
	safearray a( sizeof( char ), 5 );
	
	char c = 'c';
	char d = 'd';

	a.set( 3, &c );
	//printarray( a );

//	a.set( 7, &c );
//	//printarray( a );

	a.swap( 3, 4 );
//	a.swap( 3, 7 );
//	a.swap( 8, 4 );
	//printarray( a );

	a.move( 1, 4 );
//	a.move( -1, 4 );
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

void testauto( void )
{
	autoarray a( sizeof( char ), 5 );
	
	char c = 'c';
	char d = 'd';

	a.set( 3, &c );
	//printarray( a );

	a.set( 7, &c );
	//printarray( a );

	a.swap( 3, 4 );
	a.swap( 3, 7 );
//	a.swap( 8, 4 );
	//printarray( a );

	a.move( 1, 4 );
//	a.move( -1, 4 );
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

//	a.insertcell( 20 );
//	//printarray( a );

	autoarray b = a;
	b.set( 0, &d );
	//printarray( b );
	//printarray( a );
	autoarray f( sizeof( char ), 23 );
	f = b;
	//printarray( f );

	//printarray( f )
	f.shrinkcellcount( 1 );
	//printarray( f );

}

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

	/*
		Pauses for user to press RETURN key because CONSOLE
		 window does not scroll.
	
void Pause( void )
{
	char dummy;
	
	cout << '\n';
	cout << "press RETURN to continue." << '\n';
	scanf( "%c", &dummy );
	fflush( stdin );
}
*/
