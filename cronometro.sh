#!/bin/bash

clear
time=120;
D="y"
c=0
while [ $D = "y" ]
do
    ((c++))
    echo -e "\nIniciando contagem da acao $c"
    #date
    for (( i=1; i<=$time; i++ ))
    do 
        echo $i 
        sleep 1 
    done
    echo "O tempo acabou!"
    #date 
    read -p "comecar novamente? y/n " D
done


