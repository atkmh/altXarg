package main.java.com.matrixJava;

import java.util.Arrays;

public class Matrix {

    int mRows, mCols;
	int [][] m_data;
	

	
	
	public static void main(String[] args) {
	int mainRow, mainCol,A0,A1,B0,B1;
	mainRow=3; mainCol=4;
	A0=2; A1=4; B0=3; B1=7;
	Matrix myNewMatrix = new Matrix(mainRow, mainCol);
	Matrix myOtherMatrix = new Matrix(mainRow, mainCol, A0,A1,B0,B1);
	myNewMatrix.Add(myOtherMatrix);	
	}

	
	// Contstructor just the size / order
	Matrix( int n, int m){
		this.mRows = n;
		this.mCols = m;
		System.out.println("this is the only current contructor");
	}

	// Fixed size known at compile time 2X2 is dimension this has.
	// * Trying to figure out if this arch could make me a 1X4 or a 4X1 as well.
	// Contstructor Size, order , and all values
	public Matrix( int n, int m, int A1, int A2, int B1, int B2    ){
		this.mRows = n;
		this.mCols = m;
		int [][] m_data = new int[n][m];
		for  (int i = 0; i < m_data.length; i++) { 
			for (int j = 0; j < m_data[i].length; j++) { 
				m_data[i][j] = i + j; 
			} 
		}
		System.out.println(Arrays.deepToString(m_data));

		m_data[0][0]=A1;
		m_data[0][1]=A2;
		m_data[1][0]=B1;
		m_data[1][1]=B2;
		System.out.println(Arrays.deepToString(m_data));
		
		int[][] board = new int[n][m]; 
		for (int i = 0; i < board.length; i++) { 
			for (int j = 0; j < board[i].length; j++) { 
				board[i][j] = i + j; 
			} 
		}
		System.out.println("this is the other contructor with data");
		for (int[] a : board) { 
			for (int i : a) { 
				System.out.print(String.format("%5d", i*i*i)); 
			} 
			System.out.println(); //System.out.println("\n"); //System.out.print("\n"); 
		}
	}
	
	public static void displayDeepString(Matrix m) {
		System.out.println(Arrays.deepToString(m.m_data));
	}

	

	
	public static void Add(Matrix B) {
		System.out.println("We are inside the Matrix.Add() method");
	}

	public static void Sub(Matrix B) {  // Sub for Subtract
		System.out.println("We are inside the Matrix.Sub() method");
	}

	public static void Mult(Matrix B) {  // Mult for multiply
		System.out.println("We are inside the Matrix.Sub() method");
	}
}
	


