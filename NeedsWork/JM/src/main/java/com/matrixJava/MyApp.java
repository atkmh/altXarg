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
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;

import main.java.com.matrixJava.Usage;

public class MyApp {

//	static boolean mydebug = false;

	// String name = null;
	// String oppMode = null;

	static String runTimeCommand;
	static ArrayList<ArrayList> runTimeALOAL = new ArrayList<ArrayList>();
	static Matrix currentMx, tempMx = null;
	static String addendName1, addendName2 = null;
	static Matrix addendMx1, addendMx2 = null;
	static String currentName = null;
	static Scanner in = new Scanner(System.in);
	static double scalerValue;
	static int roboSequence = 0;
	static boolean roboSwitch = false;

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

		case "-robo":
			roboSwitch = true;
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
		if (roboSwitch) {
		RT0();
		//MyApp.roboSequence++;
		}
		
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

			case "new": case "new ": 
                if(MyApp.roboSwitch)
                StaticProcedures.newMatrix();
               
                else 
                StaticProcedures.newMatrix();
                break; 

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
			case "setdata": case "set data": StaticProcedures.SetMxDataLinear(); break;

			case "setrandata": currentMx.setRandData(); break;
		
			case "pop": StaticProcedures.pushHistory(currentMx); break;

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
			if (roboSwitch)
				switch(roboSequence) {
				case 0 : MyApp.RT0(); /*MyApp.roboSequence++;*/ break;// 'new' 
				case 1 : MyApp.RT1(); /*MyApp.roboSequence++;*/ break;// '3x4 <enter>' 
				case 2 : MyApp.RT2(); /*MyApp.roboSequence++;*/ break;// '3 3.017 3 9' 
				case 3 : MyApp.RT3(); /*MyApp.roboSequence++;*/ break; 
				case 4 : MyApp.RT4(); /*MyApp.roboSequence++;*/ break; 
				case 5 : MyApp.RT5(); /*MyApp.roboSequence++;*/ break; 
				case 6 : MyApp.RT6(); /*MyApp.roboSequence++;*/ break; 
				case 7 : MyApp.RT7(); /*MyApp.roboSequence++;*/ break; 
				case 10 : MyApp.RT10(); break; 
				case 12 : MyApp.RT12(); break; 
				
				default: System.out.println("NoRoboSequence Left : Seq Val "+MyApp.roboSequence);
				break;
				}
							
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

	
//  ROBOT TESTING Procs
	public static void RT0() throws AWTException {
		Robot myR = new Robot();
		myR.delay(500);
        myR.keyPress(KeyEvent.VK_N);
        myR.keyRelease(KeyEvent.VK_N);
        myR.keyPress(KeyEvent.VK_E);
        myR.keyRelease(KeyEvent.VK_E);
        myR.keyPress(KeyEvent.VK_W);
        myR.keyRelease(KeyEvent.VK_W);
		myR.delay(250);
        myR.keyPress(KeyEvent.VK_ENTER);
        myR.keyRelease(KeyEvent.VK_ENTER);MyApp.roboSequence++;
	}

	
	public static void RT1() throws AWTException {
		Robot myR = new Robot();
		//System.out.println("delay 500");
		myR.delay(500);
        myR.keyPress( KeyEvent.VK_3);
        myR.keyRelease(KeyEvent.VK_3);
        myR.keyPress(KeyEvent.VK_X);
        myR.keyRelease(KeyEvent.VK_X);
        myR.keyPress( KeyEvent.VK_4);
        myR.keyRelease(KeyEvent.VK_4);
		myR.delay(250);
        myR.keyPress(KeyEvent.VK_ENTER);
        myR.keyRelease(KeyEvent.VK_ENTER);MyApp.roboSequence++;
	}
		
		
	public static void RT2() throws AWTException {
		Robot myR = new Robot();
		myR.delay(500);
        myR.keyPress( KeyEvent.VK_3);
        myR.keyRelease(KeyEvent.VK_3);

        myR.keyPress( KeyEvent.VK_SPACE);
        myR.keyRelease(KeyEvent.VK_SPACE);
        
        
        myR.keyPress( KeyEvent.VK_3);
        myR.keyRelease(KeyEvent.VK_3);
        myR.keyPress( KeyEvent.VK_PERIOD);
        myR.keyRelease(KeyEvent.VK_PERIOD);
        myR.keyPress( KeyEvent.VK_0);
        myR.keyRelease(KeyEvent.VK_0);
        myR.keyPress( KeyEvent.VK_1);
        myR.keyRelease(KeyEvent.VK_1);
        myR.keyPress( KeyEvent.VK_7);
        myR.keyRelease(KeyEvent.VK_7);
        
        myR.keyPress( KeyEvent.VK_SPACE);
        myR.keyRelease(KeyEvent.VK_SPACE);

        myR.keyPress( KeyEvent.VK_3);
        myR.keyRelease(KeyEvent.VK_3);

        myR.keyPress( KeyEvent.VK_SPACE);
        myR.keyRelease(KeyEvent.VK_SPACE);

        myR.keyPress( KeyEvent.VK_9);
        myR.keyRelease(KeyEvent.VK_9);

        myR.keyPress( KeyEvent.VK_SPACE);
        myR.keyRelease(KeyEvent.VK_SPACE);
        
        myR.delay(250);
        myR.keyPress(KeyEvent.VK_ENTER);
        myR.keyRelease(KeyEvent.VK_ENTER);MyApp.roboSequence++;
	}
		
		
		
