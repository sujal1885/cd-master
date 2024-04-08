%{
#include<stdio.h>
 #include<string.h>
 int infosys = 0;
 int tcs = 0;
 int wipro = 0;
 int Accenture = 0;
 int informatica = 0;
 int male = 0;
 int female = 0;
 int cse = 0;
 int it = 0;
 int ec = 0;
%}
digit [0-9]
letter [A-Za-z]
%%
(TCS|Infosys|Wipro|Accenture|Informatica) {
 if(strcmp("TCS",yytext) == 0){
 tcs++;
 }else if(strcmp("Infosys",yytext) == 0){
 infosys++;
 }else if(strcmp("Wipro",yytext) == 0){
 wipro++;
 }else if(strcmp("Accenture",yytext) == 0){
 Accenture++;
 }else if(strcmp("Informatica",yytext) == 0){
 informatica++;
 }
}
Female|Male {
 if(strcmp("Female",yytext) == 0){
 female++;
 }
 else if(strcmp("Male",yytext) == 0){
 male++;
 }
}
[0-9]+\.[0-9]+ {
 printf("\nCGPA : %s",yytext);
}
CSE|IT|EC {
 if(strcmp("CSE",yytext) == 0){
 cse++;
 }
 else if(strcmp("IT",yytext) == 0){
 it++;
 }else if(strcmp("EC",yytext) == 0){
 ec++;
 }
}
[A-Za-z]+ {
 printf("\nName of student : %s",yytext);
}
([0-9]+) {
 printf("\nPackage : %s",yytext);
}
([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+) {
 printf("\nEmail id : %s",yytext);
}
(([0-9])+\\{10}) {
 printf("\nMobile : %s",yytext);
}
%%
int main(){
yyin = fopen("input.txt","r");
yylex();
 printf("\n-----------------------------");
 printf("\nNumber of students placed in TCS : %d",tcs);
 printf("\nNumber of students placed in Wipro : %d",wipro);
 printf("\nNumber of students placed in infosys : %d",infosys);
 printf("\nNumber of students placed in Accenture : %d",Accenture);
 printf("\nNumber of students placed in Informatica : %d",informatica);
 printf("\nNumber of Male students : %d",male);
 printf("\nNumber of Female students : %d",female);
 printf("\nNumber of CSE students : %d",cse);
 printf("\nNumber of IT students : %d",it);
 printf("\nNumber of EC students : %d",ec);
return 0;
}
int yywrap(){
return(1);
}
