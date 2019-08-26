// Key technology I could not exactly figure out, but thought about it quietly
// G: java example unit test public static void main for parsing arguments
// https://www.google.com/search?q=java+example+unit+test+public+static+void+main+for+parsing+arguments&rlz=1C1GCEB_en___US816&oq=java+example+unit+test+public+static+void+main+for+parsing+arguments&aqs=chrome..69i57.47839j0j7&sourceid=chrome&ie=UTF-8&safe=active
//
// https://stackoverflow.com/questions/4122455/is-it-possible-to-call-the-main-method-passing-args-from-another-method
// 
// Coder Ranch had an important point to make
// https://coderanch.com/t/658338/engineering/write-unit-test-passing-argumentso
// Issue:  System.exit() in main will stop testMain cus the JVM is shut down on exit
// So I commented out my exits for the command line testing.
/*                                                                 */
//http://www.nathanbak.com/?p=388   may have a solution to system.exit


package test.java.com.matrixJava;

import java.io.IOException;

import main.java.com.matrixJava.MyApp;

public class TestMyAppInput {

	private static boolean thisDebug = false;
	
	public static void main(String[] args) throws IOException { // must be Static to run by itself. is not static when run from RunAllTests.j
		
		TestUtilsMeth.testHeader("TestMyAppInput.java");
		
//		if (args.length!=0)
//			if ( args[0] == "debug")  {
//				thisDebug = true;
//			}
			
		 String[] emptyArgs = {};	// making this available but dont really want to use it 
		 							// emptyArgs causes Usage(); and as such system.exit();
		 
		  
		  System.out.println("TestMyAppInput:  call MyApp.main() with String[] \n{{-c, 3x4, 12, 32, 43, 44, 45, 56, 47, 38, 29};");
		  MyApp.main(new String[] {"-c", "3x4","12", "32", "43", "44","45", "56", "47","38","29"});
	  //  TestUtilsMeth.evalInternals();
		  TestUtilsMeth.printSeperation(); 
		 
		  System.out.println("TestMyAppInput:  call MyApp.main() with String[] \n{-c, 2x3, 4, 4, 5, 5};");
		  MyApp.main(new String[] {"-c","2x3", "4", "4","5", "5"});
	  //  TestUtilsMeth.evalInternals();
		  TestUtilsMeth.printSeperation(); 
		 


		  System.out.println("TestMyAppInput:  call MyApp.main() with String[] \n{-c, 2x3, 4, 4, 5, 5, };");
		  MyApp.main(new String[] {"-c","2x3", "4", "4 ","5  ", "   5", });
	 //	  TestUtilsMeth.evalInternals();
		  TestUtilsMeth.printSeperation(); 
		 

		  System.out.println("TestMyAppInput:  call MyApp.main() with String[] \n{-c, 2x3, 4, 4, 5, 5, 879892349};");
		  MyApp.main(new String[] {"-c","2x3", "4", "4","5", "5", "879892349"});
	 //	  TestUtilsMeth.evalInternals();
		  TestUtilsMeth.printSeperation(); 
		 
		  
/*		  System.out.println("TestMyAppInput:  call MyApp.main() with String[] \n{debug};");
		  MyApp.main(new String[] {"debug"}); 
		  if (args.length!=0)TestUtilsMeth.evalInternals();
		  if (args.length!=0)TestUtilsMeth.printSeperation();
*/		  
		  
/*		  System.out.println("TestMyAppInput:  call MyApp.main() with String[] \nemptyArgs = {};");
		  MyApp.main(emptyArgs);
		  TestUtilsMeth.evalInternals();
		  TestUtilsMeth.printSeperation();
*/		   
		  
		/*
		 * System.out.
		 * println("TestMyAppInput:  call MyApp.main() with String[] \n{{2345XXx2654, 11, 31, 41, 44};"
		 * ); MyApp.main(new String[] {"2345XXx2654","11", "31", "41", "44"}); if
		 * (args.length!=0) TestUtilsMeth.evalInternals(); if (args.length!=0)
		 * TestUtilsMeth.printSeperation();
		 */
		  
		/*
		 * System.out.
		 * println("TestMyAppInput:  call MyApp.main() with String[] \n{{2345XXx2654, 11, 31, 41, 44};"
		 * ); MyApp.main(new String[] {"2345XXx2654","11", "31", "41", "44"}); if
		 * (args.length!=0) TestUtilsMeth.evalInternals(); if (args.length!=0)
		 * TestUtilsMeth.printSeperation();
		 */
		/*
		 * System.out.
		 * println("TestMyAppInput:  call MyApp.main() with String[] \n{{debug, 2345XXx2654, 12, 32, 43, 44};"
		 * ); MyApp.main(new String[] {"debug","2345XXx2654","12", "32", "43", "44"}); 
		 * if(args.length!=0) TestUtilsMeth.evalInternals();
		 * if (args.length!=0) TestUtilsMeth.printSeperation();
		 */
		 
		  
		// System.out.println(""); MyApp.main(new String[] {"2b 3", "4", "4","5", "5"});
		 /*  * * 
		 * System.out.println(""); MyApp.main(new String[] {"2 b 3", "4", "4","5", "5"});
		 */
	}// end  void main(String[] args)
	
}
