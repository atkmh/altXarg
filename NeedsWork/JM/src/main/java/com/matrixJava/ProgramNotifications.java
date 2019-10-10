package main.java.com.matrixJava;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

public class ProgramNotifications {

	public static void openingIntroduction()  throws IOException{
		
		System.out.println("");
		System.out.println("Matrix Manipulation Program: Started");
//		System.out.println("---------------------------");
//		System.out.println("Press Enter and start.\n");
		


//		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));	
//		String catchThisRtrnKey = br.readLine(); // something like 4x7		
	}
	
	
	
	public static void giveShutDownNotice() {
				System.out.println("");
				System.out.println("............");
				System.out.println("Program Done");
	}
	
	public static void TestRunTimeCommands() throws Exception {
		String winCmdFileLocation = "C:\\Temp\\DoNotRemoveFromThisLocation__MyAppLsCmds.txt";
		/* System.out.println(""); */ {
			// pass the path to the file as a parameter
			// File file = new File("testsysoCommands.txt");
			if (System.getProperty("os.name").startsWith("Window")) {
				try {
					Scanner sc = new Scanner(new File(winCmdFileLocation));
					while (sc.hasNextLine())
						System.out.println(sc.nextLine());
					sc.close();
				} catch (FileNotFoundException e) {
					System.out.println("The following Exception was thrown");
					System.out.println(e);
					System.out.println("There was some problem with the file like name or existance");
				} // end of try catch block
			} else {
				Scanner sc = new Scanner(new File("/tmp/testsysoCommands.txt"));
				while (sc.hasNextLine())
					System.out.println(sc.nextLine());
				sc.close();
			}
			System.out.println("");
		}

	}
	
	public static void ClearScreen() throws InterruptedException, IOException {
		ProcessBuilder builder = new ProcessBuilder();
		if (System.getProperty("os.name").startsWith("Window"))
			builder.command("cmd", "/c", "cls").inheritIO().start().waitFor();
		// new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
		// exitCode = Runtime.getRuntime().exec("cls");
		else
			Runtime.getRuntime().exec("clear");
	}
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
