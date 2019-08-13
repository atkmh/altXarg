package main.java.com.matrixJava;

import java.io.IOException;
import java.util.ArrayList;
import main.java.com.matrixJava.Usage;

public class MyApp {
	/*
	 * *****************************************************************************
	 * [8/8/19 thoughts] OK in MyApp we check argument string We need to handle
	 * -<chcar> or --<char> or --<word> I have a model of that in parseInputYA If
	 * null we go to run time data entry and operation. this is it's own class to
	 * capture data and return back the same way as CmdLineStrObj
	 * 
	 * Follow that with case statement for switches From each case block we make a
	 * processing parse input routine -c <bla bla bla > goes off to the
	 * CmdLineStrObj -r would be same as no arguments, go to runtime parsing routine
	 * -f would be file based input -h is for help. Currently this is just usage -u
	 * is same: Usage
	 * 
	 * Having a little mental battle about how this program works From the command
	 * line I'm capable of entering and parsing one matrix of data From a File I can
	 * see the ablity to put in several matricies
	 * 
	 * Does the Parse input routine return an object that is passed to the matrix
	 * routine ?
	 * 
	 * Seems like the file input routine could pass properly formed strings to the
	 * ParseINput routine but that would be from the expectation that the parseinput
	 * routine would return Matrix Input objects in the manner that Ive been testing
	 * with MyApp.main(new String[] {"2x3", "4", "4","5", "5", "879892349"});
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
	// int size = (args[0].equals("debug")) ? new String[(args.length)-1] : new
	// String[args.length];

	/*
	 * [Late 8/8/19 Thinging]
	 * 
	 * This stuff is going away to be replaced with and object that should be come
	 * part of the matrix Object.
	 */
	String name = null;
	String oppMode = null;

	int[] matrixDimensions = new int[2];// 2 values M&N both int
	double[] inputValsPassToMatrix = new double[100];

	public static void main(String[] args) throws IOException {
		String firstArg = "";
		if (args.length==0) {
            firstArg = "null";
            }
/*			if (args.length==0) {
				RuntimeInStringObj inputString = new RuntimeInStringObj();
				System.out.println(inputString.getFirst());
				System.out.println(inputString.getSecond());
				System.out.println(inputString.getdata());
//			System.out.println("................");
//			System.out.println(inputString.toString());
		 Launch runtime data input 
				
		
			} */
			else   
				firstArg = args[0];
		
			switch (firstArg)  // this switch statement only analyzes the first argument 
			{
				case "-d":
				case "--d":
				case "-debug":
				case "--debug":
					// continue;  	Not continuing
					// no operation :  dropthrough to next 
					// go to runtime operation
				case "-r":
				case "--r":
				case "-runtime":
				case "--runtime":
				case "null":
					RuntimeInStringObj inputoString = new RuntimeInStringObj();
					System.out.println(inputoString.getFirst());
					System.out.println(inputoString.getSecond());
					System.out.println(inputoString.getdata());
					break; 

				case "-c":
				case "--c":
				case "-cmdline":
				case "--cmdline":
					CmdLineInStrObj myCmdLineInput = new CmdLineInStrObj(args);
					
					System.out.println(myCmdLineInput.getFirst());
					System.out.println(myCmdLineInput.getSecond());
					System.out.println(myCmdLineInput.getdata());	
					
					
					System.out.println("backFromParsingcommandLineInput:  Done   ");
					break;
					
				case "-f":
				case "--f":
				case "-file":
				case "--file":
				//Parsefile();
			//	this.oppMode = "ParseFileEntry";
					break ;// could be this should be a return cuz we're handing off control...

				case "-h":
				case "--h":
				case "-help":
				case "--help":
				case "-u":
				case "--u":
				case "-usage":
				case "--usage":
					Usage.Usage(" ");
					break ;

				default: 
					
			}//end Switch firstArg	

			//System.exit(0);
	} // end public static void main(String[] args)

} // End of class MyApp

/*
 * *****************************************************************************
 * ** Program Input Definition: What are the argument data types at the command
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
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 * Second half of the if () else ParseInputTest parseCmdLnInput = new
 * ParseInputTest();// This is the second pass at parsing input Object testObj =
 * parseCmdLnInput.buildIt(args); // Call to ParsInput.java
 * System.out.println("oppMode is: " +oppMode);
 * System.out.println("M, N, and Input is......."); System.out.println("M: "
 * +matrixDimensions[0] + " N: " +matrixDimensions[1] +" InVals "
 * +inputValsPassToMatrix.length); Matrix matrixPOCTest = new
 * Matrix(matrixDimensions[0], matrixDimensions[1],inputValsPassToMatrix);
 * matrixPOCTest.displayC(); matrixPOCTest.displayM();
 * 
 */
