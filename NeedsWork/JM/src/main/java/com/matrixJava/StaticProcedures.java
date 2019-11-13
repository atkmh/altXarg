package main.java.com.matrixJava;

import java.awt.AWTException;
import java.io.IOException;
import java.util.ArrayList;

public class StaticProcedures {

	public static void newMatrix() throws AWTException {
		MyApp.myCurChar = (char) MyApp.charRepToIncrement; // Not a declaration ! runtime Conversion of int to Upper Char
		String mName = new StringBuilder().append(MyApp.myCurChar).toString();
		InputStringObj myInputStringObj;
		try {
			myInputStringObj = new InputStringObj("-r", null);
			InputNumericObj myInputNumericObj = new InputNumericObj(myInputStringObj);
			ArrayList<Matrix> mxHistArray = new ArrayList<Matrix>();
			mxHistArray.add(new Matrix(myInputNumericObj, mName));
			MyApp.runTimeALOAL.add(mxHistArray);
			MyApp.charRepToIncrement++; // do this at the end so that the value is ready next time in.
		} catch (IOException e) {
			System.out.println("Exception " + e);
			e.printStackTrace();
		}
	}
	
	public static void PickMatrixFromMainList() throws AWTException {
		System.out.print("Enter Matrix Name Char :");
		
		if(MyApp.roboSwitch)	
			switch(MyApp.roboSequence) {	
			case 11: 
			MyApp.RT11(); break;
		}		
		
		MyApp.currentName = MyApp.in.nextLine().toUpperCase();
		ArrayList tempAl;
		for (int x = 0; x < MyApp.runTimeALOAL.size(); x++) {
			tempAl = MyApp.runTimeALOAL.get(x);
			System.out.println("");
			MyApp.currentMx = (Matrix) tempAl.get(0);
			if (MyApp.currentMx.getName().equals(MyApp.currentName)) {    
				x = MyApp.runTimeALOAL.size(); // we're done  so end the loop
			} else MyApp.currentMx = null;
		}
		System.out.println("The Mx Name entered was :" + MyApp.currentName);
		if (MyApp.currentMx == null)   System.out.println("But, " + MyApp.currentName + " wasnt found. Current Mx is still null");
	}
	
	
	
	

	public static void showmap() {
		Matrix tempshowListMx;
		System.out.println("");
		for (int i = 0; i < MyApp.runTimeALOAL.size(); i++) {
			for (int j = 0; j < MyApp.runTimeALOAL.get(i).size(); j++) {
				tempshowListMx = (Matrix) MyApp.runTimeALOAL.get(i).get(j);
				System.out.println(" ----------   ");
				System.out.println("Modification Command\t :" + tempshowListMx.getModCmd());
				System.out.println("Modification TimeStamp\t :" + tempshowListMx.getModTimeStamp());
				System.out.println("Creation Time Stamp\t :" + tempshowListMx.getCreationTimeStamp());
				tempshowListMx.displayCompact();
				System.out.println("\n ----------   ");
			}
		}
	}
	
	public static void shownames() {
		Matrix tempshowListMx;
		for (int i = 0; i < MyApp.runTimeALOAL.size(); i++) {
			for (int j = 0; j < MyApp.runTimeALOAL.get(i).size(); j++) {
				tempshowListMx = (Matrix) MyApp.runTimeALOAL.get(i).get(j);
				System.out.println(" ----------   ");
				System.out.println("Name: " +tempshowListMx.getName());
				System.out.println("Diminsion: "+tempshowListMx.getRowDimension() +"X"+tempshowListMx.getColumnDimension()  );
				System.out.println("Modification Command\t :" + tempshowListMx.getModCmd());
				System.out.println("Modification TimeStamp\t :" + tempshowListMx.getModTimeStamp());
				System.out.println("Creation Time Stamp\t :" + tempshowListMx.getCreationTimeStamp());
				System.out.println(" ----------   ");
			}
		}
	}
	
	public static void showArrayListIndex() {
	System.out.println("");
	System.out.println("main array size: " + MyApp.runTimeALOAL.size());
	for (int i = 0; i < MyApp.runTimeALOAL.size(); i++) {
		ArrayList tmpAL4Read = MyApp.runTimeALOAL.get(i);
		System.out.println("internal size on main #" + i + " is " + tmpAL4Read.size());
	}
}	
	
