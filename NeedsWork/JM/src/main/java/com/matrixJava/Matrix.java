// resource 
// G: java 2d array
// https://www.google.com/search?q=java+2d+array&rlz=1C1GCEB_en___US816&oq=java+2d&aqs=chrome.0.0j69i57j69i60l2j0l2.4360j0j7&sourceid=chrome&ie=UTF-8&safe=active
// https://www.geeksforgeeks.org/multidimensional-arrays-in-java/

package main.java.com.matrixJava;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

//  following from JAMA Matrix source
//  added here cus I want to investigate the Print method

import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.StreamTokenizer;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
import java.util.Random;


public class Matrix {
	
/* **************************************************
 *  Class Variables
 *  Private
 * 	Accessible via Public Functions
 * **************************************************/

	private String creationTS;
	/* ****************************************
	 *  modificaitonTC: "HEAD" or a time stamp *  HEAD Means it is most recent
	 *  TimeStamp refers to the time it was changed *  and a new HEAD took it's place
	 */
	private String rowOperations;
	private String modificationTS;
    private String modificationCommand;
	private int mRows;
	private int nCols;
//	public int mRows;
//	public int nCols;
	private double m_data[][];  // JAMA names A
	private String m_varName;
//	private Object dataObject;  // Sort of a place holder for the parsed dataObject that I haven't done yet.Compiles: Runs.


/* **************************************************
 *  Constructors
 *  Default: Does nothing but print. Could go away
 *	Minimal1: Input: Row dimensions mRows, nCols   Action:  creates a new Array of dimension 
 *  Medium1   Input Row Dims, Array of values	
 *  Medium2   Input Row dims, ArrayList of values
 */
	
	public Matrix(){System.out.println(/* "defualtConstructor Matrix class" */ );}
	
	
	public Matrix(int M, int N){
		//System.out.println("defualtConstructor Matrix class");
		this.mRows = M;
		this.nCols = N;
		m_data = new double [mRows][nCols];
		creationTS =  new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
	} // end of constructor

	
	
	public Matrix(int[]dimension, double[] dataArylst) {
		this.mRows = dimension[0]; // i: rows
		this.nCols = dimension[1]; // j; cols
		m_data = new double [mRows][nCols];
		int inputLen = dataArylst.length, dataIndex = 0;
		
		for (int i=0; i<mRows; i++) { 
			for (int j=0; j<nCols; j++) {
// inputLen may be 10 but indicies needs to be 0--9  so needs to be < 10 not <=10
//				try {	if (inputLen >= dataIndex   ) { // same as !(dataindex < inputlen)
				try {	if (inputLen > dataIndex   ) { // same as !(dataindex < inputlen)
						m_data [i][j] = dataArylst[dataIndex++];
					}else {	m_data [i][j] = 0;
					}
				} catch ( Exception e) {	System.out.println("Exception was: " +e);
				}
			}
		} // System.out.println("Second Parameterized Constructor double [] completed");
		creationTS =  new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
	}
	
	public Matrix(int M, int N, double[] dataArylst) {
		this.mRows = M; // i: rows
		this.nCols = N; // j; cols
		m_data = new double [mRows][nCols];
		int inputLen = dataArylst.length, dataIndex = 0;
		
		for (int i=0; i<mRows; i++) { 
			for (int j=0; j<nCols; j++) {
// inputLen may be 10 but indicies needs to be 0--9  so needs to be < 10 not <=10
//				try {	if (inputLen >= dataIndex   ) { // same as !(dataindex < inputlen)
				try {	if (inputLen > dataIndex   ) { // same as !(dataindex < inputlen)
						m_data [i][j] = dataArylst[dataIndex++];
					}else {	m_data [i][j] = 0;
					}
				} catch ( Exception e) {	System.out.println("Exception was: " +e);
				}
			}
		} // System.out.println("Second Parameterized Constructor double [] completed");
		creationTS =  new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
	}
	
	
	
