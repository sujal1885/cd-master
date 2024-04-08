%{
#include <stdio.h>
#include <stdlib.h>
%}

%token A B C D NL 

%%
ST : ST1 { printf("Valid String\n"); exit(0);}
   ;

ST1 : A X D D NL 
    | Y		
    ;

X : A X D D 
  | Y
  |
   ;

Y : B Y C 
  | 
  ;

%%

int yyerror(char *msg) {
    printf("Invalid String\n");
    exit(0);
}

int main() {
    printf("Enter the string: \n");
    yyparse();
    return 0;
}
