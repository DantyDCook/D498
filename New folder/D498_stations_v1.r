#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

library(stringr)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

setwd("D:/WGU/D498/D498/")
getwd()

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 


temp_location_scouting_df <- subset(bikeshare_main_df, select = c("location", "ride_id", "start.station", "end.station"))

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

temp_location_scouting_df[c("start.station.ns", "start.station.ew")] <- str_split_fixed(temp_location_scouting_df$start.station, '&', 2) 

#### #### #### #### #### #### #### #### 

temp_location_scouting_df[c("end.station.ns", "end.station.ew")] <- str_split_fixed(temp_location_scouting_df$end.station, '&', 2) 

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

location_scouting_df <- temp_location_scouting_df %>%
  pivot_longer(
    cols = c(start.station.ns, start.station.ew, end.station.ns, end.station.ew),
    names_to = c("station_type", ".value"),
    names_pattern = "(start|end)\\.station\\.(ns|ew)"
  ) %>%
  select(location, ride_id, station.ns = ns, station.ew = ew)


View(location_scouting_df)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 


#extract_street_suffix <- function(station){
#  last_space_position = str_locate(rev(station), " ")[[1]]
  
#  street_suffix = substr(station, nchar(station)-last_space_position+1, nchar(station))
#  return(street_suffix)
  
#}

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

#location_scouting_df$start.station.ns.street_suffix <- sapply(location_scouting_df$start.station.ns, extract_street_suffix)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

#normalize_stations <- function(station){
#  #location <- tolower(location)
#  location <- str_squish(location)
#  #location <- str_replace_all(location, "st\\.", "Street")
#  #location <- str_replace_all(location, "ave\\.", "Avenue")
#  return(location)
#  }
#}

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

station_squished <- function(station) {
  str_squish(station)  # No need for return()
}

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

location_scouting_df$station.ns <- station_squished(location_scouting_df$station.ns)

location_scouting_df$station.ew <- station_squished(location_scouting_df$station.ew)

station.ns.counts <- table(location_scouting_df$station.ns)
station.ew.counts <- table(location_scouting_df$station.ew)

station.ns.counts_sorted <- sort(station.ns.counts, decreasing = TRUE)
station.ew.counts_sorted <- sort(station.ew.counts, decreasing = TRUE)

head(station.ns.counts_sorted, 5)
head(station.ew.counts_sorted, 5)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

locations_list <- unique(location_scouting_df$location)

for (location in locations_list) {
  cat("\nTop Five North/South Stations for:", location, "\n")
  filtered_location <- location_scouting_df[location_scouting_df$location == location, ]
  station_ns_counts <- sort(table(filtered_location$station.ns), decreasing = TRUE)
  print(head(station_ns_counts, 5))
}

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

chicago_lsd <- location_scouting_df %>%
  filter(location == "chicago")

new_york_city_lsd <-location_scouting_df %>%
  filter(location == "new york city")

washington_lsd <- location_scouting_df %>%
  filter(location == "washington")


#chicago_lsd.station.ns.counts
chicago_lsd.station.ns.counts <- table(chicago_lsd$station.ns)
chicago_lsd.station.ew.counts <- table(chicago_lsd$station.ew)

new_york_city_lsd.station.ns.counts <- table(new_york_city_lsd$station.ns)
new_york_city_lsd.station.ew.counts <- table(new_york_city_lsd$station.ew)

washington_lsd.station.ns.counts <- table(washington_lsd$station.ns)
washington_lsd.station.ew.counts <- table(washington_lsd$station.ew)


chicago_lsd.station.ns.counts_sorted <- sort(chicago_lsd.station.ns.counts, decreasing = TRUE)
chicago_lsd.station.ew.counts_sorted <- sort(chicago_lsd.station.ew.counts, decreasing = TRUE)

