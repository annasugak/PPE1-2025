if [ $# -ne 2 ]; then
    echo "Usage: $0 <fichier_urls> <fichier_sortie_html>"
    exit 1
fi
FICHIER_URL=$1
FICHIER_SORTIE=$2
lineno=1
cat > "$FICHIER_SORTIE" << 'EOF'
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau des résultats - Analyse d'URLs</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
</head>
<body>
    <section class="section">
        <div class="container">
            <div class="hero is-info mb-5">
                <div class="hero-body">
                    <h1 class="title">Résultats des analyses d'URLs</h1>
                    <p class="subtitle">Tableau récapitulatif des informations collectées</p>
                </div>
            </div>
            <div class="table-container">
                <table class="table is-striped is-hoverable is-fullwidth">
                    <thead>
                        <tr>
                            <th>Numéro</th>
                            <th>URL</th>
                            <th>Code HTTP</th>
                            <th>Encodage</th>
                            <th>Nombre de mots</th>
                        </tr>
                    </thead>
                    <tbody>
EOF
while read -r line; do
    if [ -n "$line" ]; then
        code=$(curl -s -o /dev/null -w "%{http_code}" "$line")
        content=$(curl -s "$line")
        encodage=$(echo "$content" | grep -i "charset=" | head -n1 | sed -E 's/.*charset=([^">]+).*/\1/' | tr -d '>"')
        if [ -n "$encodage" ]; then
            encodage_display="UTF-8"
        else
            encodage_display="<span class='has-text-grey'>Non spécifié</span>"
        fi
        nb_mots=$(echo "$content" | wc -w)
        if [ "$code" -eq 200 ]; then
            code_class="has-text-success"
        elif [ "$code" -ge 400 ]; then
            code_class="has-text-danger"
        elif [ "$code" -ge 300 ]; then
            code_class="has-text-warning"
        else
            code_class="has-text-info"
        fi
        cat >> "$FICHIER_SORTIE" << EOF
                        <tr>
                            <td><strong>$lineno</strong></td>
                            <td><a href="$line" target="_blank">$line</a></td>
                            <td><span class="$code_class"><strong>$code</strong></span></td>
                            <td>$encodage_display</td>
                            <td><span class="tag is-info">$nb_mots</span></td>
                        </tr>
EOF
        lineno=$((lineno + 1))
    fi
done < "$FICHIER_URL"

cat >> "$FICHIER_SORTIE" << 'EOF'
                    </tbody>
                </table>
            </div>
        </div>
    </section>
</body>
</html>
EOF
echo "Page générée avec succès: $FICHIER_SORTIE"
