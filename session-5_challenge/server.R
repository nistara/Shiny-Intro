
library(shiny)
library(plotly)


shinyServer(function(input, output) {
  # Insert plotly server code here #
  output$penguins = renderPlotly(fig)
  
})
