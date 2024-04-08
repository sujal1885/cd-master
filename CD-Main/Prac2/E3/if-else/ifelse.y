%{
#include <stdio.h>
#include <stdlib.h>
%}

%token ID NUM WHILE IF ELSE OR AND

%right '='
%left OR
%left AND
%left '>' '<' '+' '-'
%left '!'

%%

S : ST {
    printf("Valid statement\n");
    exit(0);
}

ST : WHILE '(' E ')' DEF
   | IF '(' E ')' DEF ELSE DEF
   | '{' BODY '}'
   | E ';' /* Expression without if-else or while loop */
   | ST /* Nested statements */
   ;

DEF : '{' BODY '}' /* Block of statements */
    | ST /* Single statement */
    ;

BODY : BODY E ';' /* Multiple statements */
     | ST /* Statement */
     ;

E : ID '=' E
  | E '<' E
  | E '>' E
  | E '+' E
  | E '-' E
  | ID
  | NUM
  ;

ELSE : IF '(' E ')' DEF
     | '{' BODY '}'
     ;

%%

int main() {
    printf("Enter the statement: ");
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
