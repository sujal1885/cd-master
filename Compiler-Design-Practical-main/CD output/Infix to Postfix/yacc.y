%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int answer=0;

char postfix[100];
int pos = 0;

%}
%token NUMBER ID NL
%left '+' '-'
%left '*' '/'



%%
stmt : exp NL { printf("Valid expression & Answer: %d \n",$1); printf("Postfix Expression: %s\n", postfix);
exit(0);}
|
exp1 NL { printf("Valid Expression \nBut, Calculation Can Be Performed On Variables \n"); printf("Postfix Expression: %s\n", postfix);
exit(0);}
;

exp : exp '+' exp   {$$=$1+$3; printf("+");}
| exp '-' exp {$$=$1-$3; printf("-");}
| exp '*' exp {$$=$1*$3; printf("*");}
| exp '/' exp {$$=$1/$3; printf("/");}
| '(' exp ')' {$$=$2;}
| NUMBER {$$=$1;  printf("%d",yylval);}

;

exp1 : exp1 '+' exp1    {printf("+");}
| exp1 '-' exp1		{printf("-");}
| exp1 '*' exp1	        {printf("*");}
| exp1 '/' exp1		{printf("/");}
| '(' exp1 ')'
| ID          {printf("%s",yylval);}
;

%%
int yyerror(char *msg)
{
printf("Invalid Expression \n");
exit(0);
}
main()
{
printf("Enter the expression : \n");
yyparse();
}
int yywrap(){return 1;}
