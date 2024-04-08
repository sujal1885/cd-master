%{
#include<stdio.h>
 #include<string.h>
 char date[20];
 char sem[30];
 int questions = 0;
 int words = 0;
 int lines = 0;
 int small_letters = 0;
 int capital_letters = 0;
 int digits = 0;
 int schar = 0;
%}
digit [0-9]
letter [A-Za-z]
%%
[A-Z] {capital_letters++;REJECT}
[a-z] {small_letters++;REJECT}
[0-9] {digits++;REJECT}
\&|\?|\$ {schar++;REJECT}
"\n" {lines++;REJECT}
(([0-2][0-9]|3[0-1])\/(0[1-9]|1[0-2])\/([0-9]){4}) {strcpy(date,yytext);REJECT}
Sem:[0-9] {strcpy(sem,yytext);REJECT}
Question {questions++;REJECT}
(\s*)|(\n) {words++;}
%%
int main(){
yyin = fopen("input.txt","r");
yylex();
 printf("\n-----------------------------");
 printf("\n Date of exam : %s",date);
 printf("\n %s",sem);
 printf("\n Number of questions : %d",questions);
 printf("\n Number of words : %d",words);
 printf("\n Number of lines : %d",lines);
 printf("\n Number of small Letters : %d",small_letters);
 printf("\n Number of capital letters : %d",capital_letters);
 printf("\n Number of digits : %d",digits);
 printf("\n Special Charecters : %d\n",schar);
return 0;
}
int yywrap(){
return(1);
}