    public static void 	swapMxRows() {  // Check :  is this done.  Im not putting away
    	if (MyApp.currentMx != null) {
    	System.out.print("first row: ");
        int firstRow = Integer.parseInt(MyApp.in.nextLine());
    	System.out.print("Swap with Row: ");
        int swapRow = Integer.parseInt(MyApp.in.nextLine());
        Matrix tempMX = new Matrix();
        tempMX = MyApp.currentMx.SwapRows( firstRow, swapRow);
        // ah..... Need to add this to History
        MyApp.currentMx = tempMX;
    	} else {
    		System.out.println("Must Pick a Matrix ");
    		System.out.println("Then you can swap rows\n");
    	}
    }
	
	
	public static void MatrixAddition() throws Exception {
		System.out.println("We'll need the name of two Existing Matrices...");
		System.out.println("Enter name of first matrix");
		MyApp.addendName1 = MyApp.in.nextLine();
		System.out.println("Enter name of second matrix");
		MyApp.addendName2 = MyApp.in.nextLine();
		int found = 0;

		// Need to turn this into a function that returns a Matrix given a name

		for (int x = 0; x < MyApp.runTimeALOAL.size(); x++) {
			ArrayList tempAl = MyApp.runTimeALOAL.get(x);
			System.out.println("");
			MyApp.addendMx1 = (Matrix) tempAl.get(0);
			if (MyApp.addendMx1.getName().equals(MyApp.addendName1)) {// DONE , else
				System.out.println("Debug: First Mx found at :" + x);
				x = MyApp.runTimeALOAL.size();
				found++;
			}
		}
			
	if (found < 1) throw new Exception("Matrix Name " +MyApp.addendName1 +" was not found in Main List");
		
		for (int y = 0; y < MyApp.runTimeALOAL.size(); y++) {
			ArrayList tempAl = MyApp.runTimeALOAL.get(y);
			System.out.println("");
			MyApp.addendMx2 = (Matrix) tempAl.get(0);
			if (MyApp.addendMx2.getName().equals(MyApp.addendName2)) { // DONE , else
				System.out.println("Debug: Second Mx found at :" + y);
				y = MyApp.runTimeALOAL.size();
				found++;
			} 
		}
	if (found > 0 && found < 2) throw new Exception("Matrix Name " +MyApp.addendName2 +" was not found in Main List");
			
		
		//System.out.println("number found: " + found);
		//MyApp.addendMx1.displayCompact();  // currently this is where the exception is thrown
		//MyApp.addendMx2.displayCompact();
		MyApp.currentMx = MyApp.addendMx1.Add(MyApp.addendMx2);
		MyApp.currentMx.setName(MyApp.addendName1 + "+" + MyApp.addendName2);
		MyApp.currentMx.setModifyingCommand("Summation: "+MyApp.addendName1 +"+"+MyApp.addendName2 );
		ArrayList<Matrix> mxTempArray = new ArrayList<Matrix>();
		mxTempArray.add(MyApp.currentMx);
		MyApp.runTimeALOAL.add(mxTempArray);
	}	

