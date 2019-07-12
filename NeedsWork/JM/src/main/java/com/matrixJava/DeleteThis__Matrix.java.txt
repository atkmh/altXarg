package main.java.com.matrixJava;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.ListIterator;

final public class Matrix {

 /*  private int mRows;
   private int nCols;
   private int m_data[0][0] = (int)21;
*/	
  
/*	public Matrix( int m, int n, ArrayList<Integer> data   ){
		this.mRows = m;
		this.nCols = n;
		int[][] m_data = new int[n][m];
		
		ListIterator<Integer> listIter = data.listIterator();
	
		for  (int i = 0; i < mRows; i++) { 
			for (int j = 0; j < nCols; j++) { 
				if(listIter.hasNext()) 
				m_data[i][j] = listIter.next();
				else
				m_data[i][j] = 0;
			} 
		}
	} */
  
	
/*	
   // Contstructor just the size / order
   Matrix( int n, int m ){ // Shold be zero filled
		this.mRows = n;
		this.nCols = m;
		m_data = new int[mRows][nCols];
	}  */


		
//	System.out.println(Arrays.deepToString(m_data));

   public static void main(String args[]) {

		System.out.println("in Matrix.java main");
		

	}	
	
	public static void Add(Matrix B) {
		System.out.println("We are inside the Matrix.Add() method");
	}

	public static void Subtract(Matrix B) {  // Sub for Subtract
		System.out.println("We are inside the Matrix.Sub() method");
	}

	public static void Mult(Matrix B) {  // Mult for multiply
	/* if a.N != b.M  then illegal operation on given matrices */
		System.out.println("We are inside the Matrix.Sub() method");
	}

	public static void displayDeepString(Matrix m) {
		System.out.println(Arrays.deepToString(m.m_data));
	}

	

	
	
}// end of ClassFile Matrix.java
	


