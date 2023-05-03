#!/bin/sh
secretins=$(openssl rand -base64 8)
{
clear
printf "\n"

    printf "${GREEN}";
    printf "██ ██████ ██ ██   ██ ██████    ██████ ██████ ██████  \n";
    printf "██     ██ ██ ███  ██ ██        ██  ██ ██  ██ ██  ██\n";
    printf "██   ██   ██ ██ █ ██ ██  ██    ██████ ██████ ██  ██\n";
    printf "██ ██     ██ ██  ███ ██   █    ██     ██ ██  ██  ██\n";
    printf "██ ██████ ██ ██   ██ ██████ ██ ██     ██  ██ ██████ V.1.5 \n";
    printf "${NC}";
    printf "\n"
    printf "  Compartilhar, vender ou fornecer essa solução\n";
    printf "  sem autorização é crime previsto na Artigo 184\n";
    printf " do código penal que descreve a conduta criminosa\n";
    printf "  de infringir os direitos autorais do Izing Pro.\n";
    printf "\n";
    printf "          PIRATEAR ESSA SOLUÇÃO É CRIME.\n";
    printf "\n";
    printf "        © Instalador Premium - Izing.io \n";
    printf "\n";
    printf "\n";
    printf "\n\n";
    printf "   Solicite sua senha de acesso para usar essa solução";
    printf "  Envie esse código para podermos gerar usuario e senha: $secretins ";
    printf "\n\n\n\n";
}

IZING=http://install.izing.app
FILE_ID=10001
printf "Sistema de Autenticação Instalador Premium \n"
printf 'Username: '
read USER_NAME
printf 'Password: '
read -s PASSWORD
OUTPUT=`curl -Ss -X POST \
	-H 'Content-Type: application/json' \
	-d "{\"username\": \"${USER_NAME}\",\"password\": \"${PASSWORD}\"}" \
	"${IZING}/rest/auth/1/session"`
if [[ "$OUTPUT" == *"errorMessages"* ]]; then
	printf "Autenticação falhou, Baixando Instalador Padrão\n\n"
        sleep 2
        cd 
        git clone https://github.com/Silvioerick/izing.io.installer-master.git
        cd izing.io.installer-master
        bash izing
	#rm -Rf *
else
	printf "Autenticação bem-sucedida!\n"
	printf "Realizando o download do arquivo...\n"
	TOKEN=$(echo "$OUTPUT" | grep -oP '"session":\{"name":"[^"]+","value":"\K[^"]+')
curl -OJ -H "Cookie: JSESSIONID=${TOKEN}" "${IZING}/secure/attachment/${FILE_ID}/izing.pro.installer.zip" 
	if [ $? -eq 0 ]; then
        printf "Download concluído!"
        else
        printf "Falha ao baixar o arquivo. Verifique as permissões e o ID do arquivo.\n\n"
        fi
        printf "\n\n\n" 
	printf "ATUALIZANDO O LINUX\n"
	sleep 3
	sudo apt update -y 
	sudo apt upgrade -y
        printf "INSTALANDO DEPENDECIAS DO INSTALADOR \n"
	sleep 3
	sudo apt install -y unzip
        sudo apt install -y git
        unzip izing.pro.installer.zip
	cd izing.pro.installer
	bash izing
	cd .. 
	rm izing.pro.installer.zip && rm -Rf izing.pro.installer
fi

