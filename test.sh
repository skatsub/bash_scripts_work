#!/bin/bash

file="/tmp/test.txt"
IFS=$'\n'

rm -r /tmp/list

echo "!======================= permission check $node =======================!"

for a in $(cat $file)
do
timeout 1 bash -c "echo -e '\x1dclose\x0d' | telnet $a > /dev/null 2>/dev/null"
c=$?; 

        if [ "$c" = "0" ]; then
                echo -e "\e[1;32m $node $a connected\e[0m"
        else
                h=$c
		echo -e "\e[1;31m $node $a connected permission\e[0m" >> /tmp/list
fi
done

FILE=/tmp/list

if [ -f "$FILE" ]; then
		cat /tmp/list
		exit 1
fi

rm -r /tmp/list

#Скрипт для проверки доступов
