if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <chemin_ann> <type>" >&2
  exit 1
fi

CHEMIN="$1"
TYPE="$2"

for YEAR in 2016 2017 2018; do
  echo "Nombre de $TYPE en $YEAR:"
  ./compte_par_type.sh "$CHEMIN" "$YEAR" "$TYPE"
done
