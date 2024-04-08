%{
#include<stdio.h>
%}
digit [0-9]
letter [A-Za-z]
%%
\/\/[^\n]* {}
\/*.*\*\/ {}
[.]* {printf("%s",yytext);};
%%
int main(){
yyin = fopen("input.c","r");
yyout = fopen("out.c","w");
yylex();
return 0;
}
int yywrap(){
return(1);
}