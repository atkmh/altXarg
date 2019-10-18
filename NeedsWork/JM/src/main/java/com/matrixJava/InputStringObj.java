package main.java.com.matrixJava;

import java.awt.AWTException;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Scanner;
//import org.apache.commons.lang3.StringUtils;

public class InputStringObj {
	
	
		private String inputSwitch;
		private String firstRT;
		private String firstCL;
		private String second= ""; // 3X6 Must Be ! 
//		private String[] arrayOfStrings;
		private ArrayList<String> mVals = new ArrayList<String>();  // remember this is input
    //  NOTE: **** 'RT'  means RunTime  ****	
	public InputStringObj(String rt_operation, String[] cl_Data ) throws IOException, AWTException {
		
		String tmpStr = "";
		String [] arrayOfStrings;
		String mValues = "";
		String mDims = "";
		//String strValue;
	
		// 10/16/19 New input manner
		Scanner in = new Scanner(System.in);

		this.inputSwitch = rt_operation;
		
		/* Since we pass a switch in here we check and operate accordingly  */
		/* Assumption:  We only send two switches                           */
		/*  --------------------------------------------------------------  */
		if(rt_operation.equals("-r")) {

/* Direct the user on how to use the sys   */
			presentUsage();  

          /* setting the arg[0] parameter === "-r"                         */
			this.firstRT = rt_operation;

/* Get Matrix dimensions*/			
			System.out.print("Enter Dimension: ");

//	See Note: BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
//	See Note: mDims = br.readLine(); // something like 4x7	
// Note: 10/16/19 New input manner below
			
	/*
	 *  If you notice the nature of this section
	 * 	is about Matrix Dimensions
	 * mDims = in.nextLine();
	 * so... only RT procs that deliver mRows and nCols
	 * should be available here
	 * Anything else would be an Error.	
	 */
		if(MyApp.roboSwitch)	
			switch(MyApp.roboSequence) {
			case 1 : 
				MyApp.RT1(); //MyApp.roboSequence++;// '3x4 <enter>' 
				break;
		
			case 4 : 
				MyApp.RT4(); //MyApp.roboSequence++;
				break;
			case 8 : 
				MyApp.RT8(); //MyApp.roboSequence++;
				break;
				
			default: System.out.println("NoRoboSequence Left : Seq Val "+MyApp.roboSequence);
			break;
				
			}
            mDims = in.nextLine();

/* Get raw matrix values                              */			
/* Get all values in a String                         */
			System.out.print("Enter Matrix Values: ");
//			tmpStr = br.readLine(); // something like 2.0 2.3 4 5 6.6 7.77 0.888 9.0 10
		// 10/16/19 New input manner

			if(MyApp.roboSwitch)	
			switch(MyApp.roboSequence) {
			case 2: case 5: 
				MyApp.RT2(); //MyApp.roboSequence++;
				break;
			case 9:
				MyApp.RT9();break;
			default: System.out.println("NoRoboSequence Left :Seq Val "+MyApp.roboSequence);
			break;	
				
			}
			tmpStr = in.nextLine();

/*      We Are Finish this with runtime Data Entry   */
		} else if(rt_operation.equals("-c")) { 
		
/*                                         */
/* *****************************************/
/*      Starting Command Line Data Entry   */
/* *****************************************/
/*                                         */
			
          /* setting the arg[0] parameter === "-c"                         */
			this.firstCL = rt_operation;

/* Get raw dimensions*/			
			mDims = cl_Data[1];   // something like 7x4 
			
			tmpStr = "";
			for(int x=2 ; x < cl_Data.length ; x++) 
				tmpStr = tmpStr+cl_Data[x] +" ";
		
/*                                         */
/* *****************************************/
/*        We are DONE with Data Entry      */
/* *****************************************/
/*                                         */
		} else Usage.UsageTerminal(" Some How the wrong switch was passed!! How I don't know !");

		
	/*	System.out.println("DebugBreakpoint"); */
	/*	System.out.println("tmpStr is :" +tmpStr);  */
/*                                         */
/* *****************************************/
/*       Check and Parse gathered data     */
/* *****************************************/
/*                                         */

/* check for lower x's in mDims  Error with usage if found */		
		if (mDims.contains("x") || mDims.contains("X") ) {
			mDims = mDims.replace('x', 'X');
			mDims = fixInnerSpace(mDims,0); // integer size of space to leave
			mDims = mDims.trim(); // take off trailing white space.
		
//	if( ! ( checkDimChars(mDims.charAt(i) /*"Dim"  or "Val" */  ) )) 
/* check all mDims chars in list < 0123456789X > Error: Usage if fail */	
        	for(int i=0; i<mDims.length(); i++)
        		if( !validateStringChars(mDims.charAt(i) ,"Dim" ) ) 
        			Usage.UsageTerminal("Problem: illegal char in Dimensions \n" +mDims +" " +tmpStr +" some Data");
        
/* check if there was more than one X in the dimension */		
        	if ( 1 < (mDims.codePoints().filter(ch -> ch =='X').count()) ) 
        		Usage.UsageTerminal("Problem: to many Xs \n" +mDims +" " +tmpStr +" some Data");
        	
        	
        } else Usage.UsageTerminal("Proglem: bad character in Dimension \n" +mDims +" " +tmpStr +"some Data");
		
		
/*                                         */
/* *****************************************/
/* Make value assignment to member variable*/
/* *****************************************/
/*                                         */

		this.second = mDims;
		
		
/*                                         */
/* *****************************************/
/* The following some what hacky looking   */
/* block of code will handla a large number*/
/* of conditions where space in in between */
/* the data values                         */
/* *****************************************/
/*                                         */
		tmpStr = fixInnerSpace(tmpStr,1); // integer size of space to leave
/* make assignment to array of strings                     */
/* This step makes assigning to ArrayLins this much easier */		

		arrayOfStrings = tmpStr.split(" ");

/* work through the raw matrix string values        */
/* checking to see if they are all legit num values */
/* checking to see if they are multiple decimal pts */
/* if No Errors then make the assignment to the member variable */		

//				if(!check_mValuesChars(strValue.charAt(x)   /*"Dim"  or "Val" */   ))
		// need to test out a try and catch block with a slight different config.....
//		for (String strValue: arrayOfStrings) {
		for (String strValue: arrayOfStrings) {
			try {
			   for(int x = 0 ; x < strValue.length() ; x++ ) 
				   validateStringChars(strValue.charAt(x),"Val" );
			   
/*				if(! validateStringChars(strValue.charAt(x),"Val" )) {
				//	Usage.UsageTerminal("Problem: A matrix value was not in [.0-9] ");
					Usage.UsageRecoverable("Problem: A matrix value was not in [.0-9] ");
					//break;
				}*/			
			  } catch (Exception e) {
            	 Usage.UsageRecoverable("Problem: A matrix value was not in [.0-9] ");
             }
			if( 1 < (strValue.codePoints().filter(ch -> ch =='.').count()))
//					Usage.UsageTerminal("multiple decimal points were found\n"+mDims +" " +tmpStr +"some data" );
					Usage.UsageRecoverable("multiple decimal points were found\n"+mDims +" " +tmpStr +"some data" );
			this.mVals.add(strValue); // member variable assignment
	}	
	}// Constructor / main method done
	
