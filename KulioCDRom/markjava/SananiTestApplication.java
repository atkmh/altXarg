import com.abtcorp.io.*;
import com.abtcorp.hub.*;
import com.abtcorp.core.ABTException;
import com.abtcorp.core.ABTValue;
import TestLib.*;
import java.io.*;
import java.awt.*;
import java.awt.event.*;
import java.applet.*;
import javax.swing.*;

// <applet code=SananiTestApplication.class width=900 height=900></applet> 

public class SananiTestApplication extends Applet
{
	//public static boolean FileReadDEBUG = false;
	public static boolean FileReadDEBUG = true;
	
	public SananiTestApplication() { }   // constructor: currently nothing to do.
              
	// ******************************************************
	//    
	// SananiTestApplication object Variables
   String s_one, s_two;
	
   Button                                                     // Buttons for RunTestObjectPopulation
     button2RTObjPop = new Button("RunTestObjectPopulation"), //  RunTestProperties
     button2RTProp   = new Button("RunTestProperties"),       //  RunTestSessions
     button2RTSess   = new Button("RunTestSessions"),         //  RunTestTransactions
     button2RTTrans  = new Button("RunTestTransactions");     //  RunTestSessions

  
     JTextArea myTextArea = new JTextArea(35,80);
	 JScrollPane myPane = new JScrollPane(myTextArea);

   Button
     buttonLogF1 = new Button("TestObject.log"),
     buttonLogF2 = new Button("TestProperties.log"),
     buttonLogF3 = new Button("TestSessions.log"),
     buttonLogF4 = new Button("TestTransactions.log");

   Button myExitButton = new Button("Exit");
	
	// ******************************************************
	//
    // End of SananiTestApplication object Variables
   
	
	// ******************************************************
	//
	// Register Button variables with b-Act-listeners
	// Add button objects to the app.
   public void init()
   {
     button2RTObjPop.addActionListener(new BC1("RunTestObjectPopulation"));    // registration of button listeners
     button2RTProp.addActionListener(new BC1("RunTestProperties"));
     button2RTSess.addActionListener(new BC1("RunTestSessions"));
     button2RTTrans.addActionListener(new BC1("RunTestTransactions"));

     buttonLogF1.addActionListener(new BL1("TestObject.log"));  
     buttonLogF2.addActionListener(new BL1("TestProperties.log")); 
     buttonLogF3.addActionListener(new BL1("TestTransactions.log"));
     buttonLogF4.addActionListener(new BL1("TestSessions.log"));

     add(button2RTObjPop);
     add(button2RTProp);
     add(button2RTSess);
     add(button2RTTrans);

     add(myTextArea);

     add(buttonLogF1);
     add(buttonLogF2);
     add(buttonLogF3);
     add(buttonLogF4);

    myExitButton.addActionListener(new cExitButton());
    add(myExitButton);
 
   	
   }

	
	class BL1 implements ActionListener {            //, Runnable // Button Log Listner one
      private String logFileName;  
		
	public BL1(String s){ 	logFileName = s; }
   
	public void actionPerformed(ActionEvent myLogButtonEvent) { 
     int stringBufferLineCount = 0;
     StringBuffer sb_1 = new StringBuffer(); 
	//	 myTextArea.selectAll();
		 myTextArea.setText("");
   
     try{ BufferedReader in = 
            new BufferedReader( 
                new FileReader(logFileName));
     	
     while((s_one = in.readLine())!=null) {  
         sb_1.append( s_one + "\n");
         stringBufferLineCount += 1;
    } // end while
     	
     if ( FileReadDEBUG == true)    
          System.out.println(stringBufferLineCount);
     	

      myTextArea.append(sb_1.toString());
     	in.close(); 
    } // end try
  
    catch (FileNotFoundException fnfe) { 
    fnfe.printStackTrace();            } 
   
    catch (IOException e) { 
    e.printStackTrace();  }
    	
    } // end void actionPerformed
  } // end class BL1




   class BC1 implements ActionListener {     // listen for button action event 
      
   	private String buttonName;
   	
   	public BC1(String s) { buttonName = s; 	}
   	
    public void actionPerformed(ActionEvent myButtonEvent)
    { 
     try{
     	
        if(buttonName.equalsIgnoreCase("RunTestObjectPopulation")) {
        LogFile TestObjectPopulationLog = new LogFile("TestObject",false,true);
        TestObjectPopulation TestObj    = new TestObjectPopulation(TestObjectPopulationLog);
        TestObj.populate(50);  
        }
        else if(buttonName.equalsIgnoreCase("RunTestProperties")) {
      	 LogFile TestPropertiesLog = new LogFile("TestProperties",false,true);
        TestProperties TestProp = new TestProperties(TestPropertiesLog);
        TestProp.populate(3);
     	}
     	
       	else if(buttonName.equalsIgnoreCase("RunTestSessions")){
        LogFile TestSessionsLog = new LogFile("TestSessions",false,true);
        TestSessions TestSess = new TestSessions(TestSessionsLog);
        TestSess.populate(5,50); 	
     	}
     	
       	else if(buttonName.equalsIgnoreCase("RunTestTransactions")){
       LogFile TestTransactionsLog = new LogFile("TestTransactions",false,true);
       TestTransactions TestTrans = new TestTransactions(TestTransactionsLog);
       TestTrans.populate(5,50);
      }
     	
     }
     catch(Exception except){  
        except.printStackTrace();
     }
    	
    }
   } // end class BC1



/********************************************************************
*  To close a window using provided window controls, ie: Alt-Space, C
*/
  static class WinListn extends WindowAdapter {
    public void windowClosing(WindowEvent e) {
      System.exit(0);
    }
  }
/********************************************************************
*  To close a window using exit button provided by this client code.
*/
  class cExitButton implements ActionListener {
     public void actionPerformed(ActionEvent exitButtonEvent) { System.exit(0);} }

   public static void main(String args[]) {
   
    SananiTestApplication app = new SananiTestApplication();
    JFrame myFrame = new JFrame("SananiTestApplication");
    myFrame.addWindowListener(new WinListn());
    
   	myFrame.getContentPane().add(app);
   	//myFrame.add(app, BorderLayout.CENTER);
    myFrame.setSize(600,700);
    app.init();
    app.start();
    myFrame.setVisible(true);


   } // end Main

} // end SananiTestApplication