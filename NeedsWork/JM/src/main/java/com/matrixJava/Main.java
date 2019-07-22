package main.java.com.matrixJava;

import java.util.ArrayList;

public class Main {

	static boolean mydebug = false;
	/*
	 * static boolean mydebug = false, orderSet = false; private static int row_m =
	 * 0; private static int col_n = 0; private static String rawOrder = null;
	 * private static int orderProduct = 0; private static ArrayList<Integer>
	 * allRowsData = new ArrayList<Integer>();
	 */
	static String oppMode = null;

	public static void main(String[] args) {
		//ParseInput myPI = new ParseInput();	This was the first pass at parsing input
		ParseInputYA myPIya = new ParseInputYA();//	This is the second pass at parsing input


//		
////	int loopCount = 0, 
//	int allRowsData_index = 0;
////	ArrayList<Integer> allRowsData = new ArrayList<Integer>();
////	int[] allRowsData = null; 
////	int tempInt = 0 ;
//	int x = 0;
////	boolean orderLowXFixed = false; // not sure I can/should use: do I ever know if it was x vs X
//	mydebug = false;
//	orderSet= false;	
//	row_m = 0;
//	col_n = 0;
//	rawOrder = null;
//	orderProduct = 0;
//	
	if (args.length==0) 
{
			System.out.println("No input. See Usage.");
			myPIya.Usage();
		
} // end of if (args.length==0) 
	else 
{  
			myPIya.PIYA(args,mydebug); // Call to ParsInput.java
			System.out.println("oppMode is: " +oppMode);
			
			


	
//	System.out.println("Clearing out the ArrayList<Integer>                       ");
//	allRowsData.clear();	
} // End of class Main
	}
}

/********************************************************************************
 * Program Input Definition: What are the argument data types at the command
 * line
 * 
 * ProgramName: This ClassName Arg1: String - in form " NXN where N is Positive
 * Integer , X is "X" : To start this project N < 4 otherwise thigs will just be
 * stupid : N and N will be the controlling Row and Column Loop controls Arg2:
 * String - in form N where N is integer Arg-: String - in form N where N is
 * integer Arg-: String - in form N where N is integer Arg-: String - in form N
 * where N is integer Arg-
 * 
 * 
 * https://www.oreilly.com/library/view/java-cookbook/0596001703/ch03s05.html //
 * StrCharAt.java String a = "A quick bronze fox leapt a lazy bovine"; for (int
 * i=0; i < a.length( ); i++) System.out.println("Char " + i + " is " +
 * a.charAt(i));
 * 
 * 
 */
//	 int get_line_number() {
//		    List<StackFrame> stack = StackWalker.getInstance(StackWalker.Option.SHOW_HIDDEN_FRAMES).walk((s) -> s.skip(1).collect(Collectors.toList()));
//		    return stack.get(0).getLineNumber();
		//}


