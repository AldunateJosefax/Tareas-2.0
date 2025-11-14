# Perritos del Norte

*Noviembre 13, 2025*

En el norte de Chile, los perritos son parte del alma de cada ciudad. Desde las playas de Arica hasta las calles soleadas de Antofagasta, es común verlos acompañando a la gente, durmiendo bajo una sombra o moviendo la cola en las ferias. Sin embargo, las condiciones extremas de nuestro característico norte, como el sol implacable, el desierto infinito y las largas distancias hacen que la vida para muchos de ellos no sea fácil, pero también revelan el enorme cariño y compromiso de las comunidades locales para sus cuidados.

Con ello, el mejor amigo de las personas, no siempre ha sido el que más ayuda necesita, sino que por mucho tiempo ha sido elegidos aquellos que vienen desde negocios de explotación y compra venta, lo cual ha significado aumentos de la población significativos y maltrato animal. Pero esto a lo largo de los años ha cambiado, o eso es lo que espero yo, ya que se ha dado a conocer las condiciones de muchos criaderos y se ha destacado la importancia y lo bonito que significa acoger a un animal que lo necesita, y que ha vivido en condiciones deplorables como puede ser la calle.

Es por ello, que en base a mi conocimiento del tema (muy poco), quise saber si es tan real como aparentan mis redes sociales, acerca de que la adopción ha sido uno de los métodos de obtención más común en la actualidad y que la compra ya es nula, así evidenciaré si me encuentro en mi burbuja de buenas personas o es la realidad del país. De esta forma, el norte ha sido la zona escogida, debido a que a lo largo de los años, los perros callejeros han sido un tema en discusión.

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

Link para acceder al sitio web–> https://proactiva.subdere.gov.cl/handle/123456789/644

Link de la base de datos -> https://proactiva.subdere.gov.cl/bitstream/handle/123456789/644/RNMAC%20al%2030-09-2025%20%281%29.xlsx?sequence=43&isAllowed=y

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

![](images/clipboard-4265337782.png)

Es así, como podemos mirar un maravilloso gráfico lleno de color, que nos afirma que los perritos regalados suelen ser el modo de obtención más común, lo cual es bastante curioso porque este pudo haber sido comprado de igual manera. Lo que si de alguna u otra manera podemos decir que en la mayoría de las regiones la adopción está por sobre la compra de perros, lo cual es muy positivo.

¡Digamos NO a la compra y venta de animales!
