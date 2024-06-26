%{
#include"y.tab.h"
#include<stdio.h>
%}
alpha [A-Za-z]
digit [0-9]
%%
[ \t\n]  
for             return FOR;
{digit}+    return NUM;
{alpha}({alpha}|{digit})* return ID;
"<="         return LE;
">="         return GE;
"=="         return EQ;
"!="          return NE;
"||"            return OR;
"&&"         return AND;
.                return yytext[0];

%%