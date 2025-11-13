install.packages("tidyverse")

install.packages("readxl")

install.packages("dplyr")


install.packages("jsonlite")




library(tidyverse)
library(readxl)
library(dplyr)
library(ggplot2)
library(jsonlite)


datos <- read_xlsx("RNMAC al 30-09-2025 (1).xlsx")

view(datos)
colnames(datos)


datos_filtrados <- datos %>% 
  group_by(Región, `Modo de obtención`) |> 
  summarise(n = n()) |> 
  group_by(Región) |> 
  mutate(porcentaje = n / sum(n) * 100)
  

view(datos_filtrados)

ggplot(datos_filtrados, aes(x = reorder(Región, porcentaje), y = porcentaje, 
                            fill = `Modo de obtención`)) +
  geom_col(position = "dodge2") +
  scale_y_continuous(labels = scales::percent_format(scale = 1),
                     limits = c(0, 100)) +
  coord_flip() +
  labs(
    title = "Perritos del Norte de Chile ¿Cómo llegan?",
    x = "Región",
    y = "Cantidad de registros",
    fill = "Modo de obtención"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.text.y = element_text(size = 10)
  )




