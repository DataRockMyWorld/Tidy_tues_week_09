
# Name : Jewel Bansah ----
# Title: Alternative Fuel Stations in the US
# Date : 01/03/2022

## Setting Up working Environment ----
library(tidytuesdayR)
library(tidyverse)
library(skimr)


## Importing the Data ----

tidytue <- tt_load("2022-03-01")

stations <- tidytue$stations
stations

## Exploring & Cleaning the Data ----
skim(stations)

# From skimming through, the logical variables have all their rows missing hence/n
# we can take them out

stations1 <- stations %>% select_if(~!is.logical(.))

unique(stations1$FUEL_TYPE_CODE)
