%{
#include <stdio.h>
#include "symbole.h"
#include "y.tab.h"

%}

%option yylineno

int [0-9]*
ident [a-zA-Z]+[a-zA-Z0-9]*
compl_string [^"]
string \"{compl_string}*\"
space [ \n\b]

%%

":=" {return affect;}
";" {return pt_virg;}
"!" {return pt_exl;}
"(" {return par_g;}
")" {return par_d;}
"+" {return plus;}
"-" {return moins;}
"*" {return mult;}
"/" {return divi;}
"<" {return inf;}
">" {return sup;}
"<=" {return inf_eg;}
">=" {return sup_eg;}
"=" {return eg;}
"<>" {return eq;}
"&&" {return and;}
"||" {return or;}
"not" {return not;}

"true" {return true;}
"false" {return false;}

"if" {return _if;}
"then" {return _then;}
"else" {return _else;}
"while" {return _while;}
"do" {return _do;}
"done" {return _done;}
"begin" {return _begin;}
"end" {return _end;}

{ident} {
                yylval.lex_string = malloc((yyleng+1)*sizeof(char));
                strncpy(yylval.lex_string,yytext,yyleng);
                yylval.lex_string[yyleng]='\0';
                return ident;
        }

{string}    { 
                yylval.lex_string = malloc((yyleng+1)*sizeof(char));
                strncpy(yylval.lex_string,yytext,yyleng);
                yylval.lex_string[yyleng]='\0';
                return string;
            }

{int} {yylval.lex_val = atoi(yytext);return integer;}

{space} 

"print_int" {return print_int;}

"print_string" {return print_string;}

"read_int" {return read_int;}


%%