To Compile and Run Code on the UNT cell machine:

Open the UNT cell machine and compile the flex file by $flex calcy.l
Generate Parser by following: $bison -d calcy.y
Compile the code by the following: $gcc lex.yy.c calcy.tab.c -o calc -lfl
After compiling, run calcy by the following: $./calc
Input expression wanted to be shown in AST format can handle both expressions such as 5+5; and a=5*5;
