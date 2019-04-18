// pp.cc
//

#include <stdio.h>
#include <iostream.h>
#include "ordbunch.h"
#include "set.h"
#include "bunch.h"
#define newl '\n'

int main(void)
{
     
    cout << newl << newl;
	cout << "Inserting  c,m,a,l,q,d,5,t,b  in that order" << newl;

	ordbunch ob;
	
	ob.insert('c');
	ob.insert('m');
	ob.insert('a');
    	ob.insert('l');
    	ob.insert('q');
    	ob.insert('d');
    	ob.insert('5');
	ob.insert('t');
	ob.insert('b');
   
	bunch b;
	b.insert('c');
	b.insert('m');
	b.insert('a');
    	b.insert('l');
    	b.insert('q');
    	b.insert('d');
    	b.insert('5');
	b.insert('t');
	b.insert('b');

	set s;
	s.insertelement('c');
	s.insertelement('m');
	s.insertelement('a');
    	s.insertelement('l');
    	s.insertelement('q');
    	s.insertelement('d');
   	s.insertelement('5');
    	s.insertelement('t');
	s.insertelement('b');

	cout <<"ordbunch ob = ";

	ob.print(cout);
	
//cout << ' ' << ob.itemcount;
    	cout << newl;

	cout <<"bunch b = ";
	b.print(cout);
	
//cout << ' ' << b.itemcount;
    	cout << newl;

	cout <<"set s = ";
	s.print(cout);
	
//cout << ' ' << s.itemcount;
    	cout << newl;
	cout<<"test new set s2"<<newl;    

   	set s2 = s;

	cout << "compleated assignment and copy" << newl;

	cout << "Insertelement char 3"<< newl;

	s2.insertelement('3');


	cout << "Insertelement char R"<< newl;


	s2.insertelement('R');

	cout<<"set s2 = ";

	s2.print(cout); cout << newl;

	cout<<"making a copy of b"<<newl;
	cout<<"test new bunch b2"<<newl;

	bunch b2 = b;
	cout<<"copy complete"<<newl;
	cout << "removing char 5"<< newl;
	b2.remove('5');
	cout << "removing char b"<< newl;
	b2.remove('b');
	cout << "removing char c"<< newl;
	b2.remove('c');

	cout<<"bunch b2 = ";

	b2.print(cout);cout << newl;
	
}// End of block main
 // End of program **