new_york_city_lsd.station.ns.counts_sorted <- sort(new_york_city_lsd.station.ns.counts, decreasing = TRUE)
new_york_city_lsd.station.ew.counts_sorted <- sort(washington_lsd.station.ew.counts, decreasing = TRUE)

washington_lsd.station.ns.counts_sorted <- sort(washington_lsd.station.ns.counts, decreasing = TRUE)
washington_lsd.station.ew.counts_sorted <- sort(washington_lsd.station.ew.counts, decreasing = TRUE)


head(chicago_lsd.station.ns.counts_sorted, 5)
head(chicago_lsd.station.ew.counts_sorted, 5)

head(new_york_city_lsd.station.ns.counts_sorted, 5)
head(new_york_city_lsd.station.ew.counts_sorted, 5)

head(washington_lsd.station.ns.counts_sorted, 5)
head(washington_lsd.station.ew.counts_sorted, 5)


#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 


chicago_lsd_station_counts_ns_df <- as.data.frame(chicago_lsd.station.ns.counts_sorted)
View(chicago_lsd_station_counts_ns_df)

chicago_lsd_station_counts_ns_df <- chicago_lsd_station_counts_ns_df %>%
  rename("station" = "Var1" , "count" = "Freq") %>%
  filter(!is.na(station) & station != "") %>%
  mutate(
    rank = row_number(),
    direction = "ns",
    location = "chicago")


View(chicago_lsd_station_counts_ns_df)

#### #### #### #### #### #### #### #### 

chicago_lsd_station_counts_ew_df <- as.data.frame(chicago_lsd.station.ew.counts_sorted)

chicago_lsd_station_counts_ew_df <- chicago_lsd_station_counts_ew_df %>%
  rename("station" = "Var1" , "count" = "Freq") %>%
  filter(!is.na(station) & station != "") %>%
  mutate(
    rank = row_number(),
    direction = "ew",
    location = "chicago")


View(chicago_lsd_station_counts_ew_df)

#### #### #### #### #### #### #### #### 

new_york_city_lsd_station_counts_ns_df <- as.data.frame(new_york_city_lsd.station.ns.counts_sorted)

new_york_city_lsd_station_counts_ns_df <- new_york_city_lsd_station_counts_ns_df %>%
  rename("station" = "Var1" , "count" = "Freq") %>%
  filter(!is.na(station) & station != "") %>%
  mutate(
    rank = row_number(),
    direction = "ns",
    location = "new york city")


View(new_york_city_lsd_station_counts_ns_df)


#### #### #### #### #### #### #### #### 

new_york_city_lsd_station_counts_ew_df <- as.data.frame(new_york_city_lsd.station.ew.counts_sorted)

new_york_city_lsd_station_counts_ew_df <- new_york_city_lsd_station_counts_ew_df %>%
  rename("station" = "Var1" , "count" = "Freq") %>%
  filter(!is.na(station) & station != "") %>%
  mutate(
    rank = row_number(),
    direction = "ew",
    location = "new york city")


#### #### #### #### #### #### #### #### 

washington_lsd_station_counts_ns_df <- as.data.frame(washington_lsd.station.ns.counts_sorted)

washington_lsd_station_counts_ns_df <- washington_lsd_station_counts_ns_df %>%
  rename("station" = "Var1" , "count" = "Freq") %>%
  filter(!is.na(station) & station != "") %>%
  mutate(
    rank = row_number(),
    direction = "ns",
    location = "washington")


#### #### #### #### #### #### #### #### 

washington_lsd_station_counts_ew_df <- as.data.frame(washington_lsd.station.ew.counts_sorted)

washington_lsd_station_counts_ew_df <- washington_lsd_station_counts_ew_df %>%
  rename("station" = "Var1" , "count" = "Freq") %>%
  filter(!is.na(station) & station != "") %>%
  mutate(
    rank = row_number(),
    direction = "ew",
    location = "washington")


#### #### #### #### #### #### #### #### 

View(washington_lsd_station_counts_ew_df)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

