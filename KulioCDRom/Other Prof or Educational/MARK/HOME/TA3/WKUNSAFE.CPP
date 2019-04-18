// tsterror.cpp   
#include "error.h" 
#include <iostream.h>
#include "unsfaray.h"

void main()
{
 
long i_count=1, i_size=16;

unsfaray un_s_a1(sizeof( char ),i_count );  
cout << "un_s_a1.getcellcount() returns ->" ;
cout << un_s_a1.getcellcount()<< '\n';

un_s_a1.setcellcount(i_size); 
cout << "now after setting cellcount to 16"<< '\n';
cout << "un_s_a1.getcellcount() returns ->" ;
cout << un_s_a1.getcellcount()<< '\n';

char ch = 'a';
un_s_a1.set(1,&ch);
ch = 'z'; 
un_s_a1.set(2,&ch);   
ch = 'q'; 
un_s_a1.set(3,&ch);    

char outchar; 

  
   un_s_a1.get(1,&outchar);
   cout <<'\n'<< "outchar=";
   cout  << outchar;  
   
   
   un_s_a1.get(2,&outchar);
    cout <<'\n'<< "outchar=";
   cout  << outchar;  

   un_s_a1.get(3,&outchar);
    cout <<'\n'<< "outchar=";
   cout  << outchar; 
   
   cout <<'\n';
   


// char *p[3]={"yo-mama","mama_yo","yoyo-mama"};
//error(p[0]); 
//  error(p[1]); 
//   error(p[2]);  
 
 error ("simply a quoted string as the argurment to error");
 
}
