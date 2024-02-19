# cronometroshell
Um cronometro regressivo em shell script que pode ser divertido ou não.

![license](https://img.shields.io/badge/License-MIT-orange?style=flat-square)
![distro](https://img.shields.io/badge/Distro-LinuxMint_21.3-green?style=flat-square)

## Pré requisitos

Pacotes utilizados
```
cowsay
lolcat
aplay
```

## Baixando

Clonado o repositorio para o computador local
```
git clone https://github.com/smartao/cronometroshell.git
```

## Configurações
No arquivo ``variaveis`` é possível fazer algumas alterações no funcionamento do script, as instruções de funcionamento estão nesse arquivo

## Execução

### Basico

Podemos apenas executar o script, ele executará uma contagem regressiva em segundos baseado no valor configurado no arquivo ``variaveis`` que por padrão é 120 segundos.

´´´
./cronometroshell.sh
´´´ 

### Denindo o tempo

Podemos definir um tempo em segundos para a execucação do cronometro

´´´
./cronometroshell.sh 10
´´´ 