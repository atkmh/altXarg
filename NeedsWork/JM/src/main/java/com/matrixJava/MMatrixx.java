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

public class MMatrixx {
	
	
	 int mRows;
	 int nCols;
	 int m_data[][];
	
	public MMatrixx(){System.out.println("defualtConstructor MMatrixx class");}

	public MMatrixx(int M, int N, ArrayList dataAryLst)
	{ 
		this.mRows = M; // i: rows
		this.nCols = N; // j; cols
		m_data = new int[mRows][nCols];

		Iterator<Integer> dataIter = dataAryLst.iterator();

		for (int i=0; i<mRows; i++) { 
			for (int j=0; j<nCols; j++) {
				try {
				if (dataIter.hasNext()) {
					m_data [i][j] = dataIter.next();
					System.out.println(m_data[i][j]);
				} else {
					m_data [i][j] = 0;
				}
				}catch (NullPointerException e) {
					System.out.print("Exception: " +e +" ");
					System.out.println("i:" +i +" j:"+j +"data: " );
				}
			}
		}
		
		
		System.out.println("first Parameterized Constructor completed");
	}

	public static void main(String[] args) {
		System.out.println("*****************");
		System.out.println("From Within MMatrixx class main method");
		System.out.println("*****************");
		
		MMatrixx myMMatrixxxxx = new MMatrixx();
	}
	
	
	
//	public static void Add() {
	public void Add() {
		System.out.println("We are inside the Matrix.Add() method");
	}

//	public static void Subtract( ) {  // Sub for Subtract
	public void Subtract( ) {  // Sub for Subtract
		System.out.println("We are inside the Matrix.Sub() method");
	}

//	public static void Mult( ) {  // Mult for multiply
	public void Mult( ) {  // Mult for multiply
	/* if a.N != b.M  then illegal operation on given matrices */
		System.out.println("We are inside the Matrix.Sub() method");
	}

//	public static void displayDeepString( ) {
	public  void displayDeepString( ) {
		System.out.println(Arrays.deepToString(m_data));
	}
}
