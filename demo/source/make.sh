#!/bin/bash

#cc -o demo demo.c -llua5.2 -lm -I/usr/include/lua5.2/
echo "Compiling demo1"
gcc -ansi -Wall -o demo1 demo1.c -llua5.2 -lm -I/usr/include/lua5.2

echo "Compiling demo2"
gcc -ansi -Wall -o demo2 demo2.c -llua5.2 -lm -I/usr/include/lua5.2

echo "Compiling demo3"
gcc -ansi -Wall -o demo3 demo3.c -llua5.2 -lm -I/usr/include/lua5.2

echo "Compiling demo4"
gcc -ansi -Wall -o demo4 demo4.c -llua5.2 -lm -I/usr/include/lua5.2
