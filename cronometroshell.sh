#!/bin/bash

function MAIN(){
clear # Limpando a tela

. $(dirname "$0")/variaveis # Carregando arquvio de variaveis

APLICACORES # Executando a funcao cores
VALIDABINARIOS # Validando se os binarios necessários existem
VALIDAARGUMENTOS $1 $2 $3 # Executando a funcao de validar argumentos

anwser="y" # Resposta para iniciar o script
modoscript="temporizador"
falha=0 # Definindo qtd de tarefas nao executadas dentro do prazo
# Executa enquanto a resposta do usuário foi n (nao)
while [ $anwser != "n" ] # Validando resposta do usuario
do
    # Tela inicial do script
    validacao=0 # definindo valor em 0 
    ((t++)) # Incrementando o número de tarefas
    fraseinicontagem="Iniciando contagem da acao: $t"
    if [ $fun -eq 1 ]; then # Verificando se o fun esta ativo 
        cowsay "${fraseinicontagem}" | $lolcat
    else
        echo -e "\n${fraseinicontagem}"
    fi
    # Contagem regressiva da tela
    for (( i=1, c=0; i<=$time; i++, c++ ))
    do 
        ((seed++)) # Incementando valor do seed para alterar a cor
        if [ $fun -eq 1 ]; then 
            echo "Contagem: $i" | lolcat --seed $seed --spread 100
        else
            echo -e "${CAM}Contagem: $i ${CF}" # Mostrando contagem na tela
        fi
        read -s -n1 -t 1 tecla # Lendo a tecla e aguardando 1 segundo
        case "$tecla" in
        n) # Caso seja n (next) va para proxima acao
            ttemp=$time; # Armazendo tempo
            time=0  # Zerando o time para sair do cronometro
            SOMATEMPO
        ;;
        p)  
            frasepausa="Pausando o cronometro, precione qualquer tecla para continuar"            
            if [ $fun -eq 1 ]; then
                cowsay "${frasepausa}"| $lolcat
            else
                echo -e "${frasepausa}"
            fi
            read -s -n1 # Aguardando precionar para seguir com a contagem
        ;;
        e) # caso seja e (exit) saia do programa
            SOMATEMPO
            SAIDA 
        ;;
        esac
    done
    TOCAAUDIO # Funcao para tocar audio
    # Validando se foi precionado a teclado no meio da contagem
    if [ -n "$tecla" ] && [ $tecla = "n" ]; then # caso sim e seja a tecla n
        anwser=y # adicionando a reposta para sair do script
        seed=22 # Restaurando o valor da seed
        time=$ttemp # Restaurando o valor do timer
        sleep $delay # Delay para reiniciar a contagem
    else # Caso nao, imprimir que o tempo acabou
        SOMATEMPO
        ((falha++)) # Incrementando a qtd de tarefas fora do prazo
        frasetempocabou="O tempo acabou! começar novamente? y/n"
        if [ $fun -eq 1 ]; then
            cowsay "${frasetempocabou}"| $lolcat
        else
            echo -e "${frasetempocabou}"
        fi
        read anwser
    fi
    # Validando a reposta do usuario se deseja continuar ou nao
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
            validacao=0 # Desativa a validacao
            fraseerrodigitacaoyn="Digite apenas y/n!"
            if [ $fun -eq 1 ]; then
                ((e++)) # Contador de erros
                if [ $e -gt 3 ]; then # caso o numero de erros seja maior que 3 vezes
                    cowsay -f dragon Dracarys! ${fraseerrodigitacaoyn} | $lolcatdragon
                    if [ $e -gt 5 ]; then # caso erre mais que 5 vezes
                        cowsay -d Desisto... | $lolcat
                        exit 0;
                    fi
                    read anwser 
                else
                    cowsay -t "${fraseerrodigitacaoyn}" | $lolcat
                    read anwser 
               fi
            else
                echo "${fraseerrodigitacaoyn}"
                read anwser 
            fi
            ;;
        esac
    done
done
} 

