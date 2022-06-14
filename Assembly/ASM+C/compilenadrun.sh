#!/bin/sh

nasm -felf64 factorial.asm
gcc mainfactorial.c factorial.o
./a.out
