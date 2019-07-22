package test.java.com.matrixJava;

import java.util.ArrayList;

import main.java.com.matrixJava.Matrix;

public class TestMatrix {

	public static void clearScreen() {  
	    System.out.print("\033[H\033[2J");  
	    System.out.flush();  
	}  	
	
	public static void main(String[] args) {
	//	ArrayList <Integer> inputDataArray = (ArrayList<Integer>) Arrays.asList(3, 4, 6, 11, 88);

		
		double[] columnwise = {1.,2.,3.,4.,5.,6.,7.,8.,9.,10.,11.,12.};
		double[] condmat = {1.,3.,7.,9.};
		int[] matrixDimension = new int[10]; // dont except to ever use more than 4 cells. would by 99x99

	String[] inputARGNull = null ;
		ArrayList<Integer> inputTestData = new ArrayList<Integer>();
		inputTestData.add(11);
		inputTestData.add(2);
		inputTestData.add(3);
		inputTestData.add(6);
		inputTestData.add(11);
		inputTestData.add(18);
  
//		System.out.println();
//		System.out.println(inputTestData.toString());
//		System.out.println("Test Running Class: " +this.getClass()  ) ;	
//		Matrix  testRunMatrix = new Matrix(2, 3, inputTestData  );

		Matrix testRunMatrix = new Matrix();
		testRunMatrix.setName("testRunMatrix");
		testRunMatrix.displayC();
//		clearScreen();

		Matrix firstRunMatrixParams = new Matrix(3,3, inputTestData);
		firstRunMatrixParams.setName("firstRunMatrixParams");
		firstRunMatrixParams.displayC();
//		clearScreen();
		
		Matrix secondRunMatrixParams = new Matrix(3,3, columnwise); // or condmat
		secondRunMatrixParams.setName("secondRunMatrixParams");
		secondRunMatrixParams.displayC();
//		clearScreen();
		
	//	firstRunMatrixParams.displayDeepString();
	//	secondRunMatrixParams.displayDeepString();
		matrixDimension[0]=2;
		matrixDimension[1]=3;
	
		Matrix outOfSeqTestMatrix = new Matrix(matrixDimension, columnwise);
		secondRunMatrixParams.setName("outOfSeqTestMatrix");
		secondRunMatrixParams.displayC();
		
		Matrix addResult = firstRunMatrixParams.Add(secondRunMatrixParams);
		addResult.setName("addResult");
		
		addResult.displayC();
//		clearScreen();
		
//		addResult = addResult.Multiply((22/7));
		addResult = addResult.Multiply(3.623);
		addResult.displayM();
//		clearScreen();
		
	}// end Main()

}// end Class
/*
 * int testR, testC, A, B, C, D, E, F, G, H; testR=3; testC=4; A=22; B=33; C=12;
 * D=13; E=17; F=11;
 * 
 * Matrix testMatrix = new Matrix(i, j, A, B, C, D ); Matrix secTestM = new
 * Matrix (i,j,i*A,j*B,i*C,j*D);

		System.out.println("From TestMatrix.class");
		System.out.println("*********************");
		System.out.println("*********************");
		System.out.println("*********************");
		System.out.println("*********************");
		System.out.println("*********************");
		
		//secTestM.displayDeepString(secTestM);
 * 
 */		