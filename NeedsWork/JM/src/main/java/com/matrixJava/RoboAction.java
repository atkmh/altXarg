package main.java.com.matrixJava;

import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;

public class RoboAction {

	static Robot myRobo;
	static int roboSequence = 0;	
	
	public RoboAction() throws AWTException{
	     myRobo = new Robot();
	}
	
	public static void RT0() throws AWTException {
		myRobo.delay(200);
//        MyApp.roboType("new");
        RoboAction.roboType("new");
//        MyApp.roboSequence++;
        RoboAction.roboSequence++;
	}
	
	
	
	
	private static void roboType(String s)
	  {
	    byte[] bytes = s.getBytes();
	    for (byte b : bytes)
	    {
	      int code = b;
	      // keycode only handles [A-Z] (which is ASCII decimal [65-90])
	      if (code > 96 && code < 123) code = code - 32;
	      myRobo.delay(20);
	      myRobo.keyPress(code);
	      myRobo.keyRelease(code);
	    }
	    myRobo.keyPress(KeyEvent.VK_ENTER);
	    myRobo.keyRelease(KeyEvent.VK_ENTER);;
	  }
	
}
