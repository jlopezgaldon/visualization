# -----------------------------------------------------------------------------
# Ejercicio 1 de Shiny
# LÓPEZ GALDÓN, JOSE
# -----------------------------------------------------------------------------
# ui.R

# LIBRERÍAS                                                                ----

library(shiny) # Para shiny
library(ggplot2) # Para gráficos y la base de datos mpg
library(dplyr) # Para la selección de variables numéricas

# BASE DE DATOS                                                            ----

    # Cargamos la base de datos
data("mpg")

    # Cambiamos el nombre a la base de datos para trabar más cómodamente
datos <- mpg

    # Comprobamos las variables de la base de datos
names(datos)

    # Vemos de qué tipo es cada variable
str(datos)
        # Como podemos observar las variables "manufacturer" y "model" no son variables numéricas, por lo que las eliminaremos:
datosNum <- select_if(datos, is.numeric)

    # Veamos los nombres de las variables numéricas:
names(datosNum)

    # Para trabajar con las variables reaizaremos un attach
attach(datosNum)

    # Tamaño del dataset
nrow(datosNum)

# SHINY                                                                    ----

shinyUI(
    fluidPage(
        sidebarLayout(
            sidebarPanel(
                # Comenzamos definiendo el primero de nuestros selectores
                selectInput(
                    inputId = "selectX", 
                    
                    label = h4("Selecciona la variable X"), 
                    
                    # Queremos que nuestras opciones sean las variables numéricas y tengan otro nombre
                    choices = list(
                        "Centímetros cúbicos del motor" = "displ",
                        "Año de construcción" = "year",
                        "Número de cilindros" = "cyl",
                        "Consumo en ciudad" = "cty",
                        "Consumo en carretera" = "hwy"),
                    
                    # Valor por defecto: cc del motor
                    selected = "displ"
                ),
                # Continuamos definiendo el segundo selector, como vemos es muy similar al primero
                selectInput(
                    inputId = "selectY", 
                    
                    label = h4("Selecciona la variable Y"), 
                    
                    choices = list(
                        "Centímetros cúbicos del motor" = "displ",
                        "Año de construcción" = "year",
                        "Número de cilindros" = "cyl",
                        "Consumo en ciudad" = "cty",
                        "Consumo en carretera" = "hwy"),
                    
                    # Valor por defecto: año
                    selected = "year"
                ),
                # Definimos el tamaño de la muestra
                numericInput(
                    inputId = "size", 
                    
                    label = h4("Selecciona el tamaño muestral"),
                    
                    # Establecemos el valor mínimo en 2
                    min = "2", 
                    
                    # Establecemos el valor máximo en el número de observaciones
                    max = nrow(datosNum),
                    
                    # El valor por defecto será 10
                    value = 10
                ),
                # Botón para actualizar
                actionButton(
                    inputId = "update", 
                    label = "Actualizar"
                )
                
            ),
            mainPanel(
                # Histograma de la variable X
                plotOutput("histX"),
                
                # Summary de la variable X
                verbatimTextOutput("summaryX"),
                
                # Histograma de la variable Y
                plotOutput("histY"),
                
                # Summary de la variable Y
                verbatimTextOutput("summaryY"),
                
                # Diagrama de dispersión
                plotOutput("scatterPlot"),
                
                # Correlaciones
                verbatimTextOutput("corr")
                
            )
        )
    )
)
