// testcomplex.cc
// written by Richard Gordon

#include "complex.h"

void main( int argc, char* argv[])
{
	const complex i( 0, 1);

	i.print_paren( cout );
	cout<<'\n';
	i.print_math( cout );
	cout<<'\n';
	complex a(1,1);
	complex b=1/i;
	complex c = a + b * complex(1,-1);
	cout<<"i = "<<i<<'\n';
	cout<<"a = "<<a<<'\n';
	cout<<"b =a "<<a<<'\n';
	cout<<"c = "<<a<<'\n';
	cout<<"d = "<<a<<'\n';
	c = -(a / b) + 2;
	cout<< "c = " << c << '\n';

}


