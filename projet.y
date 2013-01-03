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

%token integer print_int affect ident pt_virg plus par_g par_d moins mult divi true false
%token inf inf_eg sup sup_eg eg eq not and or

%right eg
%left or
%left and
%left eq
%left inf inf_eg sup sup_eg
%left plus moins 
%left mult divi


%nonassoc umoins

%%

PROGRAM : INSTR pt_virg pt_virg 
    {
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

    | true
    {
        $$ = new_temp();
        
        /* true */
        sprintf(temp, "li $t%d 1\n", $$);
        put_line(my_code, temp);
    }

    | false
    {
        $$ = new_temp();
        
        /* false */
        sprintf(temp, "li $t%d 0\n", $$);
        put_line(my_code, temp);
    }

    | EXPR inf EXPR
    {
        $$ = new_temp();
        
        /* inferieur */
        sprintf(temp, "slt $t%d $t%d $t%d\n", $$, $1, $3);
        put_line(my_code, temp);
    }

    | EXPR inf_eg EXPR
    {
        $$ = new_temp();
        
        /* inferieur ou egal */
        sprintf(temp, "sle $t%d $t%d $t%d\n", $$, $1, $3);
        put_line(my_code, temp);
    }

    | EXPR sup EXPR
    {
        $$ = new_temp();
        
        /* superieur */
        sprintf(temp, "sgt $t%d $t%d $t%d\n", $$, $1, $3);
        put_line(my_code, temp);
    }

    | EXPR sup_eg EXPR
    {
        $$ = new_temp();
        
        /* superieur ou egal */
        sprintf(temp, "sge $t%d $t%d $t%d\n", $$, $1, $3);
        put_line(my_code, temp);
    }

    | EXPR eq EXPR
    {
        $$ = new_temp();
        
        /* equivalent */
        sprintf(temp, "seq $t%d $t%d $t%d\n", $$, $1, $3);
        put_line(my_code, temp);
    }

    | EXPR and EXPR
    {
        $$ = new_temp();
        
        /* and */
        sprintf(temp, "and $t%d $t%d $t%d\n", $$, $1, $3);
        put_line(my_code, temp);
    }

    | EXPR or EXPR
    {
        $$ = new_temp();
        
        /* or */
        sprintf(temp, "or $t%d $t%d $t%d\n", $$, $1, $3);
        put_line(my_code, temp);
    }

    | not EXPR
    {
        $$ = new_temp();
        
        /* not */
        sprintf(temp, "not $t%d $t%d\n", $$, $2);
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

    | EXPR divi EXPR
    {
        $$ = new_temp();

        /* division */
        /* realise une division entiere, sans reste */
        sprintf(temp, "div $t%d $t%d $t%d\n", $$, $1, $3);
        put_line(my_code, temp);
    }

    | par_g EXPR par_d
    {
        $$ = $2;
    }

    | moins EXPR %prec umoins
    {
        $$ = new_temp();

        /* moins unaire */
        sprintf(temp, "neg $t%d $t%d \n", $$, $2);
        put_line(my_code, temp);
    }
    ;


%%

int main (){

my_code = new_code();
yyparse();
}

