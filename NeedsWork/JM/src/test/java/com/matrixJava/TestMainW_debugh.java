package test.java.com.matrixJava;
import java.util.Arrays;

import main.java.com.matrixJava.Main;
public class TestMainW_debugh {

		private static boolean thisDebug = false;
		
		public static void main(String[] args) {
//		public  void main(String[] args) {
			TestUtilsMeth.testHeader("TestMainW_debugh.java");

			
			if (args.length!=0)
				if ( args[0] == "debug")  {
					thisDebug = true;
				}
			String[] testArgs1 = new String[] {"debuxh", "3x4","12", "32", "43", "44","45", "56", "47","38","29"};

//			  System.out.println("Test Main with String[]\n{{debuxh 3x4, 12, 32, 43, 44, 45, 56, 47, 38, 29};");
			  System.out.println("Test Main with String[]");
			  System.out.println(Arrays.toString(testArgs1));
			  Main.main(new String[] {"debuxh", "3x4","12", "32", "43", "44","45", "56", "47","38","29"});
			  TestUtilsMeth.evalInternals();
			  TestUtilsMeth.printSeperation(); 
			 
		
		 System.out.println("Test Main with String[]\n {debuxh};"); Main.main(new
		 String[] {"debuxh"}); TestUtilsMeth.evalInternals();
		 TestUtilsMeth.printSeperation();
		 
		/* System.out.
		 * println("Test Main with String[]\n{{4debug, 2345XXx2654, 12, 32, 43, 44};");
		 * Main.main(new String[] {"4debug","2345XXx2654","12", "32", "43", "44"});
		 * TestUtilsMeth.evalInternals(); TestUtilsMeth.printSeperation();
		 * 
		 * System.out.
		 * println("Test Main with String[]\n{{ddebug, 2345XXx2654, 12, 32, 43, 44};");
		 * Main.main(new String[] {"ddebug","2345XXx2654","12", "32", "43", "44"});
		 * TestUtilsMeth.evalInternals(); TestUtilsMeth.printSeperation();
		 * 
		 * System.out.println("Test Main with String[]\n{febug, 2x02, 4, 4, 5, 5};");
		 * Main.main(new String[] {"febug", "2x02", "4", "4","5", "5"});
		 * TestUtilsMeth.evalInternals(); TestUtilsMeth.printSeperation();
		 * System.out.println(""); Main.main(new String[] {"2x0", "4", "4","5", "5"});
		 * 
		 * 
		 */
			  
			  
			//System.out.println(""); Main.main(new String[] {"2b 3", "4", "4","5", "5"});
			 /*  * * 
			 * System.out.println(""); Main.main(new String[] {"2 b 3", "4", "4","5", "5"});
			 */
		}// end  void main(String[] args)
		
	}

	
	
