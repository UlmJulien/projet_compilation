#ifndef __SYMBOLE_H__
#define __SYMBOLE_H__

#include <stdio.h>
#include <stdlib.h>

typedef struct str_attribute {
    int value;
    char name[64]; // on suppose qu'un identifiant ne fera jamais plus de 64 caracteres
    int temp_value;
}*att;

typedef struct str_symtab {
    int current_id;
    att table[64];
}* symtab;

symtab init_symtab(void);
att new_attribute(void);
void put_attribute(symtab, att);
void set_attribute (att a, char* n, int t);


#endif