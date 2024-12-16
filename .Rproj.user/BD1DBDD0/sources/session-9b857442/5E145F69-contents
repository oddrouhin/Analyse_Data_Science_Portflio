# Définir le chemin principal du projet
projet_path <- "C:/Users/od-sciences/Documents/Analyse_Data_Science_Portfolio"

# Liste des dossiers et sous-dossiers à créer
dossiers <- c(
  "Documents",
  "Documents/Templates",
  "Data",
  "Data/raw",
  "Data/processed",
  "Data/results",
  "Scripts",
  "Scripts/functions",
  "Graphiques",
  "Graphiques/eda",
  "Graphiques/segmentation",
  "Graphiques/modelisation",
  "Graphiques/synthese",
  "Images",
  "Images/icones",
  "Images/illustrations",
  "Tables",
  "Outputs"
)

# Créer les dossiers
for (dossier in dossiers) {
  dir.create(file.path(projet_path, dossier), recursive = TRUE, showWarnings = FALSE)
}

# Fichiers par défaut à créer
fichiers <- list(
  "README.md" = "# Analyse Data Science Portfolio\n\nCe projet contient toutes les étapes d'analyse.",
  ".gitignore" = "Data/raw/\nData/processed/\n*.Rproj\n.Rhistory\n.RData\n",
  "Documents/Templates/black_phoenix_template.qmd" = "---\ntitle: \"Template Black Phoenix\"\noutput: html_document\n---\n\n# Contenu du Template",
  "Scripts/functions/black_phoenix_theme.R" = "library(ggplot2)\n\ntheme_black_phoenix <- function() {\n  theme_minimal() +\n    theme(\n      plot.title = element_text(color = \"#607d8b\", size = 14, face = \"bold\", hjust = 0.5),\n      axis.title = element_text(color = \"#333333\", size = 12, face = \"bold\"),\n      axis.text = element_text(color = \"#333333\"),\n      legend.title = element_text(color = \"#607d8b\", face = \"bold\"),\n      legend.text = element_text(color = \"#333333\")\n    )\n}"
)

# Créer les fichiers avec leur contenu par défaut
for (nom_fichier in names(fichiers)) {
  chemin_fichier <- file.path(projet_path, nom_fichier)
  writeLines(fichiers[[nom_fichier]], chemin_fichier)
}

# Message de confirmation
cat("✅ Structure du projet créée avec succès dans :", projet_path)
