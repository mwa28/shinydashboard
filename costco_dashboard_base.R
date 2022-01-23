library(tidyverse)
library(shinydashboard)
library(shiny)
library(plotly)
library(lubridate)

df <- read_delim('bdd.csv', delim = ';')