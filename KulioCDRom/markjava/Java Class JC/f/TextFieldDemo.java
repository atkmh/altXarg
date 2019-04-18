import java.awt.*;
import java.applet.*;

public class TextFieldDemo extends Applet {
  TextField name, pass;
  
  public void init() {
    Label namep = new Label("Name: ", Label.RIGHT);
    Label passp = new Label("Password: ", Label.RIGHT);
    name = new TextField(12);
    pass = new TextField(8);
    pass.setEchoCharacter('?');

    add(namep);
    add(name);
    add(passp);
    add(pass);
  }

  // User pressed Enter.
  public boolean action(Event evtObj, Object arg) {
    if(evtObj.target instanceof TextField) {
      repaint();
      return true;
    }
    return false;
  }

  public void paint(Graphics g) {
     g.drawString("Name: " + name.getText(), 6, 60);
     g.drawString("Selected text in name: "
                  + name.getSelectedText(), 6, 80);
     g.drawString("Password: " + pass.getText(), 6, 100);
  }
}
