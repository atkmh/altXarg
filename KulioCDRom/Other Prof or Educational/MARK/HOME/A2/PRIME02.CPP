// prime02.cpp
// 
// 
#include <stdiostr.h>  
#include <iostream.h>
#include "set.h"
#define  newln  cout<<'\n'
void main( void ) // 09/10/1007 changed main return type to void
{
	SETS Set1;
	SETS Set2;
	SETS Set3;
	SETS Set4;
 	SetElement ch;    
 	
 //	ostream& fileout;
 	   
 //	 FILE *stream;
 //	if ((stream = fopen("fileout", "a" )) == NULL)   
 //    printf ( "stream cout was not opened");
 
	cout << "insert a..z"; newln;
	for (ch='a'; ch<='z';ch++) 
		Set1.InsertElement( ch);  
    cout << Set1.CardFcn();  cout << '\n';     
	Set1.DisplaySet();     newln;
    

    cout << "copy set1 onto set2"; newln;
    Set1.CopySet(Set2);     
    
    cout << "\nDeleting elements\n";  
	ch='i';   cout << ch << " ";
	Set2.DeleteElement(ch);          
	ch='o';    cout << ch << " ";
	Set2.DeleteElement(ch);   
	ch='q';    cout << ch << " ";
	Set2.DeleteElement(ch);   
	ch= 'h';    cout << ch << " "; newln;
	Set2.DeleteElement(ch);   
	cout << Set2.CardFcn();  cout << '\n';    
	Set2.DisplaySet();     newln;



	cout << "Preform\n";
	cout << "Set2.MakeEmpty();\n";
	Set2.MakeEmpty();
    
    
    cout << "Preform Set2.InsertElement( ch); for h..o\n";
    for (ch='h'; ch<='o';ch++)
	 Set2.InsertElement( ch);      
	      
  cout << "Preform Set3.InsertElement( ch); for 1..9\n";
    for (ch='1'; ch<='9';ch++)
	 Set3.InsertElement( ch);          
	 
	SETS Setwhat;
    cout << "Preform Setwhat.InsertElement( ch); for 1..9\n";
    for (ch='1'; ch<='9';ch++)
	 Setwhat.InsertElement( ch);    
	 
   SETS SetAgain;
   Set2. Intersection(Setwhat, SetAgain );  
                    
   newln;                    
    SetAgain.DisplaySet();     newln;    
    
    SetAgain.MakeEmpty();
     Set2. Union(Setwhat, SetAgain );  
                    
   newln;                    
    SetAgain.DisplaySet();     newln;      
    
	      
	 if(Set2.EqualSet(Set3)) 
	 	cout << "EqualSet() tested  \n";  
	 	else
	 	cout <<"Failure of EqualSet()";
	 
	cout << "  **************************  \n" ;   
	
	Set4.Union(Set4, Set3); 
	Set4.Union(Set4, Set2); 	
	Set4.DisplaySet();
	cout <<" *\n";
	
    Set2.Intersection(Set3,Set2);      
    Set2. DisplaySet();       
    	cout << "*\n" ;
    Set3. DisplaySet(); 
	 }
