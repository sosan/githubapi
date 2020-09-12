#!/bin/bash

# CONFIG A CAMBIAR
USUARIOGITHUB=CAMBIAR
PASSWORDGITHUB=CAMBIAR

if [ "$USUARIOGITHUB" == "CAMBIAR" ] || [ "$PASSWORDGITHUB" == "CAMBIAR" ]; then
	echo "CAMBIA USUARIO / PASSWORD. LINEA 4 Y 5"
	exit
fi


echo "USO: bash ${0} nombre_repositorio [url_repositorio_template]"

# comprobamos que el primer parametro no esta vacio
if [ "$1" = "" ] || [ "$1" = " " ] ; then
	echo "Te falta el nombre del repositorio"
	exit
fi


REPONAME="$1"
TEMPLATEURL=https://github.com/toniferra-dev/Plantilla-FrontEnd

TEMPLATEOWNER=toniferra-dev
TEMPLATEREPO=Plantilla-FrontEnd


if [ "$2" != "" ] ; then
	echo "template desde ${2}"
	TEMPLATEURL="$2"
	IFS='/' read -ra ARRAY <<< "$TEMPLATEURL"
	TEMPLATEOWNER="${ARRAY[3]}"
	TEMPLATEREPO="${ARRAY[4]}"
fi

curl -X POST -H "Accept: application/vnd.github.baptiste-preview+json" https://api.github.com/repos/"$TEMPLATEOWNER"/"$TEMPLATEREPO"/generate  -u "$USUARIOGITHUB":"$PASSWORDGITHUB" -d "{\"name\": \""$REPONAME"\"}"

git clone https://github.com/"$USUARIOGITHUB"/"$REPONAME".git
cd "$REPONAME" || exit
git pull origin master