	public Matrix(int M, int N, ArrayList dataAryLst) // Yanked: m_data = new int[mRows][nCols];
	{   this.mRows = M; // i: rows
		this.nCols = N; // j; cols
		m_data = new double [mRows][nCols];

		Iterator<Integer> listIterator = dataAryLst.iterator();

		for (int i=0; i<mRows; i++) { 
			for (int j=0; j<nCols; j++) {
				try {
				if (listIterator.hasNext()) {
					m_data [i][j] = listIterator.next();
				//	System.out.println("debugOut  i:" +i +" j:" +j +" value:" +m_data[i][j]);
				} else {
					m_data [i][j] = 0;
				//	System.out.println("debugOut  i:" +i +" j:" +j +" value:" +m_data[i][j]);
				}
				}catch (NullPointerException e) {
					System.out.print("Exception: " +e +" ");
					System.out.println("i:" +i +" j:"+j +"data: " );
				}
			}
		} // System.out.println("first Parameterized Constructor ArrayList completed");
		creationTS =  new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
	}

	public Matrix(InputNumericObj inputNumObj,String Name) {
  		this.m_varName = Name;
        this.mRows = inputNumObj.getM();
        this.nCols = inputNumObj.getN();
		m_data = new double [mRows][nCols];
		
		ArrayList<Double> localList = inputNumObj.getArrayListData();
	
//		Iterator<Integer> listIterator = getArrayListData().iterator();
		Iterator<Double> listIterator = localList.iterator();
	
		for (int i=0; i<mRows; i++) {
		    for(int j=0; j<nCols; j++)	{
		    	try {
		    		if (listIterator.hasNext()) {
						m_data [i][j] = listIterator.next();
					//	System.out.println("debugOut  i:" +i +" j:" +j +" value:" +m_data[i][j]);
					} else {
						m_data [i][j] = 0;
					//	System.out.println("debugOut  i:" +i +" j:" +j +" value:" +m_data[i][j]);
					}  
		    	} catch(NullPointerException e) {	
		    		System.out.println("Exception: " +e +" ");
					System.out.println("i:" +i +" j:"+j +"data: " );
		    	}//end tryCatch
		    }
			
		}
	
	
		creationTS =  new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());	
		modificationCommand = "Creation";
		modificationTS = "None Yet";
    }

/*  
 *  Copy:
 *  Deep copy of m_data
 *  copy varname,
 *  copy creation time 
 */
    public Matrix copy(){
         Matrix B = new Matrix(this.mRows, this.nCols); 
         double[][] C = B.getArray();
         
         for (int i=0; i < this.mRows; i++) {
        	 for(int j=0; j < this.nCols ; j++ ) {
        		 C[i][j]  = this.m_data[i][j];
        	 }
         }
         B.m_varName = this.m_varName;
         B.creationTS = this.creationTS;
    return B;	
    }
	
	public static void main(String[] args) {
		System.out.println("*****************");
		System.out.println("From Within Matrix class main method");
		System.out.println("*****************");
		
		Matrix myMatriXX = new Matrix();
	}
     
	   /** Access the internal two-dimensional array.
	   @return     Pointer to the two-dimensional array of matrix elements.
	   */public double[][] getArray () {
		      return m_data;
		   }	
	

	   
	public Matrix Add(Matrix B) {
		Matrix A = this;
		if (B.mRows != A.mRows || B.nCols != A.nCols) {
			System.out.println("A serous problem: Matrix dimensions were not equal.  Done");
			return null;
		}
		Matrix C = new Matrix(mRows, nCols);
		for (int i = 0; i < mRows; i++)
			for (int j = 0; j < nCols; j++)
				C.m_data[i][j] = A.m_data[i][j] + B.m_data[i][j];
		System.out.println("We are finishing from inside the Matrix.Add() method");
		C.creationTS = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
		return C;
	}

	/**
	 * C = A + B
	 * 
	 * @param B another matrix
	 * @return A + B
	 */
	public Matrix MxAdd(Matrix B) {
		checkMxDims(B); // are rows and cols the same ?
		Matrix X = new Matrix(mRows, nCols);
		double[][] C = X.getArray();
		for (int i = 0; i < mRows; i++) {
			for (int j = 0; j < nCols; j++) {
				C[i][j] = this.m_data[i][j] + B.m_data[i][j];
			}
		}
		return X;
	}

