#!/bin/bash

function MAIN(){
CORES # carregando a funcao cores
clear # limpando a tela
time=2; # tempo padrao
anwser="y" # resposta padrao
t=0 # contador de tarefas

while [ $anwser != "n" ]
do
    validacao=0
    ((t++))
    echo -e "\nIniciando contagem da acao: ${CVE}$t${CF}"
    for (( i=1; i<=$time; i++ ))
    do 
        echo -e "${CAM}Contagem: $i ${CF}" 
        sleep 1 
    done
    echo -e "${CVE}O tempo acabou! ${CF}"
    read -p "Comecar novamente? y/n " anwser
    while [ $validacao -ne 1 ]
    do
        case $anwser in
        "n")
            echo -e "${CVD}Saindo ${CF}\n"
            validacao=1
            ;;
        "y")
            validacao=1
            ;;
        *) 
            echo -en "${CPU}"
            read -p "Digite apenas y/n! -.-' " anwser
            echo -e "${CF}"
            validacao=0
            ;;
        esac
    done
done
} 

function CORES(){
CVE='\e[0;31m' # Red 
CAM='\e[0;33m' # Yellow 
CVD='\e[0;32m' # Verde
CPU='\e[0;35m' # Roxo
CF='\e[0m'    # Tag end
}

MAIN
exit;