package test.java.com.matrixJava;


import java.io.IOException;

import main.java.com.matrixJava.MyApp;

public class TestMyAppW_zeros {
	
		private static boolean thisDebug = false;
		
		public static void main(String[] args) throws IOException {
//		public void main(String[] args) {
			
			TestUtilsMeth.testHeader("TestMyAppW_zeros.java");

			
		/*
		 * if (args.length!=0) if ( args[0] == "debug") { thisDebug = true; }
		 * 
		 * String[] emptyArgs = {};
		 */
			  
			  System.out.println("Test MyApp with String[]\n{ 2x03, 4, 4, 5, 5};");
			  try {
				MyApp.main(new String[] { "2x 3", "4", "4","5", "5"});
			} catch (Exception e6) {
				// TODO Auto-generated catch block
				e6.printStackTrace();
			}
			  TestUtilsMeth.evalInternals();
			  TestUtilsMeth.printSeperation(); 

			  System.out.println("Test MyApp with String[]\n{ 2x03, 4, 4, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0};");
			  try {
				MyApp.main(new String[] { "2x03", "4", "4","5", "5","0", "0","0","0","0","0","0","0","0",});
			} catch (Exception e5) {
				// TODO Auto-generated catch block
				e5.printStackTrace();
			}
			  TestUtilsMeth.evalInternals();
			  TestUtilsMeth.printSeperation(); 

			  System.out.println("Test MyApp with String[]\n{ 2x03, 0, 0, 0, 4, 4, 5, 5, 0, 0, };");
			  try {
				MyApp.main(new String[] { "2x03", "0", "0", "0", "4", "4","5", "5","0", "0","0",});
			} catch (Exception e4) {
				// TODO Auto-generated catch block
				e4.printStackTrace();
			}
			  TestUtilsMeth.evalInternals();
			  TestUtilsMeth.printSeperation(); 

			  System.out.println("Test MyApp with String[]\n{ 02x03, 4, 4, 5, 5};");
			  try {
				MyApp.main(new String[] { "02x03", "4", "4","5", "5"});
			} catch (Exception e3) {
				// TODO Auto-generated catch block
				e3.printStackTrace();
			}
			  TestUtilsMeth.evalInternals();
			  TestUtilsMeth.printSeperation(); 

			  System.out.println("Test MyApp with String[]\n{12x18, 4, 4,5, 5}; Will result in lots of zeros");
			  try {
				MyApp.main(new String[] {"12x18", "4", "4","5", "5"});
			} catch (Exception e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
			  TestUtilsMeth.evalInternals();
			  TestUtilsMeth.printSeperation(); 

			  System.out.println("Test MyApp with String[]\n{12x018, 4, 4,5, 5}; Will result in lots of zeros");
			  try {
				MyApp.main(new String[] {"12x018", "4", "4","5", "5"});
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			  TestUtilsMeth.evalInternals();
			  TestUtilsMeth.printSeperation(); 
		

			  System.out.println("Test MyApp with String[]\n{2x0, 4, 4,5, 5};");
			  try {
				MyApp.main(new String[] {"2x0", "4", "4","5", "5"});
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			  TestUtilsMeth.evalInternals();
			  TestUtilsMeth.printSeperation(); 
	
		
		} // end void main(String[] args)
}         // end Class Test MyApp with Zeros

		//	 System.out.println(""); MyApp.main(new String[] {"2x0", "4", "4","5", "5"});
		//	 System.out.println(""); MyApp.main(new String[] {"2b 3", "4", "4","5", "5"});
		//	 System.out.println(""); MyApp.main(new String[] {"2 b 3", "4", "4","5", "5"});