chicago_lsd_station_counts_nsew_df = rbind(chicago_lsd_station_counts_ns_df, chicago_lsd_station_counts_ew_df)

View(chicago_lsd_station_counts_nsew_df)

#### #### #### #### #### #### #### ####

new_york_city_lsd_station_counts_nsew_df = rbind(new_york_city_lsd_station_counts_ns_df, new_york_city_lsd_station_counts_ew_df)

washington_lsd_station_counts_nsew_df = rbind(washington_lsd_station_counts_ns_df, washington_lsd_station_counts_ew_df)


#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 


all_lsd_station_counts_nsew_df = rbind(chicago_lsd_station_counts_nsew_df, new_york_city_lsd_station_counts_nsew_df)

all_lsd_station_counts_nsew_df = rbind(all_lsd_station_counts_nsew_df, washington_lsd_station_counts_nsew_df)



#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 


top_ten_chicago <- chicago_lsd_station_counts_nsew_df %>%
  filter(rank >= 1 & rank <= 10 )

#### #### #### #### #### #### #### ####

View(top_ten_chicago)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

# Inspiration
# https://r-graph-gallery.com/37-barplot-with-number-of-observation.html


# Basic Barplot
stations_bar_plot <- barplot(top_ten_chicago$count, border=F , names.arg=top_ten_chicago$station , 
                  las=2 , 
                  col=c(rgb(0.3,0.1,0.4,0.6) , rgb(0.3,0.5,0.4,0.6) , rgb(0.3,0.9,0.4,0.6) ,  rgb(0.3,0.9,0.4,0.6)) , 
                  #ylim=c(0,13) , 
                  main="" )


abline(v=c(12.1), col="grey")

#### 

top_ten_chicago$direction <- factor(top_ten_chicago$direction, levels = c("ns", "ew"), labels = c("North-South", "East-West"))

