#include "lib.h"

int current_temp = 0;

int current_flag = 0;


//renvoie un nouveau temporaire
int new_temp () 
{
    current_temp ++;
    return current_temp%10;
}

//renvoie un nouveau flag
int new_flag ()
{
    current_flag ++;
    return current_flag;
}