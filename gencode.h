#ifndef __GENCODE_H__
#define __GENCODE_H__
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct str_code {
    int current_line;
    char tab_code[1024][64];
}* code;

code new_code ();
void put_line (code tab, char* line);
void view_code (code tab);

void complete (code tab, int t1, int t2, int c, int line);
void complete_jump(code tab, int jump, int label);

#endif

