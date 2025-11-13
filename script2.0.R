install.packages("tidyverse")

install.packages("readxl")

install.packages("dplyr")

install.packages("httr")

install.packages("jsonlite")

install.packages("sf")

install.packages("chilemapas")

library(tidyverse)
library(readxl)
library(dplyr)
library(ggplot2)
library(httr)
library(jsonlite)
library(sf)
library(chilemapas)
library(ggplot2)


datos <- read_xlsx("RNMAC al 30-09-2025 (1).xlsx")

view(datos)
colnames(datos)

#usar janittor para limpiar 

datos_filtrados <- datos %>% 
  group_by(Región, `Modo de obtención`) |> 
  summarise(n = n())
  

view(datos_filtrados)

ggplot(datos_filtrados, aes(x = reorder(Región, n), y = n, fill = `Modo de obtención`)) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Modo de obtención de perros por región - Chile (2025)",
    x = "Región",
    y = "Cantidad de registros",
    fill = "Modo de obtención"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.text.y = element_text(size = 10)
  )


ggplot(datos_filtrados, aes(x = `Modo de obtención`, y = n, fill = `Modo de obtención`)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ Región) +
  labs(
    title = "Perros del Norte - ¿Como llegan?",
    x = "Modo de obtención",
    y = NULL
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    strip.text = element_text(size = 9),
    axis.text.y = element_blank(),       # 🔹 elimina los números del eje Y
    axis.ticks.y = element_blank(),      # 🔹 elimina las marcas del eje Y
    axis.text.x = element_text(angle = 45, hjust = 1)  # 🔹 gira las etiquetas para que no se monten
  )


