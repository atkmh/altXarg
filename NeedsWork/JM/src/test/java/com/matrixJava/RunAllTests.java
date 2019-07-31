package test.java.com.matrixJava;

public class RunAllTests {

	public static void main(String[] args) {
		TestMainInput myTMI = new TestMainInput();
		TestMainAndMatrix myTMAM = new TestMainAndMatrix();
		TestMainW_zeros myTMWZ = new TestMainW_zeros();
		TestMainW_debug myTMWD = new TestMainW_debug();
		
//		TestMainW_zeros myTestMainW_zeros = new TestMainW_zeros();
//		TestW_Switches	myTestW_Switches = new TestW_Switches();
//		TestParseInput myTestParseInput = new TestParseInput();
		
		
//		myTestMain.main(new String[] {});
		myTMI.main(new String[] {});
		myTMAM.main(new String[] {});
		myTMWZ.main(new String[] {});
	
		
//		myTestMainW_debug.main(new String[] {});
//		myTestMainW_zeros.main(new String[] {});
//		myTestW_Switches.main(new String[] {});
//		myTestParseInput.main(new String[] {});
		
		

	}

}
