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
    char var; // if representing variable
    int num;  // if representing integer like '5'
    struct ASTNode * left;
    struct ASTNode * right;
}

%}

ASTNode* createNumNode(int num);
ASTNode* createVarNode(char var);

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

%type <node> expr statement

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
        ASTNode* varNode = createVarNode(*$1)
        ASTNode* assignNode = createOpNode("=", varNode, $3);
        /* Print Node */
        printf("Assignment result:\n");
        printAST(assignNode, 0);
        freeAST(assignNode);
    }
    | expr SEMICOLON
    {
        /* print first node this would be statement such as a; */
        printf("Expression result:\n");
        printAST($1, 0);
        freeAST($1);
    }
    | PRINT expr SEMICOLON
    {
        ASTNode* printNode = createOpNode("print", $2, NULL);
        printf("Print Statement:\n");
        printAST(printNode, 0);
        freeAST(printNode);
    }
    | error SEMICOLON
    {
        yerror("Syntax Error");
    }
;

%%

void yyerror(const char *s)
{
fprintf(stderr, "Error: %s\n", s);
}
