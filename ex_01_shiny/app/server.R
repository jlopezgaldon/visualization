# -----------------------------------------------------------------------------
# Ejercicio 1 de Shiny
# LÓPEZ GALDÓN, JOSE
# -----------------------------------------------------------------------------
# server.R

# LIBRERÍAS                                                                ----

library(shiny) # Para shiny
library(ggplot2) # Para gráficos y la base de datos mpg
library(dplyr) # Para la selección de variables numéricas

# BASE DE DATOS                                                            ----

# Cargamos la base de datos
data("mpg")

# Cambiamos el nombre a la base de datos para trabar más cómodamente
datos <- mpg

# Seleccionamos las variables numéricas
datosNum <- select_if(datos, is.numeric)

# Para trabajar con las variables reaizaremos un attach
attach(datosNum)

# SHINY                                                                    ----

shinyServer(function(input, output) {

# -----------------------------------------------------------------------------
# Muestra                                                                  ----
    
    muestra <- reactive({
        
        # Botón
        input$update
        
        isolate(sample_n(datosNum, size = input$size))
        
    })

# -----------------------------------------------------------------------------
# Variable X                                                               ----
    
    # Histograma para la primera variable
    output$histX <- renderPlot({
        
        # Ailsamos el siguiente input
        X <- isolate(input$selectX)
        
        # Realizamos el histograma con ggplot, como se trata de una variable programática usamos aes_String()
        ggplot(data = muestra(), aes_string(x = X)) +
            geom_histogram(color = "deepskyblue4",                # color para cambiar el borde,
                           fill = "lightskyblue") +               # fill para el relleno
            ggtitle("Histograma variable X") +                    # título del histograma
            ylab("Frecuencia")                                    # título del eje Y
    })
    
    # Summary para la primera variable
    output$summaryX <- renderPrint({
        
        # Ailsamos el siguiente input
        X <- isolate(input$selectX)
        
        # Al tratarse de una variable prográmtica tenemos que utilizar la siguiente sintáxis data[[variable]]
        summary(muestra()[[X]])
    })

# -----------------------------------------------------------------------------
# Variable Y                                                               ----
    
    # Histograma para la segunda variable
    output$histY <- renderPlot({
        
        # Ailsamos el siguiente input
        Y <- isolate(input$selectY)
        
        # Realizamos el histograma con ggplot, como se trata de una variable programática usamos aes_String()
        ggplot(data = muestra(), aes_string(x = Y)) +
            geom_histogram(color = "tomato4",                     # color para cambiar el borde,
                           fill = "tomato") +                     # fill para el relleno
            ggtitle("Histograma variable Y") +                    # título del histograma
            ylab("Frecuencia")                                    # título del eje Y
    })
    
    # Summary para la primera variable
    output$summaryY <- renderPrint({
        
        # Ailsamos el siguiente input
        Y <- isolate(input$selectY)
        
        # Al tratarse de una variable prográmtica tenemos que utilizar la siguiente sintáxis data[[variable]]
        summary(muestra()[[Y]])
    })
    
# -----------------------------------------------------------------------------
# Diagrama de dispersión                                                   ----
    
    output$scatterPlot <- renderPlot({
        
        # Ailsamos los siguientes inputs
        X <- isolate(input$selectX)
        Y <- isolate(input$selectY)
        
        # Seguimos utilizando ggplot() y aes_string()
        ggplot(data = muestra(), aes_string(x = X, y = Y)) +      # En esta ocasión, también tenemos variable Y
            geom_point(color = "seagreen3",                       # Seleccionamos el color
                       size = 4)                                  # Seleccionamos el tamaño del punto
    })
    
# -----------------------------------------------------------------------------
# Correlaciones                                                            ----
    
    output$corr <- renderText({
        
        # Ailsamos los siguientes inputs
        X <- isolate(input$selectX)
        Y <- isolate(input$selectY)
        
        # Utilizamos la función paste0() para incluir un texto antes de la función, en este caso la correlación
        paste0("La correlación es ", cor(muestra()[[X]], muestra()[[Y]]))
        
    })
    
})


