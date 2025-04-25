%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

void yyerror(const char *s);
extern int yylex();

typedef struct ASTNode
{
    char * nodeType;
    char var; // if repreenting variable
    int num;  // if representing integer like '5'
    struct ASTNode * left;
    struct ASTNode * right;
}



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
%token LPAREN RPAREN 


%%

program:
    statements
;

statements:
    statements statement
    | /* empty */
;

statement:
    VARIABLE ASSIGN expr SEMICOLON {
        ASTNode* varNode = /* fill */
        ASTNode* assignNode = /* fill */
        /* Print Node */
    }
    | expr SEMICOLON
    {
        /* print first node this would be statement such as a; */
    }

%%

void yyerror(const char *s)
{
fprintf(stderr, "Error: %s\n", s);
}
