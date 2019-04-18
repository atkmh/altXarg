// charstak.h
// #define MAXSTACK 10    // for the time being: why make an initial   // limit to the size of the stack
#include <iostream.h> 
#define MAXINT 65536
#define LOADSTACKSIZE 15
class charstak
{  
 public: 
	int size ;
	int stack_point;
    int* the_stack;
            
// name the constructor
charstak(int a)
{   stack_point=0;
	size = a;
	the_stack = new int[a];
	for (int i= 0; i<a; i++)
		the_stack[i] = 0;
}       
~charstak(void);
//void operator=(const charstak& );	// assignment
//charstak(const charstak& );	// initialization      
void push( int);  //  //	  int empty();// 	  int full();
int top(void);  
int pop( void ); 
// New functin Look reutun an int*
            
};// end of charstak


