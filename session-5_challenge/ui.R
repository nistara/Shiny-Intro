library(shiny)
library(plotly)


ui <- fluidPage(

  fluidRow(
    titlePanel(
      h1("Penguin Sizes", align = "center")
    ),

    HTML('<center><figure><img src="https://allisonhorst.github.io/palmerpenguins/reference/figures/lter_penguins.png" style="height:200px;"><figcaption>Artwork by @allison_horst</figcaption></figure></center>')
  ),

  HTML("<br>"),

  fluidRow(
    column(3),
    column(6,
    # Insert UI Components here #
      plotlyOutput("penguins")
    )
  )
)


# References
# ==============================================================================
# https://www.w3schools.com/tags/tag_figcaption.asp
# https://allisonhorst.github.io/palmerpenguins/
# https://plotly.com/r/reference/layout/
