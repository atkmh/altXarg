#include <stdio.h>                                      

int main()
{
 int pref = 0;
 char *p[] = { "hello", "there", "world"};
 char **q = p;

 printf("\n    p:   %s %s %s! \n\n", *p, p[1], p[2]);

 printf("\n q[n]:   %s %s %s! \n",*q,  q[1], q[2]);


printf("\n q++: %s ",*q); q++;


printf("%s ",*q); q++;


printf("%c",*q);



return 0;
}
