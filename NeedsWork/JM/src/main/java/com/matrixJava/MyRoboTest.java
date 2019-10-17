package main.java.com.matrixJava;

import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;

public class MyRoboTest{
	
	//static Robot myTestRobot;
	//Robot r1 = new Robot();
	
	public MyRoboTest() {}
	
//	public  MyRoboTest()throws AWTException {
//		
//	}
	
	
	public void typeNew(MyRoboTest t) {
		
		t.delay(500);
        t.keyPress(KeyEvent.VK_N);
        t.keyRelease(KeyEvent.VK_N);
        t.keyPress(KeyEvent.VK_E);
        t.keyRelease(KeyEvent.VK_E);
        t.keyPress(KeyEvent.VK_W);
        t.keyRelease(KeyEvent.VK_W);
		t.delay(2250);
	}
	
	







	  private void type(String s)
	  {
	    byte[] bytes = s.getBytes();
	    for (byte b : bytes)
	    {
	      int code = b;
	      // keycode only handles [A-Z] (which is ASCII decimal [65-90])
	      if (code > 96 && code < 123) code = code - 32;
//	      robot.delay(40);
	      myTestRobot.delay(15);
	      myTestRobot.keyPress(code);
	      myTestRobot.keyRelease(code);
	    }
	  }



}