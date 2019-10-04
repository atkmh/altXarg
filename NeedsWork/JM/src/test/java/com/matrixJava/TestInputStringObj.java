package test.java.com.matrixJava;

import java.io.IOException;

import main.java.com.matrixJava.InputStringObj;

public class TestInputStringObj {

	public static void main(String[] args) throws IOException {

		//String[] fail_testInput = new String[]{"-c","5x4","12", "32", "43", "44", "5","5","5","dd","4","4","s",".999999999","0","0","0","9","4","2.71826","3.14159","33","11","0.1136","888","7","6","5"};
		String[] testInput1 = new String[]{"-c","5x4","12", "32", "43", "44", "5","5","5","4","4",".999999999","0","0","0","9","4","2.71826","3.14159","33","11","0.1136","888","7","6","5"};
		String[] testInput2 = new String[]{"-c","5 x 4","12", "32", "43", "44", "5","5","5","4","4",".999999999","0","0","0","9","4","2.71826","3.14159","33","11","0.1136","888","7","6","5"};
		String[] testInput3 = new String[]{"-c","5x  4","12", "32", "43", "44", "5","5","5","4","4",".999999999","0","0","0","9","4","2.71826","3.14159","33","11","0.1136","888","7","6","5"};
		String[] testInput4 = new String[]{"-c","5 x4  ","12", "      32", "43", "44", "5","5","5","4","4",".999999999","0","0","0","9","4","2.71826","3.14159","33","11","0.1136","888","7","6","5"};
		String[] testInput5 = new String[]{"-c","5x4","12", "32", "43.0   ", "44           ", "5","5","5","4","4",".999999999","0","0","0","9","4","2.71826","3.14159","33","11","0.1136","888","7","6","5"};
		String[] testInput6 = new String[]{"-c","5h x4","12", "3.2", "43", "44", "5","5","5","4","4",".999999999","0","0","0","9","4","2.71826","3.14159","33","11","0.1136","888","7","6","5"};
		String[] testInput7 = new String[]{"-c","  5h 4 ","12", "3..2", "43", "44", "5","5","5","4","4",".999999999","0","0","0","9","4","2.71826","3.14159","33","11","0.1136","888","7","6","5"};
		
		
		InputStringObj myTestCase = new InputStringObj("-c", testInput1);
	System.out.println(myTestCase.getFirst());
	System.out.println(myTestCase.getSecond());
	System.out.println(myTestCase.getdata().toString());
	
	
	myTestCase = new InputStringObj("-c", testInput2);
	System.out.println(myTestCase.getFirst());
	System.out.println(myTestCase.getSecond());
	System.out.println(myTestCase.getdata().toString());
	
	myTestCase = new InputStringObj("-c", testInput3);
	System.out.println(myTestCase.getFirst());
	System.out.println(myTestCase.getSecond());
	System.out.println(myTestCase.getdata().toString());
	
	myTestCase = new InputStringObj("-c", testInput4);
	System.out.println(myTestCase.getFirst());
	System.out.println(myTestCase.getSecond());
	System.out.println(myTestCase.getdata().toString());
	
	myTestCase = new InputStringObj("-c", testInput5);
	System.out.println(myTestCase.getFirst());
	System.out.println(myTestCase.getSecond());
	System.out.println(myTestCase.getdata().toString());
	
	
	myTestCase = new InputStringObj("-c", testInput6);
	System.out.println(myTestCase.getFirst());
	System.out.println(myTestCase.getSecond());
	System.out.println(myTestCase.getdata().toString());
	
	myTestCase = new InputStringObj("-c", testInput7);
	System.out.println(myTestCase.getFirst());
	System.out.println(myTestCase.getSecond());
	System.out.println(myTestCase.getdata().toString());

System.out.println("");
System.out.println("");
System.out.println("");
System.out.println("");
System.out.println("test done");
//	myTestCase = new InputStringObj("-c", fail_testInput);
//	System.out.println(myTestCase.getFirst());
//	System.out.println(myTestCase.getSecond());
//	System.out.println(myTestCase.getdata());
//	
	
	
	
	}

}
