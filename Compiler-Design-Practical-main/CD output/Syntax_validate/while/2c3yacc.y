%{
#include <stdio.h>
#include <stdlib.h>
%}
%token ID NUM WHILE LE GE EQ NE OR AND
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE
%left '+''-'
%left '*''/'
%right UMINUS
%left '!'
%%
S        : ST1 {printf("Input accepted.\n");exit(0);};
ST1    :    WHILE'(' E2 ')' '{' ST '}'
ST      :     ST ST
          | E';'
          ;
E       : ID'='E
          | E'+'E
          | E'-'E
          | E'*'E
          | E'/'E
          | E'<'E
          | E'>'E
          | E LE E
          | E GE E
          | E EQ E
          | E NE E
          | E OR E
          | E AND E
          | ID
          | NUM
          ;
E2     : E'<'E
          | E'>'E
          | E LE E
          | E GE E
          | E EQ E
          | E NE E
          | E OR E
          | E AND E
          | ID
          | NUM
          ;

%%
int yyerror(char *msg)
{
printf("Invalid Expression\n");
exit(0);
}
int main()
{
printf("Enter the expression:\n");
yyparse();
return 0;
}
int yywrap()
{
return 1;
}