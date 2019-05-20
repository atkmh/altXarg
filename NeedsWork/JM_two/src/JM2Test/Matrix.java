package JM2Test;

import java.util.Arrays;

public class Matrix {

    int mRows, mCols;
	//int [][] m_data;
	

	
	
	public static void main(String[] args) {
	int mainRow, mainCol,A0,A1,B0,B1;
	mainRow=3; mainCol=4;
	A0=2; A1=4; B0=3; B1=7;
	Matrix myNewMatrix = new Matrix(mainRow, mainCol);
	Matrix myOtherMatrix = new Matrix(mainRow, mainCol, A0,A1,B0,B1);
		
	}

	
	// Contstructor
	Matrix( int n, int m){
		this.mRows = n;
		this.mCols = m;
		System.out.println("this is the only current contructor");
	}

	
	// Contstructor
	Matrix( int n, int m, int A1, int A2, int B1, int B2    ){
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
		System.out.println(Arrays.deepToString(board));
		System.out.println("this is the other contructor with data");
		for (int[] a : board) { 
			for (int i : a) { 
				System.out.print(i + "\t"); } 
			System.out.println("\n"); }
	}
	
	
	
	public static void Add() {
		
	}
}
	


