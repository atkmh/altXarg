/*******************
* 
* A program to solve the U2 Puzzle
* 
***************************/

class puzzle {
	public static void main(String args[]) {

	Solution getSolution = new Solution();
		
	//getSolution.InitV();
	//getSolution.cross_record();	
		
 /*
 while (getToTheShow.totalDuration != 17)
 */
		

	}
	
	
}

//  The definition of what I know

/************************************************
* Star:  Get two and crossOver
*        Send one back
*        Get two and cross over
*        Send one back
*        Get two and cross over..  that's the end.
* 
*   A list of moves, the record.
*   this is some kind of sorting.
*
   abcd		xxxx
   xxcd		abxx
   axcd		xbxx
   xxxd		abcx
   xbxd		axcx
   xxxx		abcd

//  Post this thought it is clear that 
//  the solution does not fit into this algorithm.
* Method to pick low member
   from what ever set pick the member with the lowest
   From what ever set I can know cardinality of set
     for iteration purposes.
// Forget this.

// on with permutation.

Best CASE

1) 1,2	over	2
2) 1	back	1
3) 5,10	over	10
4) 2	back	2
5) 1,2  over	2
-------------------
   total		17
   
   
1) pickTwoOfFour(1,2,5,10)			record move   6	{(1 2),(1 5)(1 10)(2 5)(2,10)(5,10)}
2) pickOneOfTwo( step1(picktwo())	record move   2{ a or b}
3) PickTwoOfThree(a,b,c,d)			record move   3{ ab ac bc}
4) PickOneThree?( step3(pickTwo())	record move   2{ x or y}
5) PickTwoOfTwo ()					record move	   1{z z`}
* ___________________________________________________
*                                  Total ways   72 ways



**************************************************************************
Another thought that is a total removal from this angorithm
Object that is a record. Object contains everything about 
the group crossing the bridge.
So, in total there would be 72 object at the end of the program
2 of them would have the solution.


Object definition
Move  there will be 5 of them   3 Dest 2 PreDest
time to complete a move will be determined my max(the members)
sum of all moves

Move knows it is doing Dest or PreDest
and picks accordingly.

SPreDest and SDest // S for set but I think I'll use a vector

Move looks at PreDest to determin who goes over
Move looks at Dest to determine who to send back
Move records in an array of objects containing aMoves
An aMove is a object that is one or two members
An aMove indicates direction, probably to keep it straight in my mind.
Move looks at the previous recorded moves to determine what's been done

* 
***************************************************/