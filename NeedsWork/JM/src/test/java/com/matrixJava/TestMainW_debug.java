package test.java.com.matrixJava;
import main.java.com.matrixJava.Main;
public class TestMainW_debug {

		private static boolean thisDebug = false;
		
//		public static void main(String[] args) {
		public  void main(String[] args) {
			printSeperation();
			System.out.println("________________________________________________________________");
			System.out.println("****************************************************************");	
			System.out.print("** ");
			System.out.println("Test Running Class: " +this.getClass().getSimpleName()  ) ;	
			printSeperation();	
			if (args.length!=0)
				if ( args[0] == "debug")  {
					thisDebug = true;
				}
				

			  System.out.println("TestMain:  call Main.main() with String[] {{debug 3x4, 12, 32, 43, 44, 45, 56, 47, 38, 29};");
			  Main.main(new String[] {"debug", "3x4","12", "32", "43", "44","45", "56", "47","38","29"});
			  evalInternals();
			  printSeperation(); 
			 
			  System.out.println("TestMain:  call Main.main() with String[] {debug};");
			  Main.main(new String[] {"debug"}); 
			  if (args.length!=0)evalInternals();
			  if (args.length!=0)printSeperation();

			  System.out.println("TestMain:  call Main.main() with String[] {{debug, 2345XXx2654, 12, 32, 43, 44};");
			  Main.main(new String[] {"debug","2345XXx2654","12", "32", "43", "44"});
			  if (args.length!=0)evalInternals();
			  if (args.length!=0)printSeperation();
			 
			  System.out.println("TestMain:  call Main.main() with String[] {debug, 2x02, 4, 4, 5, 5};");
			  Main.main(new String[] {"debug", "2x02", "4", "4","5", "5"});
			  if (args.length!=0)evalInternals();
			  if (args.length!=0)printSeperation();
			  System.out.println(""); Main.main(new String[] {"2x0", "4", "4","5", "5"});
			 
			//System.out.println(""); Main.main(new String[] {"2b 3", "4", "4","5", "5"});
			 /*  * * 
			 * System.out.println(""); Main.main(new String[] {"2 b 3", "4", "4","5", "5"});
			 */
		}// end  void main(String[] args)
		
		  public static void evalInternals() {
			  System.out.print("get_m: ");
			  System.out.println(Main.get_m());
			  System.out.print("get_n: ");
			  System.out.println(Main.get_n());	
			  System.out.print("get_prod: ");
			  System.out.println(Main.get_prod());
			  System.out.print("get_debug: ");
			  System.out.println(Main.get_debug());
			  System.out.print("get_rawOrder: ");
			  System.out.println(Main.get_order());
		  }
		  public static void printSeperation(){
			 System.out.println("");
			 System.out.println("");
			  
		  }

	}

	
	
