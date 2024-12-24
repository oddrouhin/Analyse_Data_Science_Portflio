# Chargement des bibliothèques nécessaires
library(tidyverse)
library(GGally)

# Charger les données nettoyées depuis le fichier RData
load("Data/processed/cleaned_data.RData")

# Vérification des jeux de données chargés
cat("Les données suivantes ont été chargées :\n")
print(ls())

# Conversion de la colonne 'Date' au format Date pour une analyse temporelle
ventes_train <- ventes_train %>% mutate(Date = as.Date(Date, format = "%Y-%m-%d"))
ventes_test <- ventes_test %>% mutate(Date = as.Date(Date, format = "%Y-%m-%d"))

# 1. Résumé Statistique Global
cat("\n### Résumé Statistique Global\n")
summary(ventes_train)
summary(ventes_test)
summary(store)

# 2. Analyse des Ventes à 0
cat("\n### Analyse des Ventes à 0\n")
ventes_0 <- ventes_train %>% filter(Ventes == 0)
summary(ventes_0$Ouvert)

# 3. Corrélations entre Variables Numériques
cat("\n### Corrélations entre Variables Numériques\n")
ventes_numeric <- ventes_train %>% select(Ventes, Clients, Promotion, Vacances_Scolaires)
ggpairs(ventes_numeric, title = "Corrélations entre Variables Numériques")
ggsave("Graphiques/eda/correlations_numeriques.png", width = 8, height = 5)

# 4. Visualisations

# Distribution des Ventes
ggplot(ventes_train, aes(x = Ventes)) +
  geom_histogram(fill = "#4fc3f7", color = "black", bins = 30) +
  labs(title = "Distribution des Ventes", x = "Ventes", y = "Fréquence") +
  theme_minimal()
ggsave("Graphiques/eda/distribution_ventes.png", width = 8, height = 5)

# Relation entre Clients et Ventes
ggplot(ventes_train, aes(x = Clients, y = Ventes)) +
  geom_point(alpha = 0.5, color = "#FF784E") +
  labs(title = "Relation entre Clients et Ventes", x = "Clients", y = "Ventes") +
  theme_minimal()
ggsave("Graphiques/eda/relation_clients_ventes.png", width = 8, height = 5)

# Boxplot des Ventes par Magasin
ggplot(ventes_train, aes(x = factor(Magasin), y = Ventes)) +
  geom_boxplot(fill = "#4fc3f7") +
  labs(title = "Distribution des Ventes par Magasin", x = "Magasin", y = "Ventes") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("Graphiques/eda/boxplot_ventes_magasin.png", width = 8, height = 5)

# 5. Analyse Temporelle

# Évolution des Ventes dans le Temps
ggplot(ventes_train, aes(x = Date, y = Ventes)) +
  geom_line(color = "#607D8B") +
  labs(title = "Évolution des Ventes dans le Temps", x = "Date", y = "Ventes") +
  theme_minimal()
ggsave("Graphiques/eda/evolution_ventes_temps.png", width = 8, height = 5)

# Moyennes hebdomadaires des ventes
ggplot(ventes_train, aes(x = Jour_Semaine, y = Ventes)) +
  stat_summary(fun = mean, geom = "bar", fill = "#4fc3f7", color = "black") +
  labs(title = "Moyenne des Ventes par Jour de la Semaine", x = "Jour de la Semaine", y = "Moyenne des Ventes") +
  theme_minimal()
ggsave("Graphiques/eda/moyenne_ventes_jour_semaine.png", width = 8, height = 5)

# Sauvegarde des données transformées et visualisations
cat("\nLes analyses exploratoires et visualisations sont terminées.\nLes graphiques sont enregistrés dans le dossier Graphiques/eda.")

# 6. Analyse de l'effet des promotions et des vacances scolaires

# Moyenne des ventes avec et sans promotion
ggplot(ventes_train, aes(x = factor(Promotion), y = Ventes)) +
  geom_boxplot(fill = "#4fc3f7", color = "black") +
  labs(title = "Effet des Promotions sur les Ventes", x = "Promotion", y = "Ventes") +
  theme_minimal()
ggsave("Graphiques/eda/effet_promotions.png", width = 8, height = 5)

# Moyenne des ventes pendant et hors vacances scolaires
ggplot(ventes_train, aes(x = factor(Vacances_Scolaires), y = Ventes)) +
  geom_boxplot(fill = "#4fc3f7", color = "black") +
  labs(title = "Effet des Vacances Scolaires sur les Ventes", x = "Vacances Scolaires", y = "Ventes") +
  theme_minimal()
ggsave("Graphiques/eda/effet_vacances.png", width = 8, height = 5)

# Sauvegarde des données transformées et visualisations
cat("\nLes analyses exploratoires et visualisations sont terminées.\nLes graphiques sont enregistrés dans le dossier Graphiques/eda.")





