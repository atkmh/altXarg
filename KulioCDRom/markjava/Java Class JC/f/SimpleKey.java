// Demonstrate a keyboard event handler.
import java.awt.*;
import java.applet.*;
/*
  <applet code="SimpleKey" width=300 height=100>
  </applet>
*/

public class SimpleKey extends Applet{
  String msg = "";

  // Handle key press events.
  public boolean keyDown(Event evtObj, int key) {
    msg += (char) key;
   repaint();
    showStatus("Key Down");

    return true;
  }

  // Handle key release events.
  public boolean keyUp(Event evtObj, int key) {
    showStatus("Key Up");

    return true;
  }

  // Display keystrokes.
 // public void paint(Graphics g) {
  //  g.drawString(msg, 10, 20);
  }    
}
