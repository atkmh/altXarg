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


	private String dimension;
	private String mValues; 
	private String first = "-r";
	private String second ="";
	private String[] arrayOfStrings;
	private ArrayList<String> mVals = new ArrayList<String>();

	public RuntimeInStringObj() throws IOException {
		
		presentUsage();
	
	/*
		System.out.print("Enter Data: ");
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		strReadIn = br.readLine();
		String myOptions= "-r ";
		String testJoinStr = myOptions + strReadIn ;
		arrayOfStrings = testJoinStr.split(" ");
	*/	
		System.out.print("Enter Dimension: ");
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		dimension = br.readLine(); // something like 4x7

		System.out.print("Enter Matrix Values: ");
		mValues = br.readLine(); // something like 4x7

		String tmpStr = "";
		String myOptions= "-r ";
		tmpStr = myOptions + mValues;
		arrayOfStrings = tmpStr.split(" ");
		
		for (int x = 0; x < arrayOfStrings.length; x++) {
			mVals.add(arrayOfStrings[x]);
		}
		
	}

	public String debugOutput = "Debug: Currently in method ";
	
	public String[] getStringArray() {
		//System.out.println(debugOutput +"getSringArray");
		return this.arrayOfStrings;
	}
	
	public String getFirst() {
		//System.out.println(debugOutput +"getFirst");
		return this.first;
	}
	
	public String getSecond() {
		//System.out.println(debugOutput +"getSecond");
		return this.second;
	}
	
	public ArrayList getdata() {
		//System.out.println(debugOutput +"getdata");
		return this.mVals;
	}	
	
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
//		System.out.println("");
//		System.out.println("");
//		System.out.println("");
		
		
		
//		System.out.println("");
	}
}









// end of document
