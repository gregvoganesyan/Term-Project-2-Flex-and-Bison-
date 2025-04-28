#ifndef CALCY_H
#define CALCY_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct ASTNode 
{
    char *nodeType;
    char var;
    int num;
    struct ASTNode *left;
    struct ASTNode *right;
} ASTNode;

ASTNode* createNumNode(int num);
ASTNode* createVarNode(char var);
ASTNode* createOpNode(char* op, ASTNode* left, ASTNode* right);
void printAST(ASTNode* node, int level);
void freeAST(ASTNode* node);

int yylex(void);
void yyerror(const char *s);

#endif
