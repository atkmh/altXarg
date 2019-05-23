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


package test.java.com.matrixJava;

import main.java.com.matrixJava.Main;

public class TestMain {

	public static void main(String[] args) {
		
	Main.main(new String[] {});
	System.out.println("");
	Main.main(new String[] {"2x2","1", "3", "4", "4"});
	System.out.println("");

	Main.main(new String[]{"2x2", "4", "4","5", "5"});
System.out.println("");
	Main.main(new String[] {"2x3", "4", "4","5", "5"});

System.out.println("");
	Main.main(new String[] {"2x0", "4", "4","5", "5"});

System.out.println("");
	Main.main(new String[] {"2b 3", "4", "4","5", "5"});

System.out.println("");
	Main.main(new String[] {"2 b 3", "4", "4","5", "5"});
	
	
	
	
	}

}
