package test.java.com.matrixJava;

import main.java.com.matrixJava.Main;
import main.java.com.matrixJava.Matrix;
import main.java.com.matrixJava.ParseInputYA;

public class TestUtilsMeth {
	
	public static void testHeader(String runnerFileName) {
		System.out.println("Test file running Main Class in " +runnerFileName +" , Parsing input");
		System.out.println("------------------------------------------------------------");
		System.out.println("------------------------------------------------------------\n");
	}
	
	  public static void evalInternals() {
		  System.out.print("get_m: ");
//		  System.out.println(Main.get_m());
		 // System.out.println(ParseInputYA.get_m());
		  System.out.print("get_n: ");
//		  System.out.println(Main.get_n());	
		  //System.out.println(ParseInputYA.get_n());	
		  System.out.print("get_prod: ");
//		  System.out.println(Main.get_prod());
		  System.out.println(ParseInputYA.get_prod());
		  System.out.print("get_debug: ");
//		  System.out.println(Main.get_debug());
		  System.out.println(ParseInputYA.get_debug());
		  System.out.print("get_rawOrder: ");
//		  System.out.println(Main.get_order());
		  System.out.println(ParseInputYA.get_order());
		  System.out.print("get_InputData: ");
//		  System.out.println(Main.get_InputData());
		  System.out.println(ParseInputYA.get_InputData());
		  System.out.println("-----------------------------------------------");	 
//		  Main.clear_inputData();
		  ParseInputYA.clear_inputData();

	  }
	  public static void printSeperation(){
		 System.out.println("");
		 System.out.println("");
		  
	  }


	  
	  
	
}
