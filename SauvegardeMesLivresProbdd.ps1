#Pause de sécurité le temps de la connexion
#Start-Sleep -Seconds 30

# Obtenez la date actuelle
$aujourdhui = Get-Date

# Chemin du fichier source
$cheminSource = "Y:\*"

# Dossier de destination
$dossierDestination = "C:\Users\Unifi\Documents\SauvegardeMesLivresProbdd"

# Nom du fichier destination avec la date ajoutée
$nomFichierDestination = "DataBooksDB_$($aujourdhui.ToString('yyyyMMdd_HHmmss')).mdb"

# Construire le chemin complet du fichier destination
$cheminDestination = Join-Path $dossierDestination $nomFichierDestination

# Copier le fichier
Copy-Item -Path $cheminSource -Destination $cheminDestination

# Chemin du répertoire à nettoyer
$repertoire = "C:\Users\Unifi\Documents\SauvegardeMesLivresProbdd"

# Récupération de la date actuelle
$dateActuelle = Get-Date

# Définition de l'intervalle de temps (1 mois)

$intervalle = New-TimeSpan -Days 30
# Calcul de la date limite (il y a plus d'un mois)
$dateLimite = $dateActuelle - $intervalle

# Récupération de la liste des fichiers dans le répertoire
$fichiers = Get-ChildItem -Path $repertoire

# Parcours de la liste des fichiers
foreach ($fichier in $fichiers) {
    # Vérification de la date de dernière modification
    if ($fichier.LastWriteTime -lt $dateLimite) {
        # Suppression du fichier
        Remove-Item -Path $fichier.FullName -Force
        Write-Output "Supprimé : $($fichier.FullName)"
    }
}
