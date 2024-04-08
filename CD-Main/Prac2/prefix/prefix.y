%{ 
/* Definition section */
#include <stdio.h> 
#include <stdlib.h> 
#include <string.h>
#include "y.tab.h"  // Include the yacc header file
%} 

%token ID 

/* Rule Section */
%% 

S : E 
E : '+' E T   { printf("+"); } E  { A1(); } 
  | '-' E T   { printf("-"); } E  { A1(); }
  | T 
; 
T : '*' T F   { printf("*"); } T  { A1(); } 
  | '/' T F   { printf("/"); } T  { A1(); } 
  | F 
; 
F : '(' E ')' 
  | '-' F     { printf("-"); } F  { A1(); } 
  | ID        { printf("%s", $1); } // Print the string stored in yylval
; 

%% 

#include"y.tab.h" 
char st[100]; 
int top=0; 

// Function declarations
void A1();

//driver code 
int main() 
{ 
    printf("Enter infix arithmetic expression: "); 
    yyparse(); 
    printf("\n"); 
    return 0; 
} 

void A1() 
{ 
    st[top++] = yylval.str[0]; // Access the string stored in yylval
} 
