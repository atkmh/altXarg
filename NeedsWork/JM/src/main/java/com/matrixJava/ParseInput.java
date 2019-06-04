package main.java.com.matrixJava;

public class ParseInput {
	
	public void PI(String[] args, boolean mydebug ) {
	String[] myArgs = (args[0].equals("debug")) ? new String[(args.length)-1] : new String[args.length] ;


	if (args[0].equals("debug")){ mydebug = true; 	System.arraycopy(args, 1, myArgs, 0, (args.length)-1);
	} else {/* No debug arg so copy all */			System.arraycopy(args, 0, myArgs, 0, args.length);
	} // end else line above

	if (myArgs.length == 0) {
		if (mydebug)System.out.println("debug: was the only command line argument");
		System.out.println("Program continues: User will enter all params at runtime.");

		/* Here's where I go off to a method in a big user event loop				*/
		/* 																			*/
	} else { /* myArgs.length != 0, so greater than zero.  Real Input !				*/
		/* Fixing input:  It is just easiest to make this correction here if needed	*/
		/* Fixint Input: 	Assumption First argument in form NxM					*/
		/* Fixing INput:	If its a lower x we fix. If not, caught elsewhere		*/
		String matrixA = myArgs[0].replace('x', 'X');/* This is just for uniformity	*/

		/************************************************************************	*/
		/* Determine first argument format nXn for now should limit to 3 chars		*/
		//Main.evalArg_0(matrixA); // check for x check for digits check for len == 3
		evalArg_0(matrixA); // check for x check for digits check for len == 3

		/************************************************************************	*/
		/*	ParsingInput()
		 *  Get the first char of first Argument  nXn 
		 * 
		 * 
		 *																			*/ 

		int i=0, j, k=0 ;
		while (k < matrixA.length() && matrixA.charAt(k) !='X' ) {
			i =  Character.getNumericValue( matrixA.charAt(k) );
			k++;
		}
		if (mydebug ) System.out.println("the value of K is: " +k);
		if (mydebug ) System.out.println("the value of i multiply by 6 is: " +i*6);
		k=0 ; // reset index

		// The following is a little bit of a trick using  k++ inside as the charAt(argument) // but it keeps you from having to write it inside the Loop, and once after the loop
		//

		while ( ( k < matrixA.length() ) && (matrixA.charAt(k++) !='X')  ) 
			//{	k++; } /* Advance the index pointing in the string */
			//k++; /* Advance the index one last time to move past the X or x */

			/*  Next two PringLn are debug and testing code */
			if (mydebug ) System.out.println("the value of K is: " +k);
		if (mydebug ) System.out.println("the char at K is " +matrixA.charAt(k));


		j = Character.getNumericValue( matrixA.charAt(k) );

		if (mydebug ) System.out.println("The total number of arguments to parse is : "+i +" x " +j +" = " +i*j);

		/* After correctly parsing the first argument you can tell if the remaining   *
		 * arguments are sufficient to fill our the matrix of order you've identified *
		 *                                                                            */
		//Main.chkArgsLength(myArgs,i, j);
		chkArgsLength(myArgs,i, j);
		//Main.displayInput(myArgs);
		displayInput(myArgs);

		if (mydebug ) System.out.println("Matrix A: is " + matrixA);
		if (mydebug ) System.out.println("seems as it here is where I could make a call to matrix to do something with this input");

		} //  end of ???
	}// end of method PI Primary method of class ParseInput
	
	public static void chkArgsLength(String[] theArgs, int row, int col) {
		if ( theArgs.length < (row*col)+1 ) {
			System.out.println("The Input length was: " +theArgs.length );
			displayInput(theArgs);
			System.out.println("exiting input to short ");
			//System.exit(0);
		}
	}// end void chkArgslength
	
	
	public static void displayInput(String[] input) {
		System.out.print("Input data: ");
		for (int x=0 ; x<input.length ; x++) 
			System.out.print(input[x] +" ");
		System.out.println("");
	}// end void display
	
	public static void evalArg_0(String argument_0) {
		
		 /* [ late: I've decided not to compltely use this the way originally implemtned.
		  * [ late: if input is less then product of MxN  then complete fill with zeros
		  *  ===========================================================================
		  *  i need to put in here analysis of the characters in the string.
		  *     
		  *  if (Character.isDigit(x)) { // Determines if the specified character is a digit.
		  *  int y = Character.getNumericValue(x); 	//Returns the int value that the 
													//specified Unicode character represents. 
		  * 	System.out.println(y);
		  *  }
	      */

			if (!( argument_0.contains("X") )) {
				System.out.println("INPUT ERROR: Usage- NXN Matrix Order ");
				System.out.println("As the first argument, " +argument_0 +" does not conform to mXn .");
				System.out.println("A key char 'X' was missing from arg[0]");
				System.out.println("EXITING");
				//System.exit(0);
			}
			for (int i=0 ; i<argument_0.length(); i++) {
				char ch = argument_0.charAt(i);
				
				if ( ( Character.isDigit( ch ) || (ch == 'X') )  )
					; // no opp.  I could just negate the if.... hummmmm
				else {
					System.out.println("INPUT ERROR: Usage- NXN Matrix Order ");
					System.out.println("As the first argument, " +argument_0 +" does not conform to mXn .");
					System.out.println("At least one char was not a ditgit in the correct locaion");
					System.out.println("EXITING");
					//System.exit(0);
				}
			}	
			
		}// end of method evalArg_0
	
	
} // end of class
