/*

*/

import java.awt.*;
import java.applet.*;
/*
  <applet code="SchoolWork " width=250 height=200>
  </applet>
*/

public class SchoolWork extends Applet {
  String msg = "";
  Checkbox win95, winNT;

  public void init() {
    win95 = new Checkbox("Windows 95", null, true);
    winNT = new Checkbox("Windows NT");


    add(win95);
    add(winNT);

  }

  // Repaint when status of check box changes. 
  public boolean action(Event evtObj, Object arg) {
    if(evtObj.target instanceof Checkbox) {
      repaint();
      return true;
    }
    return false;
  }

  // Display current state of the check boxes.
  public void paint(Graphics g) {
    msg = "Current state: ";
    g.drawString(msg, 6, 80);
    msg = "  Windows 95: " + win95.getState();
    g.drawString(msg, 6, 100);
    msg = "  Windows NT: " + winNT.getState();
    g.drawString(msg, 6, 120);
  
  }
}




