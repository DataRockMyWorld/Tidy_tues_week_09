
# Name : Jewel Bansah ----
# Title: Alternative Fuel Stations in the US
# Date : 01/03/2022

## Setting Up working Environment ----
library(tidytuesdayR)
library(tidyverse)
library(sf)
library(tigris)
library(MetBrewer)
library(showtext)

## Fonts

font_add_google("Oxygen","Oxygen")
font_add_google("Playfair Display","Playfair Display")
font_add_google("Monoton","Monoton")
font_add_google("Amaranth","Amaranth")

showtext_auto()

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

## Carbon_based fuels

station_sf %>% distinct(FUEL_TYPE_CODE)

carbon_based <- c("CNG","LPG","LNG","BD","E85")

station_df <- station_sf %>%
  mutate(fuel_cat = case_when(
    FUEL_TYPE_CODE %in% carbon_based ~ "HC_Based",
    FUEL_TYPE_CODE == "HY" ~ "Hydrogen",
    FUEL_TYPE_CODE == "ELEC" ~ "Electricity",
    TRUE ~ as.character(FUEL_TYPE_CODE)
  ))

station_df

  
# Plot

ggplot() +
  geom_sf(data = states_shp, fill= "#474649", color = "#bde162") +
  geom_sf(data = station_df, aes(color = fuel_cat), size = .5) +
  coord_sf() +
  labs(title = "West Coast Embracing Alternative fuel than the East ?",
       subtitle = "Alternative Fuel Stations in the US",
       caption = "Data from tidytuesday | map by jewel",
       x = NULL,
       y = NULL) +
  scale_colour_brewer(palette = "Set1") +

theme(plot.background = element_rect(fill = "#bee0ec"),
      plot.title = element_text(colour = "black", size = 15, face = "bold",family = "Amaranth"),
      plot.title.position = "plot",
      plot.subtitle = element_text(size = 12, face = "bold.italic"),
      plot.caption = element_text(colour = "black", face = "bold"),
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
 


  
?MetBrewer::colorblind_palettes



