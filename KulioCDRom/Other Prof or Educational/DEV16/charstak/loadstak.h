//
#include <iostream.h> 
#define MAXINT 65536
#define LOADSTACKSIZE 15

class loaded_stack
{ 
 public: 
	int lsize ;
	int lstack_point;
    int* lthe_stack;
            
// name the constructor
loaded_stack(void)
{   //lstack_point=0;
	//size = LOADSTACKSIZE;
	//lthe_stack = new int[LOADSTACKSIZE];
	//for (int i= 0; i<LOADSTACKSIZE; i++)
       // lthe_stack[i] = i*5;	

}       
   
   
// name the destructor
   ~loaded_stack(void);

	void loaded_top();

}; // end of class loaded_stack

