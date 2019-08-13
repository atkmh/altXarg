package test.java.com.matrixJava;

import main.java.com.matrixJava.ParseInput_v_one;

public class TestParseInput {

	public static void main(String[] args) {
//	public  void main(String[] args) {
		System.out.println("");
		System.out.println("");
		System.out.println("________________________________________________________________");
		System.out.println("****************************************************************");	
		System.out.print("** ");
	//	System.out.println("Test Running Class: " +this.getClass().getSimpleName()  ) ;	
		System.out.println("");
		System.out.println("");
		
		String [] testArgs = {"debug","2x4","3" ,"4" ,"66" ,"23","1","34","3" ,"4"};
		boolean testBool = false;
		
		ParseInput_v_one inputTest = new ParseInput_v_one(  ); 
		inputTest.PI(testArgs, testBool);
		
		System.out.println("*********************");
		System.out.println("*********************");

		String [] testArgs2 = {"2x4","3" ,"4" ,"66" ,"23","1","34","3" ,"4"};		
		
		inputTest.PI(testArgs2, testBool);
		
	}

}
