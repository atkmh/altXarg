package main.java.com.matrixJava;

import java.util.ArrayList;

public class ParseInput_v_two {
	
		static boolean mydebug = false; 
		static boolean orderSet = false;
		//	private static int row_m = 0;
		//	private static int col_n = 0;
		private int row_m = 0;
		private int col_n = 0;
		
		private String oppMode = null;
	
		private static String rawOrder = null;
		
		private static int orderProduct = 0;
	
		private static ArrayList<Integer> arrayListData = new ArrayList<Integer>();
		
		
// The following two lines live in the section below
// Loop #2
// if (cmdLineArgsIndex > 0 && orderSet) 
//		double[] inputDataArray = new double[args.length-1];
//		double[] inputDataArray = new double[args.length];

	public void PIYA(String[] args, boolean mydebug ) { // Parse Input Yet Again

//  The folling is the direction we are likely to go
//	public ParseInput_v_two PIYA(String[] args, boolean mydebug ) { // Parse Input Yet Again
		
		
    //  consider calling this function normalizeInputString: Strip debug if exist
		String[] myArgs = normalizeInput(args);
		

		int arrayListData_index = 0;
		int cmdLineArgsIndex = 0;
	
		


		int loc = 0;			
		if(mydebug) // this block works only if my debug is set
		{// ended Yes
			/* ***********************************
			 *   The following check means did not find 'x' or 'X'   indexOf returns -1 if not found
			 *   [late]this if below needs to be much much better. shouldn't be making the assignment
			 */
			if (( (loc = args[1].indexOf('x')  ) < 0) &&  (( loc = args[1].indexOf('X')) < 0) ) {
				System.out.println("should mean I didn't find X or x ");
				System.out.println("Also by now I should have found debug if it were there");
				System.out.println("This should be a total Order entry failure ");
				System.out.println("Usage:"); Usage.Usage("");
			}
		}//end if !mydebug		
			
// Loop Section #0,  Zero based cus in this zeroth or first secion
// we are looking at what the value is in Index position zero (0)
		for ( cmdLineArgsIndex = 0 ; cmdLineArgsIndex < args.length; cmdLineArgsIndex++) 
		{// ended yes
			if (cmdLineArgsIndex == 0 ) 	// means this section of code is for the first argument
			{// ended Yes
				String firstArg = args[0];
				switch (firstArg)  // this switch statement only analyzes the first argument 
				{
					case "-d":
					case "--d":
					case "-debug":
					case "--debug":
						// I have not re factored for this model
						continue;  	// Means: We have met the first argument and its time to 
						      		// iterate in the for loop and get the next argument
						
					case "-r":
					case "--r":
					case "-runtime":
					case "--runtime":
					this.oppMode = "RuntimeEntry";
					return;  	// I get to return here cus by definition we are only intereested in the
								// first (and only) argument :  operate in runtime mode
								// There is no Argument List to parse we're done.
					case "-f":
					case "--f":
					case "-file":
					case "--file":
					Parsefile();
					this.oppMode = "ParseFileEntry";
						continue ;// could be this should be a return cuz we're handing off control...

					case "-h":
					case "--h":
					case "-help":
					case "--help":
					Usage.Usage("");
						continue ;

					case "-u":
					case "--u":
					case "-usage":
					case "--usage":
						Usage.Usage("");
						continue ;

					case "debug":	// got to fix this and incorporate the other into this debug Model
						switch_debug(myArgs);
						continue;

					default: 
						/* ******************************************************************************
						 *  1: Check if first char of the args string is a digit
						 *  2: Convert 'x' to 'X' and put dimension string into rawOrder( to be parsed )
						 *  3:  
						 */
						switch_default(args, cmdLineArgsIndex);	// Side effect? set mydebug===true;
						this.oppMode = "CmdLineEntry";
				       continue ; 
				}//end Switch firstArg

			}// end if(cmdLineArgsIndex==0
	
			
			
			/* *********************************************************************
			 *	Come here if arg 0 was debug:  implies Second argument will be dimension string
			 *  3X4 will be in arg 1 :  Fix input: If its a lower x we fix. 
			 *  with uniform dimension string 3X4 now parse dimension to mRows&nCols 
			 */
// Loop Section #1:  In this section we are checking if we are on the second loop index == 1
// And we are in a debug condition
			if( (cmdLineArgsIndex == 1) && mydebug  ) {
				if (args[cmdLineArgsIndex].contains("x")||args[cmdLineArgsIndex].contains("X")) {// ends with else
					rawOrder = args[cmdLineArgsIndex].replace('x', 'X');
					parseOrder(rawOrder);
					orderSet=true;
				}// end of if (args[x].contains("x")||args[x].contains("X")) 
				else {	System.out.print("There's a big Problem. ");
						System.out.println("Dimension is not stated correctly. ");
						Usage.Usage(""); 
				} // because of the problem listed the lines above we 
				  // need to bail out of the loop and program.  This is done with Usage();

				continue;	// Reaching this point all it going ok
							// We exit the loop session and get back to the top
				
			}// end of if( cmdLineArgsIndex == 0 || cmdLineArgsIndex == 1) 

		
			// Set to zero prior to entry 
			arrayListData_index = 0;
			
		    /* *********************************************************************
		     *  We've made it past debug and dimension, so now were on data
		     *  Orderset ? DimensionSet might be a better var name
		     * 
		     * 	If these are true we are looking at data in arg 1 or in arg2 
		     *  depending if we had a debug or not.	
		     */
			if (cmdLineArgsIndex > 0 && orderSet)   // then this means WHAT ???  Where am I ??
			{// ended yet
				
				if (args[0].contentEquals("debug"))	//	This check cuz we need to know cuantos to loop
				{// ended Yes			
					double[] inputDataArray = new double[args.length-1];
					for (int i = 2 ; i <= (args.length)-1 ; i++ , arrayListData_index++ ) 
					{// ended Yes
						arrayListData.add( Integer.parseInt(args[i]) );
						inputDataArray[arrayListData_index] = Integer.parseInt(args[i]);
					}// end of for ( i <= (args.length)-1 
			//		MyApp.inputValsPassToMatrix = inputDataArray;
			//		MyApp.matrixDimensions[0] = row_m;
			//		MyApp.matrixDimensions[1] = col_n;
					
				}// end of if (args[0].contentEquals("debug"))
				else if (args[0].contains("x")||args[0].contains("X")) 
				{// ended yes
					double[] inputDataArray = new double[args.length];
					System.out.println("noDebug");
					for (int i = 1 ; i < (args.length) ; i++, arrayListData_index++ ) 
					{// ended Yes
						arrayListData.add( Integer.parseInt(args[i]) );
						inputDataArray[arrayListData_index] = Integer.parseInt(args[i]);
					}// end of for ( i <= (args.length)-1 
			//		MyApp.inputValsPassToMatrix = inputDataArray;
			//		MyApp.matrixDimensions[0] = row_m;
			//		MyApp.matrixDimensions[1] = col_n;
					
				}// end of else if (args[0].contains("x")||args[0].contains("X"))  
				// else {  logic should idenfity that not debug or NXM offered }

				System.out.println(""); // do I need this ???
				cmdLineArgsIndex=args.length;  // I think this is a hacky short circuit of the for loop
								// this would effectively end the loop.  Amy I right 7/27/19 ???
				
			}// end of if (x > 0 && orderSet)

		}//end of for (  x < args.length;   OUTER_LOOP call unused

		

	if(mydebug)System.out.println("Last couple of things coming out of method MyApp");	 


	}// end public void PIYA(String[] args, boolean mydebug )
	
//	public static void parseOrder(String order) {
	public void parseOrder(String order) {
		if (mydebug)
			System.out.println("OrderLength is: " + order.length());

		int first_xLoc = 0, last_xLoc = 0;
		first_xLoc = order.indexOf('X');
		last_xLoc = order.lastIndexOf('X');
		if (mydebug) System.out.println("First and last X recorded");

		// Detection of an input problem "3xxx6" for example
		if (first_xLoc != last_xLoc) // if != there was more than one X
		 System.out.println("houston:  We Had a multiple X's input condition   " +order);

		this.row_m = Integer.parseInt((order.substring(0, first_xLoc /* spacer */ )));

		// Error Checking here.... 0x3  type input
		if (this.row_m < 1) {// error condition
			System.out.println("Value less that 1 detected: ");
			Usage.Usage("");
			System.out.println("Exiting");
			System.out.println("but were not really going to exit rt now");
			//System.exit(1);  // cold make this if(myExit) where exit is passed in to test ???
		}

		if (mydebug) System.out.println("Let See if we have row integer: " + row_m);

		this.col_n = Integer.parseInt((order.substring((last_xLoc + 1), order.length())));

		// Error Checking here.... 4x0  type input
		if (this.col_n < 1) {
			System.out.println("Value less that 1 detected: ");
			Usage.Usage("");
			System.out.println("Exiting");
			System.out.println("but were not really going to exit rt now");
			//System.exit(1);
		}
			
		if (mydebug) System.out.println("Let See if we have col integer: " + col_n);

		this.orderProduct = this.row_m * this.col_n;

		if (mydebug) System.out.println("orderProduct just set at: " + orderProduct);

	} // end public static void parseOrder(String order) 

