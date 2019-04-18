// prime02.cpp
// 
// 
      
#include <iostream.h>
#include "set.h"
#define  newln  cout<<'\n'
void proc1();

void main( void ) // 09/10/1007 changed main return type to void     
{ 
 proc1();
}
 
 void proc1()
{
	SETS Set1(333); 
	Set1.DisplaySet(); newln;
	
	char Pchar [] = { "xhis is a test "};   
	
	SETS Set2(Pchar, 7);  
	
	SETS Set3( "Lnother Test", 5);
	
	newln; cout << Set2.CardFcn(); newln;  
	
	SETS setcopy;
	  newln; cout << " set assignment with < "; newln;
	setcopy < Set3;
	setcopy.DisplaySet();
	newln;
	
	Set2.DisplaySet();   
	newln;
	
	Set3.DisplaySet();
	newln;
	
	
	Set1.DisplaySet();
 }