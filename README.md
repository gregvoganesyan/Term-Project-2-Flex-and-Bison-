To Compile and Run Code on the UNT cell machine:

1. Open the UNT cell machine and compile the flex file by $flex calcy.l
2. Generate Parser by following: $bison -d calcy.y
3. Compile the code by the following: $gcc lex.yy.c calcy.tab.c -o calc -lfl
4. After compiling, run calcy by the following: $./calc
5. The expression wished to be shown in the AST format must be typed in the terminal
6. Expected AST output will be shown in terminal after expression is typed and entered
7. Input expression wanted to be shown in AST format can handle both expressions such as 5+5 and a=5*5   
