package main.java.com.matrixJava;

import java.util.ArrayList;

public class Main {

	static boolean mydebug = false, orderSet = false;
	private static int row_m = 0;
	private static int col_n = 0;
	private static String rawOrder = null;
	private static int orderProduct = 0;
	private static ArrayList<Integer> allRowsData = new ArrayList<Integer>();

	public static void main(String[] args) {
		//ParseInput myPI = new ParseInput();	This was the first pass at parsing input

//	int loopCount = 0, 
	int allRowsData_index = 0;
//	ArrayList<Integer> allRowsData = new ArrayList<Integer>();
//	int[] allRowsData = null; 
//	int tempInt = 0 ;
	int x = 0;
//	boolean orderLowXFixed = false; // not sure I can/should use: do I ever know if it was x vs X
	mydebug = false;
	orderSet= false;	
	row_m = 0;
	col_n = 0;
	rawOrder = null;
	orderProduct = 0;
	
	if (args.length==0) 
{
			System.out.println("absolutely no input");
		
} // end of if (args.length==0) 
	else 
{  
		//	myPI.PI(args,mydebug);  Call to ParsInput.java

	int loc = 0;			
	if(mydebug) 
	{// ended Yes
		if (( (loc = args[1].indexOf('x')  ) < 0) &&  (( loc = args[1].indexOf('X')) < 0) ) 
		{// ended yes
			System.out.println("should mean I didn't fine and X or and x ");
			System.out.println("Also by now I should have found debug if it were there");
			System.out.println("This should be a total Order entry failure ");
			System.out.println("Usage:"); Usage();
		}// end if (( (loc = args[0].indexOf('x')  ) < 0) &&  (( loc = args[0].indexOf('X')) < 0) )  

	}//end if !mydebug		
		

//  Don't think I"m using OUTER_LOOP any longer	6/28/19
//	OUTER_LOOP:
	for ( x = 0 ; x < args.length; x++) 
	{// ended yes
		if (x == 0 ) 
		{// ended Yes
			String firstArg = args[0];
			switch (firstArg) 
			{// ended yes
				case "-h":
				case "--h":
				case "-help":
				case "--help":
				Usage();
					continue ;
				case "-u":
				case "--u":
				case "-usage":
				case "--usage":
					Usage();
					continue ;
				case "debug":
					if (args.length < 2 )  Usage(); // Means all that was passed was "debug" 
					mydebug = true;
					if(mydebug)System.out.println("debugset");
				//	if(mydebug)System.out.println("loopCount is: " +loopCount++ +" "+ args[x]);
					System.out.println("Using continue to outer loop");
					//break ;
					continue;
				default:
					//System.out.println("DebutPrintOutof XXXXX: " +x);
					//
					boolean charTestBool = false;
					char firstChar = 0;
					try {// start of try
					firstChar = args[x].charAt(0);
				/* end of try*/	} catch (IndexOutOfBoundsException e) { // start of catch
					System.out.println("Exception" +e );
							Usage();
						} // endof Catch
					charTestBool = Character.isDigit(firstChar);
					if (!charTestBool) 
						Usage();
					else {

					try {// start of try
					rawOrder = args[x].replace('x', 'X');
					parseOrder(rawOrder);
					orderSet=true;
				/* end of try*/	} catch (IndexOutOfBoundsException e) { // start of catch
					System.out.println("Exception" +e );
							Usage();
						} // endof Catch
					continue ; 
					}

			}//end Switch firstArg
		}// end if(x==0
	
		
	/*
		int loc = 0;	
		if(!mydebug) 
		{// ended Yes
			if (( (loc = args[0].indexOf('x')  ) < 0) &&  (( loc = args[0].indexOf('X')) < 0) ) 
			{// ended yes
				System.out.println("should mean I didn't fine and X or and x ");
				System.out.println("Also by now I should have found debug if it were there");
				System.out.println("This should be a total Order entry failure ");
				System.out.println("Usage:"); Usage();
			}// end if (( (loc = args[0].indexOf('x')  ) < 0) &&  (( loc = args[0].indexOf('X')) < 0) )  

		}//end if !mydebug
	*/

		if( (x == 1) && mydebug  ) // I only come here if arg 0 was debug
		{// ended yes
				if (args[x].contains("x")||args[x].contains("X")) 
				{// ended yes
					// Fixing input: If its a lower x we fix. 
					rawOrder = args[x].replace('x', 'X');
				//	if(mydebug)System.out.println("loopCount is: " +loopCount++ +" "+ args[x]);
					parseOrder(rawOrder);
					orderSet=true;
				}// end of if (args[x].contains("x")||args[x].contains("X")) 
				else {System.out.println("There's a big Problem.  No Exxes.  USAGE... ");Usage(); }
				continue;
		}// end of if( x == 0 || x == 1) 

		// Prior to entry 
		allRowsData_index = 0;
		
		if (x > 0 && orderSet)   // then this means WHAT ???  Where am I ??
		{// ended No
			if (args[0].contentEquals("debug"))	//	This check cuz we need to know cuantos to loop
			{// ended Yes							
				for (int i = 2 ; i <= (args.length)-1 ; i++ , allRowsData_index++ ) 
				{// ended Yes
					allRowsData.add( Integer.parseInt(args[i]) );
					//System.out.print(". ");System.out.print(args[i]);
				}// end of for (int i = 2 ; i <= (args.length)-1 ; i++) {
			}// end of if (args[0].contentEquals("debug"))	{
			else if (args[0].contains("x")||args[0].contains("X")) 
			{// ended yes
				System.out.println("noDebug");

				for (int i = 1 ; i < (args.length) ; i++, allRowsData_index++ ) 
				{// ended Yes

					allRowsData.add( Integer.parseInt(args[i]) );
					//System.out.print(". ");System.out.print(args[i]);

				}// end of for (int i = 2 ; i <= (args.length)-1 ; i++) {

			}// en of else if (args[0].contains("x")||args[0].contains("X"))  
			// else {  logic should idenfity that not debug or NXM offered }
			System.out.println("");
			x=args.length;
					
			
		}// end of if (x > 0 && orderSet)

	//System.out.print("");
	}//end of for ( x = 0 ; x < args.length; x++)   OUTER_LOOP


}// end for ( x = 0 ; x < args.length; x++) else 

		 
		 
if(mydebug)System.out.println("Last couple of things coming out of method Main");	 


}// end void main(String[] args )

