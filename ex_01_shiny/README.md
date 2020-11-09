## README

#### ENUNCIADO
Vamos a realizar una aplicación que permita la visualización del dataset mpg. El usuario podrá elegir un par de variables para analizar su relación bivariada (diagrama de dispersión y correlación de Pearson) y sus distribuciones univariadas (histograma y summary). Además, existirá un campo numérico que permita al usuario seleccionar una submuestra aleatoria del dataset.

Realizar una aplicación shiny que usa sidebarLayout en la que aparezca:

- Dos selectores que permitan elegir cada uno una variable del dataset mpg (ver ayuda de mpg para saber qué variables contiene).
	- Estos selectores deben mostrar al usuario un nombre de variable inteligible que describa la variable y no el nombre de la variable del dataset pero internamente su valor sí debe ser el nombre de la variable.

	Por ejemplo “cyl” no debería mostrarse al usuario sino “number of cylinders” o “número de cilindros”. Pero “cyl” si debería ser el valor del input para luego utilizarlo en los outputs correctamente.

- Campo numérico para elegir el tamaño de la submuestra a realizar. Su mínimo es 2 y su valor máximo es el número de registros del dataset. El valor por defecto debe ser 10.
- Un botón para accionar el análisis y que los resultados se actualicen

La aplicación tiene como objetivo:

- Realizar una muestra con la función “sample” de R sobre mpg. Es decir, no vamos a coger todos los registros sino una submuestra de ellos de tamaño elegido por el usuario (campo numérico)

- Esta muestra será analizada de varias maneras:
	- Dos histogramas (función hist) y dos summarys de cada variable por separado

	- Un diagrama de dispersión (con ggplot) con las dos variables, en el eje X e Y (indistintamente)

	- Mostrar la correlación de pearson entre ambas variables (función cor)

- Dado que los análisis requieren variables numéricas eliminaremos de las opciones para elegir las variables del dataset que no son numéricas como manufacturer.

Tened en cuenta que:

- Sólo el botón actualiza los cálculos, ninguna otra interacción debe activar la actualización
- Todos los análisis (distribuciones, summary, correlación, etc) deben realizarse exactamente con la misma muestra. Es decir, todos los outputs deben tomar la misma fuente para que todos los cálculos sean consistentes.

Recordar que al hacer un sample el proceso es aleatorio, es decir, cada muestra será distinta cada vez que la calculemos y por ello debemos garantizar la consistencia entre todos los cálculos.

#### ESTRUCTURA

- _README.md_ <- The top-level README for developers.

- _APP_ <- ui.R & server.R 