    public static void MatrixSubtract() throws Exception {// Minuend - Subtrahend = Difference
		System.out.println("We'll need the name of two Existing Matrices...");
		System.out.println("Enter name of first matrix");
		MyApp.minuendName = MyApp.in.nextLine();
		System.out.println("Enter name of second matrix");
		MyApp.subtrahendName = MyApp.in.nextLine();
		int found = 0;	
    	
		for (int x = 0; x < MyApp.runTimeALOAL.size(); x++) {
			ArrayList tempAl = MyApp.runTimeALOAL.get(x);
			System.out.println("");
			MyApp.minuMx = (Matrix) tempAl.get(0);
			if (MyApp.minuMx.getName().equals(MyApp.minuendName)) {// DONE , else
				System.out.println("Debug: First Mx found at :" + x);
				x = MyApp.runTimeALOAL.size();
				found++;
			}
		} 
		
		if (found < 1) throw new Exception("Matrix Name " +MyApp.minuendName +" was not found in Main List");
		
		for (int y = 0; y < MyApp.runTimeALOAL.size(); y++) {
			ArrayList tempAl = MyApp.runTimeALOAL.get(y);
			System.out.println("");
			MyApp.subtraMx = (Matrix) tempAl.get(0);
			if (MyApp.subtraMx.getName().equals(MyApp.subtrahendName)) { // DONE , else
				System.out.println("Debug: Second Mx found at :" + y);
				y = MyApp.runTimeALOAL.size();
				found++;
			} 
		}
	if (found > 0 && found < 2) throw new Exception("Matrix Name " +MyApp.addendName2 +" was not found in Main List");
		
	//System.out.println("number found: " + found);
	//MyApp.addendMx1.displayCompact();  // currently this is where the exception is thrown
	//MyApp.addendMx2.displayCompact();
	MyApp.currentMx = MyApp.minuMx.Subtract(MyApp.subtraMx);
	MyApp.currentMx.setName(MyApp.minuendName + "-" + MyApp.subtrahendName);
	MyApp.currentMx.setModifyingCommand("Difference: "+MyApp.minuendName +"+"+MyApp.subtrahendName );
	ArrayList<Matrix> mxTempArray = new ArrayList<Matrix>();
	mxTempArray.add(MyApp.currentMx);
	MyApp.runTimeALOAL.add(mxTempArray);	
    }
    
    
	public static void MatrixMultiply() throws Exception {
		System.out.println("We'll need the name of two Existing Matrices...");
		System.out.println("Enter name of first matrix");
		MyApp.factor1Name = MyApp.in.nextLine();
		System.out.println("Enter name of second matrix");
		MyApp.factor2Name = MyApp.in.nextLine();
		int found = 0;	
		
		for (int x = 0; x < MyApp.runTimeALOAL.size(); x++) {
			ArrayList tempAl = MyApp.runTimeALOAL.get(x);
			//System.out.println("");
			MyApp.factorMx1 =  (Matrix) tempAl.get(0);
			if (MyApp.factorMx1.getName().equals(MyApp.factor1Name)) {// DONE , else
				System.out.println("Debug: First Mx found at :" + x);
				x = MyApp.runTimeALOAL.size();
				found++;
			}
		}
		if (found < 1) throw new Exception("Matrix Name " +MyApp.addendName1 +" was not found in Main List");
		for (int y = 0; y < MyApp.runTimeALOAL.size(); y++) {
			ArrayList tempAl = MyApp.runTimeALOAL.get(y);
			//System.out.println("");
			MyApp.factorMx2 = (Matrix) tempAl.get(0);
			if (MyApp.factorMx2.getName().equals(MyApp.factor2Name)) { // DONE , else
				System.out.println("Debug: Second Mx found at :" + y);
				y = MyApp.runTimeALOAL.size();
				found++;
			} 
		}
	    if (found > 0 && found < 2) throw new Exception("Matrix Name " +MyApp.addendName2 +" was not found in Main List");
		System.out.println("number found: " + found);
		//MyApp.factorMx1.displayCompact();  // currently this is where the exception is thrown
		//MyApp.factorMx2.displayCompact();
		MyApp.currentMx = MyApp.factorMx1.Multiply(MyApp.factorMx2);
		MyApp.currentMx.setName(MyApp.factor1Name + "*" + MyApp.factor2Name);
		ArrayList<Matrix> mxTempArray = new ArrayList<Matrix>();
		mxTempArray.add(MyApp.currentMx);
		MyApp.runTimeALOAL.add(mxTempArray);	
	}

