/*
 * Treti demonstracni priklad
 *
 * Pouziti vlastni alokacni funkce, ktera
 * loguje veskere alokace, realokace ci uvolnovani pameti
 * (tyto operace jsou automaticky provadeny interpretem a GC)
 */

#include <stdio.h>
#include <stdlib.h>

/* Zakladni a doplnkove funkce interpretu jazyka Lua */
#include <lua5.2/lualib.h>
#include <lua5.2/lauxlib.h>

#include "demo.h"

/* Skript napsany v programovacim jazyce Lua */
/* Ve skriptu se neustale zvetsuje pamet nutna pro ulozeni */
/* retezce 'x' */
const char * SCRIPT_DEMO_4 =
		"x='hello '\n" \
"for i=0, 10 do\n" \
"    local z='world!'\n" \
"    x=x..z..' '\n" \
"end\n";

/* Vlastni alokacni funkce */
/* ud - uzivatelsky nastaveny ukazatel (vzdy konstantni) */
/* ptr - ukazatel na pamet, ktera se ma alokovat ci dealokovat */
/* osize - puvodni delka bloku */
/* nsize - nova (pozadovana) delka bloku */
static void *memory_allocator(void *ud, void *ptr, size_t osize, size_t nsize) {
	printf("memory_allocator (ud=%p): ", ud);
	/* pokud je nsize == 0, znamena to, ze se ma pamet uvolnit */
	if (nsize == 0) {
		printf("uvolnuji %d bajtu pameti na adrese %p\n", osize, ptr);
		/* Muze nastat free(NULL), pokud osize==0, to je vsak v ANSI C korektni */
		free(ptr);
		return NULL;
	} else {
		if (ptr == NULL) {
			printf("alokuji %d bajtu pameti\n", nsize);
		} else {
			printf("realokuji %d bajtu pameti na adrese %p na delku %d\n",
					osize, ptr, nsize);
		}
		/* pokud ptr==NULL, provede se malloc() */
		return realloc(ptr, nsize);
	}
}

/* Hlavni funkce konzolove aplikace */
int main_demo4(void) {
	int result;

	/* vytisteni hlavicky */
	puts(LUA_RELEASE);
	puts(LUA_COPYRIGHT);
	puts(LUA_AUTHORS);
	putchar('\n');

	/* vytvoreni objektu, do nejz se uklada stav interpretu */
	lua_State* L = lua_newstate(memory_allocator, (void*) 0x1234);
	luaL_openlibs(L);
	/* nacteni retezce interpretem, jeho preklad a nasledne spusteni */
	result = luaL_dostring(L, SCRIPT_DEMO_4);
	/* odstraneni vsech objektu asociovanych se stavem "Lua" */
	lua_close(L);
	if (result != 0) {
		printf("Error # %d\n", result);
	}
	/* vypocet navratoveho kodu */
	return (result != 0);
}

/* finito */
