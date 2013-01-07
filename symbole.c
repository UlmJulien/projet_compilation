#include "symbole.h"
#include <string.h>

//initialise la table des symboles
symtab init_symtab(){
    symtab table = malloc (sizeof(struct str_symtab));
    table->current_id = 0;
    return table;
}

//alloue l'espace necessaire et renvoie un nouvel attribut vide
att new_attribute(){
    att temp_att = malloc (sizeof(struct str_attribute));
    return temp_att;
}

void put_attribute(symtab s, att a){
    s->table[s->current_id] = a;
    s->current_id ++;
}

//remplis les informations relatives a l'attribut
void set_attribute (att a, char* n, int t){
    strcpy(a->name, n);
    a->temp_value = t;
}