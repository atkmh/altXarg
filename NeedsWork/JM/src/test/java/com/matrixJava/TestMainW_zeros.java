package test.java.com.matrixJava;


import main.java.com.matrixJava.Main;

public class TestMainW_zeros {
	
		private static boolean thisDebug = false;
		
		public static void main(String[] args) {
//		public void main(String[] args) {
			
			TestUtilsMeth.testHeader("TestMainW_zeros.java");

			
			if (args.length!=0)
				if ( args[0] == "debug")  {
					thisDebug = true;
				}
				
			 String[] emptyArgs = {};
			  
			  System.out.println("Test Main with String[]\n{ 2x03, 4, 4, 5, 5};");
			  Main.main(new String[] { "2x03", "4", "4","5", "5"});
			  TestUtilsMeth.evalInternals();
			  TestUtilsMeth.printSeperation(); 

			  System.out.println("Test Main with String[]\n{2x0, 4, 4,5, 5};");
			  Main.main(new String[] {"2x0", "4", "4","5", "5"});
			  TestUtilsMeth.evalInternals();
			  TestUtilsMeth.printSeperation(); 
		
		} // end void main(String[] args)
}         // end Class Test Main with Zeros

		//	 System.out.println(""); Main.main(new String[] {"2x0", "4", "4","5", "5"});
		//	 System.out.println(""); Main.main(new String[] {"2b 3", "4", "4","5", "5"});
		//	 System.out.println(""); Main.main(new String[] {"2 b 3", "4", "4","5", "5"});