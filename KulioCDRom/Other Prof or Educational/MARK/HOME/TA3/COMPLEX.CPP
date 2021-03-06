//complex.cc


#include "complex.h"

complex::complex( double r, double i )
{	re = r;
	im = i;
}

complex::complex( double r )
{	re = r;
	im = 0;  // Correction made here  im=0; see page 19 of
}            // from im-0;  10/9/1997       C++ language B.S.

void complex::print_paren( ostream& s) const
{	s<<'('<<re<<','<<im<<')'; 	}

void complex::print_math( ostream& s ) const
{
	if(im == 0)
	  cout<<re;
	else
	{
	  if(re != 0)
	    cout<<re;
	  double temp_im = im;
	  if(temp_im > 0)
	  { if(re != 0 )
		cout<<'+';
	  }
	  else
	  {
 	    if(re !=0 )
		cout<<'-';
	    temp_im = -im;
	  }
	  if(temp_im != 1)
		cout<<temp_im;
	  cout<<'i';
	}
}

complex operator+( complex x, complex y )
{	return complex( x.re + y.re, x.im + y.im );	}


complex operator-( complex x, complex y )
{       return complex( x.re - y.re, x.im + y.im );    }

complex operator-( complex x )
{	return complex( -x.re, -x.im );			}

complex operator*( complex x, complex y )
{  return complex( x.re*y.re - x.im*y.im, x.re*y.im + x.im*y.re );  }


complex operator/( complex x, complex y )
{
   double denom = y.re*y.re + y.im*y.im;

   return complex( (x.re*y.re + x.im*y.im)/ denom , (-x.re*y.im + x.im*y.re)/
	denom );
}

ostream& operator<<( ostream&s, complex x )
{	x.print_math ( s );
	return s;
}


