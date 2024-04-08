%{
#include "y.tab.h"
%}

%%
[aA] {return A;}
[bB] {return B;}
[cC] {return C;}
[dD] {return D;}
\n {return NL;}
. {return yytext[0];}
%%

int yywrap(){
    return 1;
}
