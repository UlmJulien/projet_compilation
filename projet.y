%{

#include <stdio.h>
#include <stdlib.h>
#include "gencode.h"
#include "lib.h"
#include "symbole.h"

symtab my_table;
code my_code;
data my_data;
char temp[64]; // for put_line purposes

int expr_type = 0;

extern int yylex();
extern int yylineno;

void yyerror(char *s) 
{
    printf("ligne %d : %s", yylineno, s);
    exit(0);
}

%}

%start PROGRAM

%token integer print_int affect pt_virg plus par_g par_d moins mult divi true false
%token inf inf_eg sup sup_eg eg eq not and or string _if _then _else _while _do _done read_int
%token _begin _end print_string pt_exl
%token<att> ident

%nonassoc umoins

%right eg
%left or
%left and
%left eq
%left inf inf_eg sup sup_eg
%left plus moins 
%left mult divi

%union
{
    struct str_attribute att;
    int lex_val;
    char* lex_string;
}

%type<lex_val> EXPR IDENT J T G M

%%

PROGRAM : INSTR pt_virg pt_virg 
    {
        printf(".data\n");
        view_data(my_data);
        printf(".text\n");
        view_code(my_code);
        printf("_____________________\n");
        view_table(my_table);
        write_code(my_code, my_data);
    }
    ;

INSTR : print_int EXPR 
    {   
        /* affichage d'un entier */
        if(expr_type == 0)
        {
            sprintf(temp, "move $a0 $t%d", $2);
            put_line(my_code, temp);
        }
        else
        {
            sprintf(temp, "move $a0 $s%d", $2);
            put_line(my_code, temp);
            expr_type = 0;
        }

        sprintf(temp, "li $v0 1\nsyscall");
        put_line(my_code, temp);
    }

    | print_string string
    {
        /* affichage d'une chaine de caractere */
        int str_temp = new_data();

        sprintf(temp, "str%d: .asciiz %s", str_temp, yylval.lex_string);
        put_data(my_data, temp);
                
        sprintf(temp, "la $a0 str%d", str_temp);
        put_line(my_code, temp);

        sprintf(temp, "li $v0 4\nsyscall");
        put_line(my_code, temp);
    }

    | _if EXPR T J _then INSTR
    {
        /* structure de controle if then */
        sprintf(temp, "L%d:", my_code->current_line);
        put_line(my_code, temp);

        complete(my_code, $4, $2, $3, (my_code->current_line)-1);
    }

    | _if EXPR T J _then INSTR _else G M INSTR
    {
        /* structure de controle if then else */
        int f_temp = new_flag();
        sprintf(temp, "L%d:", f_temp);
        put_line(my_code, temp);

        complete(my_code, $4, $2, $3, $9);

        complete_jump(my_code, $8, f_temp); 
    }

    | _while M EXPR T J _do SEQUENCE G _done
    {
        /* structure de controle while do done */
        sprintf(temp, "L%d:", my_code->current_line);
        put_line(my_code, temp);

        /* complete du J */
        /* on branche a la fin si EXPR = false */
        complete (my_code, $5, $3, $4, (my_code->current_line)-1);
        
        /* complete du G */
        complete_jump (my_code, $8, $2);
    }

    | _begin SEQUENCE _end
    {
        /* rien */
    }

    | _begin _end
    {
        /* rien */
    }

    | IDENT affect EXPR
    {
        /* generation du code pour l'affectation */
        sprintf(temp, "move $s%d $t%d", $1, $3); /* le registre s garde le registre t contenant l'EXPR */
        put_line(my_code, temp);
    }
    ;

SEQUENCE : INSTR
    {
        /* rien */
    }
    
    | SEQUENCE pt_virg INSTR
    {
        /* rien */
    }
    ;

