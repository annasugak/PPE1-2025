if [ $# -ne 1 ]; then
    echo "Usage: $0 <fichier_tsv>"
    exit 1
fi
FICHIER_TSV=$1
FICHIER_HTML="${FICHIER_TSV%.tsv}.html"
echo "<!DOCTYPE html>" > "$FICHIER_HTML"
echo "<html lang='fr'>" >> "$FICHIER_HTML"
echo "<head>" >> "$FICHIER_HTML"
echo "<meta charset='UTF-8'>" >> "$FICHIER_HTML"
echo "<title>Tableau des sites</title>" >> "$FICHIER_HTML"
echo "<style>" >> "$FICHIER_HTML"
echo "  body { font-family: Arial, sans-serif; margin: 20px; }" >> "$FICHIER_HTML"
echo "  table { border-collapse: collapse; width: 100%; }" >> "$FICHIER_HTML"
echo "  th, td { border: 1px solid #000; padding: 5px; text-align: left; }" >> "$FICHIER_HTML"
echo "  th { background-color: #ddd; }" >> "$FICHIER_HTML"
echo "  tr:nth-child(even) { background-color: #f2f2f2; }" >> "$FICHIER_HTML"
echo "</style>" >> "$FICHIER_HTML"
echo "</head>" >> "$FICHIER_HTML"
echo "<body>" >> "$FICHIER_HTML"
echo "<h2>Résultats d'analyse des sites</h2>" >> "$FICHIER_HTML"
echo "<table>" >> "$FICHIER_HTML"
lineno=0
while IFS=$'\t' read -r num url code encodage nbmots; do
    if [ $lineno -eq 0 ]; then
        echo "  <tr><th>$num</th><th>$url</th><th>$code</th><th>$encodage</th><th>$nbmots</th></tr>" >> "$FICHIER_HTML"
    else
        echo "  <tr><td>$num</td><td><a href=\"$url\">$url</a></td><td>$code</td><td>$encodage</td><td>$nbmots</td></tr>" >> "$FICHIER_HTML"
    fi
    ((lineno++))
done < "$FICHIER_TSV"
echo "</table>" >> "$FICHIER_HTML"
echo "</body>" >> "$FICHIER_HTML"
echo "</html>" >> "$FICHIER_HTML"
rm "$FICHIER_TSV"
echo "Fichier HTML créé : $FICHIER_HTML"
echo "Fichier TSV supprimé : $FICHIER_TSV"
