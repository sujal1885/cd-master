%{  
#include <stdio.h>  
#include "y.tab.h"  
%}  
alpha [A-Za-z]  
digit [0-9] 
%%  
[\t \n]  
for return FOR;  
{digit}+ return NUM;  
{alpha}({alpha}|{digit})* return ID;  . return yytext[0];  
%% 
