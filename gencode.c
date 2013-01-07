#include "gencode.h"

// genere une nouvelle table pour stocker le code
code new_code (){
    code code_tab = malloc(sizeof(struct str_code));
    code_tab->current_line = 0;
    return code_tab;
}

//genere une nouvelle table pour stocker les datas
data new_data_table (){
    data data_tab = malloc(sizeof(struct str_data));
    data_tab->current_line = 0;
    return data_tab;
}

// insere une ligne dans la table de code
void put_line (code tab, char* line){
    strcpy(tab->tab_code[tab->current_line], line);
    (tab->current_line)++;
}

// insere une ligne dans la table des datas
void put_data (data tab, char* line){
    strcpy(tab->tab_data[tab->current_line], line);
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

// affiche le contenu de la table des datas
void view_data (data tab){
    int i;
    for(i=0; i<tab->current_line; i++)
    {
        printf("%s\n", tab->tab_data[i]);
    }
}

// ecrit le contenu de la table de code dans le fichier 'rend.txt'
void write_code (code c, data d){
    FILE* file = fopen("rend.txt", "w+");
    fprintf(file, ".data\n");
    
    int j;
    for(j=0; j<d->current_line; j++)
    {
        fprintf(file, "%s\n", d->tab_data[j]);
    }
    
    
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
void complete (code tab, int t1, int t2, int c, int line){
    
    char temp[64];
    sprintf(temp, "bne $t%d $t%d L%d", c, t2, line);
    
    strcpy(tab->tab_code[t1], temp);
}

void complete_jump (code tab, int jump, int label){
    char temp[64];
    sprintf(temp, "j L%d", label);
    
    strcpy(tab->tab_code[jump], temp);    
}