function VALIDABINARIOS(){
    arquivos=("$audio" "$bicow" "$bilol" "$biapl")
    for arquivo in "${arquivos[@]}"; do
        # Verifica se o arquivo não existe
        if [ ! -f "$arquivo" ]; then
            echo -e "
            O arquivo ${CVE}'$arquivo'${CF} necessário para o não existe
            Configure o caminho usando o arquivo de variaveis
            Caso não exista no sistema é necessário insta-lo"
            exit 0;
        fi
    done
}

function APLICACORES(){
CVE='\e[0;31m' # Red ${CVE}
CAM='\e[0;33m' # Yellow ${CAM}
CVD='\e[0;32m' # Verde ${CVD}
CPU='\e[0;35m' # Roxo ${CPU}
CF='\e[0m'     # Tag end ${CF}
}

function HELP(){
    __help="
Use: $(basename $0) [OPCAO1] [OPCAO2]

    OPCAO1:                 Pode ser omitida para executar o tempo padrao de 120s
    -s <n>                  Defini o tempo em segundos
    -m <n>                  Defini o tempo em minutos
    -h, --help              Mostra essa página

    OPCAO2:
    -c                      Modo cronometro, depende ter o primeiro argumento do tempo
    
    EXEMPLOS: 
    ./$(basename $0)
    ./$(basename $0) -s 20
    ./$(basename $0) -m 10
    ./$(basename $0) -m 5 -c
    "  
    echo -e "$__help"
}

function VALIDAARGUMENTOS(){
    arg1=$1
    arg2=$2
    arg3=$3
    #echo $arg1 $arg2 $arg3
    if [ -z $arg1 ]; then # validando se existe o primeiro argumento
        time=$tpadrao # caso nao exista setar tempo padrao
    else
        case $arg1 in
        -s|-m)
            if [[ $arg2 ]] && [ $arg2 -eq $arg2 2>/dev/null ]; then # validando se é um numero
                time=$arg2 # Definindo o valor de time
                if ! [ -z $arg3 ]; then
                    modoscript="cronometro"
                exit
                fi
            else
                APLICACORES
                echo -e "${CVE}Parametro ${arg2} nao aceito!${CF}"
                HELP
                exit
            fi
        ;;
        -h|--help)
            HELP
            exit
        ;;
        *)
            APLICACORES
            echo -e "${CVE}Parametro ${arg1} nao aceito!${CF}"
            HELP
            exit
        ;;
        esac
fi
}

function SOMATEMPO(){
    let somat=$somat+$c # Somando o tempo total gastos em segundos
}

function TOCAAUDIO(){
    if [ $mute = 0 ];then
        paplay $audio
    fi
}

function SAIDA(){
    let mediat=$somat/$t # Calculando a media do tempo total
    if [ $somat -ge 60 ]; then # Caso tenha passado mais que 60 segundos
        min=$(( somat / 60 ))
        seg=$(( somat % 60 ))
        somat="${min}m e ${seg}s" # Atribuindo valor minutos e segundos a somat
        if [ $mediat -ge 60 ]; then  # Caso a media seja maior que 1 minuto
            min=$(( mediat / 60 ))  
            seg=$(( mediat % 60 ))
            mediafinal="${min}m e ${seg}s" # Setando a média em min e segundaos
            frasefinal="
            Acoes:...........................${t} 
            Tempo:...........................${somat}
            Media_de_tempo:..................${mediafinal}
            Acoes_fora_do_prazo:.............${falha} 
            by =)"
        else # Caso seja menor que 60s sera mostrado em segundos
            frasefinal="
            Acoes:...........................${t} 
            Tempo:...........................${somat}
            Media_de_tempo...................${mediat}s
            Acoes_fora_do_prazo:.............${falha} 
            by =)"
        fi
    else
        frasefinal="
        Acoes:...........................${t} 
        Tempo:...........................${somat}s
        Media_de_tempo:..................${mediat}s 
        Acoes_fora_do_prazo:.............${falha} 
        by =)"
    fi
    if [ $fun -eq 1 ]; then
        cowsay -W 45 $frasefinal | lolcat
    else
        echo -e "$frasefinal\n"
    fi
    exit 0;
}

MAIN $1 $2 $3