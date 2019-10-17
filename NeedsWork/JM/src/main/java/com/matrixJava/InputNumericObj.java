package main.java.com.matrixJava;

import java.util.ArrayList;

public class InputNumericObj {
	
	private double[] mxValues = null;
	/* As stated below, is mxVals Array List necessary ???   */
	private ArrayList<Double> mxVals = new ArrayList<Double>();
	private int M;
	private int N;
	private String  itemName;
	private String opperationalMode;

// so ???  Why isn't my may data carrier an arrayList
// my parse Srting Obj is 

	public InputNumericObj(InputStringObj strObj) {
	    int xLoc = strObj.getSecond().indexOf("X");
	   // Get Rows Value 
	    this.M = Integer.parseInt((strObj.getSecond().substring(0, xLoc )));

	   // Get Column value
	    this.N = Integer.parseInt((strObj.getSecond().substring(xLoc+1,strObj.getSecond().length() )));
		
	    mxValues = new double[  strObj.getdata().size() ];
	    
	    for (int x = 0 ; x < strObj.getdata().size(); x++) {
	        try {	
	    	     mxValues[x] = Double.parseDouble(strObj.get(x));
	    	} catch (Exception e) {
	    		 Usage.UsageRecoverable("Problem: A matrix value was not in [.0-9]mxValues ");
	    	}

	 /* OK, Somthing to Figure out.  Do I need to parst and assign to array List mxVals ???  */       
	        try {	
	    	     mxVals.add(Double.parseDouble(strObj.get(x)));
	    	} catch (Exception e) {
	    		 Usage.UsageRecoverable("Problem: A matrix value was not in [.0-9]mxVals ");
	    	}
	    	
	    }
		
		return ;
	}

	
	public int getM() {
		return this.M;
	}

	public int getN() {
		return this.N;
	}
	
	public double get(int index) {
		return mxValues[index];
	}
	
	public double[] getArrayData() {
		return this.mxValues;
	}
	
	public ArrayList<Double> getArrayListData() {
		return this.mxVals;
	}
	
	
	public void setCell(int index, double val) {
		this.mxValues[index] = val;
	}
	
	public void setOppMode(String mode) {
		this.opperationalMode = mode;
	}
	
	
    private void setOrderValues(String dimension) {
    // maybe I dont' use this....... ?	
    }
    
    public void displayNumMatrixValues() {
    	System.out.print("numeric Matrix values: ");
    	for (int x=0 ; x < mxValues.length; x++) 
    		System.out.print(mxValues[x] +" ");
    	System.out.println("");
    	
    	
    }
}
