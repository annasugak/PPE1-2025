if [ $# -ne 1 ]; then
    echo "Usage: $0 <fichier_url>"
    exit 1
fi
file=$1
num=1
output="/home/annasugak/Bureau/PPE1-2526/PPE1-2025/miniprojet/tableaux/tableau-fr.tsv"
echo -e "Numéro\tURL\tCode_HTTP\tEncodage\tNb_mots" > "$output"
while read -r line; do
    if [ -n "$line" ]; then
        code=$(curl -s -o /dev/null -w "%{http_code}" "$line")
        content=$(curl -s "$line")
        encoding=$(echo "$content" | grep -iPo '(?<=charset=)[a-zA-Z0-9_-]+' | head -n 1)
        nb_mots=$(echo "$content" | wc -w)
        if [ -z "$encoding" ]; then
            encoding="Non présent"
        fi
        echo -e "${num}\t${line}\t${code}\t${encoding}\t${nb_mots}" >> "$output"
        ((num++))
    fi
done < "$file"

echo "Résultat enregistré dans : $output"
