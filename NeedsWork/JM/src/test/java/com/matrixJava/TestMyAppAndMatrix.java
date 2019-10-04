package test.java.com.matrixJava;

import java.io.IOException;
import java.util.ArrayList;

import main.java.com.matrixJava.MyApp;
import main.java.com.matrixJava.Matrix;

public class TestMyAppAndMatrix {

	public static void clearScreen() {  
	    System.out.print("\033[H\033[2J");  
	    System.out.flush();  
	}  	
	
	public static void main(String[] args) throws IOException {
//	//	ArrayList <Integer> inputDataArray = (ArrayList<Integer>) Arrays.asList(3, 4, 6, 11, 88);
//
//		System.out.println("Test File Running MyApp Class in TestMyAppAndMatrix.java,  Parsing input");
//
//		System.out.println("Test Running Class: " +this.getClass().getSimpleName()  ) ;	
//		System.out.println("---------------------------------------------------------\n");		
		
		TestUtilsMeth.testHeader("TestMyAppAndMatrix.java");	
		
//		double[] columnwise = {1.,2.,3.,4.,5.,6.,7.,8.,9.,10.,11.,12.};
//		double[] condmat = {1.,3.,7.,9.};

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


		  
		  System.out.println("TestMyAppInput:  call MyApp.main() with String[] \n{{-c 3x4, 12, 32, 43, 44, 45, 56, 47, 38, 29             };");
		  try {
			MyApp.main(new String[] {"-c", "3x4","12", "32", "43", "44","45", "56", "47","38","29"});
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  
		  
		  System.out.println("TestMyAppInput:  call MyApp.main() with String[] \n{{-c 3x4, 12 32  43 44 45 56 47 38 29   };");
		  try {
			MyApp.main(new String[] {"-c", "3x4","12 32 43 44 45 56 47 38 29     "});
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  
		  
		  System.out.println("TestMyAppInput:  Null String[] ");
		  try {
			MyApp.main(inputARGNull);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
/*		
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
	
		
		Matrix addResult = firstRunMatrixParams.Add(secondRunMatrixParams);
		addResult.setName("addResult");
		
		addResult.displayC();
//		clearScreen();
		
//		addResult = addResult.Multiply((22/7));
		addResult = addResult.Multiply(3.623);
		addResult.displayM();
//		clearScreen();

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