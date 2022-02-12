library(tidyverse)
library(shinydashboard)
library(shiny)
library(plotly)
library(lubridate)
library(scales)
library(rjson)


############################################################
#                                                          #
#   Fichier de base contenant la base des données          #
#   et les librairies                                      #  
#                                                          #
############################################################

df <- read_delim('bdd.csv', delim = ';')
country_codes <- read_delim('country_codes.csv', delim = ',')
europe <- rjson::fromJSON(file='europe.geojson')