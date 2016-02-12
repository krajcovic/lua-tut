#!/bin/bash

cc -o lua_logo lua_logo.c -llua5.2 -lm -I/usr/include/lua5.2/
#gcc -ansi -Wall lua_logo.c -I/usr/include/lua5.2 -llua5.2 -lm