	public static void Parsefile() {
		System.out.println("looking for the input file with data");
		System.out.println("Production would Exit missing data on the parseFile Call");
	//	System.exit(-1);
	}


		
	public static void clear_inputData(){
		arrayListData.clear();
		return;
	}
		
	public static ArrayList<Integer> get_InputData() {
		return arrayListData ;
	}
		
	public static String get_order() {
		return rawOrder;
	}
		
		
	public static int get_prod() {
//	public int get_prod() {
		return orderProduct;
	}

		
//	public static int get_m() {
	public int get_m() {
		return this.row_m;
	}

		
//	public static int get_n() {
	public int get_n() {
		return this.col_n;
	}

		
	public static String get_debug() {
		//String result = "set";
		if (mydebug)
			return "set";
		else
			return "unset";
	}
	
		
	// I need the array passed as an argument cuz of the 
	// test done in the firest line of the method
	//
	public static void switch_debug(String[] args) {
		if (args.length < 2 )  Usage.Usage(""); // Means all that was passed was "debug" 
										// otherwise : set true following the command line option 
		mydebug = true;
		if(mydebug)System.out.println("debugset");
		if(mydebug)System.out.println("Using continue to outer loop");
	} // end public static void switch_debug(String[] args) 

		
//	public static void switch_default(String[] args, int cmdLineStringIndex) {
	public void switch_default(String[] args, int cmdLineStringIndex) {

		boolean charTestBool = false;
		char charIndex = 0;

		try {// start of try
			charIndex = args[cmdLineStringIndex].charAt(0);
		} // end of try	 

		catch (IndexOutOfBoundsException e) { // start of catch
			System.out.println("Exception" +e );
			Usage.Usage("");
		} // endof Catch

		charTestBool = Character.isDigit(charIndex);

		if (!charTestBool) Usage.Usage("");
		else {
			try {// start of try
				rawOrder = args[cmdLineStringIndex].replace('x', 'X');
				this.parseOrder(rawOrder);
				orderSet=true;
			} //* end of try
			catch (IndexOutOfBoundsException e) { // start of catch
				System.out.println("Exception" +e );
				Usage.Usage("");
			} // endof Catch
		}  // if (!charTestBool) else 	
	} // end public static void switch_default(String[] args, int x)


	
	
