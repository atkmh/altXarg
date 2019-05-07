package testAgain;

public class PartTwo_FizBuzz {

	public static void main(String[] args) {
		for (int n=44; n>=1 ; n--) {
			if ( (n%3 == 0 ) && (n%5 == 0) )
				System.out.println("FizBuzz");
			else if (n % 5 == 0 )
				System.out.println("Buzz");
			else if (n % 3 == 0)
				System.out.println("Fiz");
			else
				System.out.println(n);

		}

	}
	
}
