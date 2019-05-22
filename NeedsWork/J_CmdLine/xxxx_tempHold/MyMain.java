package theBeginning;

import java.io.Console;
import java.util.Scanner;

public class MyMain {

char charArray[];

	public static void main(String[] args) {
		
		if (args.length > 0)
			System.out.println("commandLine Args Entered");
		System.out.println("args is: "+args);
		System.out.println("Initial presentation:  To be changed");
		
        Scanner in = new Scanner(System.in);
        System.out.print("Please enter number of Matrices : ");
        String howMany = in.nextLine(); //Original call
        in.close(); 
        if (howMany.equals("0")) {
        	System.out.print(howMany);
        	System.out.println(" :entered");
        	System.out.println("Exiting");
        	java.lang.System.exit(0);
        }
        
        //int howMany = Integer.parseInt(in.nextLine());       
        System.out.println("You entered : " + howMany);
	
        
       
        
        
        System.out.println("continueDoing Somthing");
	}// end main()



}// end MyMainClass


// pages I've read from'
//https://www.xyzws.com/Javafaq/how-to-read-input-from-console-keyboard-in-java/195
//https://www.geeksforgeeks.org/system-exit-in-java/
//https://beginnersbook.com/2013/12/java-strings/
//
//
//
//
//
//
//
//
//
//
//
//
//
//