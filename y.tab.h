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
     ident = 261,
     pt_virg = 262,
     plus = 263,
     par_g = 264,
     par_d = 265,
     moins = 266,
     mult = 267,
     divi = 268,
     true = 269,
     false = 270,
     inf = 271,
     inf_eg = 272,
     sup = 273,
     sup_eg = 274,
     eg = 275,
     eq = 276,
     not = 277,
     and = 278,
     or = 279,
     string = 280,
     _if = 281,
     _then = 282,
     umoins = 283
   };
#endif
/* Tokens.  */
#define integer 258
#define print_int 259
#define affect 260
#define ident 261
#define pt_virg 262
#define plus 263
#define par_g 264
#define par_d 265
#define moins 266
#define mult 267
#define divi 268
#define true 269
#define false 270
#define inf 271
#define inf_eg 272
#define sup 273
#define sup_eg 274
#define eg 275
#define eq 276
#define not 277
#define and 278
#define or 279
#define string 280
#define _if 281
#define _then 282
#define umoins 283




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