	private boolean validateStringChars(char myChar, String whichOne) {
          boolean theAnswer = false;
          String myRegex = "";
          String dimRegex = "0123456789X";
          String valRegex = "0123456789.-"; 
          if (whichOne.equals("Dim"))
               myRegex = dimRegex;
          else if (whichOne.equals("Val")) 
               myRegex = valRegex;
               
          for(int x=0 ; x < myRegex.length() ; x++)
			    if(myChar == myRegex.charAt(x))
				     theAnswer = true;
		return theAnswer;
  }     	

	
	/* **********************************************************
	 * This is a rather interesting little ditty.  I haven't 
	 * checked out permutations, but in most cases running all 
	 * these will remove an infinite number of spaces in a String
	 */
	private String fixInnerSpace(String data, int zeroSpace) {
		data = data.replace("      ", " ");//6 -> 1
		data = data.replace("     ", " ");//5 -> 1
		data = data.replace("    ", " ");//4 -> 1
		data = data.replace("   ", " ");//3 -> 1
		data = data.replace("  ", " ");//2 -> 1
		if (zeroSpace<1)
			data = data.replace(" ", "");//1 -> 0
		return data;
	} /*It might be do able with less  */
	
	public String getFirst() {
		String returnVal ="";
		
		if (this.inputSwitch == "-r")
			returnVal = this.firstRT;
		if (this.inputSwitch == "-c")
			returnVal = this.firstCL;
		return returnVal;
	}
	
	public String getSecond() {
		return this.second;
	}
	
	public ArrayList getdata() {
		return this.mVals;
	}
	
	public String get(int index ) {
		return this.mVals.get(index);
	}
	
/*RunTimeCode */	
	public void displayArrayList() {
		System.out.println("Array Length is "+mVals.size());
		for (String value : mVals)
			System.out.println(value);
	}
		
	public void presentUsage() {
		System.out.println("Matrix Data Entry.");
		System.out.println("Dimension example: 3x4");
		System.out.println("Matrix Values example: 1 3 2.3 4.125");
	}	
	
	
	
}// Class file done