	public static void MatrixScalerMultiplication() {
		// Check if we are pointing at a current Matrix if so, get scaler value. Echo the scaler entered multiply
		// current*Scaler. prepare a temporary Matrix so we can search for new current home get the name of the
		// current Mx. Prepare a var for array index of name. start the search. when found - put CurrentMx away
				if (MyApp.currentMx == null) {
					System.out.println("Current Matrix is not selected.  Pick-A-Matrix");
					return;
				}
				System.out.println("Enter Scaler Value");   MyApp.scalerValue = Double.parseDouble(MyApp.in.nextLine());
				System.out.println("Scaler Value entered: " + MyApp.scalerValue);   
				MyApp.currentMx = MyApp.currentMx.Multiply(MyApp.scalerValue);
				String currentMxName = MyApp.currentMx.getName();   
				MyApp.currentMx.setModifyingCommand(currentMxName + "=" + currentMxName + "x where x == " + MyApp.scalerValue);
				
				Matrix tempMx;
				int rtALOAL_Index = 0;

				for (int i = 0; i < MyApp.runTimeALOAL.size(); i++) {
					tempMx = (Matrix) MyApp.runTimeALOAL.get(i).get(0);
					if (currentMxName == tempMx.getName()) {
						rtALOAL_Index = i;
						i = MyApp.runTimeALOAL.size(); // this should break us out
					}
				}
				System.out.println("The index of the name is :" + rtALOAL_Index);

				ArrayList<Matrix> tempAL = MyApp.runTimeALOAL.get(rtALOAL_Index); // get a temp ArrayList

				for (int x = tempAL.size(); x < 0; x--) { // iterate thought history copying N to N+1 this is done backwards
					tempAL.add((x + 1), tempAL.get(x));
					System.out.println("copied into " + (x + 1) + "from " + x);
				}
				tempAL.add(0, MyApp.currentMx);// finish with the zeroth entry
			}	
	// ??  is this a display the matrix history routien  ??
	//
	public static void singleMatrixHist() {
		System.out.print("Enter Matrix Name Char :");
		MyApp.currentName = MyApp.in.nextLine();
		ArrayList tempAl;
		Matrix tempMx;
		int rtALOAL_Index = 0;
		for (int x = 0; x < MyApp.runTimeALOAL.size(); x++) {
			tempAl = MyApp.runTimeALOAL.get(x);
			MyApp.currentMx = (Matrix) tempAl.get(0);
			if (MyApp.currentMx.getName().equals(MyApp.currentName)) {    
				rtALOAL_Index = x;                  // set the index of the name we're looking for
				x = MyApp.runTimeALOAL.size();      // we're done  so end the loop
			} else MyApp.currentMx = null;
		}	
		if(MyApp.currentMx == null) {
		     tempAl = MyApp.runTimeALOAL.get(rtALOAL_Index);
		     for(int x=0 ; x < tempAl.size(); x++) {
			     tempMx = (Matrix) tempAl.get(x);
					System.out.println("Modification Command\t :" + tempMx.getModCmd());
					System.out.println("Modification TimeStamp\t :" + tempMx.getModTimeStamp());
					System.out.println("Creation Time Stamp\t :" + tempMx.getCreationTimeStamp());
			     tempMx.displayCompact();
		     }
		}
		
	}

public static void SetMxDataLinear(String debug) {  // is SetMxDataLinear supposed to return and new matrix ?
//	                                                // In my model it is supposed to
	if (MyApp.currentMx == null) {
		System.out.println("Current Matrix is not selected.  Pick-A-Matrix");
		return;
	}
	MyApp.tempMx = MyApp.currentMx.setLinearData();    // In my model it is supposed to
	MyApp.tempMx.setModifyingCommand("set Linear data" );
// debug output
//	System.out.println("tempMx name " +MyApp.tempMx.getName() +" back from data set.");
//	System.out.println("currentMx name " +MyApp.currentMx.getName() +" back from data set.");
	
	StaticProcedures.pushHistory(MyApp.tempMx,debug);
}
	
     public static void SetMxRandata() {
    	 if (MyApp.currentMx == null) {
		 System.out.println("Current Matrix is not selected.  Pick-A-Matrix");
		 return;
	     }
    	 MyApp.tempMx = MyApp.currentMx.setRandData();
    	 MyApp.tempMx.setModifyingCommand("set Random data");
    	StaticProcedures.pushHistory(MyApp.tempMx, ""); // "" represents Null debug string
     }
    
    public static void alterRowByScalerValue() throws AWTException {
    	RowOperation rowOperation = new RowOperation();
        System.out.println("Pick the Matrix");
        PickMatrixFromMainList();
        DisplayCurrentMatrixC();
        rowOperation.PrepRowAndScaler();
        MyApp.tempMx = rowOperation.RsltRowMultbyScaler(MyApp.currentMx);
   
    	MyApp.tempMx.setModifyingCommand(MyApp.tempMx.getRowOpp());
        StaticProcedures.pushHistory(MyApp.tempMx,""); // "" is passing a null char as debut
    
    }
     
