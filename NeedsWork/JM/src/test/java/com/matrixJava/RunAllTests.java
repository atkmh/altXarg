package test.java.com.matrixJava;

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
		myTMI.main(new String[] {});
		myTMAM.main(new String[] {});
		myTMWZ.main(new String[] {});
	
		
//		myTestMainW_debug.main(new String[] {});
//		myTestMainW_zeros.main(new String[] {});
//		myTestW_Switches.main(new String[] {});
//		myTestParseInput.main(new String[] {});
		
		

	}

}
