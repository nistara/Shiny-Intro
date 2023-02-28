
library(shiny)
library(leaflet)


shinyUI(
  
  bootstrapPage(
    tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
    leafletOutput("map", width = "100%", height = "100%"),    
    
    absolutePanel(top = 10, right = 10,
      wellPanel(

        h2("Select Data"),
        
        selectInput("data_select", label = h3("Data type"), 
          choices = data_df$data_label,
          selected = data_df$data_label[ 1 ]
        ),
        
        checkboxGroupInput("continent", label = h3("Continent"), 
          choices = c("All", continents),
          selected = "All"
        )
      )
    )
  )
)
