package JM2Test;

public class A2ndMain {

	public static void main(String[] args) {
		
		// Do we have argument
		if (args.length != 0) {
			String matrixA = args[0];
			
			evalArg_0(matrixA);// Exit if wrong
			
			
			for (int i=0 ; i<args.length ; i++) 
				System.out.print(args[i] +" ");
			

			System.out.println("Matrix A: is " + matrixA);
		}
		else {
			System.out.println("Program continues: User will enter all params at runtime.");
			
		}
			
	}
	private static void evalArg_0(String argument_0) {
		if (!argument_0.contains("X")) {
			System.out.println("INPUT ERROR: Usage- NXN Matrix Order ");
			System.out.println(argument_0 +" does not conform.");
			System.out.println("EXITING");
			System.exit(0);
		}
		
	}
}


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




*/