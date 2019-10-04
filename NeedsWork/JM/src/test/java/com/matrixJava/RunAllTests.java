package test.java.com.matrixJava;

import java.io.IOException;

public class RunAllTests {

	public static void main(String[] args) {
		TestMyAppInput myTMI = new TestMyAppInput();
		TestMyAppAndMatrix myTMAM = new TestMyAppAndMatrix();
		TestMyAppW_zeros myTMWZ = new TestMyAppW_zeros();
		TestMyAppW_debug myTMWD = new TestMyAppW_debug();
		
//		TestMyAppW_zeros myTestMainW_zeros = new TestMyAppW_zeros();
//		TestW_Switches	myTestW_Switches = new TestW_Switches();
//		TestParseInput myTestParseInput = new TestParseInput();
		
		
//		myTestMain.main(new String[] {});
		try {
			myTMI.main(new String[] {});
		} catch (IOException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		try {
			myTMAM.main(new String[] {});
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			myTMWZ.main(new String[] {});
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		
//		myTestMainW_debug.main(new String[] {});
//		myTestMainW_zeros.main(new String[] {});
//		myTestW_Switches.main(new String[] {});
//		myTestParseInput.main(new String[] {});
		
		

	}

}
