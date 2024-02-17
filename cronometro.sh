#!/bin/bash

function MAIN(){

# Diretorio de variaveis
# Necessario alterar conforme necessidade
DIR=/home/sergei/Midias/Dev/Shell/cronometroshell

clear
. ${DIR}/variaveis # Importando arquivo de variaveis
touch $arqtemp # Criando arquivo temporario caso nao existe

CORES # Executando a funcao cores
VALIDATEMPO $1 # Executando a funcao valida tempo

while [ $anwser != "n" ] # Validando resposta do usuario
do
    validacao=0 # setando valor em 0 
    t=$(cat $arqtemp) # Pegando valor da tarefa no arquivo temp
    ((t++)) # Incrementando o numero de tarefas

    if [ $funny -eq 1 ]; then # Verificando se o funny esta ativo 
        cowsay "Iniciando contagem da acao: $t" | $lolcat
    else
        echo -e "\nIniciando contagem da acao: ${CVE}$t${CF}"
    fi
    echo $t > $arqtemp # Gravando incremento de tarefa no arquivo tempo
    for (( i=1; i<=$time; i++ )) # Contagem regressiva timer
    do 
        echo -e "${CAM}Contagem: $i ${CF}" # Mostrando contagem na tela
        sleep 1 
    done
    paplay $audio # tocando audio quando terminar a tarefa
    if [ $funny -eq 1 ]; then # Verificando se o funny esta ativo 
        cowsay "O tempo acabou! começar novamente? y/n "| $lolcat
        read anwser
    else
        echo -e "${CVE}O tempo acabou! ${CF}"
        read -p "Comecar novamente? y/n " anwser
    fi
    while [ $validacao -ne 1 ] # Validador da reposta do usuario
    do
        case $anwser in
        "n")
            if [ $funny -eq 1 ]; then 
                cowsay "By =)"| lolcat
            else
                echo -e "${CVD}Saindo${CF}\n"
            fi
            validacao=1
            ;;
        "y")
            validacao=1
            ;;
        *) 
            validacao=0 # Desativa o validador
            if [ $funny -eq 1 ]; then
                ((e++)) # Contador de erros
                if [ $e -gt 3 ]; then # caso o numero de erros seja maior que 3 vezes
                    cowsay -f dragon Dracarys! Digite apenas y/n! | $lolcatdragon
                    if [ $e -gt 5 ]; then # caso erre mais que 5 vezes
                        cowsay -d Desisto... | $lolcat
                        exit;
                    fi
                    read anwser 
                else
                    cowsay -t Digite apenas y/n! | $lolcat
                    read anwser 
               fi
            else
                echo -en "${CAM}"
                read -p "Digite apenas y/n! -.-' " anwser 
                echo -e "${CF}"
            fi
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

function VALIDATEMPO(){
    time=$1
    if [ -z $time ]; then # validando se existe argumento
        time=$tpadrao # caso nao exista setar tempo padrao
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