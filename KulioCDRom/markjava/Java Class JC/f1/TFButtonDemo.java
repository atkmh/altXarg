import java.awt.*;
import java.applet.*;


public class TFButtonDemo extends Applet
{
	TextField mytextfield;
	String msg = "";
 

	public void init()
	{
//setLayout(new FlowLayout(FlowLayout.LEFT));

	 Label nameplace = new 
         Label("Why couldn't I correctly place the text?", Label.RIGHT);
	 mytextfield = new TextField(45);
	 Button button1 = new Button("ONE");
	 Button button2 = new Button("TWO");
	 Button button3 = new Button("THREE");

	 add(nameplace);
	 add(mytextfield);
	 add(button1);
	 add(button2);
	 add(button3);
	}// end init

    // Trap event User Pressed Enter
    public boolean action(Event evtObj, Object arg)
    {   // One long Boolean expression that might
        // be more elegantly written, but not now.
        // if(TextField or Button)
	if((evtObj.target instanceof TextField ) 
         | (evtObj.target instanceof Button))
	{
	  if(evtObj.target instanceof TextField)
	  {	repaint();
	 	return true;
	  }// end if
	  else if(evtObj.target instanceof Button)
	  {
	 	if(arg.equals("ONE"))
	 	{ msg = "You pressed Button ONE"; 
		  //mytextfield.setCaretPosition(10);
		  mytextfield.setText(msg);
	 	}
	 	else if(arg.equals("TWO"))
	 	{  msg = "You pressed Button TWO";
		 // mytextfield.setCaretPosition(10);
		  mytextfield.setText(msg);
	 	}
		else if(arg.equals("THREE"))
	 	{  msg = "What d'ju say about my moma?!?";
		  //mytextfield.setCaretPosition(10);
		  mytextfield.setText(msg);
	 	}
		repaint();
		return true;
	  }// end else if
	}// end if

    	return false;

    }// end public boolean action
}// end class
