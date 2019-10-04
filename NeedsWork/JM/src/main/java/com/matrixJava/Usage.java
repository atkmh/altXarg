package main.java.com.matrixJava;

public class Usage {

	public static void UsageTerminal(String context	) {
		System.out.println(context);
		int status = 0;
		System.out.println("Usage: app_name [options] required_input required_input2 ... ");
		System.out.println(" options:");
		System.out.println("What about NO input to me identifying runtime data entry ???               ");
		System.out.println("   -c, --c, -cmdln,   --cmdln: parse all input variables from commadn line");
		System.out.println("   -d, --d, -debug,   --debug: only a concept when entering data at command line");
		System.out.println("   -r, --r, -runtime, --runtime: signals the app we capture data interactively");
		System.out.println("   -f, --f, -file,    --file:  File supplied with required_input data");
		System.out.println("   -h, --h, -help,    --help:  Causes this output");
		System.out.println("   -u, --u, -usage,   --usage: Causes this output");
		System.out.println("  required_input:  Matrix diminsions MxN Rows x Columns");
		System.out.println("  required_input2: List of Matrix values. Space delimiter");
		System.out.println("");

		System.out.println("Example: app_name 2X3 1 4 11 2 5 0 ");
		

		
		ProgramNotifications.giveShutDownNotice();
		
		System.exit(status);
		
	}
	
    public static void UsageRecoverable(String context)	{
    	System.out.println(context);
    System.out.println(" Hey.  you did something wrong:  Lets' try again if we can"); 
    return;
    }
	
}
