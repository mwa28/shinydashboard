library(tidyverse)
library(shinydashboard)
library(shiny)
library(plotly)
library(lubridate)
library(scales)

df <- read_delim('bdd.csv', delim = ';')