	public static String[] normalizeInput(String[] args) {
		// *************************************
		//  7/17/19 Last thing I did was add the triem if x then y else z
		//  Idea is to make myArgs Global and available to other methods outside MyApp well PIYA
		//    0     1   2  3  4 5 6 7 8   9
		//  [ debug 2x4 33 44 4 3 2 8 118 22 ] (i=1; i<9 ; i++i) mA[i-1] = args[i]
		//  [ 2x4 33 44 4 3 2 8 118 22 ]       (i=0;  )          mA[i] = args[i]
		//    0   1  2  3 4 5 6 7   8
		String[] argumentList = (args[0].equals("debug")) ?  new String[(args.length)-1] : new String[args.length] ;	
		if (args[0].contentEquals("debug")) {
			for (int i = 1;  i < args.length;  i++ )
				argumentList[i-1] = args[i];  // why is this different from the one below: hint skipping the first arg
		} else {
			for (int i = 0;  i < args.length;  i++ )
				argumentList[i] = args[i];    // cus this one didn't have 'debug' and the one above did
		}	
		
		return argumentList;
	} // end public static void parseMyInput(String[] args)

	
	
} // end of class
		

//   Comment start
//   This is a onHold Copy of the switch Statment 
//	 this code has been Methodized vs it being inline in the switch structure
//
////////////////////////////////////////////////////////////////////////////////////////