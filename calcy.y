%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(const char *s);
extern int yylex();

%}

%union {
    int iValue;
    char* sValue;
    nodeType *node;
}

%token <iValue> INTEGER
%token <sIndex> VARIABLE
%token PLUS MINUS MULT DIV POW
%token GE LE EQ
%token WHILE IF ELSE PRINT


