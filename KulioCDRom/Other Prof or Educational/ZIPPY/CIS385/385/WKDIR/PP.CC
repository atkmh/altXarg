// test.cc 10/27/92

#include "character.h"
#include "bunch.h"
#include <iostream.h>
#include <stdio.h>
#define newl '\n'

// ***********************
// prototypes

void testseq();
void testbunch();

int main( void )
{
//	testunsafe();
//	testsafe();
//	testauto();
//	testsequence();

	testbunch();
	
}

void testbunch()
{
    cout << newl << newl;
	cout << "Inserting  c,m,a,l,q,d,5,t,b  in that order" << newl;

	bunch b;

	b.insert(&character('c'));
	b.insert(&character('m'));
	b.insert(&character('a'));
	b.insert(&character('l'));
	b.insert(&character('q'));
	b.insert(&character('d'));
	b.insert(&character('5'));
	b.insert(&character('t'));
	b.insert(&character('b'));

        cout << "test mem thru insert"<<newl;
    b.insert(&character('c'));
	cout<<"bunch b = "<<b<<newl;

	bunch b2=b;
	cout<<"copy complete"<<newl;
	cout<<"removing char 5"<< newl;
	b2.remove( &character('5'));

	cout<<"removing char b"<< newl;
	b2.remove( &character('b'));

	cout<<"removing char c"<< newl;
	b2.remove( &character('c'));

	cout<<"bunch b2 = "<<b2<<newl;;
    cout << "new bunch  z" << newl;
    bunch z = b;
    bunch x = b2;

//    cout << b << newl; 

//    cout << b << newl; 
    
/*
    cout << x << z << newl;


    cout << "Inserting bunch b into z" << newl;

    z.insert( &b);

    cout << "Inserting bunch b2 into z" << newl; 
    z.insert( &b2);

    cout << "printing  z" << newl;
    cout << z << newl;
*/
  }
