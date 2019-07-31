package main.java.com.matrixJava;

public class Usage {

	public static void Usage() {
		int status = 0;
		System.out.println("Usage: app_name [options] required_input required_input2 ... ");
		System.out.println(" options:");
		System.out.println("   -d, --d, -debug,   --debug: only a concept when entering data at command line");
		System.out.println("   -r, --r, -runtime, --runtime: signals the app we capture data interactively");
		System.out.println("   -f, --f, -file,    --file:  File supplied with required_input data");
		System.out.println("   -h, --h, -help,    --help:  Causes this output");
		System.out.println("   -u, --u, -usage,   --usage: Causes this output");
		System.out.println("  required_input:  Matrix diminsions MxN Rows x Columns");
		System.out.println("  required_input2: List of Matrix values. Space delimiter");
		System.out.println("");

		System.out.println("Example: app_name 2X3 1 4 11 2 5 0 ");
		System.exit(status);

		}
}
