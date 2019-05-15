//https://docs.oracle.com/javase/tutorial/essential/environment/cmdLineArgs.html
//g: java code to parse command line arguments
/*  
 * https://www.google.com/search?q=java+code+to+parse+command+line+arguments&rlz=1C1GCEB_en___US816&oq=java+examples+of+parsing+command+line+input&aqs=chrome.1.69i57j0.12465j0j7&sourceid=chrome&ie=UTF-8&safe=active
 */

package theBeginning;

public class OracleJavaEchoingCmdLnArgs {

	 public static void main (String[] args) {
	        for (String s: args) {
	            System.out.println(s);
	        }
	        
	        int firstArg;
	        if (args.length > 0) {
	            try {
	                firstArg = Integer.parseInt(args[0]);
	            } catch (NumberFormatException e) {
	                System.err.println("Argument" + args[0] + " must be an integer.");
	                System.exit(1);
	            }
	        } 
	        
	        
	    }
	}