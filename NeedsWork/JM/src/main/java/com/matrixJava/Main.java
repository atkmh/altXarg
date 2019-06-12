package main.java.com.matrixJava;

public class Main {

	static boolean mydebug = false, orderSet = false;
	private static int row_m = 0;
	private static int col_n = 0;
	private static String rawOrder = null;
	private static int orderProduct = 0;
	//private static int allRowsData[];

	public static void main(String[] args) {
		//ParseInput myPI = new ParseInput();	This was the first pass at parsing input

	int loopCount = 0, allRowsData_index = 0;
	int allRowsData[] = null; 
	int tempInt = 0 ;
	boolean debugRead = false;
	boolean orderLowXFixed = false; // not sure I can/should use: do I ever know if it was x vs X
	mydebug = false;
	orderSet= false;	
	row_m = 0;
	col_n = 0;
	rawOrder = null;
	orderProduct = 0;
	
		if (args.length==0) {
			System.out.println("absolutely no input");
		} else {  
		//	myPI.PI(args,mydebug);  Call to ParsInput.java

/*		System.out.println("Printing Out the Input Data:");
		for (String dataOut: args)	{

			System.out.print(dataOut +" ");
		} System.out.println("---------------------------------------");
*/			
	
		//New for loop replacing for each	
		for (int x = 0 ; x < args.length; x++) {
			/*
			 *  debug only lives at 0
			 *  Contains X only lives at 0 or 1
			 * 
			 */
			if ( x == 0) {
				if ( args[x].equals("debug") ) {// cuz it gives me much more exact location in the array of str
					debugRead = true;
					mydebug = true;
					if(mydebug)System.out.println("debugset");
					if(mydebug)System.out.println("loopCount is: " +loopCount++ +" "+ args[x]);
				}
			}
			
			if( x == 0 || x == 1) {
				if (args[x].contains("x")||args[x].contains("X")) {
					// Fixing input: If its a lower x we fix. 
					rawOrder = args[x].replace('x', 'X');
					//
					//  rawOrder is now in the form of MXN
					//
					if(mydebug)System.out.println("loopCount is: " +loopCount++ +" "+ args[x]);
					parseOrder(rawOrder);
					orderSet=true;
				}
			}

			
			if (x > 0 && orderSet) {
				if(mydebug)System.out.print("Rows data is: ");
				if (orderSet) { // order is only set after parsing order of MxN
					//allRowsData[allRowsData_index++] = Integer.parseInt(input);
					if(mydebug)System.out.println("x is : " +x +" args[x] is: " +args[x]);
					//System.out.print(args[x]);
						tempInt = Integer.parseInt(args[x]);
						//allRowsData[allRowsData_index] = Integer.parseInt(args[x]);
						//allRowsData_index =+ 1;
						System.out.print("Capture Int: ");
						System.out.println(tempInt);
				}
			}

			//System.out.println("");
		
			
		}// end of for (int x = 0 ; x <= args.length; x++) {


		}// end else args.length != 0

		 
		 
	//	 int get_line_number() {
	//		    List<StackFrame> stack = StackWalker.getInstance(StackWalker.Option.SHOW_HIDDEN_FRAMES).walk((s) -> s.skip(1).collect(Collectors.toList()));
	//		    return stack.get(0).getLineNumber();
			//}
		 
		// mydebug=false;
		 loopCount = 0;
		 allRowsData_index = 0;	 
		 
	}// end void main(String[] args )

	public static void parseOrder(String order) {
		if (mydebug)
			System.out.println("OrderLength is: " + order.length());

		int first_xLoc = 0, last_xLoc = 0;
		first_xLoc = order.indexOf('X');
		last_xLoc = order.lastIndexOf('X');
		if (mydebug)
			System.out.println("First and last X recorded");

		if (first_xLoc != last_xLoc) // if != there was more than one X
			if (mydebug)
				System.out.println("houston:  We Have An XXXXXXXX Problem");

		row_m = Integer.parseInt((order.substring(0, first_xLoc /* spacer */ )));
		if (row_m < 1) {
			System.out.println("Value less that 1 detected: ");
			Usage();
			System.out.println("Exiting");
			System.exit(1);
		}

		if (mydebug)
			System.out.println("Let See if we have row integer: " + row_m);
		col_n = Integer.parseInt((order.substring((last_xLoc + 1), order.length())));
		if (col_n < 1) {
			System.out.println("Value less that 1 detected: ");
			Usage();
			System.out.println("Exiting");
			System.exit(1);
		}
		
		
		
		if (mydebug)
			System.out.println("Let See if we have col integer: " + col_n);

		orderProduct = row_m * col_n;
		if (mydebug)
			System.out.println("orderProduct just set at: " + orderProduct);

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
	}
	
	
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