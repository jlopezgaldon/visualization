# -----------------------------------------------------------------------------
# Ejercicio 1 de Shiny
# LÓPEZ GALDÓN, JOSE
# -----------------------------------------------------------------------------

# LIBRERÍAS 
library(shiny)
library(ggplot2)

# ui...
ui <- fluidPage(
    titlePanel("Ejercicio 2 de Shiny. Jose López Galdón"),  # Ponemos un título a nuestro shiny
        mainPanel(
            plotOutput("plot",                              # Generamos un plot donde tendremos nuestros gráfico de puntos
                       hover = "calamar"),                  # "hover" para indicar que el ratón pasa por encima
            dataTableOutput("coordenadasCercanas")          # una tabla con las coordenadas más cercanas
            )
    )

# server...
server <- function(input, output) {
    
    # Comenzamos definiendo el dataset, como una distancia de 5 pixeles es muy poco generamos más de 30 obs
    
    dataset <- reactiveVal({
        
        data.frame(x = rnorm(100), y = rnorm(100))
    })
    
    # Generemos la gráfica con ggplot
    
    output$plot <- renderPlot({
        
        ggplot(data = dataset(), aes(x = x, y = y)) +
            geom_point(col = "dodgerblue4")
        
    })
    
    # Generamos el dataset con los dos puntos más cercanos a una distancia de 5
    
    output$coordenadasCercanas <- renderDataTable({
        
        nearPoints(df = dataset(),                  # dataframe utilizado
                   coordinfo = input$calamar,       # input utilizado, recordemos que hemos llamado "calamar" al hover
                   maxpoints = 2,                   # número máximo de puntos que queremos visualizar
                   threshold = 5)                   # distancia maxima en pixeles 
         
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
