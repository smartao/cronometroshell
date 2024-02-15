#!/bin/bash

function MAIN(){

clear # Limpando a tela
. variaveis # Importando arquivo de variaveis
touch $arqtemp # Criando arquivo temporario caso nao existe
CORES # Executando a funcao cores
TEMPO $1 # Executando a funcao tempo

while [ $anwser != "n" ] # Validando resposta do usuario
do
    validacao=0
    t=$(cat $arqtemp) # Pegando valor da tarefa no arquivo temp
    ((t++)) # Incrementando o numero de tarefas
    echo -e "\nIniciando contagem da acao: ${CVE} $t ${CF}"
    echo $t > $arqtemp # Gravando incremento de tarefa no arquivo tempo
    for (( i=1; i<=$time; i++ )) # Contagem regressiva timer
    do 
        echo -e "${CAM}Contagem: $i ${CF}" # Mostrando contagem na tela
        sleep 1 
    done
    echo -e "${CVE}O tempo acabou! ${CF}"
    read -p "Comecar novamente? y/n " anwser
    while [ $validacao -ne 1 ] # Validador da reposta do usuario
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
rm $arqtemp # Deletando arquivo de contagem de tarefas
} 

function CORES(){
CVE='\e[0;31m' # Red 
CAM='\e[0;33m' # Yellow 
CVD='\e[0;32m' # Verde
CPU='\e[0;35m' # Roxo
CF='\e[0m'     # Tag end
}

function TEMPO(){
    time=$1
    if [ -z $time ]; then # validando se existe argumento
        time=4 # tempo padrao
    else # caso exista
        if [[ $time ]] && [ $time -eq $time 2>/dev/null ]; then # validando se é um numero
            echo ok > /dev/null
        else
            echo -e "${CAM}Script aceita apenas numeros como timer, sera usado o tempo padrao: $tpadrao${CF}"
            time=$tpadrao
        fi
    fi
}

MAIN $1