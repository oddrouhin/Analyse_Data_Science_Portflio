# 02_clean_data.R
# Script pour nettoyer et préparer les données pour l'analyse exploratoire et la modélisation

# Charger les librairies nécessaires
library(tidyverse)  # Pour la manipulation des données
library(ggplot2)    # Pour les visualisations

# Étape 1 : Charger les données importées
load("Data/processed/imported_data.RData")

# Vérifications initiales
cat("Dimensions des données avant nettoyage :\n")
cat("ventes_train :", dim(ventes_train), "\n")
cat("ventes_test :", dim(ventes_test), "\n")
cat("store :", dim(store), "\n")

# Étape 2 : Identifier les valeurs manquantes
calculate_na_summary <- function(data) {
  data.frame(
    Variable = colnames(data),
    NA_Count = colSums(is.na(data)),
    NA_Percentage = round(colSums(is.na(data)) / nrow(data) * 100, 2)
  ) %>% arrange(desc(NA_Percentage))
}

na_summary_store <- calculate_na_summary(store)
cat("\nRésumé des valeurs manquantes pour store :\n")
print(na_summary_store)

# Visualisation des NA par variable
na_summary_store %>%
  ggplot(aes(x = reorder(Variable, -NA_Percentage), y = NA_Percentage, fill = NA_Percentage)) +
  geom_bar(stat = "identity") +
  labs(title = "Pourcentage de NA par variable (store)", x = "Variable", y = "Pourcentage de NA") +
  theme_minimal() +
  coord_flip()

# Étape 3 : Traitement des valeurs manquantes
## 3.1 Variables liées à Promo2
store <- store %>%
  mutate(
    Promo2_Participation = ifelse(is.na(Promo2SinceWeek), "Non participant", "Participant"),
    Promo2SinceWeek = ifelse(is.na(Promo2SinceWeek), 0, Promo2SinceWeek),
    Promo2SinceYear = ifelse(is.na(Promo2SinceYear), 0, Promo2SinceYear)
  )

# Visualisation de la distribution des participants/non participants à Promo2
store %>%
  ggplot(aes(x = Promo2_Participation, fill = Promo2_Participation)) +
  geom_bar() +
  labs(title = "Distribution des magasins participants à Promo2", x = "Participation", y = "Nombre de magasins") +
  theme_minimal()

## 3.2 Variables liées à Competition
store <- store %>%
  mutate(
    CompetitionOpenSinceMonth = ifelse(is.na(CompetitionOpenSinceMonth), 0, CompetitionOpenSinceMonth),
    CompetitionOpenSinceYear = ifelse(is.na(CompetitionOpenSinceYear), 0, CompetitionOpenSinceYear)
  )

store <- store %>%
  mutate(
    CompetitionDistance = ifelse(is.na(CompetitionDistance), median(CompetitionDistance, na.rm = TRUE), CompetitionDistance)
  )


ventes_train <- ventes_train %>%
  mutate(Date = as.Date(Date))

ventes_train %>%
  ggplot(aes(x = Date)) +
  geom_histogram(binwidth = 30, fill = "#ff784e") +
  labs(title = "Distribution des dates dans ventes_train", x = "Date", y = "Nombre d'observations") +
  theme_minimal()




# Visualisation de CompetitionDistance après traitement
ggplot(store, aes(x = CompetitionDistance)) +
  geom_histogram(fill = "#4fc3f7", bins = 30) +
  labs(title = "Distribution de CompetitionDistance après traitement", x = "CompetitionDistance", y = "Fréquence") +
  theme_minimal()

# Étape 4 : Vérification et visualisations des dates
ventes_train %>%
  ggplot(aes(x = Date)) +
  geom_histogram(fill = "#ff784e", bins = 30) +
  labs(title = "Distribution des dates dans ventes_train", x = "Date", y = "Nombre d'observations") +
  theme_minimal()

# Étape 5 : Conversion des types de données
ventes_train <- ventes_train %>%
  mutate(
    Store = as.factor(Store),
    DayOfWeek = as.factor(DayOfWeek)
  )

store <- store %>%
  mutate(
    StoreType = as.factor(StoreType),
    Assortment = as.factor(Assortment),
    Promo2_Participation = as.factor(Promo2_Participation)
  )

ventes_train <- ventes_train %>%
  mutate(Date = as.Date(Date))
ventes_test <- ventes_test %>%
  mutate(Date = as.Date(Date))

# Renommer les colonnes dans store
store <- store %>%
  rename(
    Magasin = Store,
    Type_Magasin = StoreType,
    Assortiment = Assortment,
    Distance_Concurrent = CompetitionDistance,
    Mois_Ouverture_Concurrent = CompetitionOpenSinceMonth,
    Annee_Ouverture_Concurrent = CompetitionOpenSinceYear,
    Promotion_Continue = Promo2,
    Semaine_Debut_Promo2 = Promo2SinceWeek,
    Annee_Debut_Promo2 = Promo2SinceYear,
    Intervalle_Promo = PromoInterval
  )

# Vérification après renommage
cat("Colonnes de store après renommage :\n")
print(colnames(store))

# Renommer les colonnes dans ventes_train
ventes_train <- ventes_train %>%
  rename(
    Magasin = Store,
    Jour_Semaine = DayOfWeek,
    Date = Date,
    Ventes = Sales,
    Clients = Customers,
    Ouvert = Open,
    Promotion = Promo,
    Vacances_Scolaires = SchoolHoliday
  )

# Vérification après renommage
cat("\nColonnes de ventes_train après renommage :\n")
print(colnames(ventes_train))

summary(ventes_train)
summary(store)

ggplot(ventes_train, aes(x = Ventes)) +
  geom_histogram(fill = "#4fc3f7", bins = 30) +
  labs(title = "Distribution des ventes après renommage", x = "Ventes", y = "Fréquence")



# Étape 6 : Sauvegarde des données nettoyées
save(ventes_train, ventes_test, store, file = "Data/processed/cleaned_data.RData")

cat("\nNettoyage terminé. Les données sont sauvegardées dans 'Data/processed/cleaned_data.RData'.\n")
