
library(shiny)
library(leaflet)
library(RColorBrewer)
library(spData)
library(sf)
library(dplyr)


# Load data
# ------------------------------------------------------------------------------
data("world")
df = world[ world$name_long != "Antarctica", ]


# Input info
# ------------------------------------------------------------------------------
data_type = c("area_km2", "pop", "lifeExp", "gdpPercap")
data_label = c("Area (km)", "Population",
  "Life expectancy", "GPD")
data_df = data.frame(data_label, data_type)

continents = unique(df$continent)


# Map bounds, excluding Antarctica
# ------------------------------------------------------------------------------
bounds = df %>% 
  st_bbox() %>% 
  as.character()



