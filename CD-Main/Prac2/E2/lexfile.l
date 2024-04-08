%{ 
#include "y.tab.h"
%} 
/* Rule Section */ 
%% 
a {return A;} 
b {return B;} 
c {return C;} 
d {return D;} 
\n {return NL;} 
. {return yytext[0];} 
%% 
int yywrap() 
{ 
return 1; 
} 
