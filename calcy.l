%{
#include "calcy.tab.h"
#include "calcy.h"
#include <string.h>
%}

%%
[a-zA-Z_]    { yylval.sValue = strdup(yytext); return VARIABLE; }
[0-9]+                    { yylval.iValue = atoi(yytext); return INTEGER; }
[ \t\r]+                  { /* Ignore whitespace */ }
\n                        { return NEWLINE; }

"+"       { return PLUS; }
"-"       { return MINUS; }
"*"       { return MULT; }
"/"       { return DIV; }
"^"       { return POW; }
"("       { return LPAREN; }
")"       { return RPAREN; }
";"       { return SEMICOLON; }
">="      { return GE; }
"<="      { return LE; }
"=="      { return EQ; }
"="       { return ASSIGN; }
"while"   { return WHILE; }
"if"      { return IF; }
"else"    { return ELSE; }
"print"   { return PRINT; }

.         { printf("Unknown char: %s\n", yytext); return 0; }
%%

int yywrap(void) { 
    return 1; 
}
