//test.cc
#include "charstak.h"
#include "loadstak.h" 
#include <iostream.h>
void main()
{ 
//cout << "Helloworld!!!";  
// Declacr an instance of the stack
charstak stack_A(15);    
loaded_stack Lstack(void); 

//stack_A.push(23000);  
  

stack_A.push(23425);
stack_A.push(23555);
stack_A.push(23675);
stack_A.push(23795);
stack_A.push(23825);
stack_A.push(44);     

cout << "here's a look at the top of stack_A ";
cout << stack_A.top() << '\n';   

cout <<"and heres the next value " ;
cout << stack_A.pop() <<  '\n'; 

cout << stack_A.top() << '\n';  
// charstak stack_B = stack_A;
// if(!st.empty())
//    st.pop(&);


// cout << "top of stack_loaded" <<  stack_loaded.the_stack[14] ;



} // end of Main()

