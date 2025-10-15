TYPE=$1
A=$(bash /home/annasugak/Bureau/PPE1-2526/PPE1-2025/Exercices/compte_par_type.sh 2016 $TYPE)
B=$(bash /home/annasugak/Bureau/PPE1-2526/PPE1-2025/Exercices/compte_par_type.sh 2017 $TYPE)
C=$(bash /home/annasugak/Bureau/PPE1-2526/PPE1-2025/Exercices/compte_par_type.sh 2018 $TYPE)
echo " en 2016 : $A; en 2017 : $B; en 2018 : $C."
