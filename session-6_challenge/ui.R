
library(shiny)
library(leaflet)


shinyUI(
  
  bootstrapPage(
    tags$style(type = "text/css", "html, body {width:100%;height:100%}"),

    # Leaflet map
    leafletOutput("map", width = "100%", height = "100%"),    
    
    absolutePanel(top = 10, right = 10,
      wellPanel(

        h2("Select Data"),

        # Choose data type to be mapped (choices set in global.R)
        selectInput("data_select", label = h3("Data type"), 
          choices = data_df$data_label,
          selected = data_df$data_label[ 1 ]
        ),

        # Choose continent (All option added in global.R)
        checkboxGroupInput("continent", label = h3("Continent"), 
          choices = c("All", continents),
          selected = "All"
        )
        
      )
    )
  )
)


# Notes from Nick
# ------------------------------------------------------------------------------
# To increase the width of the selectInput panel:
# selectInput("data_select", label = h3("Data type"), width = 300, choices = data_df$data_label)
# To increase width of wellPanel:
# wellPanel(style = "width: 300px;", ...)
