install.packages("tidyverse")
install.packages("osmdata")
install.packages("showtext")
install.packages("rvest")
install.packages("ggmap")
install.packages("sf")

library(tidyverse)
library(osmdata) # package for working with streets
library(showtext) # for custom fonts
library(ggmap)
library(rvest)
library(sf)

getbb("Chicago Illinois")
getbb("Washington DC")
getbb("New York City")

#        min       max
#x -87.94009 -87.52408
#y  41.64453  42.02304

#View(big_streets[["osm_lines"]])

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

chicago_big_streets <- getbb("Chicago Illinois") %>%
  opq() %>%
  add_osm_feature(key = "highway",
                  value = c("motorway", "primary", "motorway_link", "primary_link")) %>%
  osmdata_sf()

#### #### #### #### #### #### #### ####

new_york_city_big_streets <- getbb("New York City") %>%
  opq() %>%
  add_osm_feature(key = "highway",
                  value = c("motorway", "primary", "motorway_link", "primary_link")) %>%
  osmdata_sf()

#### #### #### #### #### #### #### ####

washington_big_streets <- getbb("Washington DC") %>%
  opq() %>%
  add_osm_feature(key = "highway",
                  value = c("motorway", "primary", "motorway_link", "primary_link")) %>%
  osmdata_sf()

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 


chicago_med_streets <- getbb("Chicago Illinois") %>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("secondary", "tertiary", "secondary_link", "tertiary_link")) %>%
  osmdata_sf()

#### #### #### #### #### #### #### ####

new_york_city_med_streets <- getbb("New York City") %>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("secondary", "tertiary", "secondary_link", "tertiary_link")) %>%
  osmdata_sf()

#### #### #### #### #### #### #### ####

washington_med_streets <- getbb("Washington DC") %>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("secondary", "tertiary", "secondary_link", "tertiary_link")) %>%
  osmdata_sf()

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 



chicago_river <- getbb("Chicago Illinois") %>%
  opq()%>%
  add_osm_feature(key = "waterway", value = "river") %>%
  osmdata_sf()

#### #### #### #### #### #### #### ####

new_york_city_river <- getbb("New York City") %>%
  opq()%>%
  add_osm_feature(key = "waterway", value = "river") %>%
  osmdata_sf()

#### #### #### #### #### #### #### ####

washington_river <- getbb("Washington DC") %>%
  opq()%>%
  add_osm_feature(key = "waterway", value = "river") %>%
  osmdata_sf()

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

chicago_railway <- getbb("Chicago Illinois") %>%
  opq()%>%
  add_osm_feature(key = "railway", value="rail") %>%
  osmdata_sf()

#### #### #### #### #### #### #### ####

new_york_city_railway <- getbb("New York City") %>%
  opq()%>%
  add_osm_feature(key = "railway", value="rail") %>%
  osmdata_sf()

#### #### #### #### #### #### #### ####

washington_railway <- getbb("Washington DC") %>%
  opq()%>%
  add_osm_feature(key = "railway", value="rail") %>%
  osmdata_sf()


#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 


small_streets <- getbb("Chicago Illinois") %>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("residential", "living_street",
                            "unclassified",
                            "service", "footway"
                  )) %>%
  osmdata_sf()

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

font_add_google(name = "Lato", family = "lato") # add custom fonts
showtext_auto()

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

ggplot() +
  geom_sf(data = river$osm_lines,
          inherit.aes = FALSE,
          color = "steelblue",
          size = .8,
          alpha = .3)

#### #### #### #### #### #### #### ####

ggplot() +
  geom_sf(data = river$osm_lines,
          inherit.aes = FALSE,
          color = "steelblue",
          size = .8,
          alpha = .3) +
  geom_sf(data = railway$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .2,
          linetype="dotdash",
          alpha = .5) +
  geom_sf(data = med_streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .3,
          alpha = .5) +
  geom_sf(data = big_streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .5,
          alpha = .6) +
  geom_sf(data = wood_street, # Add Blue Ridge street 
          inherit.aes = FALSE,
          color = "orange",
          size = 1,
          alpha = 1) +
  coord_sf(xlim = c(-87.94009, -87.52408), 
           ylim = c(41.64453,  42.02304)) +
  #theme_void() + # get rid of background color, grid lines, etc.
  #theme(plot.title = element_text(size = 20, family = "lato", face="bold", hjust=.5),
  #      plot.subtitle = element_text(family = "lato", size = 8, hjust=.5, margin=margin(2, 0, 5, 0))) +
  labs(title = "Chicago", subtitle = "41.8781°N / 87.6298°W")


#### 


wood_street <- med_streets[["osm_lines"]] %>% 
  filter(name=="Wood St")

#geom_sf(data = small_streets$osm_lines,
#inherit.aes = FALSE,
#color = "#666666",
#size = .2,
#alpha = .3) #+


#### 

chicago_med_streets_list <- as.data.frame(chicago_med_streets[["osm_lines"]])

save(chicago_med_streets_list, file = "chicago_med_streets_list_export.RData")

write.csv(chicago_med_streets_list, file ="chicago_med_streets_list_export.csv", row.names = FALSE) 

#### 

View(chicago_med_streets[["osm_lines"]])


rm(wood_street)

wood_street <- med_streets[["osm_lines"]] %>%
  filter(name == "North Wood Street" | name == "South Wood Street")
