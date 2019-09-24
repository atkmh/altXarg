package main.java.com.matrixJava;

import java.io.IOException;
import java.util.ArrayList;

public class AL_AL_Mx_Test {

	public static void main(String[] args) throws IOException {


		
		
		   int charRepToIncrement = 65; 
//		   char matrixMapKeyName = (char)charRepToIncrement;   // So this Should equal "A"
		   char myCurChar = (char)charRepToIncrement;   // So this Should equal "A"
		// I will use String str - Character.toString( matrixMapKeyName)   Actuall I'm going to chang those var names

        InputStringObj caseInputStringObj = new InputStringObj("-r", null);
        InputNumericObj caseInputNumericObj = new InputNumericObj(caseInputStringObj);
   //     Matrix caseMatrixObj = new Matrix(caseInputNumericObj);
		
		
        ArrayList<ArrayList> myArrayList = new ArrayList<ArrayList>( );	
        ArrayList<Matrix> matrixHistory = new ArrayList<Matrix>();
        
        
		/* *********************************************************
		 *  myArrayList of ArrayList
		 * |--------------------------------------------------------
		 * |         |          |          |
		 * |   -A-   |   -B-    |   -C-    |
		 * |         |          |          |
		 * |--------------------------------------------------------
		 * 
		 *  matrixHistory of A
		 * |--------------------------------------------------------
		 * | 3 4 5   |  9 12 15 |  etc.     |
		 * | 6 7 8   | 18 21 24 |  etc.     |
		 * | 9 x z   | 27 3x 3z |  etc.     |
		 * |--------------------------------------------------------
		 * 
		 *  matrixHistory of B
		 * |--------------------------------------------------------
		 * | 3 4 5   |  9 12 15 |  etc.     |
		 * | 6 7 8   | 18 21 24 |  etc.     |
		 * | 9 x z   | 27 3x 3z |  etc.     |
		 * |--------------------------------------------------------
		 * 
		 *  matrixHistory of C
		 * |--------------------------------------------------------
		 * | 3 4 5   |  9 12 15 |  etc.     |
		 * | 6 7 8   | 18 21 24 |  etc.     |
		 * | 9 x z   | 27 3x 3z |  etc.     |
		 * |--------------------------------------------------------
		 * 
		 */
	
        	matrixHistory.add(new Matrix(caseInputNumericObj) );
        	
        	myArrayList.add(matrixHistory);
        	
        	Matrix tempMatrix = (Matrix)myArrayList.get(0).get(0);
       
        	tempMatrix.displayCompact();
        	
        	Matrix temp2 = (Matrix)myArrayList.get(0).get(0);
		System.out.println("display temp2");
		temp2.displayCompact();

		
        	Matrix temp22 = (Matrix)myArrayList.get(0).get(0);
		System.out.println("display temp22");
		temp22.displayCompact();
		
		
        	Matrix temp23 = (Matrix)myArrayList.get(0).get(0);
		System.out.println("display temp23");
		temp23.displayCompact();
		
		
		
	}

}
