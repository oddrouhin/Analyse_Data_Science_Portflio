library(ggplot2)

theme_black_phoenix <- function() {
  theme_minimal() +
    theme(
      plot.title = element_text(color = "#607d8b", size = 14, face = "bold", hjust = 0.5),
      axis.title = element_text(color = "#333333", size = 12, face = "bold"),
      axis.text = element_text(color = "#333333"),
      legend.title = element_text(color = "#607d8b", face = "bold"),
      legend.text = element_text(color = "#333333")
    )
}
