#include "gencode.h"

code new_code (){
    code code_tab = malloc(sizeof(struct str_code));
    code_tab->current_line = 0;
    return code_tab;
}

void put_line (code tab, char* line){
    strcpy(tab->tab_code[tab->current_line], line);
    (tab->current_line)++;
}

void view_code (code tab){
    int i;
    for(i=0; i<tab->current_line; i++)
    {
        printf("%s\n", tab->tab_code[i]);
    }
}
void write_code (code c){
    FILE* file = fopen("rend.twt", "w+");
    fprintf(file, ".text\n");
    fprintf(file, "main:\n");
    
    int i;
    for(i=0; i<c->current_line; i++)
    {
        fprintf(file, "%s\n", c->tab_code[i]);
    }
    fprintf(file, "j $ra");
    
    fclose(file);
}