
library(shiny)
library(leaflet)
library(RColorBrewer)
library(spData)
library(sf)
library(dplyr)

shinyServer(function(input, output) {
  
  data_label = reactive({
    input$data_select
  })
  
  data_type = reactive({
    print(data_df$data_type[ data_df$data_label %in% input$data_select ])
    data_df$data_type[ data_df$data_label %in% input$data_select ]
  })


  data_continent = reactive({
    if("All" %in% input$continent) {
      continents
    } else {
      input$continent
    }
  })


  filteredDF = reactive({
    df[ df$continent %in% data_continent(),  c("continent", "name_long", data_type())]
  })

  # browser()
  colorpal = reactive({
    palette(colorNumeric(brewer.pal(8, "YlOrBr"), filteredDF()[[ data_type() ]]))
  })

  colorpal = reactive({
    colorNumeric("YlOrBr", filteredDF()[[ data_type() ]])
  })

  
  output$map = renderLeaflet({
    
    leaflet(df) |>
      fitBounds(bounds[1], bounds[2], bounds[3], bounds[4]) |>
      addProviderTiles("CartoDB.Positron") |>
      addPolygons(weight = 1)
    
  })
  
  observe({
    pal = colorpal()
    
    proxy = leafletProxy("map", data = filteredDF())
    
    # Modify the leaflet proxy here
    proxy %>%
      clearShapes() |>
      addPolygons(weight = 1,
        color = "grey",
        popup = paste0("Country: ", filteredDF()[[ "name_long" ]], "<br>",
          "Continent: ", filteredDF()[[ "continent" ]], "<br>",
          data_label(), ": ", filteredDF()[[ data_type() ]]),
        fillColor = ~pal(filteredDF()[[ data_type() ]])
      )
    
  })
  
})
