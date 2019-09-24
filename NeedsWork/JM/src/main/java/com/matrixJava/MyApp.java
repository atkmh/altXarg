package main.java.com.matrixJava;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Scanner;
import java.util.Set;

import main.java.com.matrixJava.Usage;

public class MyApp {
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
	double[] inputValsPassToMatrix = new double[100];// 9/19/19 I don't think this is used !!
	//Map <String, Matrix> myHashMapListOfMatrix = new HashMap<String,Matrix>();

	public static void main(String[] args) throws IOException {
		String firstArg = "";
		InputStringObj myInputStringObj = null;
		
//		Map <String, Matrix> myHashMapListOfMatrix = new HashMap<String,Matrix>();
		Map <String, ArrayList<Matrix>> myHashMapListOfMatrix = new HashMap<String,ArrayList<Matrix>>();
		
        Map<String, ArrayList<Matrix>> myDevHMList = new HashMap<String, ArrayList<Matrix>>();	

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
				
				ProgramNotifications.openingIntroduction();
/*				
				myInputStringObj = new InputStringObj("-r", null);

//  ?????? why do this
//      myInputStringObj.getStringArray();

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
// just hold onto this		myNumTest.displayNumMatrixValues();
 
//  9/13/19 We are taking all of null -r runtime and putting on hold
//  in order ot workout the needs of the runtime part of the progrem 
          */
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
				
			//	myNumTest_cl.getArrayListData();
				Matrix numObjBasedMatrix_cl = new Matrix(myNumTest_cl);
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
				Usage.Usage(" ");
				break ;

			default: 
			//Usage.Usage("Problem: see Input  "+args[0] +" " +args[1] +" " +args[2]  +" etc..."             );	
			String tmp = "";
			for (String s: args) {tmp = tmp+s +" ";}
			Usage.Usage("Problem: see Input  " +tmp );	
		}//end Switch firstArg	
		
		Scanner in = new Scanner(System.in);
		String runTimeCommand;
		
		System.out.print("Let's get the first run time command: ");
	    runTimeCommand = in.nextLine();	
	    runTimeCommand = runTimeCommand.toLowerCase();
	 
	   /*****************
	    * 
	    * Char setup A, B, C to be the key and matrix Names 
	    *  
	    *****************/
	   int charRepToIncrement = 65; 
//	   char matrixMapKeyName = (char)charRepToIncrement;   // So this Should equal "A"
	   char myCurChar = (char)charRepToIncrement;   // So this Should equal "A"
	   // I will use String str - Character.toString( matrixMapKeyName)   Actuall I'm going to chang those var names
	    

	   
	    while(   !runTimeCommand.contentEquals("quit") && !runTimeCommand.contentEquals("q")){
	        switch (runTimeCommand) {
	        
	        case "new":
    	        InputStringObj caseInputStringObj = new InputStringObj("-r", null);
    	        InputNumericObj caseInputNumericObj = new InputNumericObj(caseInputStringObj);
    	   //     Matrix caseMatrixObj = new Matrix(caseInputNumericObj);
 
    	     /* This was operational code  */   
    	     /*   ArrayList<Matrix> myArrayList = new ArrayList(new Matrix(caseInputNumericObj)); */
    	        ArrayList<Matrix> myArrayList = new ArrayList<Matrix>( );
    	       myArrayList.add( new Matrix(caseInputNumericObj));
    	        
    	        myDevHMList.put(Character.toString(myCurChar), new ArrayList());

// Original MH(string Matrix)    	        
//    	        myHashMapListOfMatrix.put(Character.toString(myCurChar),new Matrix(caseInputNumericObj));

// firts try of MH (String , Arraylist[i]= Matrix(caseInputNumericObj);    	        
//    	       myDevHMList.put(Character.toString(myCurChar),new ArrayList( ).add(new Matrix(caseInputNumericObj)));
    	     
    	        
    	        
    	        
    	     //   caseMatrixObj.displayCompact();
    	     //   caseMatrixObj.displayMore();
    	        charRepToIncrement++;  // do this at the end so that the value is ready next time in.
    	        myCurChar = (char)charRepToIncrement;   
	        	break;

	        case "showmap":
	        case "showMap":
//	        	Set<Map.Entry <String,Matrix> > mySet = myHashMapListOfMatrix.entrySet();
//	        	for(Map.Entry <String,Matrix > me:mySet) {
//	        		System.out.println(me.getKey()+" What suppose to be the matrix");
//	        		System.out.println("Not making the me.getValue(a Matrix ) call here");
//	        	}
	        Set<Entry<String, ArrayList<Matrix>>> mySet = myDevHMList.entrySet();
	        for(Entry<String, ArrayList<Matrix>> me:mySet) {
	        		System.out.println(me.getKey()+" What suppose to be the matrix");
	        		System.out.println("Not making the me.getValue(a Matrix ) call here");
	        }
	        	break;

	        case "ls mx":
	        case "ls mx by name":
	        case "list matrix name":
                System.out.println("Working on this.  Currently we're at 'A' " );
	            break;
	        	
	        case "humm":
	        	break;
	        case "pop":
	        	char charRep;
                for (int x = 65 ; x < 80 ; x++) {
	        	     charRep = (char)x;
	        	     System.out.println(" value is : "+charRep);
	             }
      	        break;
	        
	        case "ls": 
	        case "list": 
	        case "listCmd":
	        	System.out.println("list of commands this program responds to");
	        	System.out.println("Currently, commands are.");
	        	System.out.println("new:\t\t\tcreate a new Matrix");
	        	System.out.println("showmap:\t\tprint out the current HashMap of Key:value Pairs");
	        	System.out.println("humm:\t\t\tdo nothing");
	        	System.out.println("pop:\t\t\tTest int x cast to char(x)");
	        	System.out.println("ls:\t\t\tThis command");
	        	System.out.println("list:\t\t\tThis command");
	        	System.out.println("listcmd:\t\tThis command");
	        	System.out.println("ls mx:\t\t\tnot implemented yet");
	        	System.out.println("ls mx by name:\t\tnot implemented yet");
	        	System.out.println("list matrix name:\tnot implemented yet");
	        	System.out.println("quit: but this isn't a switch entry its in the loop control check");
	        	System.out.println("");
      	        break;
	       default:
	    	   System.out.println("That command " +runTimeCommand +" was not found, quitting");
	    	   //runTimeCommand = "quit";
	    	   break;
	        }

	        System.out.print("Get another command: ");
	        runTimeCommand = in.nextLine();	
	    /* *****************************************************
	     * Initially this looked like a good idea, but it forces  
	     * me to only allow lower case switch commands.
	     * But, there is noting keeping me from codeing things
	     * with upper case that end up never working...... So....
	     * Let's remove it allowing all case of chars
	        runTimeCommand = runTimeCommand.toLowerCase();
	     */
	    }
		
		
	    ProgramNotifications.giveShutDownNotice();
	
			
			
	
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
