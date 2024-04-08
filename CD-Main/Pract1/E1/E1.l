%{ 
#include <stdio.h> 
%} 

%% 

auto|const|double|float|int|short|struct|unsigned|break|continue|else|for|long|signed|switch|void|case|default|enum|goto|register|sizeof|typedef|volatile|char|do|extern|if|return|static|union|while { 
    printf("Keyword: %s\n", yytext); 
} 

[a-zA-Z_][a-zA-Z0-9_]* { 
    printf("Identifier: %s\n", yytext); 
} 

[0-9]+ { 
    printf("Integer Constant: %s\n", yytext); 
} 

[0-9]*\.[0-9]+ { 
    printf("Float Constant: %s\n", yytext); 
} 

\'(\\.|[^\'])*\' { 
    printf("Character Constant: %s\n", yytext); 
} 

\"(\\.|[^\"])*\" { 
    printf("String: %s\n", yytext); 
} 

[+\-*/%] { 
    printf("Operator: %s\n", yytext); 
} 

[=<>!]=? { 
    printf("Relational Operator: %s\n", yytext); 
} 

[;,\(\)\{\}\[\]] { 
    printf("Special Symbol: %s\n", yytext); 
} 

[ \t\n] ; // Ignore whitespace and newline 

%% 

int main(void) { 
    FILE *input_file = fopen("input.txt", "r"); 
    if (!input_file) { 
        fprintf(stderr, "Error opening input file.\n"); 
        return 1; 
    } 

    // Set the input stream 
    yyin = input_file; 

    // Call the lexer 
    yylex(); 

    // Close the file 
    fclose(input_file); 

    return 0; 
} 

int yywrap() { 
    return 1; 
} 
