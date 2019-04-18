// pp.cc
//
#include <iostream.h>
#include "bunch.h"
#include "ordbunch.h"

void main(void)
{   cout << '\n';

	
	cout << "bunch operations" << '\n';

	bunch bnch;
	bnch.insert('a');
	 bnch.insert('b');
	  bnch.insert('c');
	bnch.insert('d');
	 bnch.print(cout);
	  cout << '\n';
	bnch.remove('b'); 
	bunch nextbunch = bnch;
	nextbunch.insert('f'); 
	nextbunch.insert('x');
	bnch.print(cout); 
	cout << '\n';
	nextbunch.print(cout); 
	cout << '\n';
	bnch.removeall();
	bnch.print(cout);
	cout << '\n';
 	cout << '\n';
	cout << "Here is an ordbunch testing" << '\n';
	cout << "test 1" << '\n';
	ordbunch ob;
	
	ob.insert('c');
	ob.print(cout);
	ob.removeall();
	ob.print(cout);
	cout << '\n';

	cout << "test 2" << '\n';

	ordbunch ob2;

	ob2.insert('b');
    ob2.insert('l');
    ob2.insert('u');
	ob2.insert('a');
	ob2.print(cout);
	
	cout << ' ' << ob2.itemcount <<'\n';
	
	ordbunch ob3; 
	ob3 = ob2;  
	ob3.insert('g');
	ob3.print(cout);
	cout << ' ' << ob3.itemcount <<'\n';
	
	ordbunch ob4 = ob3;
	ob4.print(cout);cout << ' ' << ob4.itemcount <<'\n';
      
	ob2.removeall();
	ob2.print(cout);
	cout << '\n';



	cout << "** End of program **  " << '\n';
	
}// End of block main
 // End of program **
