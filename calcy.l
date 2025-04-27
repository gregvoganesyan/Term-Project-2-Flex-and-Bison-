%{
#include "calcy.tab.h"
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
%}

[a-zA-z_][a-zA-Z0-9_]*
{
yylval.sValue = strdup(yytext);
return VARIABLE;
}

[0-9]+
{
yylval.iValue = atoi(yytext);
return INTEGER;
}

[\t\r]+ {/* Ignoting whitespace */}

\n {
    printf("End of line"); 
    return 0;
}

"+" return PLUS;
"-" return MINUS;
"*" return MULT;
"/" return DIV; 
"(" return LPAREN;
")" return RPAREN;
"=" return ASSIGN;
";" return SEMI;
">=" return GE;
"<=" return LE;
"==" return EQ; 
"while" return WHILE;
"if" return IF; 
"else" return ELSE; 
"print" return PRINT; 

.  { printf("Unknown character: %s\n", yytext); 
    return ERROR;
}

%%

int yywrap(void)
{
    return 1;
}
