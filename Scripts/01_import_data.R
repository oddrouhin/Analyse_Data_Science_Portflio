# 01_import_data.R
# Script pour charger les données brutes dans R

# Chargement des librairies nécessaires
library(tidyverse)

setwd("C:/Users/od-sciences/Documents/Analyse_Data_Science_Portfolio")


# Définir le chemin vers le dossier des données brutes
data_path <- "Data/raw/"

# Charger les fichiers CSV
ventes_train <- read.csv(file.path(data_path, "ventes_ech_train.csv"))
ventes_test <- read.csv(file.path(data_path, "ventes_ech_test.csv"))
store <- read.csv(file.path(data_path, "store.csv"))

# Aperçu rapide des données
cat("Dimensions des données :\n")
cat("ventes_train :", dim(ventes_train), "\n")
cat("ventes_test :", dim(ventes_test), "\n")
cat("store :", dim(store), "\n")

# Sauvegarder les données chargées dans un fichier intermédiaire
save(ventes_train, ventes_test, store, file = "Data/processed/imported_data.RData")

cat("Importation terminée. Les données sont sauvegardées dans Data/processed/imported_data.RData.\n")
