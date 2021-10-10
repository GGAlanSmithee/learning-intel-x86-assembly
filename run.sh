#!/bin/bash

nasm $1/$1.asm -o main.bin
qemu-system-x86_64 -drive format=raw,file=main.bin