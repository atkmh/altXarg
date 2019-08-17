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
		
		InputStringObj inputoString = null;
		
		
		if (args.length==0)  	// We want null input at command line to indicate 
            firstArg = "null"; 	// that we want runTime data input.  Switch on null
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
			case "null":  // special case: no command line args
				inputoString = new InputStringObj("-r", null);
				System.out.println(inputoString.getFirst());
				System.out.println(inputoString.getSecond());
				System.out.println(inputoString.getdata());
				break; 

			case "-c":
			case "--c":
			case "-cmdline":
			case "--cmdline":
				inputoString = new InputStringObj("-c", args);
				System.out.println(inputoString.getFirst());
				System.out.println(inputoString.getSecond());
				System.out.println(inputoString.getdata());	
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
			//Usage.Usage("Problem: see Input  "+args[0] +" " +args[1] +" " +args[2]  +" etc..."             );	
			String tmp = "";
			for (String s: args) {tmp = tmp+s +" ";}
			Usage.Usage("Problem: see Input  " +tmp );	
		}//end Switch firstArg	
		
			
			
			System.out.println("");
			System.out.println("............");
			System.out.println("Program Done");
	
			//System.exit(0);
	} // end public static void main(String[] args)

} // End of class MyApp














/*
 * *****************************************************************************
 * 
 * 
 * 
 * 
 */
