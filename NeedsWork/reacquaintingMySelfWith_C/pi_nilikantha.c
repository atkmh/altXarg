#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main( int argc , char *argv[]){
float three=3.0;

   int i, n=1;
   double top =4.0 , a,b,c,resultIs;
   double fracTmp, fracSum, fracL, fracR;

//   int loops = atoi(argv[2]);
//   int skipps= atoi(argv[3]);
   
   int loops = 0;
   int skips= 0; 
   
   printf( "argc is: pi.exe + %d args \n " , argc-1 );
  
  if (argc > 3 ){ printf( "Error: not taking more than 2 args. exiting \n " );  exit (0); }

  if (argc == 2){ printf( "Error: not taking 1 args. exiting \n " );  exit (0); }
   
  if (argc == 1 ){
   printf("  enter value for iterations and a value for loopPrintSkip :");
   scanf("%d %d", &loops, &skips);
  } else {
	  printf("debug:  we are attempting to parse command line input\n");
	  printf("argv-2 :%d \n",atoi(argv[2]) );
	
      loops = atoi(argv[1]);
      skips= atoi(argv[2]);

    printf(" we jump by 4 so this many iterations %d\n", loops/4);
  }

   for( i=2;i<=loops; i+=4){
     // printf("\ti is: %d \n",i)
     a=i;  b=i+1; c=i+2;
     fracL = 4/(a*b*c);
     a=i+2; b=i+3; c=i+4;
     fracR =4/(a*b*c);
     fracTmp= fracL-fracR;
     
     resultIs = resultIs + fracTmp;
   //  printf("i :%d",i);
   //  if ( i%8332 == 0 )
	 if( loops % skips == 0 ) 
      printf("i is: %d \t& \t loops/skips == %d \n", i, (loops/skips));
      
     if (i%skips == 0)
      printf("%12.20f \n", three+resultIs);
   
   
   }
  printf("%d iterations\n,",(i/4));
//printf("%1.20f \n", three+resultIs);

return 0;
}


