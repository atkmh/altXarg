import java.util.*;


class Solution 
{

	int totalDuration;
		
	Vector VStart  = new Vector (5);
	Vector VFinish = new Vector (5);

	Vector vStart  = new Vector(5);
	Vector vFinish = new Vector(5);
	
	Solution() { 	}// constructor currently does nothing.
		// initialize;	
	

	

//
/*************************
* 
* 

1,2,5,10 Pick two (1,10)  2,5    1,10
2,5   1,10  Pick one (10 )  2,5,10  1,
2,5,10 Pick two ( 5,10 )   2     1,5,10
2  1,5,10  Pick one   2,1  5,10
2,1  Pick two (2,1)   ....  1,2,5,10

* 
*  
**************************/

	
	
	//
	/**************************
	* something I prob wont use
	* 
	* 
	* 
	************************************/
	void InitV() {
   		VStart.addElement(new bandMember("Larry", 1));
   		VStart.addElement(new bandMember("Adam",  2));
   		VStart.addElement(new bandMember("Bono",  5));
   		VStart.addElement(new bandMember("Edge", 10));
    }

	  
	//
	/**************************
	* something I prob wont use
	* 
	* 
	* 
	************************************/
	void cross_record() { // run all the solution steps

		
		Random rand = new Random();
		
		
		for(int i=0; i< 5 ; i++) {
			int randint = (int)(5 * rand.nextDouble());
			System.out.println(randint);
		}
			
	}// end cross_record
       
	
	
}// class Solution



