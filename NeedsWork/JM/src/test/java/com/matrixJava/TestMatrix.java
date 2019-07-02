package test.java.com.matrixJava;

import java.util.ArrayList;
import java.util.Arrays;

import main.java.com.matrixJava.Matrix;

public class TestMatrix {

	public static void main(String[] args) {
	//	ArrayList <Integer> inputDataArray = (ArrayList<Integer>) Arrays.asList(3, 4, 6, 11, 88);
		
		ArrayList<Integer> inputTestData = new ArrayList<Integer>();
		inputTestData.add(11);
		inputTestData.add(2);
		inputTestData.add(3);
		inputTestData.add(6);
		inputTestData.add(11);
		inputTestData.add(88);

		System.out.println();
		System.out.println(inputTestData.toString());
//		System.out.println("Test Running Class: " +this.getClass()  ) ;	
		
		Matrix  testRunMatrix = new Matrix(2, 3, inputTestData  );


		
		System.out.println("*********************");
		System.out.println("*********************");
		System.out.println("*********************");
		System.out.println("*********************");
		System.out.println("*********************");
		
		//System.out.println(testRunMatrix.toString());
		//secTestM.displayDeepString(secTestM);
		
	}

}
/*
 * int testR, testC, A, B, C, D, E, F, G, H; testR=3; testC=4; A=22; B=33; C=12;
 * D=13; E=17; F=11;
 * 
 * Matrix testMatrix = new Matrix(i, j, A, B, C, D ); Matrix secTestM = new
 * Matrix (i,j,i*A,j*B,i*C,j*D);
 */