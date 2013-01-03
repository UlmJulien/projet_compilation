%{
#include <stdio.h>
#include "y.tab.h"
%}

%option yylineno

int [0-9]*
string [a-zA-Z]

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
"<" {return inf;}
"<=" {return inf_eg;}
">=" {return sup_eg;}
"=" {return eg;}
"<>" {return eq;}
"&&" {return and;}
"||" {return or;}
"not" {return not;}

"true" {return true;}
"false" {return false;}

{string} return ident;
{int} {yylval = atoi(yytext);return integer;}

"print_int" {return print_int;}

%%