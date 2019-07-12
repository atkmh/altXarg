package test.java.com.matrixJava;

import main.java.com.matrixJava.Main;
import main.java.com.matrixJava.Matrix;

public class TestUtilsMeth {
	
	public static void testHeader(String runnerFileName) {
		System.out.println("Test run " +runnerFileName +" against Main.java, Parse input");
		System.out.println("------------------------------------------------------------\n");
	}
	
	  public static void evalInternals() {
		  System.out.print("get_m: ");
		  System.out.println(Main.get_m());
		  System.out.print("get_n: ");
		  System.out.println(Main.get_n());	
		  System.out.print("get_prod: ");
		  System.out.println(Main.get_prod());
		  System.out.print("get_debug: ");
		  System.out.println(Main.get_debug());
		  System.out.print("get_rawOrder: ");
		  System.out.println(Main.get_order());
		  System.out.print("get_InputData: ");
		  System.out.println(Main.get_InputData());
		  System.out.println("-----------------------------------------------");	 
		  Main.clear_inputData();

	  }
	  public static void printSeperation(){
		 System.out.println("");
		 System.out.println("");
		  
	  }

	  public static void display(Matrix A) { 
		  System.out.println("Matrix: " +A.getName());
		  for (int i = 0; i < A.getRowDimension(); i++) {
			  for (int j = 0; j < A.getColumnDimension(); j++) {
				  //System.out.println("%9.4f ", data[i][j]);
				  //System.out.println( data[i][j]);
//				  System.out.printf("%5.2f   ", A.m_data[i][j] );// needs to be get value of cells
				  System.out.printf("%5.2f   ", A.get(  i,j ));// needs to be get value of cells
			  } System.out.println();
		  }	
	  } 
	  
	  
	
}
