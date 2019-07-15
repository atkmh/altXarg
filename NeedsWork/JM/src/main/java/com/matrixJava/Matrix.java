// resource 
// G: java 2d array
// https://www.google.com/search?q=java+2d+array&rlz=1C1GCEB_en___US816&oq=java+2d&aqs=chrome.0.0j69i57j69i60l2j0l2.4360j0j7&sourceid=chrome&ie=UTF-8&safe=active
// https://www.geeksforgeeks.org/multidimensional-arrays-in-java/

package main.java.com.matrixJava;

import java.util.ArrayList;
import java.util.Arrays;
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
import java.util.List;
import java.util.Locale;


public class Matrix {
	
	
	private int mRows;
	private int nCols;
//	int m_data[][];
	private double m_data[][];  // JAMA names A
	private String m_varName;
	
	public Matrix(){System.out.println("defualtConstructor Matrix class");}
	
	public Matrix(int M, int N){
		//System.out.println("defualtConstructor Matrix class");
		this.mRows = M;
		this.nCols = N;
		m_data = new double [mRows][nCols];
	}

	
	
	public Matrix(int M, int N, double[] dataArylst) {
		this.mRows = M; // i: rows
		this.nCols = N; // j; cols
		m_data = new double [mRows][nCols];
		int inputLen = dataArylst.length, dataIndex = 0;
		
		for (int i=0; i<mRows; i++) { 
			for (int j=0; j<nCols; j++) {
				try {	if (inputLen >= dataIndex   ) { // same as !(dataindex < inputlen)
						m_data [i][j] = dataArylst[dataIndex++];
					}else {	m_data [i][j] = 0;
					}
				} catch ( Exception e) {	System.out.println("Exception was: " +e);
				}
			}
		}   System.out.println("Second Parameterized Constructor double [] completed");
	}
	
	
	public Matrix(int M, int N, ArrayList dataAryLst)
	{ 
		this.mRows = M; // i: rows
		this.nCols = N; // j; cols
//		m_data = new int[mRows][nCols];
		m_data = new double [mRows][nCols];

		Iterator<Integer> dataIter = dataAryLst.iterator();

		for (int i=0; i<mRows; i++) { 
			for (int j=0; j<nCols; j++) {
				try {
				if (dataIter.hasNext()) {
					m_data [i][j] = dataIter.next();
					System.out.println("debugOut  i:" +i +" j:" +j +" value:" +m_data[i][j]);
				} else {
					m_data [i][j] = 0;
					System.out.println("debugOut  i:" +i +" j:" +j +" value:" +m_data[i][j]);
				}
				}catch (NullPointerException e) {
					System.out.print("Exception: " +e +" ");
					System.out.println("i:" +i +" j:"+j +"data: " );
				}
			}
		}
		
		
		System.out.println("first Parameterized Constructor ArrayList completed");
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
	
	
	 public Matrix Add( Matrix B ) {
	  Matrix A = this; 
	  if (B.mRows != A.mRows || B.nCols !=A.nCols ) {
		  System.out.println("A serous problem: No Exception at this time Exiting");
		  System.exit(-1); 
	  } 
	  Matrix C = new Matrix(mRows,nCols);
	  for (int i = 0 ; i < mRows ; i++)
		  for (int j = 0; j < nCols ; j++)
			  C.m_data[i][j] = A.m_data[i][j] + B.m_data[i][j];
	  System.out.println("We are finishing from inside the Matrix.Add() method"); 
	  return C;
	 }
	  
	 

//	public static void Subtract( ) {  // Sub for Subtract
	public void Subtract( ) {  // Sub for Subtract
		System.out.println("We are inside the Matrix.Sub() method");
	}

	public void Multply(Matrix B ) {  // Mult for multiply

	     if ( B.M != this.nCols ) { 
	    	 System.out.println);illegal operation on given matrices */
		       System.out.println("We are inside the Matrix.Sub() method");
	      }
	
	}

//	public static void displayDeepString( ) {
	public  void displayDeepString( ) {
		System.out.println(Arrays.deepToString(m_data));
	}

	public void display() { // Doesn't need an argument. Method display 
							// refers to what ever object is in play
    	System.out.println("Matrix: " +this.m_varName);
        for (int i = 0; i < mRows; i++) {
            for (int j = 0; j < nCols; j++) {
                System.out.printf("%5.2f   ", m_data[i][j] );// or "%9.4f ", data[i][j]
            } System.out.println();
        }	
	}

	/**
	 * Get row dimension.
	 * @return m, the number of rows.
	 */
	
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

}
