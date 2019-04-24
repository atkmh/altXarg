/*****************************************************************************
 * ArmStrong number calculation
 * Where 153 is an arm strong number cuz
 * 1^3 + 5^3 + 3^3 === 153
 * 
 *  what I need to do is run this thorugh a loop and find the A numbers 
 * 
 * 
 *
*/

#include <stdio.h>

int main() {
   int arms = 153; 
   int check, rem, sum = 0;

   check = arms;

   while(check != 0) {
      rem = check % 10;// mod 10 gives the remainder
      sum = sum + (rem * rem * rem);
      check = check / 10;
   }

   if(sum == arms) 
      printf("%d is an armstrong number.", arms);
   else 
      printf("%d is not an armstrong number.", arms);
      
   return 0;
}