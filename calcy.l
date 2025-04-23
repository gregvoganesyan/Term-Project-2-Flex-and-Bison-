%{
#include "calc.tab.h"
#include <ctype.h>
%}

[a-zA-z]+
{
yyval = yytext[0];
return VARIABLE;
}

[0-9]+
{
yylval.iValue = atoi(yytext)
return INTEGER
}

[\t\r]+ {/* Ignoting whitespace */}

\n {printf("End of line"); return 0;}

"+" return PLUS;
"-" return MINUS;
"*" return MULT;
"/" return DIV; 
"(" return LPAREN;
")" return RPAREN;
"=" return EQ;
";" return SEMI;
">=" return GE;
"<=" return LE;
"==" return EQ; 
"while" return WHILE;
"if" return IF; 
"else" return ELSE; 
"print" return PRINT; 

.  { printf("Unknown character: %s\n", yytext); }

%%

int yywrap(void)
{
    return 1;
}
