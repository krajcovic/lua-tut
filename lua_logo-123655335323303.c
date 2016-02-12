/*
 * Roz���en� interpreteru jazyka Lua o p��kazy "left", "right", "forward",
 * "back", "home", "clean", "penup" a "pendown", pomoc� nich� lze kreslit r�zn�
 * obrazce s vyu�it�m �elv� grafiky.
 *
 * Autor: Pavel Ti�novsk�, 2009
 */

#include <stdlib.h>
#include <stdio.h>
#include <memory.h>
#include <math.h>
#include <lauxlib.h>  /* && */
#include <lualib.h>  /* && */

/* Velikost v�sledn� bitmapy */
#define BITMAP_WIDTH 800
#define BITMAP_HEIGHT 800

/* St�ed bitmapy */
#define ORIGIN_X (BITMAP_WIDTH>>1)
#define ORIGIN_Y (BITMAP_HEIGHT>>1)

#define NUMBER_OF_PARAMETERS(cnt) if (lua_gettop(L)!=(cnt)) perror("parameter count differ!");
#define LUA_FUNC static int
#define LUA_OK return 1;
#define DEG2RAD(angle) ((angle)*M_PI/180.0)

/* Struktura popisuj�c� bitmapu */
typedef struct
{
    unsigned int width;
    unsigned int height;
    unsigned char *array;
    unsigned long size;
} Bitmap;

/* Struktura uchov�vaj�c� stav �elvy */
typedef struct
{
    double x;
    double y;
    double angle;
    int pendown;
} Turtle;

Bitmap *bmp = NULL;
Turtle turtle = {0.0, 0.0, 90.0, 0};

/*
 * Vytvo�en� bitmapy s 8bpp (stupn� �edi)
 */
Bitmap * bitmapCreate(unsigned int width, unsigned int height)
{
    Bitmap *bitmap=(Bitmap*)malloc(sizeof(Bitmap));
    bitmap->width=width;
    bitmap->height=height;
    bitmap->size=width*height>>3;
    bitmap->array=(unsigned char*)malloc(bitmap->size*sizeof(unsigned char));
    return bitmap;
}

/*
 * Dealokace pam�ti s bitmapou
 */
void bitmapDestroy(Bitmap *bitmap)
{
    free(bitmap->array);
    free(bitmap);
}

/*
 * Vymaz�n� obsahu bitmapy
 */
void bitmapClear(Bitmap *bitmap)
{
    memset(bitmap->array, 0x00, bitmap->size);
}

/*
 * Vykreslen� jednoho pixelu do bitmapy. V�dy je nastavena �ern� barva na b�l�m
 * pozad�.
 */
void bitmapPutPixel(Bitmap *bitmap, int x, int y)
{
    unsigned char *p;
    unsigned int maska;
    if (!bitmap) return;
    if (x<0 || y<0 || x>=bitmap->width || y>=bitmap->height) return;
    p=bitmap->array+((x+y*bitmap->width)>>3);
    maska=128 >> (x%8);
    *p|=maska;
}

/*
 * Vykreslen� �se�ky Bresenhamov�m algoritmem
 */
void bitmapLine(Bitmap *bitmap, int x1, int y1, int x2, int y2)
{
    int i, deltax, deltay, numpixels;
    int d, dinc1, dinc2, xinc1, xinc2, yinc1, yinc2;

    if (!bitmap) return;

    deltax=abs(x2-x1);
    deltay=abs(y2-y1);
    if (deltax>=deltay)
    { // �hel men�� ne� 45 stup��
        numpixels=deltax;
        d=(deltay<<1)-deltax;
        dinc1=deltay<<1;
        dinc2=(deltay-deltax)<<1;
        xinc1=xinc2=1;
        yinc1=0;
        yinc2=1;
    }
    else
    { // �hel v�t�� ne� 45 stup��
        numpixels=deltay;
        d=(deltax<<1)-deltay;
        dinc1=deltax<<1;
        dinc2=(deltax-deltay)<<1;
        xinc1=0;
        xinc2=1;
        yinc1=yinc2=1;
    }
    if (x1>x2)
    { // oto�en� x-ov�ch sou�adnic
        xinc1=-xinc1;
        xinc2=-xinc2;
    }
    if (y1>y2)
    {  // oto�en� y-ov�ch sou�adnic
        yinc1=-yinc1;
        yinc2=-yinc2;
    }
    for (i=0; i<=numpixels; i++)
    {
        bitmapPutPixel(bitmap, x1, y1);
        if (d<0) {
            d+=dinc1;
            x1+=xinc1;
            y1+=yinc1;
        }
        else {
            d+=dinc2;
            x1+=xinc2;
            y1+=yinc2;
        }
    }
}

