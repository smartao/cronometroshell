#!/bin/bash

function MAIN(){
# Diretorio de variaveis
# Necessario alterar conforme necessidade
DIR=/home/sergei/Midias/Dev/Shell/cronometroshell

clear # Limpando a tela
. ${DIR}/variaveis # Importando arquivo de variaveis

if [ $fun -eq 1 ]; then 
    APLICACORES # Executando a funcao cores
fi
VALIDATEMPO $1 # Executando a funcao valida tempo

while [ $anwser != "n" ] # Validando resposta do usuario
do
    # Tela inicial do script
    validacao=0 # definindo valor em 0 
    ((t++)) # Incrementando o número de tarefas
    if [ $fun -eq 2 ]; then # Verificando se o fun esta ativo 
        cowsay "Iniciando contagem da acao: $t" | $lolcat
    else
        echo -e "\nIniciando contagem da acao: ${CVE}$t${CF}"
    fi
    # Contagem regressiva da tela
    for (( i=1; i<=$time; i++ ))
    do 
        ((seed++)) # Incementando valor do seed para alterar a cor
        if [ $fun -eq 2 ]; then 
            echo "Contagem: $i" | lolcat --seed $seed --spread 100
        else
            echo -e "${CAM}Contagem: $i ${CF}" # Mostrando contagem na tela
        fi
        read -n1 -t 1 TECLA # Lendo a tecla e aguardando 1 segundo
        case "$TECLA" in
        n) # Caso seja n (next) va para proxima acao
            ttemp=$time; # Armazendo tempo
            time=0  # Zerando o time para sair do cronometro
            if [ $fun -eq 2 ]; then
                cowsay "Iniciando proxima contagem"| $lolcat
            else
                echo -e "${CVD}\nIniciando proxima contagem ${CF}"
            fi
        ;;
        e) # caso seja e (exit) saia do programa
            SAIDA 
        ;;
        esac
    done
    TOCAAUDIO # Funcao para tocar audio
    # Validando se foi precionado a teclado no meio da contagem
    if [ -n "$TECLA" ] && [ $TECLA = "n" ]; then # caso sim e seja a tecla n
        anwser=y # adicionando a reposta padrao
        seed=22 # Restaurando o valor da seed
        time=$ttemp # Restaurando o valor do timer
        sleep $delay # Delay para reiniciar a contagem
    else # Caso nao, imprimir que o tempo acabou
        if [ $fun -eq 2 ]; then
            cowsay "O tempo acabou! começar novamente? y/n "| $lolcat
            read anwser
        else
            echo -e "${CVE}O tempo acabou! ${CF}"
            read -p "Comecar novamente? y/n " anwser
        fi
    fi
    # Validador da reposta do usuario
    while [ $validacao -ne 1 ]
    do
        case $anwser in
        "n")
            SAIDA
            validacao=1
            ;;
        "y")
            validacao=1
            ;;
        *) 
            validacao=0 # Desativa o validador
            if [ $fun -eq 2 ]; then
                ((e++)) # Contador de erros
                if [ $e -gt 3 ]; then # caso o numero de erros seja maior que 3 vezes
                    cowsay -f dragon Dracarys! Digite apenas y/n! | $lolcatdragon
                    if [ $e -gt 5 ]; then # caso erre mais que 5 vezes
                        cowsay -d Desisto... | $lolcat
                        exit 0;
                    fi
                    read anwser 
                else
                    cowsay -t "Digite apenas y/n!" | $lolcat
                    read anwser 
               fi
            else
                echo -en "${CAM}"
                read -p "Digite apenas y/n!" anwser 
                echo -e "${CF}"
            fi
            ;;
        esac
    done
done
} 

function APLICACORES(){
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

function TOCAAUDIO(){
    paplay $audio 
}

function SAIDA(){
    if [ $fun -eq 2 ]; then 
        cowsay "Total de acoes:${t} By =) "| lolcat
    else
        echo -e "${CVD}\nTotal de acoes:$t Saindo${CF}\n"
    fi
    exit 0;
}

MAIN $1