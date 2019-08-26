package main.java.com.matrixJava;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
//import org.apache.commons.lang3.StringUtils;

public class InputStringObj {
	
	
		private String inputSwitch;
		private String firstRT;
		private String firstCL;
		private String second= ""; // 3X6 Must Be ! 
//		private String[] arrayOfStrings;
		private ArrayList<String> mVals = new ArrayList<String>();  // remember this is input
	
	public InputStringObj(String switchPassed, String[] cl_Data ) throws IOException {
		
		String tmpStr = "";
		String [] arrayOfStrings;
		String mValues = "";
		String mDims = "";

		this.inputSwitch = switchPassed;
		
		/* Since we pass a switch in here we check and operate accordingly  */
		/* Assumption:  We only send two switches                           */
		/*  --------------------------------------------------------------  */
		if(switchPassed.equals("-r")) {
/* Direct the user on how to use the sys   */
			presentUsage();  

          /* setting the arg[0] parameter === "-r"                         */
			this.firstRT = switchPassed;

/* Get raw dimensions*/			
			System.out.print("Enter Dimension: ");
			BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
			mDims = br.readLine(); // something like 4x7	

/* Get raw matrix values                              */			
/* Get all values in a String                         */
			System.out.print("Enter Matrix Values: ");
//			mValues = br.readLine(); // something like 2.0 2.3 4 5 6.6 7.77 0.888 9.0 10
			tmpStr = br.readLine(); // something like 2.0 2.3 4 5 6.6 7.77 0.888 9.0 10

/* Just to kee the system running temporarily we use hits call */	
		//mValues = tmpStr;
			
			
/*      We Are Finish this with runtime Data Entry   */
		} else if(switchPassed.equals("-c")) { 
		
/*                                         */
/* *****************************************/
/*      Starting Command Line Data Entry   */
/* *****************************************/
/*                                         */
			
          /* setting the arg[0] parameter === "-c"                         */
			this.firstCL = switchPassed;

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
		} else Usage.Usage(" Some How the wrong switch was passed!! How I don't know !");

		
/*                                         */
/* *****************************************/
/*       Check and Parse gathered data     */
/* *****************************************/
/*                                         */

/* check for lower x's in mDims  Error with usage if found */		
		if (mDims.contains("x") || mDims.contains("X") ) {
			mDims = mDims.replace('x', 'X');
			mDims = mDims.trim(); // take off trailing white space.
		
	
/* check all mDims chars in list < 0123456789X > Error: Usage if fail */	
        	for(int i=0; i<mDims.length(); i++)
        		if( ! ( checkDimChars(mDims.charAt(i)) )) 
        			Usage.Usage("Problem: illegal char in Dimensions \n" +mDims +" " +tmpStr +" some Data");
        
/* check if there was more than one X in the dimension */		
        	if ( 1 < (mDims.codePoints().filter(ch -> ch =='X').count()) ) 
        		Usage.Usage("Problem: to many Xs \n" +mDims +" " +tmpStr +" some Data");
        	
        	
        } else Usage.Usage("Proglem: bad character in Dimension \n" +mDims +" " +tmpStr +"some Data");
		
		
/*                                         */
/* *****************************************/
/*     Make value assignment to object     */
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
		tmpStr = tmpStr.replace("      ", " ");//6
		tmpStr = tmpStr.replace("     ", " ");//5
		tmpStr = tmpStr.replace("    ", " ");//4
		tmpStr = tmpStr.replace("   ", " ");//3
		tmpStr = tmpStr.replace("  ", " ");//2


/* make assignment to array of strings                     */
/* This step makes assigning to ArrayLins this much easier */		

		arrayOfStrings = tmpStr.split(" ");

/* work through the raw matrix string values        */
/* checking to see if they are all legit num values */
/* if No Errors then make the assignment to the member variable */		

		for (String strValue: arrayOfStrings) {
			for(int x = 0 ; x < strValue.length() ; x++ ) 
				if(!check_mValuesChars(strValue.charAt(x)))
					Usage.Usage("Problem: A matrix value was not in [.0-9] ");
			mVals.add(strValue);
		}
		
	}// Constructor / main method done
	
	
	
	// Now, I could combine both of these into a single method
	// but I'd have to pass inthe regEx string:  Will consider this
	private boolean check_mValuesChars(char myChar) {
		String myRegex = "0123456789.";  // We're not allowing neg Number so no "-"
		boolean thisAnswer = false;
		for(int x=0 ; x < myRegex.length() ; x++)
			if(myChar == myRegex.charAt(x))
				thisAnswer = true;
		return thisAnswer;	
	}
	
	private boolean checkDimChars(char myChar) {
		String myRegex = "0123456789X";
		boolean theAnswer = false; 
		for(int x=0 ; x < myRegex.length() ; x++)
			if(myChar == myRegex.charAt(x))
				theAnswer = true;
		return theAnswer;
	}
	
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
//	public void displayStringArray(String[] strArray) {
	public void displayArrayList() {
//		System.out.println("Array Length is "+strArray.length);
		System.out.println("Array Length is "+mVals.size());
		for (String value : mVals)
			System.out.println(value);
		System.out.println(".............");
	}
		
	public void presentUsage() {
		System.out.println("Matrix Data Entry.");
		System.out.println("Dimension example: 3x4");
		System.out.println("Matrix Values example: 1 3 2.3 4.125");
	}	
	
//		public String[] getStringArray() {
//			//System.out.println(debugOutput +"getSringArray");
//			return this.arrayOfStrings;
//		}
			
	
	
	
}// Class file done


// Keep this until I parse into actual numbers
				// curious Im not supposed to do this yet
				// this.mVals.add( Double.parseDouble( cmdLineInput[x] )); 
/* **********************************************************
 *   Putting this call on hold for rt now
 * 	 This should be done for both runtime and commandline 
 *   But only once	
 *			mValues = tmpStr.trim().replaceAll(" +",  " ");
 */


