#include "gencode.h"

// genere une nouvelle table pour stocker le code
code new_code (){
    code code_tab = malloc(sizeof(struct str_code));
    code_tab->current_line = 0;
    return code_tab;
}

// insere une ligne dans la table de code
void put_line (code tab, char* line){
    strcpy(tab->tab_code[tab->current_line], line);
    (tab->current_line)++;
}

// affiche le contenu de la table de code
void view_code (code tab){
    int i;
    for(i=0; i<tab->current_line; i++)
    {
        printf("%s\n", tab->tab_code[i]);
    }
}

// ecrit le contenu de la table de code dans le fichier 'rend.txt'
void write_code (code c){
    FILE* file = fopen("rend.txt", "w+");
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

// complete le jump dans le cadre des structures de controle
void complete (code tab, int t1, int t2, int line){
    char temp[64];
    sprintf(temp, "bne 0 $t%d L%d", t2, line);
    
    strcpy(tab->tab_code[t1], temp);
}