/*
 * Ulo�en� bitmapy do souboru typu PBM (Portable BitMap)
 */
void bitmapSave(Bitmap *bitmap, const char *filename)
{
    FILE *fout=fopen(filename, "wb");
    fprintf(fout, "P4\n"\
                  "# Created by Lua\n"
                  "%d %d\n", bitmap->width, bitmap->height);
    fwrite(bitmap->array, bitmap->size, 1, fout);
    fclose(fout);
}

/*
 * Posun �elvy kup�edu
 */
LUA_FUNC forward(lua_State* L)
{
    double x,y;
    NUMBER_OF_PARAMETERS(1);
    x = turtle.x+lua_tonumber(L, 1)*cos(DEG2RAD(turtle.angle));
    y = turtle.y+lua_tonumber(L, 1)*sin(DEG2RAD(turtle.angle));
    if (turtle.pendown)
    {
        bitmapLine(bmp, ORIGIN_X + turtle.x, ORIGIN_Y - turtle.y, ORIGIN_X + x, ORIGIN_Y - y);
    }
    turtle.x = x;
    turtle.y = y;
    LUA_OK
}

/*
 * Posun �elvy dozadu
 */
LUA_FUNC back(lua_State* L)
{
    double x,y;
    NUMBER_OF_PARAMETERS(1);
    x = turtle.x-lua_tonumber(L, 1)*cos(DEG2RAD(turtle.angle));
    y = turtle.y-lua_tonumber(L, 1)*sin(DEG2RAD(turtle.angle));
    if (turtle.pendown)
    {
        bitmapLine(bmp, ORIGIN_X + turtle.x, ORIGIN_Y - turtle.y, ORIGIN_X + x, ORIGIN_Y - y);
    }
    turtle.x = x;
    turtle.y = y;
    LUA_OK
}

/*
 * Oto�en� �elvy doleva
 */
LUA_FUNC left(lua_State* L)
{
    NUMBER_OF_PARAMETERS(1);
    turtle.angle += lua_tonumber(L, 1);
    LUA_OK
}

/*
 * Oto�en� �elvy doprava
 */
LUA_FUNC right(lua_State* L)
{
    NUMBER_OF_PARAMETERS(1);
    turtle.angle -= lua_tonumber(L, 1);
    LUA_OK
}

/*
 * Zvednut� pera
 */
LUA_FUNC penup(lua_State* L)
{
    NUMBER_OF_PARAMETERS(0);
    turtle.pendown = 0;
    LUA_OK
}

/*
 * Spu�t�n� pera
 */
LUA_FUNC pendown(lua_State* L)
{
    NUMBER_OF_PARAMETERS(0);
    turtle.pendown = 1;
    LUA_OK
}

/*
 * N�vrat �elvy k po��tku
 */
LUA_FUNC home(lua_State *L)
{
    NUMBER_OF_PARAMETERS(0);
    turtle.x = 0;
    turtle.y = 0;
    turtle.angle = 90.0;
    LUA_OK
}

/*
 * N�vrat �elvy k po��tku s vymaz�n�m obrazovky
 */
LUA_FUNC clean(lua_State *L)
{
    NUMBER_OF_PARAMETERS(0);
    home(L);
    pendown(L);
    bitmapClear(bmp);
    LUA_OK
}

/*
 * Registrace funkc� pro programy napsan� v Lua
 */
void registerLuaFunctions(lua_State* L)
{
    lua_register(L, "left", left);
    lua_register(L, "right", right);
    lua_register(L, "forward", forward);
    lua_register(L, "back", back);
    lua_register(L, "home", home);
    lua_register(L, "clean", clean);
    lua_register(L, "penup", penup);
    lua_register(L, "pendown", pendown);
}

/*
 * Hlavn� funkce konzolov� aplikace
 */
int main(int argc, char **argv)
{
    int result;
    bmp = bitmapCreate(BITMAP_WIDTH, BITMAP_HEIGHT);
    bitmapClear(bmp);
    lua_State* L = lua_open();  /* && */
    luaopen_base(L);  /* && */
    registerLuaFunctions(L);  /* && */
    result = luaL_dofile(L, argv[1]);
    lua_close(L);  /* && */
    if (result!=0)
    {
        printf("Error # %d\n", result);
    }
    bitmapSave(bmp, "result.pbm");
    bitmapDestroy(bmp);
    return (result != 0);
}

/*
 * finito
 */

