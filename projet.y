%{

#include <stdio.h>
#include <stdlib.h>
#include "gencode.h"

code my_code;
char temp[64]; // for put_line purposes

extern int yylex();
extern int yylineno;

void yyerror(char *s) 
{
    printf("ligne %d : %s\n", yylineno, s);
    exit(0);
}

%}

%start PROGRAM

%token integer print_int affect ident pt_virg

%%

PROGRAM : INSTR pt_virg pt_virg 
    {
        printf("Rule : Prog -> Intsr ;;\n");
        view_code(my_code);
        write_code(my_code);
    }

INSTR : print_int EXPR 
    {   
        sprintf(temp, "li $v0 1\n li $a0 %d\n syscall", $2);
        put_line(my_code, temp);
    }

EXPR : integer 
    {$$ = $1;}

%%

int main (){

my_code = new_code();
yyparse();
}

