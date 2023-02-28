
library(shiny)
library(leaflet)
library(RColorBrewer)
library(spData)
library(sf)
library(dplyr)

shinyServer(function(input, output) {

  # Get entered data label/choice (corresponds to data type)
  data_label = reactive({
    input$data_select
  })

  # Get associated data type from label/choice
  data_type = reactive({
    print(data_df$data_type[ data_df$data_label %in% input$data_select ])
    data_df$data_type[ data_df$data_label %in% input$data_select ]
  })


  # Get selected continent(s)
  data_continent = reactive({
    if("All" %in% input$continent) {
      continents
    } else {
      input$continent
    }
  })


  # Filter map data for mapping
  filteredDF = reactive({
    df[ df$continent %in% data_continent(),  c("continent", "name_long", data_type())]
  })


  # Assign color palette for chosen data type
  colorpal = reactive({
    colorNumeric("YlOrBr", filteredDF()[[ data_type() ]])
  })


  # Laeflat map, basic version without polygons
  output$map = renderLeaflet({
    
    leaflet(df) |>
      fitBounds(bounds[1], bounds[2], bounds[3], bounds[4]) |>
      addProviderTiles("CartoDB.Positron") |>
      addPolygons(weight = 1)
    
  })

  # Add mapping info based on observed selections
  observe({
    # Get new color palette
    pal = colorpal()
    data_values = filteredDF()[[ data_type() ]]

    # Create leaflet proxy
    proxy = leafletProxy("map", data = filteredDF())
    
    # Modify the leaflet proxy based on observed selections
    proxy %>%
      clearShapes() |> # removes polygons
      clearControls() |> # removes the older legend
      addPolygons(weight = 1,
        color = "grey",
        popup = paste0("Country: ", filteredDF()[[ "name_long" ]], "<br>",
          "Continent: ", filteredDF()[[ "continent" ]], "<br>",
          data_label(), ": ", data_values),
        fillColor = ~pal(data_values)) |>
      addLegend(position = "bottomright", pal = pal, values = data_values, title = data_label())
    
  })
  
})


# References:
# ------------------------------------------------------------------------------
# https://stackoverflow.com/a/66830606/5443003
# https://rstudio.github.io/leaflet/shiny.html
# https://shiny.rstudio.com/gallery/widget-gallery.html
