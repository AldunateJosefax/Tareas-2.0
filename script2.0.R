
install.packages("tidyverse")
install.packages("readxl")
install.packages("dplyr")
install.packages("jsonlite")
remotes::install_github("hadley/emo")

library(tidyverse)
library(readxl)
library(dplyr)
library(ggplot2)
library(jsonlite)
library(emo)

datos <- read_xlsx("data/RNMAC al 30-09-2025 (1).xlsx")

datos <- datos |> 
  janitor::clean_names()

colnames(datos)

datos |> 
  count(region)

datos_filtrados <- datos|> 
  group_by(region, modo_de_obtencion) |> 
  summarise(n = n()) |> 
  group_by(region) |> 
  mutate(porcentaje = n / sum(n) * 100)
  
colores_perritos <- c("#cd001a","#ef6a00","#f2cd00","#79c300","#1961ae","#61007d")

perrito <- emo::ji("dog")

ggplot(datos_filtrados,
       aes(
         x = reorder(region, porcentaje),
         y = porcentaje,
         fill = modo_de_obtencion
       )) +
  geom_col(position = "dodge2") +
  scale_y_continuous(labels = scales::percent_format(scale = 1),
                     limits = c(0, 100)) +
  scale_fill_manual(values = colores_perritos) +
  coord_flip() +
  labs(
    title = paste(
      emo::ji("dog"),
      "Perritos del Norte de Chile ¿Cómo llegan?",
      emo::ji("dog")
    ),
    x = "Región",
    y = "Cantidad de registros",
    fill = "Modo de obtención"
  )+
  theme_minimal() +
  theme(plot.title = element_text(size = 14, face = "bold"),
        axis.text.y = element_text(size = 10))

ggsave("plots/gráfico_revision.png", width = 8, height = 7)


