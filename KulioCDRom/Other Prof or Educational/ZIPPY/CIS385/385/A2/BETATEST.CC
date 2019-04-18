	cout << "Testing MakeEmpty\n";
	cout << "MakeEmpty an uninitialized set.\n";
	Set1.MakeEmpty();
	cout << "S1 = ";
	Set1.DisplaySet();
	cout << " correct result is { }\n";
	cout << "MakeEmpty an initialized and filled set.\n";
	Set1.InsertElement( 'a' );
	Set1.MakeEmpty();
	cout << "S1 = ";
	Set1.DisplaySet();
	cout << " correct result is { }\n";

	
		
	//		Test InsertElement
	//		Insert into an empty set.
	//		Insert a non-member element into a non-empty set.
	//		Insert a member element into a non-empty set.
		
	cout << "\n";
	cout << "Testing InsertElement\n" ;
	cout << "Insert 'a' into an empty set.\n" ;
	Set1.MakeEmpty();
	Set1.InsertElement( 'a' );
	cout << "S1 = " ;
	Set1.DisplaySet();
	cout << " correct result is { a }\n" ;
	cout << "Insert 'b' into { a }.\n" ;



	Set1.InsertElement( 'b' );
	cout << "S1 = " ;
	Set1.DisplaySet();
	cout << " correct result is { a b }\n" ;
	cout << "Insert 'b' into { a b }.\n" ;
	Set1.InsertElement( 'b' );
	cout << "S1 = " ;
	Set1.DisplaySet();
	cout << " correct result is { a b }\n" ;


	//		Test DeleteElement
	//		Delete from an emtpy set.
	//		Delete a non-member element from a non-empty set.
	//		Delete a member element from a non-empty set.


	cout << "\n" ;
	cout << "Testing DeleteElement\n" ;
	cout << "Delete 'a' from an empty set.\n" ;
	Set1.MakeEmpty();
	Set1.DeleteElement( 'a' );
	cout << "S1 = " ;
	Set1.DisplaySet();
	cout << " correct result is { }\n" ;
	cout << "Delete 'a' from an { b }\n" ;
	Set1.InsertElement( 'b' );
	Set1.DeleteElement('a');
	cout << "S1 = " ;
	Set1.DisplaySet();
	cout << " correct result is { b }\n" ;
	cout << "Delete 'b' from an { b }\n" ;
	Set1.DeleteElement( 'b' );
	cout << "S1 = " ;
	Set1.DisplaySet();
	cout << " correct result is { }\n" ;
 
                
	//	Test Member
	//	Check membership in empty set.
	//	Check membership for member element.
	//	Check membership for non-member element.
                
	cout << "\n" ;
	cout << "Testing Member\n" ;
	cout << "Check membership in empty set.\n" ;
	cout << "'a' in { } is %d correct result is 0.\n",Set1.Member('a') ;
	cout << "Check membership for member element.\n";
	Set1.InsertElement('a');
	cout << "'a' in { a } is %d correct result is 1.\n", Set1.Member('a') ;
	cout << "Check membership for non-member element.\n";
	cout << "'b' in { a } is %d correct result is 0.\n", Set1.Member('b') ;
	Pause();

	
	//		Test Cardinality
	//		Check empty set.
	//		Check non-empty set.
	
	cout << "\n" ;
	cout << "Testing Cardinality\n" ;
	cout << "Check empty set.\n" ;
	Set1.MakeEmpty();
	cout << "Cardinality of " ;
	Set1.DisplaySet();
	cout << " = %d correct result is 0\n",Set1.CardFcn() ;
	cout << "Check non-empty set.\n" ;
	Set1.InsertElement( 'a');
	cout << "Cardinality of ";
	Set1.DisplaySet();
	cout << " = %d correct result is 1 ", Set1.CardFcn() ;

		
	//		Test Union, Intersection, Difference
	//		Neither set is empty.
	//		One set is empty.
	//		Both sets are empty.
	

	Set1.MakeEmpty();
	for (ch='a'; ch<='d';ch++)
		Set1.InsertElement( ch);

	Set2.MakeEmpty();
	for (ch='c'; ch<='f';ch++)
		Set2.InsertElement( ch);

	cout << "\n" ;
	cout << "Testing Union Intersection, Difference\n" ;
	cout << "Neither set is empty.\n" ;

	Set1.Union( Set2, Set3);   
	Set1.DisplaySet();
	cout << " + " ;
	Set2.DisplaySet();
	cout << " = " ;
	Set3.DisplaySet();
	cout << " correct result is { a b c d e f }\n" ;

	Set1.Intersection(Set2, Set3);  
	Set1.DisplaySet();
	cout << " * " ;
	Set2.DisplaySet();
	cout << " = " ;
	Set3.DisplaySet();
	cout << " correct result is { c d }\n" ;
	Set1.Difference( Set2, Set3 );  
	Set1.DisplaySet();
	cout << " - " ;
	Set2.DisplaySet();
	cout << " = " ;
	Set3.DisplaySet();
	cout << " correct result is { a b }\n" ;

	Set2.MakeEmpty( );


	cout << "One set is empty..\n" ;

	Set1.Union( Set2, Set3 );
	Set1.DisplaySet();
	cout << "+ " ;
	Set2.DisplaySet();
	cout << " = " ;
	Set3.DisplaySet();
	cout << " correct result is { a b c d }\n" ;

	Set1.Intersection( Set2, Set3 );
	Set1.DisplaySet();
	cout << " * " ;
	Set2.DisplaySet();
	cout << " = " ;
	Set3.DisplaySet();
	cout << " correct result is { }\n" ;


	Set1.Difference( Set2, Set3 );
	Set1.DisplaySet();
	cout << " - " ;
	Set2.DisplaySet();
	cout << " = " ;
	Set3.DisplaySet();
	cout << " correct result is { a b c d }\n" ;

	Set1.MakeEmpty();

	cout << "Both sets are empty.\n" ;

	Set1.Union(  Set2, Set3 );
	Set1.DisplaySet();
	cout << " + " ;
	Set2.DisplaySet();
	cout << " = " ;
	Set3.DisplaySet();
	cout << " correct result is { }\n" ;

	Set1.Intersection(Set2,Set3);
	Set1.DisplaySet();
	cout << " * " ;
	Set2.DisplaySet();
	cout << " = " ;
	Set3 .DisplaySet();
	cout << " correct result is { }\n" ;


	Set1.Difference( Set2,Set3 );
	Set1.DisplaySet();
	cout << " - " ;
	Set2.DisplaySet();
	cout << " = " ;
	Set3.DisplaySet();
	cout << " correct result is { }\n" ;




	//		Test MakeEmpty
	//		MakeEmpty an uninitialized set.
	//		MakeEmpty an initialized and filled set.



	//		Test Subset.


	cout << "\nTesting Subset\n" ;
	Set1.MakeEmpty();
	Set2.MakeEmpty( );
	for (ch='a'; ch<='g';ch++)
		Set1.InsertElement( ch);

	for (ch='c'; ch<='e';ch++)
		Set2.InsertElement( ch);

	cout << "Set1 = "; Set1.DisplaySet(); cout << "\n";
	cout << "Set2 = "; Set2.DisplaySet(); cout << "\n";
	if( Set2.SubSet(Set1) )
		cout << "Set2 is a subset of Set1\n";
	else
		cout << "Set2 is not a subset of Set1\n";

	//
	//		Test EqualSets.
 	//

	cout << "\nTesting EqualSets\n" ;
	Set1.MakeEmpty();
	Set2.MakeEmpty( );
	for (ch='a'; ch<='g';ch++)
		Set1.InsertElement( ch);

	for (ch='a'; ch<='g';ch++)
		Set2.InsertElement( ch);


	cout << "Set1 = "; Set1.DisplaySet(); cout << "\n";
	cout << "Set2 = "; Set2.DisplaySet(); cout << "\n";

	if( Set1.EqualSet(Set2) )
		cout << "Set1 == Set2\n";
	else
		cout << "Error this didn't work right\n";


		//
		//	Testing CopySet
		//


	cout << "\nTesting CopySet\n" ;
	Set2.MakeEmpty( );
	cout << "Set1 = "; Set1.DisplaySet(); cout << "\n";
	cout << "Set2 = "; Set2.DisplaySet(); cout << "\n";
 	
	cout << "Copying Set1 to Set2\n";
	Set1.CopySet(Set2);
	cout << "Set1 = "; Set1.DisplaySet(); cout << "\n";
	cout << "Set2 = "; Set2.DisplaySet(); cout << "\n";	


		//
		//	Testing PickMember
		//


	Set3.MakeEmpty();

        cout << "\nTesting PickMember\n" ;
	cout << "Clearing char ch\n";
	ch = '\0';
	cout << "Set2 = "; Set2.DisplaySet();cout << "\n";
	cout << "ch = Set2.PickMember()\n";
	Set2.PickMember(ch);
	if(ch)
	{ cout << "ch = "; cout << ch; cout << "\n";}
	else cout << "PickMember didn't work right\n";





