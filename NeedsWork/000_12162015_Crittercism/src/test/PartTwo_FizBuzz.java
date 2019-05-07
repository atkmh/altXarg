package test;
/*
 * Mark Atkinson
 * atkinson_mark@yahoo.com
 * 707 953 2210
 */
//package test;



public class PartTwo_FizBuzz {

	
	  void fizbuzz(int n){
		if ( (n%3 == 0 ) && (n%5 == 0) )
			System.out.println("FizBuzz");
		else if (n % 5 == 0 )
			System.out.println("Buzz");
		else if (n % 3 == 0)
			System.out.println("Fiz");
		else
			System.out.println(n);
	}
	
	public static void main(String[] args) {
		PartTwo_FizBuzz myFB = new PartTwo_FizBuzz();
		
		for (int x = 1; x<=34 ; x++) {
			//fizbuzz(x);
			myFB.fizbuzz(x);
		
		// TODO Auto-generated method stub
		}

	}

}
