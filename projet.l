%{
#include <stdio.h>
#include "y.tab.h"
%}

%option yylineno

int [0-9]*
ident [a-zA-Z]
compl_string [^"]
string \"{compl_string}*\"
space [ \n\b]

%%

":=" {return affect;}
";" {return pt_virg;}
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

{ident} {return ident;}
{int} {yylval = atoi(yytext);return integer;}
{string}    { 
                return string;
            }
{space} 

"print_int" {return print_int;}



%%