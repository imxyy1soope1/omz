#!/bin/bash
# 用于在<tab>行为发生时获取当前的光标位置

exec < /dev/tty
oldstty=$(stty -g)
stty raw -echo min 0
echo -en "\033[6n" > /dev/tty
IFS=';' read -r -d R -a pos
stty $oldstty
row=$((${pos[0]:2} - 1))
col=$((${pos[1]} - 1))
echo "export row=$row" > $ZSH_CACHE_DIR/cursor
echo "export col=$col" >> $ZSH_CACHE_DIR/cursor
