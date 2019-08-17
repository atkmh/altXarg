package main.java.com.matrixJava;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;

public class InputStringObj {
	
	
		private String inputSwitch;
		private String firstRT;
		private String firstCL;
		private String second= ""; // 3X6 Must Be ! 
		private String[] arrayOfStrings;
		private ArrayList<String> mVals = new ArrayList<String>();  // remember this is input
		
	
	public InputStringObj(String switchPassed, String[] cl_Data ) throws IOException {
		
		String mValues = "";
		String mDims = "";

		this.inputSwitch = switchPassed;
		
		/* Since we pass a switch in here we check*/
		/* and operate accordingly                */
		/* Assumption:  We only send two switches */
		if(switchPassed.equals("-r")) {
/* Lets do all the -r data gathering first */
			this.firstRT = switchPassed;
			presentUsage();

/* Get raw dimensions*/			
			System.out.print("Enter Dimension: ");
			BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
			mDims = br.readLine(); // something like 4x7	

/* Get raw matrix values*/			
			System.out.print("Enter Matrix Values: ");
			mValues = br.readLine(); // something like 2.0 2.3 4 5 6.6 7.77 0.888 9.0 10
		}
		else if(switchPassed.equals("-c")) { // Finish this with else ( failure ) Usage.Usage("Error message")
/* 	Lets parse all the command line passed */
/* 	setting the arg[0] parameter           */
			this.firstCL = switchPassed;
		
/* 	setting the arg[1] parameter           */
			mDims = cl_Data[1];

/*  Checking for proper first char of Matrix Dimension */
/* 	Runtime version of this is better.  use it          */
			
/* 	get the remaining values. I have to go seriously back and forth on this one */
/*	but only because I need code to run once on both conditions: -r & -c        */
			for(int x=2 ; x < cl_Data.length ; x++) {
	           //mVals.add(cl_Data[x]);  // Cant do this rt now rt here
				mValues = mValues+cl_Data[x] +" ";
			}
		} else Usage.Usage(" Some How the wrong switch was passed!! How I don't know !");

/* ***************************************************************************
 *  Now at this point, I've either read in my data or I've raw parsed my data
 * 	Now I can run the error checks	
 */
		
/* Evaluate upper and Lower Xs in mDims*/		
		if (mDims.contains("x") || mDims.contains("X") ) {
			mDims = mDims.replace('x', 'X');
	
/* check every dimensinon char in the list */	
        	for(int i=0; i<mDims.length(); i++)
        		if( ! ( checkDimChars(mDims.charAt(i)) )) 
        			Usage.Usage("Problem: illegal char in Dimensions \n" +mDims +" " +mValues +" some Data");
        
/* check if there was more than one X in the dimension */		
        	if ( 1 < (mDims.codePoints().filter(ch -> ch =='X').count()) ) 
        		Usage.Usage("Problem: to many Xs \n" +mDims +" " +mValues +" some Data");
        }
		this.second = mDims ;
/* mDims Error Checking is done  */

		arrayOfStrings = mValues.split(" ");

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
	
/*RunTimeCode */	
	public void displayStringArray(String[] strArray) {
		System.out.println("Array Length is "+strArray.length);
		for (String value:strArray)
			System.out.println(value);
		System.out.println(".............");
	  //System.out.println("Data: "+testJoinStr); 
	  // Since moving to display this local variable is not valid
	  // so I wont use it
	}
		
	public void presentUsage() {
		System.out.println("Matrix Data Entry.");
		System.out.println("Dimension example: 3x4");
		System.out.println("Matrix Values example: 1 3 2.3 4.125");
	}	
	
		public String[] getStringArray() {
			//System.out.println(debugOutput +"getSringArray");
			return this.arrayOfStrings;
		}
			
	
	
	
}// Class file done


// Keep this until I parse into actual numbers
				// curious Im not supposed to do this yet
				// this.mVals.add( Double.parseDouble( cmdLineInput[x] )); 