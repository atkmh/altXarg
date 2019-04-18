// Demonstrate Buttons
import java.awt.*;
import java.applet.*;
/*
  <applet code="ButtonDemo" width=250 height=150>
  </applet>
*/

public class ButtonDemo extends Applet {
  String msg = "";

  public void init() {
    Button yes = new Button("Yes");
    Button no = new Button("No");
    Button maybe = new Button("JoMutha");

    add(yes);
    add(no);
    add(maybe);
  }

  // Recognize buttons by their labels.
  public boolean action(Event evtObj, Object arg) {
    if(evtObj.target instanceof Button) {
      if(arg.equals("Yes"))
         msg = "You pressed Yes."; 
      else if(arg.equals("No"))
        msg = "You pressed No.";
      else if(arg.equals("JoMutha"))
        msg = "What d'ju say about my moma";

      repaint();
      return true;
    }
    return false;
  }

  public void paint(Graphics g) {
     g.drawString(msg, 6, 100);
  }
}
