%{
#include "y.tab.h"  // Include the generated token definitions
%}

%%

[ \t\n]	;
if 	return IF;
else	return ELSE;
[a-zA-Z][_a-zA-Z0-9]* return ID;
[0-9]+	return NUMBER;
"!"	return NOT;
"&&"	return AND;
"||"	return OR;
">"	return GT;
"<"	return LT;
"=="	return EQ;
"!="	return NE;
">="	return GE;
"<="	return LE;
"+"	return ADD;
"-"	return SUB;
"="	return EQU;
"*"	return MUL;
"/"	return DIV;
";"	return SC;
"{"	return OB;
"}"	return CB;
"("	return OP;
")"	return CP;
"++"	return INCR;
"--"	return DECR;

%%