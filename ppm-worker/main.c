/*
 * main.c
 *
 *  Created on: Feb 12, 2016
 *      Author: krajcovic
 */


/*
 * Čtvrtý demonstrační příklad
 *
 * Základní podpora pro práci s bitmapovou grafikou v jazyce Lua.
 *
 * Autor: Pavel Tišnovský, 2009, lze šířit v souladu s GPL
 */

#include <stdlib.h>
#include <stdio.h>
#include <memory.h>
#include <lua5.2/lauxlib.h>
#include <lua5.2/lualib.h>

/* Maximální povolené rozměry bitmapy */
#define MAX_BITMAP_WIDTH 1024
#define MAX_BITMAP_HEIGHT 1024

/* Povolení kontroly rozsahu barvových komponent pixelu */
/*#define CHECK_COLOR_COMPONENTS*/

/* Makro, které na zásobník uloží zprávu o chybě */
#define LUA_ERROR(errorMessage) {lua_pushstring(L, (errorMessage)); lua_error(L);}

/* Makro pro kontrolu počtu parametrů */
#define NUMBER_OF_PARAMETERS(cnt) if (lua_gettop(L)!=(cnt)) LUA_ERROR("incorrect number of parameters")

/* Makro pro kontrolu, zda je parametr specifikovaný indexem, typu číslo */
#define NUMBERP(index) if (!lua_isnumber(L, (index))) LUA_ERROR("type mishmash - number expected")

/* Makro pro kontrolu, zda je parametr specifikovaný indexem, typu řetězec */
#define STRINGP(index) if (!lua_isstring(L, (index))) LUA_ERROR("type mishmash - string expected")

#define CHECK_RANGE(x, min, max, errorMessage) if ((x)<(min) || (x)>(max)) LUA_ERROR(errorMessage)

#define LUA_FUNC static int
//#define LUA_OK return 0;

/* Struktura popisující bitmapu */
typedef struct
{
    unsigned int width;
    unsigned int height;
    unsigned char *array;
    unsigned long size;
} Bitmap;

Bitmap *bmp = NULL;

/*
 * Vytvoření bitmapy s 24bpp (truecolor)
 */
Bitmap * bitmapCreate(unsigned int width, unsigned int height)
{
    Bitmap *bitmap=(Bitmap*)malloc(sizeof(Bitmap));
    if (bitmap == NULL)
    {
        return NULL;
    }
    bitmap->width=width;
    bitmap->height=height;
    bitmap->size=3*width*height;
    bitmap->array=(unsigned char*)malloc(bitmap->size*sizeof(unsigned char));
    if (bitmap->array == NULL)
    {
        free(bitmap);
        return NULL;
    }
    return bitmap;
}

/*
 * Dealokace paměti s bitmapou
 */
void bitmapDestroy(Bitmap *bitmap)
{
    if (!bitmap || !bitmap->array)
    {
        return;
    }
    free(bitmap->array);
    free(bitmap);
}

/*
 * Vymazání obsahu bitmapy
 */
void bitmapClear(Bitmap *bitmap)
{
    if (!bitmap || !bitmap->array)
    {
        return;
    }
    memset(bitmap->array, 0x00, bitmap->size);
}

/*
 * Vykreslení jednoho pixelu do bitmapy. Pixel je zadaný
 * svými souřadnicemi a barvou v barvovém prostoru RGB.
 */
void bitmapPutPixel(Bitmap *bitmap, int x, int y, unsigned char r, unsigned char g, unsigned char b)
{
    unsigned char *p;
    if (!bitmap || !bitmap->array)
    {
        return;
    }
    if (x<0 || y<0 || x>=bitmap->width || y>=bitmap->height)
    {
        return;
    }
    p=bitmap->array+(3*(x+y*bitmap->width));
    *p++=r;
    *p++=g;
    *p=b;
}

/*
 * Uložení bitmapy do souboru typu PPM (Portable PixelMap)
 */
int bitmapSave(Bitmap *bitmap, const char *name)
{
    FILE *fout = fopen(name, "wb");
    if (!bitmap || !bitmap->array)
    {
        return 0;
    }
    if (fout != NULL)
    {
        int result = 1;
        /* Kontrola zápisu hlavičky */
        result &= (fprintf(fout, "P6\n"\
               "# Created by Lua script\n"
               "%d %d\n255\n", bitmap->width, bitmap->height) > 0);
        /* Kontrola zápisu vlastní bitmapy */
        result &= (fwrite(bitmap->array, bitmap->size, 1, fout) == 1);
        /* Kontrola uzavření souboru */
        result &= (fclose(fout) == 0);
        return result;
    }
    return 0;
}

/*
 * Funkce volaná ze skriptu
 */
