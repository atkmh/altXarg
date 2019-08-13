package test.java.com.matrixJava;

import main.java.com.matrixJava.CmdLineInStrObj;

public class TestInputStringObj {

	public static void main(String[] args) {

		String[] testInput = new String[]{"-c","5x4","12", "32", "43", "44", "5","5","5","dd","4","4","s",".999999999","0","0","0","9","4","2.71826","3.14159","33","11","0.1136","888","7","6","5"};
		
		
		CmdLineInStrObj myTestCase = new CmdLineInStrObj(testInput);
	System.out.println(myTestCase.getFirst());
	System.out.println(myTestCase.getSecond());
	System.out.println(myTestCase.getdata());
	}

}
