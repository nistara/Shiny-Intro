
library(shiny)
library(here)

# Prep data
# ------------------------------------------------------------------------------
hummer_images = list.files("www/hummingbirds")
hummer_images = file.path("hummingbirds", hummer_images)
hummer_labels = gsub(".jpeg", "", basename(hummer_images))
hummers = as.list(hummer_images)
names(hummers) = hummer_labels
hummers$none = NA


# UI
# ------------------------------------------------------------------------------
ui = fluidPage(
  fluidRow(
    column(4,
      selectInput("select",
        label = h3("Hummingbird species"), 
        choices = hummers,
        selected = "annas"),
      sliderInput("slider1", label = h3("Image size"), min = 1, 
        max = 1000, value = 150)
    ),
    
    column(6,
      br(),
      uiOutput("image")
    )
  ),
  
  hr(),

  fluidRow(column(4,
    verbatimTextOutput("value"),
    verbatimTextOutput("img_size")
  ))
)



