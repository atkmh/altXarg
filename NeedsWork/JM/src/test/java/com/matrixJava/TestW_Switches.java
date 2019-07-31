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

import main.java.com.matrixJava.Main;

public class TestW_Switches {

	private static boolean thisDebug = false;
	
	public static void main(String[] args) {
	
		TestUtilsMeth.testHeader("TestMainW_Switches.java");

			
		  System.out.println("TestMainInput:  call Main.main() with String[] \n{-f somefileName }); ");
		  Main.main(new String[] {"-f", "someFileName"});
		  System.out.println("TestMainInput:  call Main.main() with String[] \n{--f somefileName }); ");
		  Main.main(new String[] {"--f", "someFileName"});
		  System.out.println("TestMainInput:  call Main.main() with String[] \n{-file somefileName }); ");
		  Main.main(new String[] {"-file", "someFileName"});
		  System.out.println("TestMainInput:  call Main.main() with String[] \n{--file somefileName }); ");
		  Main.main(new String[] {"--file", "someFileName"});
		  //TestUtilsMeth.evalInternals();
		  //TestUtilsMeth.printSeperation(); 

		  System.out.println("TestMainInput:  call Main.main() with String[] \n{{-r});  for runtime Data Entry");
		  Main.main(new String[] {"-r"});		 
		  System.out.println("TestMainInput:  call Main.main() with String[] \n{{--r});  for runtime Data Entry");
		  Main.main(new String[] {"--r"});		 
		  System.out.println("TestMainInput:  call Main.main() with String[] \n{{-runtime});  for runtime Data Entry");
		  Main.main(new String[] {"-runtime"});		 
		  System.out.println("TestMainInput:  call Main.main() with String[] \n{{--runtime});  for runtime Data Entry");
		  Main.main(new String[] {"--runtime"});		 
		  //TestUtilsMeth.evalInternals();
		  //TestUtilsMeth.printSeperation();		  
		  
		  
/*		  System.out.println("TestMainInput:  call Main.main() with String[]\n{2x3, 4, 4, 5, 5, 34523, 34634};");
		  Main.main(new String[] {"2x3", "4", "4","5", "5","34523", "34634"});
		  TestUtilsMeth.evalInternals();
		  TestUtilsMeth.printSeperation(); 
		 
		  System.out.println("TestMainInput:  call Main.main() with String[]\n{debug 2x3, 4, 4, 5, 5, 879349};");
		  Main.main(new String[] {"debug", "2X3", "4", "4","5", "5", "879349"});
		  TestUtilsMeth.evalInternals();
		  TestUtilsMeth.printSeperation(); 
		 
		 
		  System.out.println("TestMainInput:  call Main.main() with String[]\n{3x4, 12, 32, 43, 44, 45, 56, 47, 38, 29};");
		  Main.main(new String[] { "3x4","12", "32", "43", "44","45", "56", "47","38","29"});
		  TestUtilsMeth.evalInternals();
		  TestUtilsMeth.printSeperation();  */

	}// end  void main(String[] args)
	

}
