package test.java.com.matrixJava;

import java.util.ArrayList;

import main.java.com.matrixJava.Matrix;

public class TestMatrix {

	public static void main(String[] args) {
	//	ArrayList <Integer> inputDataArray = (ArrayList<Integer>) Arrays.asList(3, 4, 6, 11, 88);

		
		double[] columnwise = {1.,2.,3.,4.,5.,6.,7.,8.,9.,10.,11.,12.};
		 double[] condmat = {1.,3.,7.,9.};

	String[] inputARGNull = null ;
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
		
//		Matrix  testRunMatrix = new Matrix(2, 3, inputTestData  );
		Matrix testRunMatrix = new Matrix();
		Matrix firstRunMatrixParams = new Matrix(3,3, inputTestData);
		Matrix secondRunMatrixParams = new Matrix(3,3, columnwise);
//		Matrix secondRunMatrixParams = new Matrix(3,8, condmat);
		firstRunMatrixParams.displayDeepString();
		secondRunMatrixParams.displayDeepString();
	
		
		Matrix addResult = firstRunMatrixParams.Add(secondRunMatrixParams);
		addResult.setName("A");
		addResult.displayDeepString();
		System.out.println("");
		TestUtilsMeth.display(addResult);
		
/*		

		System.out.println("From TestMatrix.class");
		System.out.println("*********************");
		System.out.println("*********************");
		System.out.println("*********************");
		System.out.println("*********************");
		System.out.println("*********************");
		
		//secTestM.displayDeepString(secTestM);
 * 
 */		
		
	}

}
/*
 * int testR, testC, A, B, C, D, E, F, G, H; testR=3; testC=4; A=22; B=33; C=12;
 * D=13; E=17; F=11;
 * 
 * Matrix testMatrix = new Matrix(i, j, A, B, C, D ); Matrix secTestM = new
 * Matrix (i,j,i*A,j*B,i*C,j*D);
 */