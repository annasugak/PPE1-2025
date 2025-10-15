#!/bin/bash

echo "argument donné : $1"

CHEMIN=$1

for annee in 2016 2017 2018
do
    echo "Nombre de lieux en $annee:" 
    cat "$CHEMIN/$annee/"* | grep Location |  wc -l
done
