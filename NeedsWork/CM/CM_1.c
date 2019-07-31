#include <stdio.h>
#include <stdlib.h>

struct node {
   int data;
   struct node *prev;
   struct node *next;
}; // *head = NULL, *last = NULL;  // works just the same as two lines below

struct node *head = NULL;
struct node *last = NULL;

struct node *current = NULL;

//Create Linked List
void insert(int data) {
   // Allocate memory for new node;
   struct node *link = (struct node*) malloc(sizeof(struct node));

   link->data = data;
   link->prev = NULL;
   link->next = NULL;

   // If head is empty, create new list
   if(head==NULL) {
      head = link;
      return;
   }

   current = head;
   
   // move to the end of the list
   while(current->next!=NULL)
      current = current->next;

   // Insert link at the end of the list
   current->next = link;
   last = link;
   link->prev = current;
}

//display the list
void printList() {
   struct node *ptr = head;

   printf("\n[head] <=>");

   //start from the beginning
   while(ptr->next != NULL) {        
      printf(" %d <=>",ptr->data);
      ptr = ptr->next;
   }
   
   printf(" %d <=>",ptr->data);
   printf(" [head]\n");
}

int main(int argc, char *argv[]){
	int limit = atoi(argv[1]);
	for (int i=1; i<=limit; i++){
   insert(i);
 //insert(20);
 //insert(30);
// insert(1);
// insert(40);
//  insert(56); 
	}
   printList();
   return 0;
}