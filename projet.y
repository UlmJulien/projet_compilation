%{

#include <stdio.h>
#include <stdlib.h>
#include "gencode.h"
#include "lib.h"

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

%token integer print_int affect ident pt_virg plus par_g par_d moins mult

%left plus moins
%left mult

%%

PROGRAM : INSTR pt_virg pt_virg 
    {
        printf("Rule : Prog -> Intsr ;;\n");
        view_code(my_code);
        write_code(my_code);
    }
    ;

INSTR : print_int EXPR 
    {   
        sprintf(temp, "move $a0 $t%d\n", $2);
        put_line(my_code, temp);

        sprintf(temp, "li $v0 1\nsyscall");
        put_line(my_code, temp);
    }
    ;

EXPR : integer 
    {
        $$ = new_temp();
        sprintf(temp, "li $t%d %d\n", $$, yylval);
        put_line(my_code, temp);
    }

    | EXPR plus EXPR
    {
        $$ = new_temp();

        /* addition */
        sprintf(temp, "add $t%d $t%d $t%d\n", $$, $1, $3);
        put_line(my_code, temp);
    }

    | EXPR moins EXPR
    {
        $$ = new_temp();

        /* soustraction */
        sprintf(temp, "sub $t%d $t%d $t%d\n", $$, $1, $3);
        put_line(my_code, temp);
    }

    | EXPR mult EXPR
    {
        $$ = new_temp();

        /* multiplication */
        sprintf(temp, "mul $t%d $t%d $t%d\n", $$, $1, $3);
        put_line(my_code, temp);
    }

    | par_g EXPR par_d
    {
        $$ = $2;
    }
    ;


%%

int main (){

my_code = new_code();
yyparse();
}

