%{
#include <stdio.h>
#include "y.tab.h"
%}

%option yylineno

int [0-9]*
string [a-zA-Z]

%%

":=" return affect;
";" {return pt_virg;}

{string} return ident;
{int} {yylval = atoi(yytext);return integer;}

"print_int" {return print_int;}

%%