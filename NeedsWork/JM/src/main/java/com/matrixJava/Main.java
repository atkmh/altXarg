package main.java.com.matrixJava;

public class Main {

	public static void main(String[] args) {
	    // I believe this needs to become a something.  What I don't know.
		// I wanted this to be a self contained thing that parses input.
		// Do we have argument
		if (args.length != 0) {
			
			/* Fixing input:  It is just easiest to make this correction here if needed  */
			String matrixA = args[0].replace('x', 'X');
		
			evalArg_0(matrixA);// Determine proper first argument format nXn
			
			/**********************************************************
			 *  Get the first char of first Argument  nXn 
			*/
			int i=0, j, k=0 ;
			while (k < matrixA.length() && matrixA.charAt(k) !='X' ) {
				i =  Character.getNumericValue( matrixA.charAt(k) );
				k++;
			}
			System.out.println("the value of K is: " +k);
			System.out.println("the value of i multiply by 6 is: " +i*6);
		    k=0 ; // reset index
		    
		    // The following is a little bit of a trick using  k++ inside as the charAt(argument)
		    // but it keeps you from having to write it inside the Loop, and once after the loop
		    //

		  while ( ( k < matrixA.length() ) && (matrixA.charAt(k++) !='X')  ) 
		    //{	k++; } /* Advance the index pointing in the string */
		    //k++; /* Advance the index one last time to move past the X or x */
		    	
		    /*  Next two PringLn are debug and testing code */
		    System.out.println("the value of K is: " +k);
		    System.out.println("the char at K is " +matrixA.charAt(k));
		    

		    j = Character.getNumericValue( matrixA.charAt(k) );
			
		    System.out.println("The total number of arguments to parse is : "+i +" x " +j +" = " +i*j);
			
		    /* After correctly parsing the first argument you can tell if the remaining   *
		     * arguments are sufficient to fill our the matrix of order you've identified *
		     *                                                                            */
		    chkArgsLength(args,i, j);
			displayInput(args);
			
			System.out.println("Matrix A: is " + matrixA);
			
			/*
			 * int testR, testC, A, B, C, D, E, F, G, H; testR=3; testC=4; A=22; B=33; C=12;
			 * D=13; E=17; F=11;
			 * 
			 * Matrix testMatrix = new Matrix(i, j, A, B, C, D ); Matrix secTestM = new
			 * Matrix (i,j,i*A,j*B,i*C,j*D);
			 */

		} // first half of if (args.length != 0)
		else {
			System.out.println("Program continues: User will enter all params at runtime.");
			
		}
			  
	}
	private static void chkArgsLength(String[] theArgs, int row, int col) {
		if ( theArgs.length < (row*col)+1 ) {
			System.out.println("The Input length was: " +theArgs.length );
			displayInput(theArgs);
			System.out.println("exiting input to short ");
			System.exit(0);
		}
		
	}
	
	
	private static void displayInput(String[] args) {
		for (int x=0 ; x<args.length ; x++) 
			System.out.print(args[x] +" ");
		System.out.println("");
	}
	
	private static void evalArg_0(String argument_0) {
		
	 /* i need to put in here analysis of the characters in the string.
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
			System.exit(0);
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
				System.exit(0);
			}
		}	
		
		
		
		
	}
	private static void isExxe() {
		
	}// end of isExxe
} // End of Main


/********************************************************************************
Program Input Definition: What are the argument data types at the command line 

ProgramName: This ClassName
Arg1: String - in form " NXN  where N is Positive Integer , X is "X"   
	: To start this project N < 4 otherwise thigs will just be stupid
	: N and N will be the controlling Row and Column Loop controls
Arg2: String - in form N where N is integer
Arg-: String - in form N where N is integer
Arg-: String - in form N where N is integer
Arg-: String - in form N where N is integer
Arg-


https://www.oreilly.com/library/view/java-cookbook/0596001703/ch03s05.html
// StrCharAt.java
String a = "A quick bronze fox leapt a lazy bovine";
for (int i=0; i < a.length(  ); i++)
    System.out.println("Char " + i + " is " + a.charAt(i));


*/