	public static void parseOrder(String order) {
		if (mydebug)
			System.out.println("OrderLength is: " + order.length());

		int first_xLoc = 0, last_xLoc = 0;
		first_xLoc = order.indexOf('X');
		last_xLoc = order.lastIndexOf('X');
		if (mydebug) System.out.println("First and last X recorded");

		if (first_xLoc != last_xLoc) // if != there was more than one X
			if (mydebug) System.out.println("houston:  We Have An XXXXXXXX Problem");

		row_m = Integer.parseInt((order.substring(0, first_xLoc /* spacer */ )));

		if (row_m < 1) {// error condition
			System.out.println("Value less that 1 detected: ");
			Usage();
			System.out.println("Exiting");
			System.out.println("but were not really going to exit rt now");
			//System.exit(1);  // cold make this if(myExit) where exit is passed in to test ???
		}

		if (mydebug) System.out.println("Let See if we have row integer: " + row_m);

		col_n = Integer.parseInt((order.substring((last_xLoc + 1), order.length())));

		if (col_n < 1) {
			System.out.println("Value less that 1 detected: ");
			Usage();
			System.out.println("Exiting");
			System.out.println("but were not really going to exit rt now");
			//System.exit(1);
		}
		
		if (mydebug) System.out.println("Let See if we have col integer: " + col_n);

		orderProduct = row_m * col_n;

		if (mydebug)
			System.out.println("orderProduct just set at: " + orderProduct);
	}

	public static void clear_inputData(){
		allRowsData.clear();
		return;
	}
	
	public static ArrayList<Integer> get_InputData() {
		return allRowsData ;
	}
	
	public static String get_order() {
		return rawOrder;
	}
	
	
	public static int get_prod() {
		return orderProduct;
	}

	
	public static int get_m() {
		return row_m;
	}

	
	public static int get_n() {
		return col_n;
	}

	
	public static String get_debug() {
		//String result = "set";
		if (mydebug)
			return "set";
		else
			return "unset";
	}
	
	
	public static void Usage() {
		
		System.out.println("Usage:  MXN N N N N where MXN values are greater then 0");
		System.out.println("Production would Exit on the usage Call");
	//	System.exit(-1);
	}
	
//	System.out.println("Clearing out the ArrayList<Integer>                       ");
//	allRowsData.clear();	
} // End of class Main

/********************************************************************************
 * Program Input Definition: What are the argument data types at the command
 * line
 * 
 * ProgramName: This ClassName Arg1: String - in form " NXN where N is Positive
 * Integer , X is "X" : To start this project N < 4 otherwise thigs will just be
 * stupid : N and N will be the controlling Row and Column Loop controls Arg2:
 * String - in form N where N is integer Arg-: String - in form N where N is
 * integer Arg-: String - in form N where N is integer Arg-: String - in form N
 * where N is integer Arg-
 * 
 * 
 * https://www.oreilly.com/library/view/java-cookbook/0596001703/ch03s05.html //
 * StrCharAt.java String a = "A quick bronze fox leapt a lazy bovine"; for (int
 * i=0; i < a.length( ); i++) System.out.println("Char " + i + " is " +
 * a.charAt(i));
 * 
 * 
 */
//	 int get_line_number() {
//		    List<StackFrame> stack = StackWalker.getInstance(StackWalker.Option.SHOW_HIDDEN_FRAMES).walk((s) -> s.skip(1).collect(Collectors.toList()));
//		    return stack.get(0).getLineNumber();
		//}



/*			switch loc {
case 0:
	System.out.println("");
	break;
case 1;
	break;
	System.out.println("");
default;
	break;
	System.out.println("");

	} */