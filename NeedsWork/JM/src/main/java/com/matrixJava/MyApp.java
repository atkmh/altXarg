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
			case "showlist": StaticProcedures.showArrayListIndex(); break;

			case "showmap": case "showMap": StaticProcedures.showmap(); break;

			case "scalermult": case "devmult": MatrixScalerMultiplication(); break;

			case "pick": case "setcur": StaticProcedures.PickMatrixFromMainList(); break;

			case "currnullcheck": case "cnc": case "currnull?":
			case "currnull": CurrentNullCheck(); break;

			case "dispm": DisplayCurrentMatrixM(); break;

			case "dispc": DisplayCurrentMatrixC(); break;

			case "dispz": DisplayCurrentMatrixZ(); break;
			
			case "transpose":  break;
			
			case "swaprow": case "swap rows": StaticProcedures.swapMxRows(); break;

			case "ls": case "list": ProgramNotifications.TestRunTimeCommands(); break;

			case "cls": ProgramNotifications.ClearScreen(); break;
			
			case "setdata": case "set data": currentMx.setLinearData(); break;

			case "setrandata": currentMx.setRandData(); break;
		

			case "pop":
				char charRep;
				for (int x = 65; x < 80; x++) {
					charRep = (char) x;
					System.out.println(" value is : " + charRep);
				}
				break;

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
/*
 * Create a Name Char Var
 * Run the MX input routines, 
 * Process creaes a matrix and adds to the HistArrayList
 * Add the HistArrayList to the Runtime ArrayListOfArrayLists
 * 
 * This process puts the new MX away immediately
 * Could factor that out and use elsewhere
 */
//	public static void newMatrix() {
//		myCurChar = (char) charRepToIncrement; // Not a declaration ! runtime Conversion of int to Upper Char
//		String mName = new StringBuilder().append(myCurChar).toString();
//		InputStringObj myInputStringObj;
//		try {
//			myInputStringObj = new InputStringObj("-r", null);
//			InputNumericObj myInputNumericObj = new InputNumericObj(myInputStringObj);
//			ArrayList<Matrix> mxHistArray = new ArrayList<Matrix>();
//			mxHistArray.add(new Matrix(myInputNumericObj, mName));
//			runTimeALOAL.add(mxHistArray);
//			charRepToIncrement++; // do this at the end so that the value is ready next time in.
//		} catch (IOException e) {
//			System.out.println("Exception " + e);
//			e.printStackTrace();
//		}
//	}

//	public static void PickMatrixFromMainList() {
//		System.out.print("Enter Matrix Name Char :");
//		currentName = in.nextLine();
//		for (int x = 0; x < runTimeALOAL.size(); x++) {
//			ArrayList tempAl = runTimeALOAL.get(x);
//			System.out.println("");
//			currentMx = (Matrix) tempAl.get(0);
//			if (currentMx.getName().equals(currentName)) {    x = runTimeALOAL.size(); // we're done  so end the loop
//			} else currentMx = null;
//		}
//		System.out.println("The Mx Name entered was :" + currentName);
//		if (currentMx == null)   System.out.println("But, " + currentName + " wasnt found. Current Mx is still null");
//	}

//	public static void showmap() {
//		Matrix tempshowListMx;
//		System.out.println("");
//		for (int i = 0; i < runTimeALOAL.size(); i++) {
//			for (int j = 0; j < runTimeALOAL.get(i).size(); j++) {
//				tempshowListMx = (Matrix) runTimeALOAL.get(i).get(j);
//				System.out.println(" ----------   ");
//				System.out.println("Modification Command\t :" + tempshowListMx.getModCmd());
//				System.out.println("Modification TimeStamp\t :" + tempshowListMx.getModTimeStamp());
//				System.out.println("Creation Time Stamp\t :" + tempshowListMx.getCreationTimeStamp());
//				tempshowListMx.displayCompact();
//				System.out.println("\n ----------   ");
//			}
//		}
//	}
//	public static void showArrayListIndex() {
//		System.out.println("");
//		System.out.println("main array size: " + runTimeALOAL.size());
//		for (int i = 0; i < runTimeALOAL.size(); i++) {
//			ArrayList tmpAL4Read = runTimeALOAL.get(i);
//			System.out.println("internal size on main #" + i + " is " + tmpAL4Read.size());
//		}
//	}
//	
	
//    public static void 	swapMxRows() {  // Check :  is this done.  Im not putting away
//    	if (currentMx != null) {
//    	System.out.print("first row: ");
//        int firstRow = Integer.parseInt(in.nextLine());
//    	System.out.print("Swap with Row: ");
//        int swapRow = Integer.parseInt(in.nextLine());
//        Matrix tempMX = new Matrix();
//        tempMX = currentMx.SwapRows( firstRow, swapRow);
//        currentMx = tempMX;
//    	} else {
//    		System.out.println("Must Pick a Matrix ");
//    		System.out.println("Then you can swap rows\n");
//    	}
//    }

