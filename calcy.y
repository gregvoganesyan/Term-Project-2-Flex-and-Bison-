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
} ASTNode;

%}

ASTNode* createNumNode(int num);
ASTNode* createVarNode(char var);
ASTNode* createOpNode(char* op, ASTNode* left, ASTNode* right);
void printAST(ASTNode *node, int level);
void freeAST(ASTNode *node);

%union {
    int iValue;
    char* sValue;
    ASTNode* node;
}

%token <iValue> INTEGER
%token <sValue> VARIABLE
%token PLUS MINUS MULT DIV POW
%token GE LE EQ ASSIGN SEMICOLON
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

expr:
    expr PLUS expr         { $$ = createOpNode("+", $1, $3); }
    | expr MINUS expr      { $$ = createOpNode("-", $1, $3); }
    | expr MULT expr       { $$ = createOpNode("*", $1, $3); }
    | expr DIV expr        { $$ = createOpNode("/", $1, $3); }
    | expr POW expr        { $$ = createOpNode("^", $1, $3); }
    | expr GE expr         { $$ = createOpNode(">=", $1, $3); }
    | expr LE expr         { $$ = createOpNode("<=", $1, $3); }
    | expr EQ expr         { $$ = createOpNode("==", $1, $3); }
    | LPAREN expr RPAREN   { $$ = $2; }
    | VARIABLE             { $$ = createVarNode(*$1); }
    | INTEGER              { $$ = createNumNode($1); }
;

%%

ASTNode * createNumNode(int num)
{
    ASTNode *node = malloc(sizeof(ASTNode));
    node->nodeType = strdup("NUM");  
    node->num = num;
    node->left = NULL;
    node->right = NULL;
    return node;
}

ASTNode * createVarNode(char var)
{
    ASTNode *node = malloc(sizeof(ASTNode));
    node->nodeType = strdup("VAR");  
    node->var = var;
    node->left = NULL;
    node->right = NULL;
    return node;
}

void printAST(ASTNode * node, int level)
{
    if (node == NULL) return;

    for (int i = 0; i < level; i++) printf("  "); 
    if (strcmp(node->nodeType, "NUM") == 0) {
        printf("%d(int)\n", node->num);
    }
    else if (strcmp(node->nodeType, "VAR") == 0) {
        printf("%c(var)\n", node->var);
    }
    else {
        //  operators and other node types
        printf("%s\n", node->nodeType);
        printAST(node->left, level + 1);
        printAST(node->right, level + 1);
    }
}

void freeAST(ASTNode *node) 
{
    if (node == NULL) return;
    freeAST(node->left);
    freeAST(node->right);
    free(node->nodeType);
    free(node);
}

void yyerror(const char *s)
{
fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
