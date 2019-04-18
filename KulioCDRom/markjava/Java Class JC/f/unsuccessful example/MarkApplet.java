/***********************************
* Mark Atkinson
* Java SRJC Section
* Assignment F: Ch 18-20  
* Create an applet with a text field and 3 buttons, etc.
* 
* 
* 
* <applet code="MarkApplet" width=300 height=200>
* </applet>
* 
* 
**************************************/
import java.awt.*;
import java.applet.*;

public class MarkApplet extends Applet
{
 String msg = "";
 
 public boolean keyDown( Event evtObj, int key)
 {
  msg+= (char) key;
  repaint();
  showStatus("Key Down");
  System.out.println("output to console of Key" + key);
  return true;
 }


 public boolean keyUp( Event evtObj, int key)
 {
  showStatus("Key up");
  return true;
 }


 public void init()
 {
  for(int x=0; x< 5; x++)
  {System.out.println("Here's Johnny" + x);

  }
 }
 
 public void start()
 {

 }

 public void stop()
 {
 
 }

 public void destroy()
 {

 }

 public void paint(Graphics g)
 {
   g.drawString(msg, 10, 20);
 }
}
