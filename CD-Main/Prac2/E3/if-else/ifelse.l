%{
#include <stdio.h>
#include "y.tab.h"
%}

alpha [A-Za-z]
digit [0-9]

%%

[\t \n]
while return WHILE;
if return IF;
{digit}+ return NUM;
{alpha}({alpha}|{digit})* return ID;
"||" return OR;
"&&" return AND;
. return yytext[0];

%%
