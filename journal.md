# Journal de bord du projet encadré

## 04/10 
J'ai bien suivi le guide pour effectuer les opperations suivantes : création d'un nouveau dépôt "PPE1-2025", affectution de certaines commande dans le terminal, création du journal de bord et prise des notes sur le travail mené, création d'un tag sur le  dernier commit.

## 08/10 - exercice 1 
Affichage de nombre de lieux dans les dossiers "2016", "2017", "2018"; création du premier script nommé "comptes.sh" sur Kate; affichage des commandes dedans; création du dossier "Exercices"; création du tag sur le dernier commit nommé "tp1-ex1".

## 09/10 - Scripts Bash
Lors du cours de 8 octobre j'ai bien réussi à créer un script permettant de compter le nombre de Locationq pour chaque année. Après avoir commité mon travail, j'ai bien ajouté un tag 'tp1-ex1', comme indiqué dans la consigne. Par contre, j'ai rencontré les difficultés en faisant l'exercice 2. J'ai bien réussi à faire la première partie de l'exercice 2.a en créant un script ressemblant à celu qu'on avait fait pendant le cours : 
echo "argument donné : $1"
CHEMIN=$1
cat "$CHEMIN/2016/"* | grep Location | wc -l
cat "$CHEMIN/2016/"* | grep Person | wc -l
cat "$CHEMIN/2016/"* | grep Organisation | wc -l
Cependant, après avoir essayé de créer le seconde script j'ai compris que le premier n'était pas convenable pour que je puisse me baser sur lui. 
Après quelques tentatives j'ai réussi à avoir un bon script.

## 13/10 - explication du code :
!/ usr / bin / bash
if [ $ # - ne 1 ] - la condition if veut tester si le nombre d'arguments est différent de 1
then - c'est une indication du début du bloc de commandes qui vont s'exécuter si la condition est vraie
echo " ce programme demande un argument " - l'affichage d'un message disant que le programme a besoin d'un argument
exit - l'exécution du script se terminent ici
fi - la fin du bloc if
FICHIER_URLS = $1 - le fichier à lire s'appelle le premier argument
OK =0 - 0 pour les lignes valides
NOK =0 - 0 pour les lignes invalides
while read -r LINE ; - le démarrage d'une boucle while qui lit le fichier ligne par ligne en mettant chaque ligne dans la variable LINE
do - c'est le début du bloc de commandes à exécuter pour chaque ligne lue
echo " la ligne : $LINE " - l'affichage du contenu de la ligne courante
if [[ $LINE =∼ ^ https ?:// ]] - la condition if veut tester si la ligne correspond à une expression régulière qui commence par https
then - la suite c'est pour le cas où la ligne correspond à la condition
echo " ressemble à une URL valide " - affiche que la ligne “ressemble à une URL valide”
OK = $ ( expr $OK + 1)
else - si la ligne ne correspond pas à la condition précédente
echo " ne ressemble pas à une URL valide " - affiche que la ligne “ne ressemble pas à une URL valide”
NOK = $ ( expr $NOK + 1) 
fi - la fin du if "intérieur"
done < $FICHIER_URLS - indique que la boucle while doit lire les lignes à partir du fichier contenu dans la variable $FICHIER_URLS
echo " $OK URLs et $NOK lignes douteuses " - à la fin, affiche un résumé : combien de lignes valides(OK) et combien de lignes douteuses(NOK)