EXPR : integer 
    {
        $$ = new_temp();
        sprintf(temp, "li $t%d %d", $$, yylval.lex_val);
        put_line(my_code, temp);
    }

    | true
    {
        $$ = new_temp();
        
        /* true */
        sprintf(temp, "li $t%d 1", $$);
        put_line(my_code, temp);
    }

    | false
    {
        $$ = new_temp();
        
        /* false */
        sprintf(temp, "li $t%d 0", $$);
        put_line(my_code, temp);
    }

    | pt_exl IDENT
    {
        $$ = $2; /* on transmet simplement le numero de registre */
        expr_type = 1;
    }

    | EXPR inf EXPR
    {
        $$ = new_temp();
        
        /* inferieur */
        sprintf(temp, "slt $t%d $t%d $t%d", $$, $1, $3);
        put_line(my_code, temp);
    }

    | EXPR inf_eg EXPR
    {
        $$ = new_temp();
        
        /* inferieur ou egal */
        sprintf(temp, "sle $t%d $t%d $t%d", $$, $1, $3);
        put_line(my_code, temp);
    }

    | EXPR sup EXPR
    {
        $$ = new_temp();
        
        /* superieur */
        sprintf(temp, "sgt $t%d $t%d $t%d", $$, $1, $3);
        put_line(my_code, temp);
    }

    | EXPR sup_eg EXPR
    {
        $$ = new_temp();
        
        /* superieur ou egal */
        sprintf(temp, "sge $t%d $t%d $t%d", $$, $1, $3);
        put_line(my_code, temp);
    }

    | EXPR eq EXPR
    {
        $$ = new_temp();
        
        /* equivalent */
        sprintf(temp, "seq $t%d $t%d $t%d", $$, $1, $3);
        put_line(my_code, temp);
    }

    | EXPR and EXPR
    {
        $$ = new_temp();
        
        /* and */
        sprintf(temp, "and $t%d $t%d $t%d", $$, $1, $3);
        put_line(my_code, temp);
    }

    | EXPR or EXPR
    {
        $$ = new_temp();
        
        /* or */
        sprintf(temp, "or $t%d $t%d $t%d", $$, $1, $3);
        put_line(my_code, temp);
    }

    | not EXPR
    {
        $$ = new_temp();
        
        /* not */
        sprintf(temp, "not $t%d $t%d", $$, $2);
        put_line(my_code, temp);
    }

    | EXPR plus EXPR
    {
        $$ = new_temp();

        /* addition */
        sprintf(temp, "add $t%d $t%d $t%d", $$, $1, $3);
        put_line(my_code, temp);
    }

    | EXPR moins EXPR
    {
        $$ = new_temp();

        /* soustraction */
        sprintf(temp, "sub $t%d $t%d $t%d", $$, $1, $3);
        put_line(my_code, temp);
    }

    | EXPR mult EXPR
    {
        $$ = new_temp();

        /* multiplication */
        sprintf(temp, "mul $t%d $t%d $t%d", $$, $1, $3);
        put_line(my_code, temp);
    }

    | EXPR divi EXPR
    {
        $$ = new_temp();

        /* division */
        /* realise une division entiere, sans reste */
        sprintf(temp, "div $t%d $t%d $t%d", $$, $1, $3);
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
        sprintf(temp, "neg $t%d $t%d ", $$, $2);
        put_line(my_code, temp);
    }

    | read_int par_g par_d
    {
        /* lecture d'un entier sur l'entrée standard */
        sprintf(temp, "li $v0 5\nsyscall");
        put_line(my_code, temp);

        /* stockage dans une variable temporaire */
        int temp_val = new_temp();

        sprintf(temp, "move $t%d $v0", temp_val);
        put_line(my_code, temp);

        $$ = temp_val;
        
    }
    ;

IDENT : ident
    {
        if (exist_ident(my_table, yylval.lex_string))
        {
            /* on cherche si l'ident existe deja */
            att att_temp = get_ident(my_table, yylval.lex_string);
            $$ = att_temp->temp_value; /* renvoie le temporaire contenant l'ident */
        }
        else 
        {
            /* sinon, creation de l'identifiant dans la table des symboles */
            int id_temp = new_ident();
            att temp_att = new_attribute();
            set_attribute(temp_att, yylval.lex_string, id_temp);

            put_attribute (my_table, temp_att);

            $$ = id_temp;
        }
    }
    ;

T : 
    {
        /* tag utile pour la comparaison */
        /* stockage du 1 (true) pour la comparaison dans les structures de controle */
        $$ = new_temp();

        sprintf(temp, "li $t%d 1", $$);
        put_line(my_code, temp);
    }
    ;

J :
    {
        /* generation du code pour le jump */
        /* complete dans la structure de controle */

        $$ = my_code->current_line;

        sprintf(temp, "");
        put_line(my_code, temp);
    }
    ;

M :
    {
        $$ = new_flag();
        
        /* creation d'un flag pour un goto */
        sprintf(temp, "L%d:", $$);
        put_line(my_code, temp);
    }
    ;

G : 
    {
        $$ = my_code->current_line;

        /* creation d'un jump */
        sprintf(temp, "");
        put_line(my_code, temp);
    }
    ;


%%

int main (){

my_table = init_symtab();
my_code = new_code();
my_data = new_data_table();

yyparse();

}

