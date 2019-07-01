package test.java.com.matrixJava;
import main.java.com.matrixJava.Main;
public class TestMainW_debug {

		private static boolean thisDebug = false;
		
		public static void main(String[] args) {
//		public  void main(String[] args) {
			TestUtilsMeth.testHeader("TestMainW_debug.java");

			
			if (args.length!=0)
				if ( args[0] == "debug")  {
					thisDebug = true;
				}
				

			  System.out.println("Test Main with String[]\n{{debug 3x4, 12, 32, 43, 44, 45, 56, 47, 38, 29};");
			  Main.main(new String[] {"debug", "3x4","12", "32", "43", "44","45", "56", "47","38","29"});
			  TestUtilsMeth.evalInternals();
			  TestUtilsMeth.printSeperation(); 
			 
			  System.out.println("Test Main with String[]\n {debug};");
			  Main.main(new String[] {"debug"}); 
			  if (args.length!=0)TestUtilsMeth.evalInternals();
			  if (args.length!=0)TestUtilsMeth.printSeperation();

			  System.out.println("Test Main with String[]\n{{debug, 2345XXx2654, 12, 32, 43, 44};");
			  Main.main(new String[] {"debug","2345XXx2654","12", "32", "43", "44"});
			  if (args.length!=0)TestUtilsMeth.evalInternals();
			  if (args.length!=0)TestUtilsMeth.printSeperation();
			 
			  System.out.println("Test Main with String[]\n{debug, 2x02, 4, 4, 5, 5};");
			  Main.main(new String[] {"debug", "2x02", "4", "4","5", "5"});
			  if (args.length!=0)TestUtilsMeth.evalInternals();
			  if (args.length!=0)TestUtilsMeth.printSeperation();
			  System.out.println(""); Main.main(new String[] {"2x0", "4", "4","5", "5"});
			 
			//System.out.println(""); Main.main(new String[] {"2b 3", "4", "4","5", "5"});
			 /*  * * 
			 * System.out.println(""); Main.main(new String[] {"2 b 3", "4", "4","5", "5"});
			 */
		}// end  void main(String[] args)
		
	}

	
	
