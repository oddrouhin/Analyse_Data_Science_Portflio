# 02_clean_data.R
# Script pour nettoyer et préparer les données pour l'analyse exploratoire et la modélisation

# Charger les librairies nécessaires
library(tidyverse) # Pour la manipulation de données

# Charger les données importées
# Les données ont été sauvegardées dans le script 01_import_data.R
load("Data/processed/imported_data.RData")

# Afficher les dimensions initiales des données
# Cette étape permet de vérifier combien de lignes et de colonnes contiennent chaque dataset avant toute modification
cat("Dimensions initiales des données :\n")
cat("ventes_train :", dim(ventes_train), "\n")
cat("ventes_test :", dim(ventes_test), "\n")
cat("store :", dim(store), "\n")

# Vérification des valeurs manquantes
# On identifie les colonnes contenant des valeurs manquantes pour savoir lesquelles nécessitent un traitement
cat("Valeurs manquantes par colonne :\n")
ventes_train_na <- colSums(is.na(ventes_train)) # Nombre de NA par colonne dans ventes_train
ventes_test_na <- colSums(is.na(ventes_test))   # Nombre de NA par colonne dans ventes_test
store_na <- colSums(is.na(store))               # Nombre de NA par colonne dans store

# Afficher uniquement les colonnes ayant des valeurs manquantes
cat("ventes_train :\n")
print(ventes_train_na[ventes_train_na > 0])
cat("ventes_test :\n")
print(ventes_test_na[ventes_test_na > 0])
cat("store :\n")
print(store_na[store_na > 0])

# Traitement des valeurs manquantes
# Exemple 1 : Remplacer tous les NA par 0 dans ventes_train et ventes_test
# Cette opération est justifiée si les NA indiquent une absence de ventes
ventes_train[is.na(ventes_train)] <- 0
ventes_test[is.na(ventes_test)] <- 0

# Exemple 2 : Remplacer les NA dans CompetitionDistance par la médiane
# Cette colonne peut avoir des NA si la distance avec un concurrent n'est pas connue.
# On remplace les NA par la médiane pour éviter de fausser les analyses
store <- store %>%
  mutate(
    CompetitionDistance = ifelse(is.na(CompetitionDistance), median(CompetitionDistance, na.rm = TRUE), CompetitionDistance)
  )

# Conversion des colonnes en facteurs
# Les variables catégoriques doivent être converties en facteur pour les analyses statistiques et la modélisation
ventes_train <- ventes_train %>%
  mutate(Store = as.factor(Store)) # Le numéro de magasin est une catégorie, pas une variable numérique continue

store <- store %>%
  mutate(
    StoreType = as.factor(StoreType),  # Type de magasin (a, b, c, d)
    Assortment = as.factor(Assortment) # Niveau d'assortiment (a, b, c)
  )

# Suppression des colonnes inutiles ou redondantes
# Exemple : Suppression de la colonne Customers dans ventes_train
# Cette colonne pourrait être fortement corrélée à Sales, donc redondante pour certaines analyses
ventes_train <- ventes_train %>%
  select(-Customers)

# Sauvegarder les données nettoyées
# Une fois les données nettoyées, on les sauvegarde dans un fichier pour les utiliser dans les étapes suivantes
save(ventes_train, ventes_test, store, file = "Data/processed/cleaned_data.RData")

# Afficher un message de fin pour confirmer la réussite du processus
cat("Nettoyage terminé. Les données sont sauvegardées dans Data/processed/cleaned_data.RData.\n")
