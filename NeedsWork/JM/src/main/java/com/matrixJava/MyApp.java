package main.java.com.matrixJava;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.lang.management.ManagementFactory;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.Set;
import java.util.concurrent.Executors;

import main.java.com.matrixJava.Usage;

public class MyApp {

	static boolean mydebug = false;
	
	//String name = null;
	//String oppMode = null;
	
	static String runTimeCommand;
    static ArrayList<ArrayList> runTimeALOAL = new ArrayList<ArrayList>();
    static Matrix currentMx = null ;
    static String currentName = null;
    static Scanner in = new Scanner(System.in);
    static double scalerValue;

	int[] matrixDimensions = new int[2];// 2 values M&N both int
	double[] inputValsPassToMatrix = new double[100];// 9/19/19 I don't think this is used !!
	//Map <String, Matrix> myHashMapListOfMatrix = new HashMap<String,Matrix>();

	public static void main(String[] args) throws IOException, InterruptedException {
		String firstArg = "";
		InputStringObj myInputStringObj = null;

		

		if ( args==null  ||args.length==0)  	// We want null input at command line to indicate 
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
			
 /*  Can the following two lines be moved down to start of runtime input ???	*/
                  ProgramNotifications.openingIntroduction();


				break; 

			case "-c": // 
			case "--c":
			case "-cmdline":
			case "--cmdline":
				myInputStringObj = new InputStringObj("-c", args);
				System.out.println(myInputStringObj.getFirst());
				System.out.println(myInputStringObj.getSecond());
				System.out.println(myInputStringObj.getdata());	
				InputNumericObj myNumTest_cl = new InputNumericObj(myInputStringObj);
				
			//	myNumTest_cl.getArrayListData();
				Matrix numObjBasedMatrix_cl = new Matrix(myNumTest_cl, "PutInOrder2Compile_NeedsANameVar");
				numObjBasedMatrix_cl.setName("numObjBasedMatrix_cl");
				numObjBasedMatrix_cl.displayCompact();	
				numObjBasedMatrix_cl.displayMore();	
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
				Usage.UsageTerminal(" ");
				break ;

			default: 
			//Usage.UsageTerminalTerminal("Problem: see Input  "+args[0] +" " +args[1] +" " +args[2]  +" etc..."             );	
			String tmp = "";
			for (String s: args) {tmp = tmp+s +" ";}
			Usage.UsageTerminal("Problem: see Input  " +tmp );	
		}//end Switch firstArg	
	
		
		
/* ---------------------------------------------
 *  Start the runtime process
 *  got to read something in
 * 		
 */

	//	String runTimeCommand;
		
		System.out.print("Let's get the first run time command: ");
	    runTimeCommand = in.nextLine();	
	    runTimeCommand = runTimeCommand.toLowerCase();
        System.out.println("");
	    
	   /* ****************
	    * Char setup A, B, C to be the matrix Names 
	    ********/
        
	   int charRepToIncrement = 65; 
//	   char matrixMapKeyName = (char)charRepToIncrement;   // So this Should equal "A"

