/* Create a child frame window from within
   an applet.  
*/
import java.awt.*;
import java.applet.*;
/*
  <applet code="AppletFrame" width=300 height=50>
  </applet>
*/

// Create a subclass of Frame
class SampleFrame extends Frame {
  SampleFrame(String title) {
    super(title);
  }

  // Hide window when terminated by user.
  public boolean handleEvent(Event evtObj) {
    if(evtObj.id == Event.WINDOW_DESTROY) {
      hide();
      return true;
    }      
    return super.handleEvent(evtObj);
  }

  public void paint(Graphics g) {
    g.drawString("This is in frame window", 10, 20);
  }    
}

// Create the applet window.
public class AppletFrame extends Applet{
  SampleFrame f;

  // Create a frame window.
  public void init() {
    f = new SampleFrame("A Frame Window");
    f.show();
    f.resize(250, 100);
  }

  // Remove frame window when stopping applet.
  public void stop() {
    f.hide(); 
  }

  // Show frame window when starting applet.
  public void start() {
    f.show();
  }

  // Display msg in applet window.
  public void paint(Graphics g) {
    g.drawString("This is in applet window.", 10, 20);
  }    
}