LUA_FUNC createBitmap(lua_State* L)
{
    int width, height;
    if (bmp)
    {
        LUA_ERROR("bitmap is already created");
    }

    /* Kontrola počtu parametrů */
    NUMBER_OF_PARAMETERS(2);
    /* Kontrola typu parametrů */
    NUMBERP(1);
    NUMBERP(2);
    width = lua_tointeger(L, 1);
    height = lua_tointeger(L, 2);
    /* Kontrola hodnot parametrů */
    CHECK_RANGE(width, 0, MAX_BITMAP_WIDTH, "bitmap width is out of range");
    CHECK_RANGE(height, 0, MAX_BITMAP_HEIGHT, "bitmap height is out of range");
    /* Vše v pořádku - vytvoříme bitmapu */
    bmp = bitmapCreate(width, height);
    if (bmp == NULL)
    {
        LUA_ERROR("bitmapCreate failed");
    }
    return LUA_OK;
}

/*
 * Funkce volaná ze skriptu
 */
LUA_FUNC clearBitmap(lua_State* L)
{
    /* Kontrola počtu parametrů */
    NUMBER_OF_PARAMETERS(0);
    if (bmp == NULL)
    {
        LUA_ERROR("bitmap does not exist");
    }
    bitmapClear(bmp);
    return LUA_OK;
}

/*
 * Funkce volaná ze skriptu
 */
LUA_FUNC saveBitmap(lua_State* L)
{
    if (bmp == NULL)
    {
        LUA_ERROR("bitmap does not exist");
    }
    /* Kontrola počtu parametrů */
    NUMBER_OF_PARAMETERS(1);
    /* Kontrola typu parametrů */
    STRINGP(1);
    if (!bitmapSave(bmp, lua_tostring(L, 1)))
        LUA_ERROR("save bitmap to file failed");
    return LUA_OK;
}

/*
 * Funkce volaná ze skriptu
 */
LUA_FUNC putpixel(lua_State* L)
{
    int i, x, y, r, g, b;
    if (bmp == NULL)
    {
        LUA_ERROR("bitmap does not exist");
    }
    /* Kontrola počtu parametrů */
    NUMBER_OF_PARAMETERS(5);
    /* Kontrola typu parametrů - 5 číselných hodnot */
    for (i=1; i<=5; i++)
    {
        NUMBERP(i);
    }
    /* Kontrola hodnot parametrů */
    x = lua_tointeger(L, 1);
    y = lua_tointeger(L, 2);
    r = lua_tointeger(L, 3);
    g = lua_tointeger(L, 4);
    b = lua_tointeger(L, 5);
    CHECK_RANGE(x, 0, bmp->width-1, "x coordinate is out of range");
    CHECK_RANGE(y, 0, bmp->height-1, "y coordinate is out of range");
#if defined(CHECK_COLOR_COMPONENTS)
    CHECK_RANGE(r, 0, 255, "red color component outside 0-255");
    CHECK_RANGE(g, 0, 255, "green color component outside 0-255");
    CHECK_RANGE(b, 0, 255, "blue color component outside 0-255");
#endif
    bitmapPutPixel(bmp, x, y, (unsigned char)r, (unsigned char)g, (unsigned char)b);
    return LUA_OK;
}

/*
 * Registrace funkcí dostupných pro programy (skripty) napsané v Lua
 */
void registerLuaFunctions(lua_State* L)
{
    lua_register(L, "createBitmap", createBitmap);
    lua_register(L, "clearBitmap", clearBitmap);
    lua_register(L, "saveBitmap", saveBitmap);
    lua_register(L, "putpixel", putpixel);
}

/*
 * Výpis obsahu zásobníku intepreteru
 */
void printLuaStack(lua_State* L)
{
    int i, max;
    max = lua_gettop(L);
    fprintf(stderr, "Stack items:\n");
    for (i = 1; i <= max; i++)
    {
        fprintf(stderr, "%d/%d\t%s\n", i, max, lua_tostring(L, i));
    }
}

/*
 * Hlavní funkce konzolové aplikace
 */
int main(int argc, char **argv)
{
    int result;
    lua_State* L = luaL_newstate();
    luaL_openlibs(L);
    registerLuaFunctions(L);
    result = luaL_dofile(L, argv[1]);
    /* Zpracování chyby */
    if (result != 0)
    {
        fprintf(stderr, "Error # %d\n", result);
    } else {
    	/* the function name */
    	lua_getglobal(L, "save");

    	/* the first argument */
    	lua_pushstring(L, "images/");


    	/* call the function with 1 arguments, return 0 result */
    	lua_call(L, 1, 0);
    }
    printLuaStack(L);
    lua_close(L);
    bitmapDestroy(bmp);
    return (result != 0);
}

/*
 * finito
 */
