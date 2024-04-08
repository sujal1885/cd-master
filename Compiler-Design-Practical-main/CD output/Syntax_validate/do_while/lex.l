%{
#include "y.tab.h"
%}

%%
"if" { return IF; }
"else" { return ELSE; }
"(" { return LPAR; }
")" { return RPAR; }
"{" { return LBRACE; }
"}" { return RBRACE; }
";" { return SEMICOLON; }
"&&" { return AND; }
"||" { return OR; }
"<" { return LT; }
">" { return GT; }
[a-zA-Z][a-zA-Z0-9]* { yylval.string = yytext; return IDENTIFIER; }
[ \t\n] { /* ignore whitespace */ }
. { /* ignore other characters */ }

%%

int yywrap() {
    return 1;
}
