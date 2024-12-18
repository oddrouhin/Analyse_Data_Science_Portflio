# Charger la bibliothèque
library(magick)

# Chemin vers le logo principal
logo <- image_read("Images/Black_Phoenix_Data_Analysis_Logo.jpg")

# Redimensionner le logo (par exemple, à 100 pixels de largeur)
logo_small <- image_resize(logo, "100x100")

# Sauvegarder l'image redimensionnée
image_write(logo_small, "Documents/Templates/Black_Phoenix_Data_Analysis_Logo_small.png")

cat("Logo redimensionné et enregistré en tant que 'Black_Phoenix_Data_Analysis_Logo_small.png'")
