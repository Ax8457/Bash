#!/bin/bash
echo "=========================================="
echo "=============== IPV4 HIDER ==============="
echo "=========================================="

if [ $# -eq 0 ]; then
	echo "Veuillez passer un fichier à parser en paramètre."
	exit 1
fi

if [ ! -f "$1" ]; then 
	echo "Fichier introuvable."
	exit 1
fi 

file=$1
start=$(grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' "$file" | awk 'NR==1')

if [ -z "$start" ]; then
	echo "Aucune adresse IP ne figure dans ce fichier."
	exit 1
fi

cp "$1" "$1.bak"
incr=0
while true 
do
	ipAddress=$(grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' "$file" | awk 'NR==1')
	if [ -n "$ipAddress" ]; then 
		echo "IP trouvée : $ipAddress"
		read -p "Motif par lequel l'IP sera substituée: " motif
		sed -i "s/$ipAddress/$motif/" "$file"
		echo "L'adresse $ipAdress a été remplacée par $motif"
		echo "-----------------------------------------------"
		((incr++))
		sleep 0.5

	else
		echo "Toutes les adresses IP ont été remplacées. [$incr]"
		echo "Une backup du fichier original a été sauvegardée dans $1.bak ."
		exit 1 
	fi

done