//	public static void Add2ReturnNew() throws Exception {
//		System.out.println("We'll need the name of two Existing Matrices...");
//		System.out.println("Enter name of first matrix");
//		addendName1 = in.nextLine();
//		System.out.println("Enter name of second matrix");
//		addendName2 = in.nextLine();
//		int found = 0;
//
//		// Need to turn this into a function that returns a Matrix given a name
//
//		for (int x = 0; x < runTimeALOAL.size(); x++) {
//			ArrayList tempAl = runTimeALOAL.get(x);
//			System.out.println("");
//			addendMx1 = (Matrix) tempAl.get(0);
//			if (addendMx1.getName().equals(addendName1)) {// DONE , else
//				System.out.println("Debug: First Mx found at :" + x);
//				x = runTimeALOAL.size();
//				found++;
//			}
//		}
//			
//	if (found < 1) throw new Exception("Matrix Name " +addendName1 +" was not found in Main List");
//		
//		for (int y = 0; y < runTimeALOAL.size(); y++) {
//			ArrayList tempAl = runTimeALOAL.get(y);
//			System.out.println("");
//			addendMx2 = (Matrix) tempAl.get(0);
//			if (addendMx2.getName().equals(addendName2)) { // DONE , else
//				System.out.println("Debug: Second Mx found at :" + y);
//				y = runTimeALOAL.size();
//				found++;
//			} 
//	if (found > 0 && found < 2) throw new Exception("Matrix Name " +addendName2 +" was not found in Main List");
//			
//		}
//		System.out.println("number found: " + found);
//		addendMx1.displayCompact();  // currently this is where the exception is thrown
//		addendMx2.displayCompact();
//		currentMx = addendMx1.Add(addendMx2);
//		currentMx.setName(addendName1 + "+" + addendName2);
//		ArrayList<Matrix> mxTempArray = new ArrayList<Matrix>();
//		mxTempArray.add(currentMx);
//		runTimeALOAL.add(mxTempArray);
//
//	}




	public static void MatrixScalerMultiplication() {
// Check if we are pointing at a current Matrix if so, get scaler value. Echo the scaler entered multiply
// current*Scaler. prepare a temporary Matrix so we can search for new current home get the name of the
// current Mx. Prepare a var for array index of name. start the search. when found - put CurrentMx away
		if (currentMx == null) {
			System.out.println("Current Matrix is not selected.  Pick-A-Matrix");
			return;
		}

		System.out.println("Enter Scaler Value");   scalerValue = Double.parseDouble(in.nextLine());
		System.out.println("Scaler Value entered: " + scalerValue);   
		currentMx = currentMx.Multiply(scalerValue);
		String currentMxName = currentMx.getName();   
		currentMx.setModifyingCommand(currentMxName + "=" + currentMxName + "x where x == " + scalerValue);
		
		Matrix tempMx;
		int rtALOAL_Index = 0;

		for (int i = 0; i < runTimeALOAL.size(); i++) {
			tempMx = (Matrix) runTimeALOAL.get(i).get(0);
			if (currentMxName == tempMx.getName()) {
				rtALOAL_Index = i;
				i = runTimeALOAL.size(); // this should break us out
			}
		}
		System.out.println("The index of the name is :" + rtALOAL_Index);

		ArrayList<Matrix> tempAL = runTimeALOAL.get(rtALOAL_Index); // get a temp ArrayList

		for (int x = tempAL.size(); x < 0; x--) { // iterate thought history copying N to N+1 this is done backwards
			tempAL.add((x + 1), tempAL.get(x));
			System.out.println("copied into " + (x + 1) + "from " + x);
		}
		tempAL.add(0, currentMx);// finish with the zeroth entry
	}



	/*
	 * ***************************************************************************
	 * Current represents a 'Named' Matrix pulled out of the main List if Current is
	 * null the tempMx has not yet been copied out of the main list
	 ******************************************************************************/
	public static void CurrentNullCheck() {
		if (currentMx == null) System.out.println("yes: current is null");
		else  System.out.println(currentMx.getName());
	}

	public static void DisplayCurrentMatrixC() {
		if (currentMx == null) System.out.println("No Matrix currently selected");
		else currentMx.displayCompact();
	}

	public static void DisplayCurrentMatrixM() {
		if (currentMx == null) System.out.println("No Matrix currently selected");
		else currentMx.displayMore();
	}

	public static void DisplayCurrentMatrixZ() {
		if (currentMx == null) System.out.println("No Matrix currently selected");
		else currentMx.displayDeepString();
	}


} // End of class MyApp
