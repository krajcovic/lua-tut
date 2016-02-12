/*
 * Druhy demonstracni priklad - spusteni skriptu napsaneho
 * v programovacim jazyce Lua, ktery je ulozeny v externim
 * souboru.
 */

#include <stdio.h>
#include <stdlib.h>

/* Zakladni a doplnkove funkce interpretu jazyka Lua */
#include <lua5.2/lualib.h>
#include <lua5.2/lauxlib.h>

#include "demo.h"

/* Hlavni funkce konzolove aplikace */
int main_demo2(int argc, char **argv)
{
    int result;
    if (argc != 2)
    {
        puts("Pouziti: lua62 script.lua");
        return 1;
    }

    /* vytisteni hlavicky */
    puts(LUA_RELEASE);
    puts(LUA_COPYRIGHT);
    puts(LUA_AUTHORS);
    putchar('\n');

    /* vytvoreni objektu, do nejz se uklada stav interpretu */
    lua_State* L = luaL_newstate();
    /* nacteme zakladni knihovnu obsahujici mj. i funkci print() */
    luaL_openlibs(L);  /* && */
    /* nacteni externiho skriptu, jeho preklad a nasledne spusteni */
    result = luaL_dofile(L, argv[1]);
    /* odstraneni vsech objektu asociovanych se stavem "Lua" */
    lua_close(L);
    if (result != 0)
    {
        printf("Error # %d\n", result);
    }
    /* vypocet navratoveho kodu */
    return (result != 0);
}

/* finito */
