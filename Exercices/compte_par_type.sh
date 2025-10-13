if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <chemin_ann> <annee> <type>" >&2
  exit 1
fi
CHEMIN="$1"
ANNEE="$2"
TYPE="$3"
DIR="$CHEMIN/$ANNEE"

if [ ! -d "$DIR" ]; then
  echo "0"
  exit 0
fi
COUNT=$(find "$DIR" -type f -name '*.ann' -exec cat {} + 2>/dev/null | grep -F -- "$TYPE" | wc -l)
echo "$COUNT"
