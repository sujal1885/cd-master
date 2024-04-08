%{ 
/* Definition section */ 
#include<stdio.h> 
#include<stdlib.h> 
%} 
%token A B C D NL 
/* Rule Section */ 
%% 
statement: a b c NL { printf("valid string\n"); exit(0); } 
; 
a: A a 
| 
; 
b: B b C 
| 
; 
c: D D c 
| 
; 
%%
int yyerror(char *msg) 
{ 
printf("invalid string\n"); 
exit(0); 
} 
main() 
{ 
printf("enter the string\n"); 
yyparse(); 
} 











