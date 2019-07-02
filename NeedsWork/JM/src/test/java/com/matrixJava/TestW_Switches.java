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
	
//	public static void main(String[] args) {
	public void main(String[] args) {
		printSeperation();
		System.out.println("________________________________________________________________");
		System.out.println("****************************************************************");	
		System.out.print("** ");
		System.out.println("Test Running Class: " +this.getClass().getSimpleName()  ) ;	
		printSeperation();
		
		if (args.length!=0)
			if ( args[0] == "debug")  {
				thisDebug = true;
			}
			
		 String[] emptyArgs = {};	
		 

		 // System.out.println("TestMain:  call Main.main() with String[] {{3x4, 12, 32, 43, 44, 45, 56, 47, 38, 29};");
		 // Main.main(new String[] { "3x4","12", "32", "43", "44","45", "56", "47","38","29"});
		 // evalInternals();
		 // printSeperation(); 
		 
		  System.out.println("TestMain:  call Main.main() with String[] {2x3, 4, 4, 5, 5, 34523, 34634};");
		  Main.main(new String[] {"2x3", "4", "4","5", "5","34523", "34634"});
		  evalInternals();
		  printSeperation(); 
		 
		  System.out.println("TestMain:  call Main.main() with String[] {debug 2x3, 4, 4, 5, 5, 879349};");
		  Main.main(new String[] {"debug", "2X3", "4", "4","5", "5", "879349"});
		  evalInternals();
		  printSeperation(); 
		 
		 
			  System.out.println("TestMain:  call Main.main() with String[] {{3x4, 12, 32, 43, 44, 45, 56, 47, 38, 29};");
			  Main.main(new String[] { "3x4","12", "32", "43", "44","45", "56", "47","38","29"});
			  evalInternals();
			  printSeperation(); 
		  /*  * * 
		 * System.out.println(""); Main.main(new String[] {"2 b 3", "4", "4","5", "5"});
		 */
	}// end  void main(String[] args)
	
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
	  }
	  public static void printSeperation(){
		 System.out.println("");
		 System.out.println("");
		  
	  }

}