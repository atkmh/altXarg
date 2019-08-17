package main.java.com.matrixJava;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.Object;
import java.util.ArrayList;
import java.util.Arrays;


public class RuntimeInStringObj {

//[ late this class and RunTimeStirngObj do nearly the same thing
//  I feel like both of these classes need to be extensions of a subclass
//  Or theses are the subClass of some other root class.....	


	private String first = "-r";
	private String second ="";
	private String[] arrayOfStrings;
	private ArrayList<String> mVals = new ArrayList<String>();

	public RuntimeInStringObj() throws IOException {
		
		String mValues = "";
		String mDims = "";
		
		/* Present to the screen simple usage*/
		presentUsage();
		
		/* Request input */
		System.out.print("Enter Dimension: ");
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		mDims = br.readLine(); // something like 4x7

		if (mDims.contains("x") || mDims.contains("X") ) {
			this.second = mDims.replace('x', 'X');
	
            /* check every dimensinon char in the list */	
        	for(int i=0; i<this.second.length(); i++)
        		if( ! ( checklist(this.second.charAt(i)) ))
        			Usage.Usage("Problem: illegal char in Dimensions \n"+this.first +" " +this.second +" some Data");
        	
        	/* check if there wsa more and one X in the dimension */		
        	if ( 1 < (this.second.codePoints().filter(ch -> ch =='X').count()) )
			Usage.Usage("Problem: to many Xs \n"+this.first +" " +this.second +" some Data");
			
		}
        else {	
        //	System.out.print("There's a big Problem. ");
        // 	System.out.println("Dimension is not stated correctly. ");
			Usage.Usage("Problem: Matrix Dimensions was stated incorrectly \n "+this.first+" " +mDims +"\n");
        }	

		System.out.print("Enter Matrix Values: ");
		mValues = br.readLine(); // something like 4x7
		// dont think mvals needs to be a member variable, just a local string
		
		arrayOfStrings = mValues.split(" ");
		
		for (String strValue : arrayOfStrings) {
			mVals.add(strValue);
		}
		
	}

	
//	private boolean checklist(char myChar) {
//		String myRegex = "0123456789X";
//		boolean theAnswer = false; 
//		
//		for(int x=0 ; x < myRegex.length() ; x++)
//			if(myChar == myRegex.charAt(x))
//				theAnswer = true;
//		return theAnswer;
//	}
	
	
	
	public String debugOutput = "Debug: Currently in method ";
	
	public String[] getStringArray() {
		//System.out.println(debugOutput +"getSringArray");
		return this.arrayOfStrings;
	}
	
//	public String getFirst() {
//		//System.out.println(debugOutput +"getFirst");
//		return this.first;
//	}
//	
//	public String getSecond() {
//		//System.out.println(debugOutput +"getSecond");
//		return this.second;
//	}
	
//	public ArrayList getdata() {
//		//System.out.println(debugOutput +"getdata");
//		return this.mVals;
//	}	
	
//	public void displayStringArray(String[] strArray) {
//		System.out.println("Array Length is "+strArray.length);
//		for (String value:strArray)
//			System.out.println(value);
//		System.out.println(".............");
//	  //System.out.println("Data: "+testJoinStr); 
//	  // Since moving to display this local variable is not valid
//	  // so I wont use it
//		
//	}
	
	
	
//	public void presentUsage() {
//		System.out.println("Matrix Data Entry.");
//		System.out.println("Dimension example: 3x4");
//		System.out.println("Matrix Values example: 1 3 2.3 4.125");
////		System.out.println("");
////		System.out.println("");
////		System.out.println("");
//		
//		
//		
////		System.out.println("");
//	}
}









// end of document

//		for (int x = 0; x < arrayOfStrings.length; x++) {
//			mVals.add(arrayOfStrings[x]);