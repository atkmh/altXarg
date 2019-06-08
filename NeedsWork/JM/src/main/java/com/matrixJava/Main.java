package main.java.com.matrixJava;

public class Main {

	static boolean mydebug=false, orderSet=false;
	private static  int row_m=0;
	private static int col_n=0;
	private static int orderProduct=0;
	private static int allRowsData[] ;
	

	public static void main(String[] args) {
		//ParseInput myPI = new ParseInput();	
		/*  
		 * Matrix Order variables are M & N */
		// int m =0, n=0;
	int loopCount = 0, allRowsData_index = 0;

		if (args.length==0) {
			System.out.println("absolutely no input");
		} else {  
		//	myPI.PI(args,mydebug);  Call to ParsInput.java
	
		for (String dataOut: args)	{
			System.out.print(dataOut +" ");
		} System.out.println("");
			
		for (String input: args) {//  I think I need to consider  for ( int x=0; x<=input.length; x++ )
			if ( input.equals("debug") ) {// cuz it gives me much more exact location in the array of str
				System.out.println("debugset");
				mydebug = true;
				if(mydebug)System.out.println("loopCount is: " +loopCount++ +" "+ input);
			}
			
			if (input.contains("x")||input.contains("X")) {
				/* Fixing input: If its a lower x we fix. */
				String adjInput = input.replace('x', 'X');
				if(mydebug)System.out.println("loopCount is: " +loopCount++ +" "+ input);
				parseOrder(adjInput);
				orderSet=true;
			}
		
			if(mydebug)System.out.print("Rows data is: ");
			if (orderSet) { // order is only set after parsing order of MxN
				//allRowsData[allRowsData_index++] = Integer.parseInt(input);
			System.out.print(input);
			}
			System.out.println("");
		
			
			}// end for-each`

			

		}// end else args.length != 0
		 mydebug=false;
		 loopCount = 0;
		 allRowsData_index = 0;
	}// end void main(String[] args )
	
	public static void parseOrder(String order) {
		if(mydebug)System.out.println("OrderLength is: " +order.length());
		
		int first_xLoc=0,last_xLoc=0;
		first_xLoc = order.indexOf('X');
		last_xLoc = order.lastIndexOf('X');
		if(mydebug) System.out.println("First and last X recorded");	
	
		if (first_xLoc != last_xLoc) // if != there was more than one X
			if(mydebug)System.out.println("houston:  We Have An XXXXXXXX Problem");
		
		row_m = Integer.parseInt(( order.substring(0, first_xLoc /* spacer */   )));
		
		if(mydebug)System.out.println("Let See if we have row integer: " +row_m);
		col_n = Integer.parseInt(( order.substring((last_xLoc+1), order.length())));
		
		if(mydebug)System.out.println("Let See if we have col integer: " +col_n);

		orderProduct = row_m * col_n;
		if (mydebug) System.out.println("orderProduct just set at: " +orderProduct);
		
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
		String result ="set";
		if (mydebug)
			return result;
		else result = "unset";
		
		return result;
	}
} // End of class Main


/********************************************************************************
Program Input Definition: What are the argument data types at the command line 

ProgramName: This ClassName
Arg1: String - in form " NXN  where N is Positive Integer , X is "X"   
	: To start this project N < 4 otherwise thigs will just be stupid
	: N and N will be the controlling Row and Column Loop controls
Arg2: String - in form N where N is integer
Arg-: String - in form N where N is integer
Arg-: String - in form N where N is integer
Arg-: String - in form N where N is integer
Arg-


https://www.oreilly.com/library/view/java-cookbook/0596001703/ch03s05.html
// StrCharAt.java
String a = "A quick bronze fox leapt a lazy bovine";
for (int i=0; i < a.length(  ); i++)
    System.out.println("Char " + i + " is " + a.charAt(i));


*/