	   char myCurChar = (char)charRepToIncrement;   // So this Should equal "A"
	   // I will use String str - Character.toString( matrixMapKeyName)   Actuall I'm going to chang those var names
	   

	   
	    while(   !runTimeCommand.contentEquals("quit") && !runTimeCommand.contentEquals("q")){
	        switch (runTimeCommand) {
	        case "new":
	        	myCurChar = (char)charRepToIncrement; 	
	        	String mName = new StringBuilder().append(myCurChar).toString();
    	        InputStringObj caseInputStringObj = new InputStringObj("-r", null);
    	        InputNumericObj caseInputNumericObj = new InputNumericObj(caseInputStringObj);
 
    	        ArrayList<Matrix> mxHistArray = new ArrayList<Matrix>(); 
    	        mxHistArray.add(new Matrix(caseInputNumericObj,mName) );
    	        runTimeALOAL.add(mxHistArray);

    	        charRepToIncrement++;  // do this at the end so that the value is ready next time in.
	        	break;

	        case "showmap":
	        case "showMap":
	        	showmap();
	        	break;

	        case "showListSpecs":
	        case "showlistspecs":
	        case "showlistmain":
	        case "showmainlist":
	        
	        	Matrix tmpShowMapAll;
	        	
	        	System.out.println("");
	        	System.out.println("main array size: "+runTimeALOAL.size() );
	        	for (int i=0 ; i < runTimeALOAL.size(); i++) {
	        		ArrayList tmpAL4Read = runTimeALOAL.get(i);
                        System.out.println("internal size on main #" +i +" is " +tmpAL4Read.size() );
	        		for (int j=0; j < tmpAL4Read.size(); j++) {
	        			tmpShowMapAll = (Matrix) runTimeALOAL.get(i).get(j);
	        		}
	        	}
	        	break;
	        	
	        case "ls mx":
	        case "ls mx by name":
	        case "list matrix name":
	        	runTimeCommand = "showmap";
//                System.out.println("Working on this.  Currently we're at 'A' " );
	            continue;	
	            
			case "scalerMultx":
			case "scalermultx":

				System.out.println("Enter Scaler Value");
				scalerValue =  Double.parseDouble( in.nextLine());
				System.out.println("Scaler Value entered: "+scalerValue);
				if (currentMx != null) {
					currentMx = currentMx.Multiply(scalerValue);
				} else
					System.out.println("Cant Mult current when current is null");


	        	break;
	        /* Entry Requirement:  */	
			case "devmult":
			case "multDev":
			case "multdev":
			case "scalerMult":
			case "scalermult":
				MatrixScalerMultiplication();

			
				break;
	        	
	        case "pop":
	        	char charRep;
                for (int x = 65 ; x < 80 ; x++) {
	        	     charRep = (char)x;
	        	     System.out.println(" value is : "+charRep);
	             }
      	        break;

	       
	        case "pickmatrix":
	        case "pickmx":
	        case "setCurrName":
	        case "setcurrname":
	        	PickMatrixFromMainList();
	            break;
	           
	        case "currNullCheck":
	        case "currnullcheck":
	        case "curnulck":
	        case "cnc":
	        	CurrentNullCheck();
	        	break;
	           
	        case "dispCurr":
	        case "dispcurr":
	        	 DisplayCurrentMatrix();
	        	break;
	        	
	        case "ls":
	        case "list": 
	        case "listCmd":
	        	ListRunTimeCommands();
	        	break;
	        	
	        case "cls":	
	        	ClearScreen();
                 break;
                 
	        	
	       default:
	    	   System.out.println("That command " +runTimeCommand +" was not found, try again");
	    	   System.out.println("");
	    	   runTimeCommand = "ls";
	    	   //runTimeCommand = "quit";
	    	   continue;
	        }

	        System.out.print("Get another command: ");
	        runTimeCommand = in.nextLine();	
	    /* ***************************************************************************************
	     * Initially this looked like a good idea, but it forces me to only allow lower case 
	     * switch commands. But, there is noting keeping me from coding things with upper case 
	     * that end up never working...... So....  Let's remove it allowing all case of chars
	        runTimeCommand = runTimeCommand.toLowerCase();
	     */
	    }
	    