//	public static void Subtract( ) {  // Sub for Subtract
	public Matrix Subtract(Matrix B ) {  // Sub for Subtract
		checkMxDims(B); // are rows and cols the same ?i
		Matrix A = this; // just makes it easer to write the equation
		Matrix X = new Matrix(mRows, nCols);
		double [][] C = X.getArray();
		for (int i=0; i < mRows; i++)
            for (int j=0 ; j < nCols; j++)
            	X.m_data [i][j] = A.m_data[i][j] - B.m_data[i][j];
		
		return X;
	}



	/* *******************************************************************
	 * Because I"m Performing Ax = B  we know the dimensions
	 * of A, hence B will have the same
	 * 
	 * @input x is a scalar to multiply against current Matrix
	 * @output Matrix, B.  Result of Ax = B
	 */
	
	public Matrix Multiply(double scalar) {
	    String tmpTS  = this.creationTS;	
		Matrix my_Matrix = new Matrix (mRows, nCols); 
		my_Matrix.m_varName = this.m_varName;
		
		double [][] B = my_Matrix.getArray(); // interesting code, go get a pointer to my data
		
		// Now in for loops multiply every entry by the Scalar
		for (int i = 0; i < mRows; i++) {
			for(int j = 0; j < nCols ; j++) {
				B[i][j] = scalar*m_data[i][j];
			}// end inner for loop
		}// end outer for loop
		my_Matrix.modificationTS =  new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
		// I'm doing the following so that I capture the ornginal matrix creation time, not this new one.
		my_Matrix.creationTS = tmpTS;  
	return my_Matrix;	
	}	

	
	public Matrix Multiply(Matrix B) throws IllegalArgumentException {
		Matrix A = this;
		if (A.nCols != B.mRows) 
			throw new IllegalArgumentException("A serous problem: Inner Matrix dimensions were not equal.  Done");
		Matrix C = new Matrix(A.mRows, B.nCols);
		for (int i=0; i < C.mRows; i++) 
			for (int j=0; j < C.nCols; j++) 
				for (int k=0; k < A.nCols; k++ )
					C.m_data[i][j] += (A.m_data[i][k] * B.m_data[k][j]);
		// C.m_varName = "" ;  I don't know the actual factor names. Do this in StaticProcedures
		C.creationTS = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
		return C;
	}
	

	

