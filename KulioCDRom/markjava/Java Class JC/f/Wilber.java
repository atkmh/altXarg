import java.awt.*;
import java.applet.*;

public class Wilber extends Applet
{
	TextField Tfname, Tfpass;
	Checkbox CbforWilber;

	public void init()
	{
	 CbforWilber = new Checkbox("Box for X", null, true);
	 Label namep = new Label("Name: ", Label.RIGHT);
	 Label passp = new Label("Password: ", Label.RIGHT);
         Tfname = new TextField(12);
	 Tfpass = new TextField(8);
	 Tfpass.setEchoCharacter('*');
	 add(CbforWilber);
	 add(namep); 
	 add(Tfname);  
	 add(passp);  
	 add(Tfpass);  
	}


    // Trap event User Pressed Enter
    public boolean action(Event evtObj, Object arg)
    {   if(evtObj.target instanceof TextField)
	{	repaint();
	 	return true;
	}
	return false;
    }
 
    public void paint(Graphics g)
    {  g.drawString("Tfname: " + Tfname.getText(), 6, 60);
       g.drawString("Selected Text within Tfname: " 
                  + Tfname.getSelectedText(), 6, 80);
       g.drawString("Tfpass: " + Tfpass.getText(), 6, 100);
    }
}
