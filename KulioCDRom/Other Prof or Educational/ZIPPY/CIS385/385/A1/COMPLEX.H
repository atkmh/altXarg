//complex.h
//written by Richard Gordon. Entered by M. H. Atkinson

#ifndef COMPLEX_H
#define COMPLEX_H

#include <iostream.h>

class complex  
{
	 double re, im;

	public:
	 //initializer
	 complex( double, double);
	 //float->complex conversion
	 complex( double );

	 //member founctions
	 void print_paren( ostream& s) const;
	 void print_math( ostream& s) const;

	 //friends

         friend complex operator+( complex, complex );
         friend complex operator-( complex, complex );
         friend complex operator-( complex );
         friend complex operator*( complex, complex );
         friend complex operator/( complex, complex );
};//end of class complex

ostream& operator<<( ostream& s, complex x );
#endif
