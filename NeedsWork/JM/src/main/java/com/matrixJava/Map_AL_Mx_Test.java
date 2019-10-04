package main.java.com.matrixJava;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Map_AL_Mx_Test {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		
		   int charRepToIncrement = 65; 
//		   char matrixMapKeyName = (char)charRepToIncrement;   // So this Should equal "A"
		   char myCurChar = (char)charRepToIncrement;   // So this Should equal "A"
		   // I will use String str - Character.toString( matrixMapKeyName)   Actuall I'm going to chang those var names

        InputStringObj caseInputStringObj = new InputStringObj("-r", null);
        InputNumericObj caseInputNumericObj = new InputNumericObj(caseInputStringObj);
   //     Matrix caseMatrixObj = new Matrix(caseInputNumericObj);

     /* This was operational code  */   
     /*   ArrayList<Matrix> myArrayList = new ArrayList(new Matrix(caseInputNumericObj)); */
        ArrayList<Matrix> myArrayList = new ArrayList<Matrix>( );

		Map <String, ArrayList<Matrix>> myHashMapListOfMatrix = new HashMap<String,ArrayList<Matrix>>(); 
        
        
//		myHashMapListOfMatrix.put(Character.toString(myCurChar),new Matrix(caseInputNumericObj));
		myHashMapListOfMatrix.put(Character.toString(myCurChar),myArrayList);
		
		
		
		//myHashMapListOfMatrix.
///		(Character.toString(myCurChar),myArrayList.add(new Matrix(caseInputNumericObj)));
		
		System.out.println("");
		
        myArrayList.add( new Matrix(caseInputNumericObj,"Map_AL_Mx_Test-string"));	
	
		
System.out.println("");

		

		
		

		
//		Map <String, Matrix> myHashMapListOfMatrix = new HashMap<String,Matrix>();
// line21		Map <String, ArrayList<Matrix>> myHashMapListOfMatrix = new HashMap<String,ArrayList<Matrix>>();
		
System.out.println("");	
        Map<String, ArrayList<Matrix>> myDevHMList = new HashMap<String, ArrayList<Matrix>>();	
		
		
		
		
		
		
	}

}
