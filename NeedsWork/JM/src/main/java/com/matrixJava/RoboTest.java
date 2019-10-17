package main.java.com.matrixJava;

import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;

public class RoboTest{

	
	Robot robot = new Robot();
	Robot r2 = new Robot();
	
//	  public static void main(String[] args) throws AWTException
//	  {
//	    new RoboTest();
//	  }
	  public RoboTest() throws AWTException
	  {
	    robot.setAutoDelay(40);
	    robot.setAutoWaitForIdle(true);
	    
	    robot.delay(4000);
//	    robot.delay(2500);
	    robot.mouseMove(240, 330);
	    robot.delay(500);

	    leftClick();
	    robot.delay(500);
	    leftClick();

	    robot.delay(500);
//	    type("Hello, world. ");
	    type("new");
	    robot.delay(50);
	    type(KeyEvent.VK_ENTER);
	    robot.delay(4500);
	  }	    
	  
	  
	  
//	    type("3x4");
//	    robot.delay(500);
//	    type(KeyEvent.VK_ENTER);
//	    
	    
	    
//	    
//	    
//	    robot.mouseMove(40, 160);
//	    robot.delay(500);
//
//	    leftClick();
//	    robot.delay(500);
//	    leftClick();
//	    
//	    robot.delay(500);
////	    type("This is a test of the Java Robot class");
//	    type("Testing the Java Robot class, we are. ");
//	    
//	    robot.delay(50);
//	    type(KeyEvent.VK_DOWN);
//	    
//	    robot.delay(250);
////	    type("Four score and seven years ago, our fathers ...");
//	    type("Four score and seven yada yada yada");
//
//	    robot.delay(1000);
//	  //  System.exit(0);
//	  }
	  
	  private void leftClick()
	  {
	    robot.mousePress(InputEvent.BUTTON1_MASK);
	    robot.delay(200);
	    robot.mouseRelease(InputEvent.BUTTON1_MASK);
	    robot.delay(200);
	  }
	  
	  private void type(int i)
	  {
//	    robot.delay(40);
	    robot.delay(15);
	    robot.keyPress(i);
	    robot.keyRelease(i);
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
	      robot.delay(15);
	      robot.keyPress(code);
	      robot.keyRelease(code);
	    }
	  }
}
