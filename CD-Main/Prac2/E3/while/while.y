%{ 
#include <stdio.h> 
#include <stdlib.h> 
%} 
%token ID NUM WHILE OR AND %right "=" 
%left OR AND 
%left '>' '<' 
%left '+' '-' 
%left '!' 
%% 
S : ST { 
printf("Valid while statement\n"); exit(0); 
} 
ST : WHILE '('E')' DEF; 
DEF : '{' BODY '}' 
| E';' 
| ST 
| 
; 
BODY : BODY BODY 
| E ';' 
| ST 
| 
;
E : ID '=' E 
| E '<' E 
| E '>' E 
| E '+' E 
| E '-' E 
| ID 
| NUM 
; 
%% 
main() { 
printf("Enter the while statement :"); 
yyparse(); 
} 
int yywrap(void) 
{ 
return 1; 
} 
int yyerror(char *mes) { 
printf("Invalid statement\n"); 
return 0; 
} 
