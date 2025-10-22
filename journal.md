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

## 17/10 - explication du code :
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

##22/10
###on stocke dans la variable file le premier argument donné au script.
file=$1

###ainsi le compteur est initialisé à 1
num=1

###le chemin complet du fichier de sortie où seront enregistrés les résultats
output="/home/annasugak/Bureau/PPE1-2526/PPE1-2025/miniprojet/tableaux/tableau-fr.tsv"

###la création du fichier TSV avec les en-têtes de colonnes (-e permet d'interpréter \t comme une tabulation, > remplace le contenu du fichier au cas où il existe déjà)
echo -e "Numéro\tURL\tCode_HTTP\tEncodage\tNb_mots" > "$output"

###on lit le fichier ligne par ligne en mettant chaque ligne dans la variable "line"
while read -r line; do

###la vérification que la ligne n'est pas vide (-n signifie "pas vide")
    if [ -n "$line" ]; then

###l'nvoie d'une requête HTTP à l’URL et la récupération du code HTTP (-s c'est le mode silencieux, donc pas d’affichage dans le terminal;  -o /dev/null on ne garde pas le contenu de la page; -w "%{http_code}"  affiche uniquement le code HTTP)
        code=$(curl -s -o /dev/null -w "%{http_code}" "$line")

###le téléchargement du contenu HTML complet de la page et son stockage dans la variable content
        content=$(curl -s "$line")

###echo "$content" envoie le HTML à la commande grep -iPo; -P utilise la syntaxe Perl pour les expressions régulières; -o n’affiche que la partie qui correspond à la regex; la regex (?<=charset=)[a-zA-Z0-9_-]+ signifie que tous les caractères sont alphanumériques après charset=; head -n 1 garde uniquement la première correspondance.
 encoding=$(echo "$content" | grep -iPo '(?<=charset=)[a-zA-Z0-9_-]+' | head -n 1)

 ###on compte le nombre de mots dans le contenu HTML
nb_mots=$(echo "$content" | wc -w)

###on vérifie si la variable encoding est vide
        if [ -z "$encoding" ]; then

###la valeur par défaut si aucun encodage n'a été trouvé
            encoding="Non présent"
        fi

###on ajoute une nouvelle ligne au fichier TSV contenant le numéro, l'URL, le code HTTP, l'encodage et le nombre de mots
        echo -e "${num}\t${line}\t${code}\t${encoding}\t${nb_mots}" >> "$output"

###l'incrémente la variable num (passe à l’URL suivante)
         ((num++))

###on termine la condition if [ -n "$line" ]
    fi

###on indique que la boucle while doit lire son entrée depuis le fichier file
done < "$file"
