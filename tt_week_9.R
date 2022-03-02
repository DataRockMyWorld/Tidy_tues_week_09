
# Name : Jewel Bansah ----
# Title: Alternative Fuel Stations in the US
# Date : 01/03/2022

## Setting Up working Environment ----
library(tidytuesdayR)
library(tidyverse)
library(skimr)
library(gghighlight)


## Importing the Data ----

tidytue <- tt_load("2022-03-01")

stations <- tidytue$stations
stations

## Exploring & Cleaning the Data ----
skim(stations)

# From skimming through, the logical variables have all their rows missing hence/n
# we can take them out

stations1 <- stations %>% select_if(~!is.logical(.))

## selecting the columns that i need.

station2 <- stations1 %>% select(FUEL_TYPE_CODE,STATION_NAME,STREET_ADDRESS,
                                 CITY,STATE,CARDS_ACCEPTED,OWNER_TYPE_CODE,COUNTRY,
                                 LONGITUDE,LATITUDE)

# change names to lower
station2 %>% 
  ggplot(aes(LONGITUDE,LATITUDE))+
  geom_polygon()






stations1 %>% count(FUEL_TYPE_CODE)

