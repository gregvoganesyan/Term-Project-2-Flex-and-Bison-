%{
#include "calcy.tab.h"
#include "calcy.h"
#include <string.h>
%}

%%

[a-z] {
    yylval.sValue = strdup(yytext);
    return VARIABLE;
}

[0-9]+ {
    yylval.iValue = atoi(yytext);
    return INTEGER;
}

[\t\r ]+   { /* Ignoring whitespace */ }

\n {
        printf("End of line\n");
        return 0;
}

"+" { return PLUS; }
"-" { return MINUS; }
"*" { return MULT; }
"/" { return DIV; }
"(" { return LPAREN; }
")" { return RPAREN; }
";" { return SEMICOLON; }
">=" { return GE; }
"<=" { return LE; }
"==" { return EQ; }
"=" { return ASSIGN; }
"while" { return WHILE; }
"if" { return IF; }
"else" { return ELSE; }
"print" { return PRINT; }

. {
    printf("Unknown character: %s\n", yytext);
    return 0;
}

%%

int yywrap(void) {
    return 1;
