CHEMIN="./ann"
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <annee> <mois> <nombre>"
  exit 1
fi

ANNEE="$1"
MOIS="$2"
NOMBRE="$3"

if [ "$ANNEE" = "*" ]; then
  ANNEE="*"
fi
if [ "$MOIS" = "*" ]; then
  MOIS="*"
fi

FICHIERS=$(find "$CHEMIN"/$ANNEE/$MOIS -type f -name '*.ann' 2>/dev/null)

if [ -z "$FICHIERS" ]; then
  echo "Aucun fichier trouvé pour cette période."
  exit 0
fi
grep -h "Location" $FICHIERS | awk '{print $NF}' | sort | uniq -c | sort -nr | head -n "$NOMBRE"
