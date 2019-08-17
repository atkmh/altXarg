package test.java.com.matrixJava;

import java.io.IOException;

import main.java.com.matrixJava.CmdLineInStrObj;
import main.java.com.matrixJava.InputStringObj;

public class TestInputStringObj {

	public static void main(String[] args) throws IOException {

		String[] fail_testInput = new String[]{"-c","5x4","12", "32", "43", "44", "5","5","5","dd","4","4","s",".999999999","0","0","0","9","4","2.71826","3.14159","33","11","0.1136","888","7","6","5"};
		String[] testInput = new String[]{"5x4","12", "32", "43", "44", "5","5","5","4","4",".999999999","0","0","0","9","4","2.71826","3.14159","33","11","0.1136","888","7","6","5"};
		
		
		InputStringObj myTestCase = new InputStringObj("-r", testInput);
	System.out.println(myTestCase.getFirst());
	System.out.println(myTestCase.getSecond());
	System.out.println(myTestCase.getdata());
System.out.println("");
System.out.println("");
System.out.println("");
System.out.println("");
//	myTestCase = new InputStringObj("-c", fail_testInput);
//	System.out.println(myTestCase.getFirst());
//	System.out.println(myTestCase.getSecond());
//	System.out.println(myTestCase.getdata());
//	
	
	
	
	}

}
