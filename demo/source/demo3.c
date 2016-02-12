/*
 * Treti demonstracni priklad - zavolani ceckove funkce
 * z Lua skriptu.
 */

#include <stdio.h>
#include <stdlib.h>

/* Zakladni a doplnkove funkce interpretu jazyka Lua */
#include <lua5.2/lualib.h>
#include <lua5.2/lauxlib.h>

#include "demo.h"

/* Vypocet nejvetsiho spolecneho delitele */
static int gcd(lua_State* L)
{
    int x, y, iter = 1;
    /* zjistit pocet parametru pri volani funkce */
    if (lua_gettop(L) != 2)
    {
        lua_pushstring(L, "incorrect argument");
        lua_error(L);
    }

    /* kontrola typu obou parametru */
    if (!lua_isnumber(L, 1))
    {
        lua_pushstring(L, "incorrect first argument");
        lua_error(L);
    }

    if (!lua_isnumber(L, 2))
    {
        lua_pushstring(L, "incorrect second argument");
        lua_error(L);
    }

    /* nacist parametry */
    x = lua_tonumber(L, 1);
    y = lua_tonumber(L, 2);

    /* vypocet nejvetsiho spolecneho delitele */
    while (x % y > 0)
    {
        int pom = y;
        y = x % y;
        x = pom;
        iter ++;
    }

    /* prvni vysledek */
    lua_pushnumber(L, y);

    /* druhy vysledek */
    lua_pushnumber(L, iter);

    /* ulozit pocet vysledku na zasobniku */
    return 2;
}

/* Hlavni funkce konzolove aplikace */
int main_demo3(int argc, char **argv)
{
    int result;
    if (argc != 2)
    {
        puts("Pouziti: lua63 script.lua");
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

    /* registrace ceckove funkce gcd() pod jmenem "gcd" */
    lua_register(L, "gcd", gcd);

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
