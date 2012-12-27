%{
#include <stdio.h>
%}
%token pt_virg
%token in
%token let
%token indent
%token ref
%token rec
%token bool
%token int
%token integer
%token Array.make
%token if
%token then
%token else
%token while
%token done
%token begin
%token end
%token print_int
%token print_string
%token string
%token pt_double
%token plus 
%token moins 
%token fois 
%token div 
%token inf 
%token inf_eg 
%token sup 
%token sup_eg 
%token eg 
%token equ
%token and 
%token or 
%token not
%token affect_tab
%start PROGRAM
%%
PROGRAM : DECLLIST INSTR pt_virg pt_virg
DECLLIST :	
		| DECL in DECLLIST

VARDECLLIST :
		| VARDECL in VARDECLLIST

DECL : VARDECL 
		| FUNDECL

VARDECL : let ident pt_double TYPE eg VALCST                             // déclaration d'une constante
        |  let ident pt_double ATOMICITYPE ref eg ref ATOMICCST         // déclaration et initialisation d'une variable

FUNDECL : let FUNDEF
		| let rec FUNDEFS               // groupe de fonctions ou procédures (mutuellement récursives)

FUNDEFS :  FUNDEF 
		| FUNDEF and FUNDEFS

FUNDEF :  ident ARGLIST eq VARDECLLIST INSTR                            // déclaration d'une procédure
        |  ident ARGLIST pt_double ATOMICTYPE eg VARDECLLIST INSTR pt_virg EXPR     // déclaration d'une fonction 
        |  ident ARGLIST pt_double ATOMICTYPE eg VARDECLLIST EXPR             // déclaration d'une fonction pure
        
TYPE :  ATOMICTYPE
		| ATOMICTYPE array

ATOMICTYPE : bool 
	 	| int

VALCST : ATOMICCST 
		| Array.make integer ATOMICCST

ATOMICCST : integer 
		| par_g moins integer par_d 
		| boolean 

ARGLIST : par_g par_d 
		| ARGLIST1

ARGLIST1 : par_g ARG par_d 
		| par_g ARG par_d ARGLIST1

ARG : ident pt_double TYPE 
		|  ident pt_double ATOMICTYPE ref                              

INSTR : if EXPR then INSTR                                  // conditionnelle
		|   if EXPR then INSTR else INSTR                         // alternative
		|   while EXPR do SEQUENCE done                         // itération
		|   begin SEQUENCE end    
		|    begin end                  						// bloc d'instructions
		|     ident affect EXPR                                       // affectation d'une variable
		|   ident pt par_g EXPR par_d affect_tab EXPR                            // affectation d'un élément de tableau
		|   ident EXPRLIST   
		|    ident par_g par_d                         // appel de procédure
		|   print_int EXPR                                      // écriture d'un entier sur la sortie standard
		|   print_string string                                  // écriture d'une chaîne de caractères

SEQUENCE : INSTR 
		| SEQUENCE pt_virg INSTR

EXPR : INTEGER 
		| boolean 
		| par_g EXPR par_d
		| EXPR OPB EXPR 
		| OPU EXPR
        |    if EXPR then EXPR else EXPR                // alternative
        |      ident EXPRlist   
        |     ident par_g par_d               // appel de fonction
        |    read_int par_g par_d                                  // valeur d'un entier lu sur l'entrée standard  
        |      ident                                        // valeur d'une constante
        |       pt_exl ident                                     // valeur d'une variable
        |    ident pt par_g EXPR par_d                            // valeur d'un élément de tableau

EXPRLIST : EXPR 
		| EXPRLIST EXPR

OPB : plus 
		| moins 
		| fois 
		| div 
		| inf 
		| inf_eg 
		| sup 
		| sup_eg 
		| eg 
		| equ
		| and 
		| or

OPU : moins 
		| not


%%
yylex ()
{
}
