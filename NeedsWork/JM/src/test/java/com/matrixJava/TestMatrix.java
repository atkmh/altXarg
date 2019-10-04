package test.java.com.matrixJava;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import main.java.com.matrixJava.InputNumericObj;
import main.java.com.matrixJava.InputStringObj;
import main.java.com.matrixJava.Matrix;

public class TestMatrix {

	public static void clearScreen() {  
	    System.out.print("\033[H\033[2J");  
	    System.out.flush();  
	}  	
	
	public static void main(String[] args) throws IOException {
	//	ArrayList <Integer> inputDataArray = (ArrayList<Integer>) Arrays.asList(3, 4, 6, 11, 88);

		
		double[] columnwise = {1.,2.,3.,4.,5.,6.,7.,8.,9.,10.,11.,12.};
		double[] condmat = {1.,3.,7.,9.};
		int[] matrixDimension = new int[10]; // dont except to ever use more than 4 cells. would by 99x99

	String[] inputARGNull = null ;
		ArrayList<Integer> inputTestData = new ArrayList<>(Arrays.asList(11,2,3,6,11,18,45,88));

//		System.out.println();
//		System.out.println(inputTestData.toString());
//		System.out.println("Test Running Class: " +this.getClass()  ) ;	
//		Matrix  testRunMatrix = new Matrix(2, 3, inputTestData  );

		Matrix testRunMatrix = new Matrix();
		testRunMatrix.setName("testRunMatrix");
		testRunMatrix.displayCompact();
//		clearScreen();

		Matrix firstRunMatrixParams = new Matrix(3,3, inputTestData);
		firstRunMatrixParams.setName("firstRunMatrixParams");
		firstRunMatrixParams.displayCompact();
//		clearScreen();
		
		Matrix secondRunMatrixParams = new Matrix(3,3, columnwise); // or condmat
		secondRunMatrixParams.setName("secondRunMatrixParams");
		secondRunMatrixParams.displayCompact();
//		clearScreen();
		
	//	firstRunMatrixParams.displayDeepString();
	//	secondRunMatrixParams.displayDeepString();
		matrixDimension[0]=2;
		matrixDimension[1]=3;
	
		Matrix outOfSeqTestMatrix = new Matrix(matrixDimension, columnwise);
		secondRunMatrixParams.setName("outOfSeqTestMatrix");
		secondRunMatrixParams.displayCompact();
		
		Matrix addResult = firstRunMatrixParams.Add(secondRunMatrixParams);
		addResult.setName("addResult");
		
		addResult.displayCompact();
//		clearScreen();
		
//		addResult = addResult.Multiply((22/7));
		addResult = addResult.Multiply(3.623);
		addResult.displayMore();
		
		
		String[] testInput1 = new String[]{"-c","5x4","12", "32", "43", "44", "5","5","5","4","4",".999999999","0","0","0","9","4","2.71826","3.14159","33","11","0.1136","888","7","6","5"};
		InputStringObj myTestCase = new InputStringObj("-c", testInput1);
		InputNumericObj myNumTest = new InputNumericObj(myTestCase);
		
		System.out.println("And Now a Matrix from a Numeric Object");

		Matrix numObjBasedMatrix = new Matrix(myNumTest,"TestMatrix.java_string");
		numObjBasedMatrix.setName("numObjBasedMatrix");
		numObjBasedMatrix.displayCompact();
	System.out.println("");
	System.out.println("");
		numObjBasedMatrix.displayMore();
		
		
//		clearScreen();
		
	}// end MyApp()

}// end Class










