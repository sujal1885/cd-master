%{  
#include <stdio.h>  
#include <stdlib.h>  
%}  
%token ID NUM FOR  
%%  
  
S : ST {  
 printf("Valid for statement\n");   exit(0);  
}  
ST : FOR '(' E ';' E ';' E ')' DEF;  
DEF : '{' BODY '}'  
 | E';'  
 | ST  
 ;  
BODY : BODY BODY  
 | E ';'  
 | ST  
 ;  
E : ID '=' E  
 | E '<' E  
 | E '>' E  
 | E '+' E  
 | E '-' E  
 | ID  
 | NUM  
 | ID '+' '+'  
 | ID '-' '-' 
 ;  
%%  
int main() {  
 printf("Enter the for statement: ");  
 yyparse();  
 return 0;  
}  
int yywrap(void) {  
 return 1;  
}  
int yyerror(char *mes) {  
 printf("Invalid statement\n");  
 return 0;  
}  
