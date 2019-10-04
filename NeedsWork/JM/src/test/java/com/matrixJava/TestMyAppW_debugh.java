package test.java.com.matrixJava;
import java.util.Arrays;

import main.java.com.matrixJava.MyApp;
public class TestMyAppW_debugh {

		private static boolean thisDebug = false;
		
		public static void main(String[] args) {
//		public  void main(String[] args) {
			TestUtilsMeth.testHeader("TestMyAppW_debugh.java");

			
			if (args.length!=0)
				if ( args[0] == "debug")  {
					thisDebug = true;
				}
			String[] testArgs1 = new String[] {"debuxh", "3x4","12", "32", "43", "44","45", "56", "47","38","29"};

//			  System.out.println("Test MyApp with String[]\n{{debuxh 3x4, 12, 32, 43, 44, 45, 56, 47, 38, 29};");
			  System.out.println("Test MyApp with String[]");
			  System.out.println(Arrays.toString(testArgs1));
			  try {
				MyApp.main(new String[] {"debuxh", "3x4","12", "32", "43", "44","45", "56", "47","38","29"});
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			  TestUtilsMeth.evalInternals();
			  TestUtilsMeth.printSeperation(); 
			 
		
		 System.out.println("Test MyApp with String[]\n {debuxh};"); try {
			MyApp.main(new
			 String[] {"debuxh"});
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} TestUtilsMeth.evalInternals();
		 TestUtilsMeth.printSeperation();
		 
		/* System.out.
		 * println("Test MyApp with String[]\n{{4debug, 2345XXx2654, 12, 32, 43, 44};");
		 * MyApp.main(new String[] {"4debug","2345XXx2654","12", "32", "43", "44"});
		 * TestUtilsMeth.evalInternals(); TestUtilsMeth.printSeperation();
		 * 
		 * System.out.
		 * println("Test MyApp with String[]\n{{ddebug, 2345XXx2654, 12, 32, 43, 44};");
		 * MyApp.main(new String[] {"ddebug","2345XXx2654","12", "32", "43", "44"});
		 * TestUtilsMeth.evalInternals(); TestUtilsMeth.printSeperation();
		 * 
		 * System.out.println("Test MyApp with String[]\n{febug, 2x02, 4, 4, 5, 5};");
		 * MyApp.main(new String[] {"febug", "2x02", "4", "4","5", "5"});
		 * TestUtilsMeth.evalInternals(); TestUtilsMeth.printSeperation();
		 * System.out.println(""); MyApp.main(new String[] {"2x0", "4", "4","5", "5"});
		 * 
		 * 
		 */
			  
			  
			//System.out.println(""); MyApp.main(new String[] {"2b 3", "4", "4","5", "5"});
			 /*  * * 
			 * System.out.println(""); MyApp.main(new String[] {"2 b 3", "4", "4","5", "5"});
			 */
		}// end  void main(String[] args)
		
	}

	
	