	    ProgramNotifications.giveShutDownNotice();
	
	} // end public static void main(String[] args)

  public static void newMatrix() {
	  
  }
	

  
  
  public static void showmap() {
  	Matrix tempshowListMx;
  	System.out.println("");
  	for (int i=0 ; i < runTimeALOAL.size(); i++) {
  		for(int j=0 ; j < runTimeALOAL.get(i).size(); j++ ) {
  			tempshowListMx = (Matrix) runTimeALOAL.get(i).get(j);
  	     System.out.println(" ----------   ");
  	     System.out.println("Modification Command\t :" +tempshowListMx.getModCmd()  );
  	     System.out.println("Modification TimeStamp\t :" +tempshowListMx.getModTimeStamp()  );
  	     System.out.println("Creation Time Stamp\t :" +tempshowListMx.getCreationTimeStamp()  );
  	     tempshowListMx.displayCompact();
  	     System.out.println("");
  	     System.out.println(" ----------   ");
  		}
  	}	 
	  
  }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public static void MatrixScalerMultiplication() {
		// Check if we are pointing at a current Matrix if so, get scaler value.  Echo the scaler entered
		// multiply current*Scaler. prepare a temporary Matrix so we can search for new current home
		// get the name of the current Mx. Prepare a var for array index of name. start the search.
        // when found - put CurrentMx away 

			if (currentMx == null) {
				System.out.println("Current Matrix is not selected.  Pick-A-Matrix");
				return;	
			}

			System.out.println("Enter Scaler Value");
			scalerValue =  Double.parseDouble( in.nextLine());
			System.out.println("Scaler Value entered: "+scalerValue);
			currentMx = currentMx.Multiply(scalerValue);

			String currentMxName = currentMx.getName();
			currentMx.setModifyingCommand(currentMxName +"="+currentMxName +"x where x == " +scalerValue);
			Matrix tempMx;
//			String currentMxName = currentMx.getName();
			int rtALOAL_Index = 0;
			
			for (int i=0 ; i < runTimeALOAL.size(); i++) {
				tempMx = (Matrix)runTimeALOAL.get(i).get(0);
                 if( currentMxName == tempMx.getName() ) {
                	 rtALOAL_Index = i;
                	 i = runTimeALOAL.size();  // this should break us out
                 }	
            }
		
		     System.out.println("The index of the name is :" +rtALOAL_Index);
		// ???
		// Will this all work by reference ???  What do I mean ???
		// set tempAL to runTimeALOAL.get(rtALOAL_Index)
		// now do my size and push down on tempAl... Will this affect the AL in rTALOAL[rtALOAL_Index] ???
		
		// Prepare a temp ArrayList to work on
		ArrayList<Matrix> tempAL = runTimeALOAL.get(rtALOAL_Index);

		// lets iterate thought the history array copying N to N+1  
		// this has to be done backwards
		for (int x=tempAL.size(); x < 0 ; x--) {
			tempAL.add((x+1), tempAL.get(x));
			System.out.println("copied into "+(x+1) +"from " +x);
		}
		// and for the zeroth entry
		tempAL.add(0, currentMx );
		
		
	}
	
	
	
	
	public static void PickMatrixFromMainList() {
    	System.out.print("Enter Matrix Name Char :");
    	currentName = in.nextLine();	
	    for (int x=0 ; x < runTimeALOAL.size(); x++) {
	         ArrayList tempAl = runTimeALOAL.get(x);
	         currentMx = (Matrix) tempAl.get(0);
	         if (currentMx.getName().equals(currentName)) {
	        	 x=runTimeALOAL.size();
	        	//System.out.println("found it");
	        	break;
	         }
	         else currentMx = null;
	         
	    }
//	    System.out.println("The char entered was :" +nameChar);
	    System.out.println("The Mx Name entered was :" +currentName);
	    if (currentMx==null) System.out.println("But, "+currentName +" wasnt found. Current Mx is still null");
	}
	
	
	//****************************************************************************
	// Current represents a 'Named' Matrix pulled out of the main List
	// if Current is null the tempMx has not yet been copied out of the main list
       public static void CurrentNullCheck() {
       	if (currentMx == null)
    		System.out.println("yes: current is null");
    	else
    		System.out.println(currentMx.getName()); 
       }
	
	   public static void DisplayCurrentMatrix() {
       	if(currentMx == null )
    		System.out.println("No Matrix currently selected");
    	else
    		currentMx.displayCompact();
		   
	   }
	
	
	   public static void ListRunTimeCommands() throws IOException 	{
	       	System.out.println(""); { 
	            // pass the path to the file as a parameter 
	            File file = new File("C:\\atkmhDev\\NeedsWork\\JM\\testsysoCommands.txt");
	            Scanner sc = new Scanner(file); 
	            while (sc.hasNextLine()) 
	                 System.out.println(sc.nextLine()); 
	                 sc.close();           }
	            System.out.println("");
			   
		   }
	   
	   
	   public static void ClearScreen() throws InterruptedException, IOException {
       	ProcessBuilder builder = new ProcessBuilder();
        if( System.getProperty( "os.name" ).startsWith( "Window" ) )
        	builder.command("cmd", "/c", "cls").inheritIO().start().waitFor();
        //	new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
        //	 exitCode = Runtime.getRuntime().exec("cls");
		else
		   Runtime.getRuntime().exec("clear"); 
	   }
	   

	

} // End of class MyApp

/*
 * One Change to cement a branch
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





/*				
 *	Formerly of the main body switch -r for runtime. This was active but 
 *	it was not interactive. 
 * 
myInputStringObj = new InputStringObj("-r", null);
//?????? why do this
//myInputStringObj.getStringArray();

System.out.println(myInputStringObj.getFirst());
System.out.println(myInputStringObj.getSecond());
System.out.println(myInputStringObj.getdata());

System.out.println("");
System.out.println("call displayArrayList");
myInputStringObj.displayArrayList();

InputNumericObj myNumTest_rt = new InputNumericObj(myInputStringObj);
//	myNumTest_rt.getArrayListData();
Matrix numObjBasedMatrix_rt = new Matrix(myNumTest_rt);
numObjBasedMatrix_rt.setName("numObjBasedMatrix_rt");
numObjBasedMatrix_rt.displayCompact();
numObjBasedMatrix_rt.displayMore();
//just hold onto this		myNumTest.displayNumMatrixValues();
//
//9/13/19 We are taking all of null -r runtime and putting on hold
//in order ot workout the needs of the runtime part of the progrem */


