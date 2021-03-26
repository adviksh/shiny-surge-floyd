# Libraries ---------------------------------------------------------------
library(here)
library(readr)
library(glue)
library(stringr)
library(lubridate)
library(tibble)
library(dplyr)
library(tidyr)
library(ggplot2)
library(sf)
library(shiny)


# Helpers -----------------------------------------------------------------
date_to_int = function(x) { as.integer(str_remove_all(x, '-')) }



# Shapefiles --------------------------------------------------------------
states   = readRDS(here('data', 'states.rds'))
counties = readRDS(here('data', 'counties.rds'))


# Device Surge ------------------------------------------------------------
surge = readRDS(here('data', 'device_surge.rds'))
