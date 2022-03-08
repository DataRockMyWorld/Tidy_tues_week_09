
# Name : Jewel Bansah ----
# Title: Alternative Fuel Stations in the US
# Date : 01/03/2022

## Setting Up working Environment ----
library(tidytuesdayR)
library(tidyverse)
library(sf)
install.packages("tigris")
library(tigris)


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
                                 ZIP,LONGITUDE,LATITUDE)

#states to exclude
excluded_states <- c("AK","VI","AS","GU","MP","PR","HI")

# Load states shapefile
states_shp <- tigris::states() %>% 
  st_transform(crs = 5070) %>% 
  filter(!STUSPS %in% excluded_states)

# stations dataset
station_sf <- station2 %>% filter(!STATE %in% excluded_states) %>% 
  st_as_sf(coords = c("LONGITUDE","LATITUDE"), crs = 4326) %>% 
  st_transform(crs = 5070) %>% 
  st_crop(states_shp)
  

# Plot

ggplot() +
  geom_sf(data = states, fill= "#474649", color = "#bde162") +
  geom_sf(data = station_sf, aes(color = FUEL_TYPE_CODE), size = .5) +
  coord_sf() +
  labs(title = "West Coast Embracing Alternative fuel than the East ?",
       subtitle = "Alternative Fuel Stations in the US",
       caption = "Data from tidytuesday | map by jewel",
       x = NULL,
       y = NULL) +
  scale_color_viridis_d() +

theme(plot.background = element_rect(fill = "#bee0ec"),
      plot.title = element_text(colour = "black", size = 15, face = "bold"),
      plot.title.position = "plot",
      plot.subtitle = element_text(size = 12, face = "bold.italic"),
      plot.caption = element_text(colour = "black", face = "bold"),
      plot.margin = margin(1,.5,.5,.5, unit = "cm"),
      panel.background = element_rect(fill = "#bee0ec"),
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      panel.grid = element_blank(),
      legend.position = "top",
      legend.box = "horizontal",
      legend.title = element_blank(),
      legend.box.background = element_rect(fill = "#bee0ec"),
      legend.background = element_rect(fill = "#bee0ec")
      ) 
 


  




