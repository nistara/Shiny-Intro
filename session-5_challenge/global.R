library(shiny)
library(plotly)
library(palmerpenguins)
library("RColorBrewer")


data(package = 'palmerpenguins')
pal = rev(brewer.pal(3, "Set1"))

fig = plot_ly(data = penguins,
  x = ~flipper_length_mm,
  y = ~body_mass_g,
  color = ~species,
  colors = pal,
  text = ~paste0("<br>",
    "<b>", species, " penguin</b>\n",
    "<br>",
    "Flipper length: ", flipper_length_mm, " mm \n",
    "Body mass: ", body_mass_g, " g")
)

fig = fig |>
  layout(title = "Body mass against flipper length for Adelie, Chinstrap, and Gentoo penguins",
    xaxis = list(title = "Body mass (g)"),
    yaxis = list(title = "Flipper length (mm)")
  )
    
