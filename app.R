# s
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
# Open the data for Marseille
Marseille_carreaux = read.csv('marseille_carreaux.csv')

# Define UI for application that draws
ui <- fluidPage(
    leafletOutput("mymap"))

# Define server logic required to draw
server <- function(input, output) 
    {
    # On créee notre palette de couleurs bleues
    pal <- colorNumeric(
        palette = "viridis",
        domain = Marseille_carreaux$Revenue_personne)
    
    leaflet(data=Marseille_carreaux) %>%
        addTiles() %>%
        addCircleMarkers(lng=~lon,lat=~lat,color=~pal(Revenue_personne)) %>%
        addRectangles(
            lng1=5.3, lat1=43.20,
            lng2=5.45, lat2=43.4,
            fillColor = "transparent") %>%
        addLegend("bottomright", pal = pal, values = ~Marseille_carreaux$Revenue_personne,
                  title = "Revenue par Personne € (2010)",
                  opacity = 1)
    
    output$mymap <- renderLeaflet({
        leaflet(data=Marseille_carreaux) %>%
            addTiles() %>%
            addCircleMarkers(lng=~lon,lat=~lat,color=~pal(Revenue_personne)) %>%
            addRectangles(
                lng1=5.3, lat1=43.20,
                lng2=5.45, lat2=43.4,
                fillColor = "transparent") %>%
            addLegend("bottomright", pal = pal, values = ~Marseille_carreaux$Revenue_personne,
                      title = "Revenue_personne € (2010)",
                      opacity = 5)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
