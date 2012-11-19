%{
#include <stfdio.h>
#include "y.tab.h"
%}

int [0-9]*
string [a-zA-Z]

"." pt
";" pt_virg
"!" pt_exl
":" pt_double
":=" affect
"<-" affect_tab
"(" par_g
")" par_d
"{" acc_g
"}" acc_d
"-" moins
"+" plus
"*" fois
"/" div
"<" inf
"<=" inf_eg
">" sup
">=" sup_eg
"=" eg
"<>" equ
"&&" and
"||" or



%%

{int}       {yylval = *yytext - (( *yytext < 'a' ) ? 'A' : 'a'); return integer;}
{string}    {yylval = return ident;}

{pt}                {return pt;}
{pt_virg}           {return pt_virg;}
{pt_exl}            {return pt_exl;}
{pt_double}         {return pt_double;}
{affect}            {return affect;}
{affect_tab}        {return affect_tab;}
{par_g}             {return par_g;}
{par_d}             {return par_d;}
{acc_g}             {return acc_g;}
{acc_d}             {return acc_d;}
{moins}             {return moins;}
{plus}              {return plus;}
{fois}              {return fois;}
{div}               {return div;}
{inf}               {return inf;}
{inf_eg}            {return enf_eg;}
{sup}               {return sup;}
{sup_eg}            {return sup_eg;}
{eg}                {return eg;}
{equ}               {return equ;}
{and}               {return and;}
{or}                {return or;}

"let"               {return let;}
"rec"               {return rec;}
"if"                {return if;}
"then"              {return then;}
"else"              {return else;}
"while"             {return while;}
"begin"             {return begin;}
"end"               {return enf;}
"print_in"          {return print_in;}
"print_string"      {return print_string;}
