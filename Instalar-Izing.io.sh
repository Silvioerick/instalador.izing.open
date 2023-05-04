#!/bin/sh
secretins=$(openssl rand -base64 8)
{
clear
printf "\n"

    printf "${GREEN}";
    printf "██ ██████ ██ ██   ██ ██████    ██ ██████  \n";
    printf "██     ██ ██ ███  ██ ██        ██ ██  ██\n";
    printf "██   ██   ██ ██ █ ██ ██  ██    ██ ██  ██\n";
    printf "██ ██     ██ ██  ███ ██   █    ██ ██  ██\n";
    printf "██ ██████ ██ ██   ██ ██████ ██ ██ ██████ V.2.2 \n";
    printf "${NC}";
    printf "\n"
    printf "     Compartilhar, vender ou fornecer essa solução\n";
    printf "    sem autorização é crime previsto na Artigo 184\n";
    printf "   do código penal que descreve a conduta criminosa\n";
    printf "de infringir os direitos autorais do Instalador Premium.\n";
    printf "\n";
    printf "             PIRATEAR ESSA SOLUÇÃO É CRIME.\n";
    printf "\n";
    printf "            © Instalador Premium - Izing.io \n";
    printf "\n";
    printf "\n";
    printf "\n\n";
    printf "         Compre o acesso para o Instalador Premium";
    printf "               R$ 100,00 PIX (11) 98752-9199 ";
    printf "\n\n\n\n";
}

IZING=http://install.izing.app
FILE_ID=10001
printf "Sistema de Autenticação Instalador Premium \n"
printf 'Username: '
read USER_NAME
printf 'Password: '
read PASSWORD
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
curl -OJ -H "Cookie: JSESSIONID=${TOKEN}" "${IZING}/secure/attachment/${FILE_ID}/Instalador.premium.izing.io.zip" 
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
        unzip Instalador.premium.izing.io.zip
	cd Instalador.premium.izing.io
	bash izing
	cd .. 
	rm Instalador.premium.izing.io.zip && rm -Rf Instalador.premium.izing.io
fi
