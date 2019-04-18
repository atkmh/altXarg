#include <stdio.h>                                      

int main()
{
 int pref = 0;
 char *p[] = { "hello", "there", "world"};
 char **q = p;

 printf("\n    p:   %s %s %s! \n\n", *p, p[1], p[2]);

 printf("\n q[n]:   %s %s %s! \n",*q,  q[1], q[2]);

 printf("\n ++q :   %s %s %s!  \n", ++*q,   ++*q,  ++*q);

 q=p;

 printf("\n q++ :   %s %s %s!  \n", *q++, *q++,*q++);

 printf("\n printch:  %s %s %s  :end ", *p, (*p)++, (*p)++);
 return 0;
}
