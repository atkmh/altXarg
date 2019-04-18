// charstak.cc
#include "charstak.h"    


// charstak constructor specifics      
//charstak::charstak(int req_size)
//{ if (req_size < 0) 
//	//cout <<"size request less than zero ";   
//  //else
//  {	size = req_size;
//  	stack_point = 0 ;
//  }
//}       
  
charstak::~charstak()
{
 delete [] the_stack ;
}          
  
//Initialization constructor kinda things
       
//charstak::charstak(const charstak &a)
//{	size = a.size;
//	the_stack = new int[size];
//	for (int i= 0; i<size; i++)
//	the_stack[i] = a.the_stack[i];
//}       
       
//void charstak::operator=(const charstack& a) // assignment operator overload
//{ if (size != a.size ) 
//	error( "bad stack size for \"=\" assignment");
 // else
//  //{
//  
//  }
// //
//} 
  

     
void charstak::push( int push_value)
{
 if (push_value > MAXINT|| push_value <0) 
 	cout << "bad value pushed onto the stack"; 
 else
 	the_stack[stack_point++]=push_value;

}  

int charstak::top(void)
{
 return the_stack[stack_point-1];
}  


int charstak::pop(void)
{          
 stack_point--;
 return the_stack[stack_point];
 
}  


//void charstak::error(char [] ) 
//{

//}
//
//
