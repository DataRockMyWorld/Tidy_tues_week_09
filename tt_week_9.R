
# Name : Jewel Bansah ----
# Title: Alternative Fuel Stations in the US
# Date : 01/03/2022

## Setting Up working Environment ----
library(tidytuesdayR)
library(tidyverse)
library(skimr)
library(gghighlight)
library(usdata)

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



state_abb <- data.frame(STATE_NAME = state.name,STATE = state.abb)


station3 <- station2 %>% inner_join(state_abb,by = "STATE") %>% 
  mutate(region = tolower(STATE_NAME))



us_geo <- map_data("state")

station_final <- station3 %>% full_join(us_geo, by = "region")


# change names to lower
station_final %>% 
  ggplot(aes(long,lat, group = group))+
  geom_polygon()






stations1 %>% count(FUEL_TYPE_CODE)

