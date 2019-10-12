package main.java.com.matrixJava;

import java.io.IOException;
import java.util.ArrayList;

public class StaticProcedures {

	public static void newMatrix() {
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
	
	public static void PickMatrixFromMainList() {
		System.out.print("Enter Matrix Name Char :");
		MyApp.currentName = MyApp.in.nextLine();
		for (int x = 0; x < MyApp.runTimeALOAL.size(); x++) {
			ArrayList tempAl = MyApp.runTimeALOAL.get(x);
			System.out.println("");
			MyApp.currentMx = (Matrix) tempAl.get(0);
			if (MyApp.currentMx.getName().equals(MyApp.currentName)) {    x = MyApp.runTimeALOAL.size(); // we're done  so end the loop
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
        MyApp.currentMx = tempMX;
    	} else {
    		System.out.println("Must Pick a Matrix ");
    		System.out.println("Then you can swap rows\n");
    	}
    }
	
	
	public static void Add2ReturnNew() throws Exception {
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
	if (found > 0 && found < 2) throw new Exception("Matrix Name " +MyApp.addendName2 +" was not found in Main List");
			
		}
		System.out.println("number found: " + found);
		MyApp.addendMx1.displayCompact();  // currently this is where the exception is thrown
		MyApp.addendMx2.displayCompact();
		MyApp.currentMx = MyApp.addendMx1.Add(MyApp.addendMx2);
		MyApp.currentMx.setName(MyApp.addendName1 + "+" + MyApp.addendName2);
		ArrayList<Matrix> mxTempArray = new ArrayList<Matrix>();
		mxTempArray.add(MyApp.currentMx);
		MyApp.runTimeALOAL.add(mxTempArray);

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
