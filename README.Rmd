# Perritos del Norte

*Noviembre 13, 2025*

En el norte de Chile, los perritos son parte del alma de cada ciudad. Desde las playas de Arica hasta las calles soleadas de Antofagasta, es común verlos acompañando a la gente, durmiendo bajo una sombra o moviendo la cola en las ferias. Las condiciones extremas —el sol implacable, el desierto infinito y las largas distancias— hacen que la vida para muchos de ellos no sea fácil, pero también revelan el enorme cariño y compromiso de las comunidades locales.

### **En primer lugar,** es importante cargar todas los paquetes que utilizaremos a lo largo del trabajo.

```{r}
install.packages("tidyverse")

install.packages("readxl")

install.packages("dplyr")
```

Ahora haremos llamado a sus librerias correspondientes

```{r}
library(tidyverse)
library(readxl)
library(dplyr)
library(ggplot2)
```

Una vez cargadas las libererias, llamaremos a nuestra base de datos, que fue descargada del Informe final: Estimación de la población canina y felina del país y diagnóstico de la tenencia responsable, de SUBDERE.

```{r}
datos <- read_xlsx("RNMAC al 30-09-2025 (1).xlsx")
```

Ahora veamos como es la base de datos `view(datos)` y podemos aprovechar de ver que variables tiene `colnames(datos)`

Es importante tener en consideración que al ser una base tan pesada en excel, debemos darle la indicación a R y Github que esta no será incluida en el repositorio - esta fue una de las cosas más complejas, ya que no sabía que era posible.

Ahora limpiaremos la base con las categorías que nos interesan, ya que hay muchas y nosotros en verdad sólo queremos saber que tanto adoptan jajaja, por lo que nos enfocaremos en Región y el Modo de obtención.

```{r}
datos_filtrados <- datos %>% 
  group_by(Región, `Modo de obtención`) |> 
  summarise(n = n()) |> 
  group_by(Región) |> 
  mutate(porcentaje = n / sum(n) * 100)
```

Ahora si queremos ver si funciono lo hacemos con `view(datos_filtrados)`

Para luego finalmente crear nuestro gráfico para realizar la comparativa con todos los modos de obtención, buscaremos que sea colorido para poder diferenciar mejor los tipos de obtención, y en porcentaje para comparar de manera más sencilla cual es el modo de obtención más común en cada región.

```{r}
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
```

Contemplemos el gráfico...

![]()

Es así, como podemos mirar un maravilloso gráfico lleno de color, que nos afirma que los perritos regalos suelen ser el modo de obtención más común, lo cual es bastante curioso porque este pudo haber sido comprado de igual manera. Lo que si de alguna u otra manera podemos decir que en la mayoría de las regiones la adopción está por sobre la compra de perro, lo cual es muy positivo.

¡No a la compra y venta de animales!
