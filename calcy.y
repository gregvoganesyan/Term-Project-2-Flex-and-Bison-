%{
#include "calcy.h"
%}

%union {
    int iValue;
    char* sValue;
    struct ASTNode* node;
}

%token <iValue> INTEGER
%token <sValue> VARIABLE
%token PLUS MINUS MULT DIV POW
%token GE LE EQ ASSIGN SEMICOLON
%token WHILE IF ELSE PRINT
%token LPAREN RPAREN

%type <node> expr statement

%left PLUS MINUS
%left MULT DIV
%right POW
%left GE LE EQ

%%

program: statements;

statements: 
    statements statement 
    | /* empty */;

statement:
    VARIABLE ASSIGN expr SEMICOLON {
        ASTNode* varNode = createVarNode(*$1);
        ASTNode* assignNode = createOpNode("=", varNode, $3);
        printf("Assignment result:\n");
        printAST(assignNode, 0);
        freeAST(assignNode);
    }
    | expr SEMICOLON {
        printf("Expression result:\n");
        printAST($1, 0);
        freeAST($1);
    }
    | PRINT expr SEMICOLON {
        ASTNode* printNode = createOpNode("print", $2, NULL);
        printf("Print Statement:\n");
        printAST(printNode, 0);
        freeAST(printNode);
    }
    | error SEMICOLON {
        yyerror("Syntax Error");
        yyerrok;
    };

expr:
    expr PLUS expr { $$ = createOpNode("+", $1, $3); }
    | expr MINUS expr { $$ = createOpNode("-", $1, $3); }
    | expr MULT expr { $$ = createOpNode("*", $1, $3); }
    | expr DIV expr { $$ = createOpNode("/", $1, $3); }
    | expr POW expr { $$ = createOpNode("^", $1, $3); }
    | expr GE expr { $$ = createOpNode(">=", $1, $3); }
    | expr LE expr { $$ = createOpNode("<=", $1, $3); }
    | expr EQ expr { $$ = createOpNode("==", $1, $3); }
    | LPAREN expr RPAREN { $$ = $2; }
    | VARIABLE { $$ = createVarNode(*$1); }
    | INTEGER { $$ = createNumNode($1); };

%%

/* Implementations of AST functions */
ASTNode* createNumNode(int num) {
    ASTNode* node = malloc(sizeof(ASTNode));
    node->nodeType = strdup("NUM");
    node->num = num;
    node->left = node->right = NULL;
    return node;
}

ASTNode* createVarNode(char var) {
    ASTNode* node = malloc(sizeof(ASTNode));
    node->nodeType = strdup("VAR");
    node->var = var;
    node->left = node->right = NULL;
    return node;
}

ASTNode* createOpNode(char* op, ASTNode* left, ASTNode* right) {
    ASTNode* node = malloc(sizeof(ASTNode));
    node->nodeType = strdup(op);
    node->left = left;
    node->right = right;
    return node;
}

void printAST(ASTNode* node, int level) {
    if (!node) return;
    for (int i = 0; i < level; i++) printf("  ");
    if (strcmp(node->nodeType, "NUM") == 0) {
        printf("%d(int)\n", node->num);
    } else if (strcmp(node->nodeType, "VAR") == 0) {
        printf("%c(var)\n", node->var);
    } else {
        printf("%s\n", node->nodeType);
        printAST(node->left, level + 1);
        printAST(node->right, level + 1);
    }
}

void freeAST(ASTNode* node) {
    if (!node) return;
    freeAST(node->left);
    freeAST(node->right);
    free(node->nodeType);
    free(node);
}

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter an expression (make sure it ends with a semicolon): ");
    yyparse();
    return 0;
}
