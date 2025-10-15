ANNEE=$1
TYPE=$2
DIR="/home/annasugak/Bureau/PPE1-2526/Exercice1/ann"

cat $DIR/$ANNEE/*.ann | grep "$TYPE" | wc -l
