package main.java.com.matrixJava;

import java.util.ArrayList;

public class CmdLineInStrObj {
	
//[ late this class and RunTimeStirngObj do nearly the same thing
//  I feel like both of these classes need to be extensions of a subclass
//  Or theses are the subClass of some other root class.....

// Assumption [late:  This assumption is wrong.
// what about -f filename -r runtime
// Input:   #program -b|c|d|h 3x5 2.3 22 0 0.5 11 0 0 2.1787
// Output : [Object [-b][3x5][2.3 22 0 0.5 11 0 0 2.1787]]

	private String first = ""; // -b Must be !
	private String second= ""; // 3X6 Must Be ! 
	private ArrayList<String> mVals = new ArrayList<String>();  // remember this is input

		//CmdLineInStrObj myInputObj = null;
		
	public CmdLineInStrObj(String[] cmdLineInput) {
//		String myRegex = "[0123456789X]";
		
		if( cmdLineInput[0].charAt(0) != '-'  )
			Usage.Usage("Problem: Options character wrong \n "+cmdLineInput[0] +" " +cmdLineInput[1] +" some Data");
		
	    this.first = cmdLineInput[0];	
	    
		/*  Checking for proper first char of Matrix Dimension */
		if( !( Character.isDigit(cmdLineInput[1].charAt(0))) )
			Usage.Usage("Problem: Dimensions numeric value wrong\n" +cmdLineInput[0] +" " +cmdLineInput[1] +" some Data");
	    
        if(cmdLineInput[1].contains("x") || cmdLineInput[1].contains("X"))	{
        	this.second = cmdLineInput[1].replace('x', 'X');

            /* check every dimensinon char in the list */	
        	for(int i=0; i<this.second.length(); i++)
        		if( ! ( checklist(this.second.charAt(i)) ))
			Usage.Usage("Problem: illegal char in Dimensions \n"+this.first +" " +this.second +" some Data");

        	/* check if there wsa more and one X in the dimension */		
        	if ( 1 < (this.second.codePoints().filter(ch -> ch =='X').count()) )
			Usage.Usage("Problem: to many Xs \n"+this.first +" " +this.second +" some Data");
        }
        else {	
        //	System.out.print("There's a big Problem. ");
        // 	System.out.println("Dimension is not stated correctly. ");
			Usage.Usage("Problem: Matrix Dimensions was stated incorrectly \n "+cmdLineInput[0] +" " +cmdLineInput[1] +" some Data");
        }	
        
        

		for(int x=2 ; x < cmdLineInput.length ; x++) {
			// curious Im not supposed to do this yet
			// this.mVals.add( Double.parseDouble( cmdLineInput[x] )); 
               mVals.add(cmdLineInput[x]);
		}
	}
	private boolean checklist(char myChar) {
		String myRegex = "0123456789X";
		boolean theAnswer = false; 
		
		for(int x=0 ; x < myRegex.length() ; x++)
			if(myChar == myRegex.charAt(x))
				theAnswer = true;
		return theAnswer;
	}
	
	public String getFirst() {
		return this.first;
	}
	
	public String getSecond() {
		return this.second;
	}
	
	public ArrayList getdata() {
		return this.mVals;
	}

	// the one and only constructor that I can think of
//	public CmdLineInStrObj CmdLineInStrObj (String[] cmdLineInput) {
//		
//        
//		
//		
//		/*  Checking for proper first char of -b switch*/
//		if( cmdLineInput[0].charAt(0) != '-'  )
//			Usage.Usage();
//	    this.first = cmdLineInput[0];	
//	    
//	    
//		/*  Checking for proper first char of Matrix Dimension */
//		if( !Character.isDigit(cmdLineInput[1].charAt(0) ))
//			Usage.Usage();
//	    this.second = cmdLineInput [1];		
//
//		for(int x=2 ; x < cmdLineInput.length ; x++) {
//			// curious Im not supposed to do this yet
//			// this.mVals.add( Double.parseDouble( cmdLineInput[x] )); 
//               mVals.add(testInput[x]);
//		}
//		return this;
//	}
	
	// I think setThird shold set an arrayList
	// cus I don't need to know it's size

}
