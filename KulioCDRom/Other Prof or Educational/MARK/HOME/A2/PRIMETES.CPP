// primetest.cpp
// 
// 
/******************************************************************
	Last modification:9-29-92 

	I have removed the major portion of this program that was 
	the ANSI C conversion to C++.  It compiles and runs, but I
	got tired of waiting for all of it to go by so that I could
	see the code that I had written.  
*/

#include <iostream.h>
#include "set.h"

// Function prototypes
// 	
void DisplaySet( SETS S );
void Pause( void );



void main( void ) // 09/10/1007 changed main return type to void
{
	SETS Set1;
	SETS Set2;
	SETS Set3;
	SETS Set4;
//	const SETS ExtraSet("123459876",9);
	
	SetElement ch;
 	cout << "\n************************  START OF PROGRAM  " ;
	cout << "**************************\n" ;

//	cout << "\n\nExtraSet = "; ExtraSet.DisplaySet(); cout << "\n";

	//
	// Test on operator+
	// Using operator=
	//
  
	for (ch='a'; ch<='g';ch++) 
	 Set1.InsertElement( ch);

	cout << "\nTesting opreator+ on SETS\n" ;
	
	cout << "Preform\n";
	cout << "Set2.MakeEmpty();\n";
	
	Set2.MakeEmpty();
    
    
    cout << "Preform Set2.InsertElement( ch); for h..k\n";
    for (ch='h'; ch<='k';ch++)
	 Set2.InsertElement( ch); 
	
    cout << "Preform ";
	cout << "SETS::CardFcn( ) on Set2 = "; 
	cout << Set2.CardFcn() << '\n'; 
	cout << "Display Set2 \n";
    cout << "Set2 = "; Set2.DisplaySet();cout << "\n";   
    
    cout << " x x x x x x x \n";
 //   if(SET2.CardFcn()==4)
 //   	cout <<
     
    Pause();
// *******************
// MHA  	 

	cout << "Set1 = "; Set1.DisplaySet();cout << "\n";
	cout << "Set2 = "; Set2.DisplaySet();cout << "\n";

	cout << "Set3 = Set1 + Set2\n";
    Set3=Set1+Set2;
	cout << "Set3 = "; Set3.DisplaySet();cout << "\n";

        //
        // Test on operator-
        // Using operator=
    Pause(); 
	cout << "\nTesting operator- on SETS\n";
    cout << "Set1 = "; Set1.DisplaySet();cout << "\n";
    cout << "Set3 = "; Set3.DisplaySet();cout << "\n";	
	Set4=Set1-Set3;
	cout << "Set4=Set1-Set3.\n";
	cout << "Set4 = ";  Set4.DisplaySet();   cout << '\n';
    cout << "Set2 = ";  Set2.DisplaySet();   cout << "\n";


	// Test on operator==

    cout << "\nTesting operator== on SETS\n\n";
	cout << "if( Set2 == Set4 ) then\n";
	if(Set2==Set4)
	  cout << "The operator == worked properly\n";
	else 
	  cout << "I didn't work right\n";

	cout << "\nTesting SET operator+ on SETS and char\n\n";
	cout << "Set2+'a'+'b'+'c'+'l'+'m'+'p'\n";
	Set2+'a'+'b'+'c'+'l'+'m'+'p';
	cout << "Set2 = "; Set2.DisplaySet();cout << "\n";

        cout << "\nTesting SET operator- on SETS and char\n\n";
	cout << "Set2-'k'\n";
        Set2-'k';
        cout << "Set2 = "; Set2.DisplaySet();cout << "\n";


	cout << "\nTesting SET operator* on SETS\n\n";
	cout << "Set3 = ";  Set3.DisplaySet(); cout << "\n";
	cout << "Set1 = Set3 * Set2\n";
        Set1=Set3*Set2;
        cout << "Set1 = "; Set1.DisplaySet();cout << "\n";


	cout << "\n************************  END OF PROGRAM  " ;
	cout << "**************************\n" ;

}  // *********** End of main()  ***************


	/*
  Pauses for user to press RETURN key because CONSOLE window does not scroll.
	*/
void Pause( void )
{
	char dummy;
	
	cout << "\n" ;
	cout << "press 'm' RETURN  to continue .\n" ;
	cin >> dummy ;  
	while( dummy != 'm') 
	  ;
}
