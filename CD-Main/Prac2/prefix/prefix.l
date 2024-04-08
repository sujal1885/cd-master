%{
/* Definition section */
#include <string.h>  // Include the header file for strdup
#include "y.tab.h"  // Include the yacc header file
%}

ALPHA [A-Za-z] 
DIGIT [0-9] 

/* Rule Section */
%% 
{ALPHA}({ALPHA}|{DIGIT})* { yylval.str = strdup(yytext); return ID; } // Store the string in yylval
{DIGIT}+                 { yylval.num = atoi(yytext); return ID; } // Store the number in yylval
[\n \t]                  yyterminate(); 
.                        return yytext[0]; 
%% 
