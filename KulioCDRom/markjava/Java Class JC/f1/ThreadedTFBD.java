/*********************************************
* 
* Mark Atkinson
* Assignment F Assignment F: Ch 18-20
*              Create an applet with a 
*              text field and 3 buttons
* 
* 0964.3473.F
* 
* 
* 
* 
* 
* 
**********************************************/

import java.awt.*;
import java.applet.*;


public class ThreadedTFBD extends Applet implements Runnable
{
	TextField mytextfield;
	String msg = "";

	String banner = "      A Simple Threaded Moving Banner named ";
	Thread t = null;
	Checkbox suspendMe;


	public void init()
	{


	 suspendMe = new Checkbox("Click Me: Stop the Banner", false);
	 Label nameplace = new
         Label("Why couldn't I correctly place the text?", Label.RIGHT);
	 mytextfield = new TextField(50);
	 Button button1 = new Button("ONE");
	 Button button2 = new Button("TWO");
	 Button button3 = new Button("THREE");


	 add(nameplace);
	 add(mytextfield);
	 add(button1);
	 add(button2);
	 add(button3);
	 add(suspendMe);

	 t = new Thread(this);
	 t.start();
	 t.suspend();

	 String tName = t.getName();
	 banner += tName;

	}// end init

	public void start()
	{
	 t.resume();
	}

	// Thread's Entry point.
	public void run()
	{
	 char ch;
	 for( ; ; ) // infinite loop for the banner.
	 {
		try
		{
		 repaint();
		 Thread.sleep(111);// sleep OneHundredElevel miliseconds or 1.11 10ths sec
		 ch = banner.charAt(0);
		 banner = banner.substring(1, banner.length());
		 banner += ch;
		}// end try
		catch(InterruptedException e) {}

	 }// end for
	}// end void run




    // Trap event User Pressed Enter
    public boolean action(Event evtObj, Object arg)
    {   // One long Boolean expression that might
        // be more elegantly written, but not now.
        // if(TextField or Button or Checkbox)
	if((evtObj.target instanceof TextField )
         | (evtObj.target instanceof Button)
	 | (evtObj.target instanceof Checkbox))
         {
	  if((evtObj.target instanceof TextField) | (evtObj.target instanceof Checkbox))
	  {	
		if((suspendMe.getState()) == true)
		{
			repaint();
			t.suspend();
	 		return true;
		} // end if

		else

		{	
			suspendMe.setState(false);
			t.resume();
			repaint();
	 		return true;

		}//end else

	  }// end if

	  else if(evtObj.target instanceof Button)

	  {
	 	if(arg.equals("ONE"))
	 	{ msg = "You pressed Button ONE  -- and the banner stopped.";
		  mytextfield.setText(msg);
		  suspendMe.setState(true);
	 	  t.suspend();
	 	}
	 	else if(arg.equals("TWO"))
	 	{ msg = "?Donde esta la Biblioteca";
		  mytextfield.setText(msg);
	 	}
		else if(arg.equals("THREE"))
	 	{ msg = "You pressed Button Three -- restarting the Banner.";
		  mytextfield.setText(msg);
		  suspendMe.setState(false);
		  t.resume();
	 	}
		repaint();
		return true;
	  }// end else if

	}// end if

    	return false;

    }// end public boolean action



	public void stop()
	{
	 t.suspend();
	}

	public void destroy()
	{
	 if(t != null)
	 {
	  t.stop();
	  t=null;
	 }
	}

	public void paint(Graphics gc)
	{
	 
	 gc.drawString(banner,25,175);
	}

}// end class