    public static void alterRowByAddingModifiedRow() throws AWTException {
    	RowOperation rowOperation = new RowOperation();
        System.out.println("Pick the Matrix");
        PickMatrixFromMainList();
        DisplayCurrentMatrixC();
        rowOperation.PrepRowScalerForAddToRow();
        MyApp.tempMx = rowOperation.RsltRowAddedToSrcRowMultbyScaler(MyApp.currentMx);
    
    	MyApp.tempMx.setModifyingCommand(MyApp.tempMx.getRowOpp());
        StaticProcedures.pushHistory(MyApp.tempMx,""); // "" is passing a null char as debut
        // Modifyts
        // ModCmd
    
    }
     
	/*
	 * ***************************************************************************
	 * Current represents a 'Named' Matrix pulled out of the main List if Current is
	 * null the tempMx has not yet been copied out of the main list
	 ******************************************************************************/
	public static void CurrentNullCheck() {
		if (MyApp.currentMx == null) System.out.println("yes: current is null");
		else  System.out.println(MyApp.currentMx.getName());
	}

	public static void DisplayCurrentMatrixC() {
		if (MyApp.currentMx == null) System.out.println("No Matrix currently selected");
		else MyApp.currentMx.displayCompact();
	}

	public static void DisplayCurrentMatrixM() {
		if (MyApp.currentMx == null) System.out.println("No Matrix currently selected");
		else MyApp.currentMx.displayMore();
	}

	public static void DisplayCurrentMatrixZ() {
		if (MyApp.currentMx == null) System.out.println("No Matrix currently selected");
		else MyApp.currentMx.displayDeepString();
	}
	
	
	// ********************************************************************************
    // * This is a storage process.  what ever is at the head of the array of Matrices 
	// * needs to be replaced with what is in mx2store* mx2store now becomes the head.
	// * newest is always the at the zeroth array index
	// ********************************************************************************
	//
	public static void pushHistory(Matrix mx2store, String debug ) { 
    Matrix tempMx;
	int rtALOAL_Index = 0;
		System.out.println("Mx Names in the List");
	for (int i = 0; i < MyApp.runTimeALOAL.size(); i++) {  // look through all of the lists
		tempMx = (Matrix) MyApp.runTimeALOAL.get(i).get(0);// get the matrix at the Head of each List
		if (debug.length() > 0 )
		System.out.print(tempMx.getName()+" "+i +" " +MyApp.runTimeALOAL.size() +" " );

		if (mx2store.getName() == tempMx.getName()) {  //  is the tempmxName fm array same as mx name passed in
			rtALOAL_Index = i;             //  get the index value cuz its true
			i = MyApp.runTimeALOAL.size(); //  Set the end condition: this should break us out
		}
	}
	ArrayList<Matrix> tempAL = MyApp.runTimeALOAL.get(rtALOAL_Index); // get a temp ArrayList 
	for (int x = tempAL.size(); x < 0; x--) { // iterate thought history copying N to N+1 this is done backwards
		tempAL.add((x + 1), tempAL.get(x));
		System.out.println("copied into " + (x + 1) + "from " + x);
	}
	tempAL.add(0, mx2store);// finish with the zeroth entry
 }

 
 
/**************************************************************************/
/*
 *   this procedure represents a  problem child that is in development
 *   Some how im addressing indices that are out of bounds
 */
	public static void  showArrayListIndex_InWork() {
		System.out.println("");
		System.out.println("main array size: " + MyApp.runTimeALOAL.size());
		String tempName;
		Matrix tmpMx;
		for (int i = 0; i < MyApp.runTimeALOAL.size(); i++) {
			try {
			ArrayList tmpAL4Read = MyApp.runTimeALOAL.get(i);
			System.out.print("internal size on main #" +i +" is " +tmpAL4Read.size() +": ");
			tempName = ((Matrix) tmpAL4Read.get(0)).getName();// cast to Matrix referrs to get(0)  not .getName
            tmpMx = (Matrix) tmpAL4Read.get(i);
//            System.out.printf("%12s" +" Matrix is ");
			System.out.print("Matrix Name: " +tempName);
			System.out.print(" ");
            System.out.print("Matrix is ");
            System.out.printf("%2d", tmpMx.getRowDimension() );
            System.out.print("X");
            System.out.println(tmpMx.getColumnDimension() );
			}
			catch (Exception e)
			{ System.out.println("what happened at " +e);
			}
			}
		
	}


}
