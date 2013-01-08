/* A Bison parser, made by GNU Bison 2.5.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2011 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     integer = 258,
     print_int = 259,
     affect = 260,
     pt_virg = 261,
     plus = 262,
     par_g = 263,
     par_d = 264,
     moins = 265,
     mult = 266,
     divi = 267,
     true = 268,
     false = 269,
     inf = 270,
     inf_eg = 271,
     sup = 272,
     sup_eg = 273,
     eg = 274,
     eq = 275,
     not = 276,
     and = 277,
     or = 278,
     string = 279,
     _if = 280,
     _then = 281,
     _else = 282,
     _while = 283,
     _do = 284,
     _done = 285,
     read_int = 286,
     _begin = 287,
     _end = 288,
     print_string = 289,
     pt_exl = 290,
     ident = 291,
     umoins = 292
   };
#endif
/* Tokens.  */
#define integer 258
#define print_int 259
#define affect 260
#define pt_virg 261
#define plus 262
#define par_g 263
#define par_d 264
#define moins 265
#define mult 266
#define divi 267
#define true 268
#define false 269
#define inf 270
#define inf_eg 271
#define sup 272
#define sup_eg 273
#define eg 274
#define eq 275
#define not 276
#define and 277
#define or 278
#define string 279
#define _if 280
#define _then 281
#define _else 282
#define _while 283
#define _do 284
#define _done 285
#define read_int 286
#define _begin 287
#define _end 288
#define print_string 289
#define pt_exl 290
#define ident 291
#define umoins 292




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 2068 of yacc.c  */
#line 45 "projet.y"

    struct str_attribute att;
    int lex_val;
    char* lex_string;



/* Line 2068 of yacc.c  */
#line 132 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


