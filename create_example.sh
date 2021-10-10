#!/bin/bash

mkdir $1

cp 001_header/001_header.asm $1/
mv $1/001_header.asm $1/$1.asm

touch $1/$1.md