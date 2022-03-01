
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
