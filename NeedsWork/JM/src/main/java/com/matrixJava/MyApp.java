package main.java.com.matrixJava;

//import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
//import java.io.FileReader;
import java.io.IOException;
//import java.io.InputStream;
//import java.io.InputStreamReader;
//import java.lang.management.ManagementFactory;
//import java.net.URL;
import java.util.ArrayList;
//import java.util.List;
//import java.util.Properties;
import java.util.Scanner;
//import java.util.Set;
//import java.util.concurrent.Executors;

import main.java.com.matrixJava.Usage;

public class MyApp {

//	static boolean mydebug = false;

	// String name = null;
	// String oppMode = null;

	static String runTimeCommand;
	static ArrayList<ArrayList> runTimeALOAL = new ArrayList<ArrayList>();
	static Matrix currentMx = null;
	static String addendName1, addendName2 = null;
	static Matrix addendMx1, addendMx2 = null;
	static String currentName = null;
	static Scanner in = new Scanner(System.in);
	static double scalerValue;

//	int[] matrixDimensions = new int[2];// 2 values M&N both int
//	double[] inputValsPassToMatrix = new double[100];// 9/19/19 I don't think this is used !!
	// Map <String, Matrix> myHashMapListOfMatrix = new HashMap<String,Matrix>();

	static int charRepToIncrement = 65;
//	   char matrixMapKeyName = (char)charRepToIncrement;   // So this Should equal "A"

	static char myCurChar = (char) charRepToIncrement; // So this Should equal "A"
	// I will use String str - Character.toString( matrixMapKeyName) Actuall I'm
	// going to chang those var names

	public static void main(String[] args) throws Exception {
		String firstArg = "";
		InputStringObj myInputStringObj = null;

		if (args == null || args.length == 0) // We want null input at command line to indicate
			firstArg = "null"; // that we want runTime data input. Switch on null
		else
			firstArg = args[0];

		switch (firstArg) // this switch statement only analyzes the first argument
		{
		case "-d":
		case "--d":
		case "-debug":
		case "--debug":
		case "-r":
		case "--r":
		case "-runtime":
		case "--runtime":
		case "null": // special case: no command line args

			/* Can the following two lines be moved down to start of runtime input ??? */
			ProgramNotifications.openingIntroduction(); // Very Brief, one line
			break;

		case "-c":
		case "--c":
		case "-cmdline":
		case "--cmdline":
			myInputStringObj = new InputStringObj("-c", args);
			System.out.println(myInputStringObj.getFirst());
			System.out.println(myInputStringObj.getSecond());
			System.out.println(myInputStringObj.getdata());
			InputNumericObj myNumTest_cl = new InputNumericObj(myInputStringObj);

			// myNumTest_cl.getArrayListData();
			Matrix numObjBasedMatrix_cl = new Matrix(myNumTest_cl, "NameStringForCommandLineOperation");
			numObjBasedMatrix_cl.setName("numObjBasedMatrix_cl");
			numObjBasedMatrix_cl.displayCompact();
			numObjBasedMatrix_cl.displayMore();
			break;

		case "-f":
		case "--f":
		case "-file":
		case "--file":
			// Parsefile();
			// this.oppMode = "ParseFileEntry";
			break;// could be this should be a return cuz we're handing off control...

		case "-h":
		case "--h":
		case "-help":
		case "--help":
		case "-u":
		case "--u":
		case "-usage":
		case "--usage":
			Usage.UsageTerminal(" ");
			break;

		default:
			// Usage.UsageTerminalTerminal("Problem: see Input "+args[0] +" " +args[1] +" "
			// +args[2] +" etc..." );
			String tmp = "";
			for (String s : args) {
				tmp = tmp + s + " ";
			}
			Usage.UsageTerminal("Problem: see Input  " + tmp);
		}// end Switch firstArg

		/*
		 * --------------------------------------------- Start the runtime process got
		 * to read something in
		 * 
		 */

		// String runTimeCommand;

		System.out.print("Let's get the first run time command: ");
		runTimeCommand = in.nextLine();
		// runTimeCommand = runTimeCommand.toLowerCase();
		System.out.println("");

		/*
		 * **************** Char setup A, B, C to be the matrix Names
		 ********/

//	   int charRepToIncrement = 65; 
//	   char matrixMapKeyName = (char)charRepToIncrement;   // So this Should equal "A"

//	   char myCurChar = (char)charRepToIncrement;   // So this Should equal "A"
		// I will use String str - Character.toString( matrixMapKeyName) Actuall I'm
		// going to chang those var names

		while (!runTimeCommand.contentEquals("quit") 
				&& !runTimeCommand.contentEquals("q")
				&& !runTimeCommand.contentEquals("x")) {
			switch (runTimeCommand) {

			case "new": case "new ": StaticProcedures.newMatrix(); break;

			case "add2mx": // Addend + Addend = sum
				           // really should be Add2PutSumAway
                try {
                	StaticProcedures.Add2ReturnNew();
                } catch (Exception e) {
                	System.out.println("Problem Exception " +e);
                	
                }
				
				break;
			
			case "subtractmx":  // Minuend - Subtrahend = Difference
				break;
				
			case "multiplymx" : // Factor X Factor = product
				break;
                             //    4  R2
                             //   | -------
			case "division": //  5| 22       5 Divisor  22 Dividend  4Quotient  2 Remainder
                             //  22/5 = 4R2

			case "transpose":  break;

			case "swaprow": case "swap rows": StaticProcedures.swapMxRows(); break;

			case "showmap": case "showMap": StaticProcedures.showmap(); break;

			case "showlist": StaticProcedures.showArrayListIndex(); break;
			
			case "showhist": StaticProcedures.singleMatrixHist(); break;

			case "scalermult": case "devmult": StaticProcedures.MatrixScalerMultiplication(); break;

			case "pick":  StaticProcedures.PickMatrixFromMainList(); break;

			case "currnullcheck": case "cnc": case "currnull?":
			case "currnull": StaticProcedures.CurrentNullCheck(); break;

			case "dispm": StaticProcedures.DisplayCurrentMatrixM(); break;

			case "dispc": StaticProcedures.DisplayCurrentMatrixC(); break;

			case "dispz": StaticProcedures.DisplayCurrentMatrixZ(); break;
			
			case "ls": case "list": ProgramNotifications.TestRunTimeCommands(); break;

			case "cls": ProgramNotifications.ClearScreen(); break;
			
//			case "setdata": case "set data": currentMx.setLinearData(); break;
			case "setdata": case "set data": currentMx.setLinearData(); break;

			case "setrandata": currentMx.setRandData(); break;
		
			case "pop": break;

			case "classpath":
				String myJCP = System.getProperty("java.class.path");
				System.out.println(" myJCP is " + myJCP);
				break;

			default:
				System.out.println("That command " + runTimeCommand + " was not found, try again");
				System.out.println("");
				runTimeCommand = "ls";
				// runTimeCommand = "quit";
				continue;
			}

			System.out.print("Get another command: ");
			runTimeCommand = in.nextLine();
			/*
			 * *****************************************************************************
			 * ********** Initially this looked like a good idea, but it forces me to only
			 * allow lower case switch commands. But, there is noting keeping me from coding
			 * things with upper case that end up never working...... So.... Let's remove it
			 * allowing all case of chars runTimeCommand = runTimeCommand.toLowerCase();
			 */
		}

		/* As the program comes to an end on shutdown */
		ProgramNotifications.giveShutDownNotice();

	} // end public static void main(String[] args)



} // End of class MyApp