	public static void RT3() throws AWTException {
		MyApp.RT0(); //MyApp.roboSequence++;

	}
		

		
	public static void RT4() throws AWTException {

		MyApp.RT1();//MyApp.roboSequence++;
	}
		
		
		
	public static void RT5() throws AWTException {
		MyApp.RT2();//MyApp.roboSequence++;
	}

	public static void RT6() throws AWTException {
	//"showmap"	
		Robot myR = new Robot();
		myR.delay(500);
        myR.keyPress(KeyEvent.VK_S);
        myR.keyRelease(KeyEvent.VK_S);
        myR.keyPress(KeyEvent.VK_H);
        myR.keyRelease(KeyEvent.VK_H);
        myR.keyPress(KeyEvent.VK_O);
        myR.keyRelease(KeyEvent.VK_O);
        myR.keyPress(KeyEvent.VK_W);
        myR.keyRelease(KeyEvent.VK_W);
        myR.keyPress(KeyEvent.VK_M);
        myR.keyRelease(KeyEvent.VK_M);
        myR.keyPress(KeyEvent.VK_A);
        myR.keyRelease(KeyEvent.VK_A);
        myR.keyPress(KeyEvent.VK_P);
        myR.keyRelease(KeyEvent.VK_P);
		myR.delay(250);
        myR.keyPress(KeyEvent.VK_ENTER);
        myR.keyRelease(KeyEvent.VK_ENTER);MyApp.roboSequence++;
	}
		
	public static void RT7() throws AWTException {
         MyApp.RT0();		
	}

	public static void RT8() throws AWTException {
	//MyApp.RT2();//MyApp.roboSequence++;
		Robot myR = new Robot();
		//System.out.println("delay 500");
		myR.delay(500);
        myR.keyPress( KeyEvent.VK_6);
        myR.keyRelease(KeyEvent.VK_6);
        myR.keyPress(KeyEvent.VK_X);
        myR.keyRelease(KeyEvent.VK_X);
        myR.keyPress( KeyEvent.VK_6);
        myR.keyRelease(KeyEvent.VK_6);
		myR.delay(250);
        myR.keyPress(KeyEvent.VK_ENTER);
        myR.keyRelease(KeyEvent.VK_ENTER);MyApp.roboSequence++;
	}


	public static void RT9() throws AWTException {
		Robot myR = new Robot();
		//System.out.println("delay 500");
		myR.delay(500);
        myR.keyPress( KeyEvent.VK_0);
        myR.keyRelease(KeyEvent.VK_0);
		myR.delay(250);
        myR.keyPress(KeyEvent.VK_ENTER);
        myR.keyRelease(KeyEvent.VK_ENTER);MyApp.roboSequence++;
	}

	public static void RT10() throws AWTException {
		Robot myR = new Robot();
		//System.out.println("delay 500");
		myR.delay(500);
		 myR.keyPress(KeyEvent.VK_P);
	        myR.keyRelease(KeyEvent.VK_P);
	        myR.keyPress(KeyEvent.VK_I);
	        myR.keyRelease(KeyEvent.VK_I);
	        myR.keyPress(KeyEvent.VK_C);
	        myR.keyRelease(KeyEvent.VK_C);
	        myR.keyPress(KeyEvent.VK_K);
	        myR.keyRelease(KeyEvent.VK_K);
	        myR.keyPress(KeyEvent.VK_ENTER);
	        myR.keyRelease(KeyEvent.VK_ENTER);MyApp.roboSequence++;
	}
	public static void RT11() throws AWTException {
		Robot myR = new Robot();
		//System.out.println("delay 500");
		myR.delay(500);
	        myR.keyPress(KeyEvent.VK_C);
	        myR.keyRelease(KeyEvent.VK_C);
	        myR.keyPress(KeyEvent.VK_ENTER);
	        myR.keyRelease(KeyEvent.VK_ENTER);MyApp.roboSequence++;
	}

	public static void RT12() throws AWTException {
		Robot myR = new Robot();
		//System.out.println("delay 500");
		myR.delay(500);
		 myR.keyPress(KeyEvent.VK_S);
	        myR.keyRelease(KeyEvent.VK_S);
	        myR.keyPress(KeyEvent.VK_E);
	        myR.keyRelease(KeyEvent.VK_E);
	        myR.keyPress(KeyEvent.VK_T);
	        myR.keyRelease(KeyEvent.VK_T);
	        myR.keyPress(KeyEvent.VK_D);
	        myR.keyRelease(KeyEvent.VK_D);
	        myR.keyPress(KeyEvent.VK_A);
	        myR.keyRelease(KeyEvent.VK_A);
	        myR.keyPress(KeyEvent.VK_T);
	        myR.keyRelease(KeyEvent.VK_T);
	        myR.keyPress(KeyEvent.VK_A);
	        myR.keyRelease(KeyEvent.VK_A);
	        myR.keyPress(KeyEvent.VK_ENTER);
	        myR.keyRelease(KeyEvent.VK_ENTER);MyApp.roboSequence++;
	}
	public static void RT13() throws AWTException {
	}
	public static void RT14() throws AWTException {
	}
	public static void RT15() throws AWTException {
	}
	public static void RT16() throws AWTException {
	}
	
	
	
	
} // End of class MyApp
