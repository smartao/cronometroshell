#!/bin/bash

function MAIN(){
clear # limpando a tela
time=2; # tempo padrao
anwser="y" # resposta padrao

c=0 # contador


while [ $anwser != "n" ]
do
    validacao=0
    ((c++))
    echo -e "\nIniciando contagem da acao $c"
    for (( i=1; i<=$time; i++ ))
    do 
        echo $i 
        sleep 1 
    done
    echo "O tempo acabou!"
    while [ $validacao -ne 1 ]
    do
        read -p "comecar novamente? y/n " anwser
        case $anwser in
        "n") 
            echo "saindo";
            validacao=1;;
        "y") 
            validacao=1;;
        *) 
            echo "digite apenas y/n"
            validacao=0;;
        esac
    done
done
} 

MAIN
exit;
