#include "lib.h"

int current_temp = 0;

int new_temp () 
{
    current_temp ++;
    return current_temp%10;
}