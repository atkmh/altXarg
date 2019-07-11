package test.java.com.matrixJava;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import main.java.com.matrixJava.MMatrixx;
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
		MMatrixx testRunMatrix = new MMatrixx();
		MMatrixx firstRunMatrixParams = new MMatrixx(3,3, inputTestData);
		MMatrixx secondRunMatrixParams = new MMatrixx(3,3, columnwise);
//		MMatrixx secondRunMatrixParams = new MMatrixx(3,8, condmat);
		firstRunMatrixParams.displayDeepString();
		secondRunMatrixParams.displayDeepString();
	
		
		MMatrixx addResult = firstRunMatrixParams.Add(secondRunMatrixParams);
		addResult.setName("A");
		addResult.displayDeepString();
		System.out.println("");
		addResult.display();
		
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