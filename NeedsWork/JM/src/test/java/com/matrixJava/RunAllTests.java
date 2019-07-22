package test.java.com.matrixJava;

public class RunAllTests {

	public static void main(String[] args) {
		TestMainInput myTestMain = new TestMainInput();
		TestMainW_debug myTestMainW_debug = new TestMainW_debug();
		TestMainW_zeros myTestMainW_zeros = new TestMainW_zeros();
		TestW_Switches	myTestW_Switches = new TestW_Switches();
		TestParseInput myTestParseInput = new TestParseInput();
		
		
		myTestMain.main(new String[] {});
		myTestMainW_debug.main(new String[] {});
		myTestMainW_zeros.main(new String[] {});
		myTestW_Switches.main(new String[] {});
		myTestParseInput.main(new String[] {});
		
		

	}

}
