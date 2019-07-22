package main.java.com.matrixJava;

import java.util.ArrayList;

public class Main {
	/* *****************************************************************************
	 *  Having a little mental battle about how this program works
	 *  From the command line I'm capable of entering and parsing one matrix of data
	 *  From a File I can see the ablity to put in several matricies
	 *  
	 *  Does the Parse input routine return an object that is passed to the matrix routine ?
	 *  
	 *  Seems like the file input routine could pass properly formed strings to the ParseINput routine
	 *  but that would be from the expectation that the parseinput routine would return Matrix Input objects
	 *  in the manner that Ive been testing with Main.main(new String[] {"2x3", "4", "4","5", "5", "879892349"});
	 *  
	 * 
	 * 
	 */

	static boolean mydebug = false;
	/*
	 * static boolean mydebug = false, orderSet = false; private static int row_m =
	 * 0; private static int col_n = 0; private static String rawOrder = null;
	 * private static int orderProduct = 0; private static ArrayList<Integer>
	 * allRowsData = new ArrayList<Integer>();
	 */
	static String oppMode = null;

	public static void main(String[] args) {
		                //ParseInput myPI = new ParseInput();	This was the first pass at parsing input Keep Historical Sig
		ParseInputYA parseCmdLnInput = new ParseInputYA();//	This is the second pass at parsing input
			if (args.length==0) {
			System.out.println("No input. See Usage.");
			parseCmdLnInput.Usage();
		
		} // end of if (args.length==0) 
		else 
		{  
			parseCmdLnInput.PIYA(args,mydebug); // Call to ParsInput.java
			System.out.println("oppMode is: " +oppMode);
		}
			
			
	} //end public static void main(String[] args)
} // End of class Main

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