//	public static void displayDeepString( ) {
	public  void displayDeepString( ) {
		System.out.println(Arrays.deepToString(m_data));
	}

	public void displayCompact() { // Display Compact vs DisplayMore
		// Doesn't need an argument. Method display 
							// refers to what ever object is in plaoy
		System.out.println("Diminsion: "+mRows +"X"+nCols);
		if (this.m_varName == null)  System.out.println("Matrix: \"Unnamed\"");  
		else  System.out.println("Matrix: " +this.m_varName);
        for (int i = 0; i < mRows; i++) {
            for (int j = 0; j < nCols; j++) {
                System.out.printf("%5.2f   ", m_data[i][j] );// or "%9.4f ", data[i][j]
            } System.out.println();
        } System.out.println("");
	}

	
	
	
	
	public void displayMore() { // DisplayMore
		// Doesn't need an argument. Method display 
							// refers to what ever object is oin play
		System.out.println("Diminsion: "+mRows +"X"+nCols);
		if (this.m_varName == null) System.out.println("Matrix: \"Unnamed\"");  
		else  System.out.println("Matrix: " +this.m_varName);
        for (int i = 0; i < mRows; i++) {
            for (int j = 0; j < nCols; j++) {
                System.out.printf("%15.8f   ", m_data[i][j] );// or "%9.4f ", data[i][j]
            } System.out.println();
        }System.out.println("");
	}
	/**
	 * Get row dimension.
	 * @return m, the number of rows.
	 */

   private void checkMxDims(Matrix B) {
	  if ( B.mRows != this.mRows || B.nCols != this.nCols  ) {
		  throw new IllegalArgumentException("Matrix Dimensions must Be Equal.");
	  }
   }
	
	public Matrix SwapRows(int i, int j) {
		if(i < 0 || j < 0 )
			 throw new IllegalArgumentException("Matrix Dimensions must Be Equal.");
		if (i> this.mRows || j > this.nCols)
			 throw new IllegalArgumentException("Matrix Dimensions must Be Equal.");
        Matrix C = this.copy();
        double[] temp = C.m_data[i];
        C.m_data[i] = C.m_data[j];
        C.m_data[j] = temp;
        this.modificationCommand="swapRows(" +i +"," +j+")";
	//  Is'nt swapRows supposed to identify the Time this is done ??
    // On a bigger note does the mod command belong to this or to C ??
     return C;
	}
	
	public int getRowDimension() {
//	  return m;  // Orig var from JAMA
	  return mRows; // my var name
	}

	/**
	 * Get column dimension.
	 * @return n, the number of columns.
	 */
	public int getColumnDimension() {
//	  return n;   // Orig var from JAMA
	  return nCols; // my var name
	}
	
	public String getName() {
		return m_varName;
	}
	
	public void setName(String str) {
		this.m_varName = str ;
	}
	
	public void setModifyingCommand (String str) {
		this.modificationCommand = str;
	}
	
	public void setRowOperation (String str) {
		this.rowOperations = str;
	}
	
	public void setModTimeStamp() {
		this.modificationTS = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
	}
	
    public String getRowOpp() {
    	return rowOperations;
    }
	
	public String getModCmd() {
		return modificationCommand;
	}

	public String getModTimeStamp() {
		return modificationTS;
	}
	
	public String getCreationTimeStamp() {
		return creationTS;
	}
	
	/**
	* Get a single element.
	* @param i  Row index.
	* @param j  Column index.
	* @return A(i,j)
	* @exception ArrayIndexOutOfBoundsException
	***************************************************/
	public double get(int i, int j) {
	  return m_data[i][j];  // currently thinking is that A is m_data
	}
	
    public double[][] getData(){
      return m_data;
    }	
    
    /* ********************************************
     *  Potentially destructive
     *  Will write over all existing data
     */
    public Matrix setLinearData() {
	    String tmpTS  = this.creationTS;	
		Matrix tempMx = new Matrix (mRows, nCols); 
		tempMx.m_varName = this.m_varName;
		double [][] B = tempMx.getArray(); 
		
         Double value = 1.0;
         for(int i=0; i < mRows; i++) {
        	 for(int j=0; j<nCols ; j++) {
         //      temp.m_data[i][j] = value++;
                 B[i][j] = value++;
        	 }
         }
         tempMx.modificationCommand = "Set Linear Data";
         tempMx.modificationTS =  new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
		 
		 return tempMx;
    }
    public Matrix setRandData() {
	    String tmpTS  = this.creationTS;	
		Matrix tempMx = new Matrix (mRows, nCols); 
		tempMx.m_varName = this.m_varName;
		double [][] B = tempMx.getArray();
    	
    	Random rData = new Random();
        for(int i=0; i < mRows; i++) {
       	  for(int j=0; j<nCols ; j++) {
                B[i][j] = rData.nextDouble();
       	  }
        }
        tempMx.modificationCommand = "Set Random Data";
		tempMx.modificationTS =  new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
		return tempMx;
    }

}
