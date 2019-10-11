package main.java.com.matrixJava;

import java.util.ArrayList;

public class StaticProcedures {


	public static void showmap() {
		Matrix tempshowListMx;
		System.out.println("");
		for (int i = 0; i < MyApp.runTimeALOAL.size(); i++) {
			for (int j = 0; j < MyApp.runTimeALOAL.get(i).size(); j++) {
				tempshowListMx = (Matrix) MyApp.runTimeALOAL.get(i).get(j);
				System.out.println(" ----------   ");
				System.out.println("Modification Command\t :" + tempshowListMx.getModCmd());
				System.out.println("Modification TimeStamp\t :" + tempshowListMx.getModTimeStamp());
				System.out.println("Creation Time Stamp\t :" + tempshowListMx.getCreationTimeStamp());
				tempshowListMx.displayCompact();
				System.out.println("\n ----------   ");
			}
		}
	}
	public static void showArrayListIndex() {
		System.out.println("");
		System.out.println("main array size: " + MyApp.runTimeALOAL.size());
		String tempName;
		Matrix tmpMx;
		for (int i = 0; i < MyApp.runTimeALOAL.size(); i++) {
			try {
			ArrayList tmpAL4Read = MyApp.runTimeALOAL.get(i);
			System.out.print("internal size on main #" +i +" is " +tmpAL4Read.size() +": ");
			tempName = ((Matrix) tmpAL4Read.get(0)).getName();// cast to Matrix referrs to get(0)  not .getName
            tmpMx = (Matrix) tmpAL4Read.get(i);
//            System.out.printf("%12s" +" Matrix is ");
			System.out.print("Matrix Name: " +tempName);
			System.out.print(" ");
            System.out.print("Matrix is ");
            System.out.printf("%2d", tmpMx.getRowDimension() );
            System.out.print("X");
            System.out.println(tmpMx.getColumnDimension() );
			}
			catch (Exception e)
			{ System.out.println("what happened at " +e);
			}
			}
		
	}


}