ggplot(top_ten_chicago, aes(x = reorder(station, rank), y = count, fill = direction)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ direction, scales = "free_x") +  # Split charts by direction
  labs(title = "Top 10 Stations by Direction",
       x = "Station",
       y = "Count") +
  scale_y_continuous(breaks = seq(0, max(top_ten_chicago$count), by = 2000)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 



#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 



all_lsd_station_counts_nsew_df = rbind(chicago_lsd_station_counts_nsew_df, new_york_city_lsd_station_counts_nsew_df)

all_lsd_station_counts_nsew_df = rbind(all_lsd_station_counts_nsew_df, washington_lsd_station_counts_nsew_df)


#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

all_top_ten_stations_df <- all_lsd_station_counts_nsew_df %>%
  filter(rank >= 1 & rank <= 10 )


View(all_top_ten_stations_df)

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

all_top_ten_stations_df <- select(all_top_ten_stations_df, location, direction, rank, station, count)

View(all_top_ten_stations_df)


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

all_top_ten_stations_df$direction <- factor(all_top_ten_stations_df$direction, levels = c("ns", "ew"), labels = c("North-South", "East-West"))
all_top_ten_stations_df$location <- factor(all_top_ten_stations_df$location, levels = c("chicago", "new york city", "washington"), labels = c("Chicago, IL", "New York City, NY", "Washington, D.C."))


ggplot(all_top_ten_stations_df, aes(x = reorder(station, rank), y = count, fill = direction)) +
  geom_bar(stat = "identity") +
  facet_wrap(location ~ direction, scales = "free_x") +  # Split charts by direction
  labs(title = "Top 10 Stations by Direction and Location",
       x = "Station",
       y = "Count") +
  scale_y_continuous(breaks = seq(0, max(all_top_ten_stations_df$count), by = 2000)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

all_top_ten_stations_df


cites = c("Chicago, Illinois, USA", "New York City, New York, USA", "Washington, D.C., USA")

for (city in cities) {

  rivers_osm_data <- opq(city) %>% add_osm_feature(key = "waterway", value = "river") %>% osmdata_sf()
  
  railways_osm_data <- opq(city) %>% add_osm_feature(key = "railway", value = "rail") %>% osmdata_sf()

  bigstreets_osm_data <- opq(city) %>% 
    add_osm_feature(
      key = "highway", 
      value = c("motorway", "trunk", "primary", "motorway_link", "trunk_link", "primary_link")) %>% 
    osmdata_sf()

  streets_osm_data <- opq(city) %>% 
    add_osm_feature(
      key = "highway", 
      value = c("secondary", "tertiary", "secondary_link", "tertiary_link")) %>% 
    osmdata_sf()

  city_top_ten_ns <- all_top_ten_stations_df %>% 
    filter(station == city_name) %>% 
    filter(direction == "ns")

  city_top_ten_ns_stations <- city_top_ten_ns$station

  city_top_ten_ns_stations <- str_remove(city_top_ten_ns_stations$station, "\\b(North|South|East|West|N|S|E|W)\\b\\s*")
  city_top_ten_ns_stations_cleaned <- str_remove(city_top_ten_ns_stations$station, "\\s+(St|Dr|Ave|Blvd|Rd)$")

  top_ns_streets_list <- city_top_ten_ns_stations_cleaned$station

  city_top_ten_ew <- all_top_ten_stations_df %>% 
    filter(station == city_name) %>% 
    filter(direction == "ew")

  city_top_ten_ew_stations <- city_top_ten_ew$station

  city_top_ten_ew_stations <- str_remove(city_top_ten_ew_stations$station, "\\b(North|South|East|West|N|S|E|W)\\b\\s*")
  city_top_ten_ew_stations_cleaned <- str_remove(city_top_ten_ew_stations$station, "\\s+(St|Dr|Ave|Blvd|Rd)$")

  top_ew_streets_list <- city_top_ten_ew_stations_cleaned$station
  
  ns_match_pattern <- paste(top_ns_streets_list, collapse = "|") 
  ew_match_pattern <- paste(top_ew_streets_list, collapse = "|")

  empty_osm <- streets_osm_data[['osm_lines']][0,]

  filtered_ns_streets <- streets_osm_data[['osm_lines']] %>%
    filter(grepl(ns_match_pattern, name))

  filtered_ew_streets <- streets_osm_data[['osm_lines']] %>%
    filter(grepl(ew_match_pattern, name))

  ns_streets_osm <- bind_rows(empty_osm, filtered_ns_streets)

  ew_streets_osm <- bind_rows(empty_osm, filtered_ew_streets)

  rivers <- rivers_osm_data$osm_lines
  railways <- railways_osm_data$osm_lines
  bigstreets <- bigstreets_osm_data$osm_lines
  streets <- streets_osm_data$osm_lines

  city_name = sub(",.*", "", city)
  city_name <- tolower(city_name)

  streets_file_name = paste(city_name, "streets.gpkg", sep = "_")
  big_streets_file_name = paste(city_name, "bigstreets.gpkg", sep="_")
  rivers_file_name = paste(city_name, "rivers.gpkg", sep = "_")
  railways_file_name = paste(city_name, "railways.gpkg", sep = "_")
  ns_streets_file_name = paste(city_name, "ns_streets.gpkg", sep="_")
  ew_streets_file_name = paste(city_name, "ew_streets.gpkg", sep="_")

  # Save locally as a GeoPackage
  st_write(streets, streets_file_name, delete_layer = TRUE)
  st_write(bigstreets, big_streets_file_name, delete_layer = TRUE)
  st_write(rivers, rivers_file_name, delete_layer = TRUE)
  st_write(railways, railways_file_name, delete_layer=TRUE)

  st_write(ns_streets_osm, ns_streets_file_name, delete_layer = TRUE)
  st_write(ew_streets_osm, ew_streets_file_name, delete_layer = TRUE)

}

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
