library(osmdata)
library(sf)
library(stringr)

# Define city and get OSM data
#city <- "Chicago, Illinois, USA"
#city <- "New York City, New York, USA"
#city <- "Washington, D.C., USA"

getbb(city)

#osm_data <- opq(city) %>% add_osm_feature(key = "highway") %>% osmdata_sf()


rivers_osm_data <- opq(city) %>% add_osm_feature(key = "waterway", value = "river") %>% osmdata_sf()
railways_osm_data <- opq(city) %>% add_osm_feature(key = "railway", value = "rail") %>% osmdata_sf()

#original
#streets_osm_data <- opq(city) %>% 
#  add_osm_feature(
#    key = "highway", 
#    value = c("motorway", "primary", "motorway_link", "primary_link", "secondary", "tertiary", "secondary_link", "tertiary_link")) %>% 
#  osmdata_sf()


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


get_top_five_ns_streets = all_top_ten_stations_df
get_top_five_ew_streets 


top_ns_streets_list <- c("Clark", "Clinton", "Michigan", "Lake Shore", "Canal", "Franklin", "Wabash", "Damen", "Streeter", "Halset")
top_ew_streets_list <- c("Grand", "Jackson", "Monroe", "Madison", "Lake", "Randolph", "Erie", "Adams", "Kinzie", "Washington")

ns_match_pattern <- paste(top_ns_streets_list, collapse = "|") 
ew_match_pattern <- paste(top_ew_streets_list, collapse = "|")

empty_osm <- streets_osm_data[['osm_lines']][0,]

filtered_ns_streets <- streets_osm_data[['osm_lines']] %>%
  filter(grepl(ns_match_pattern, name))

filtered_ew_streets <- streets_osm_data[['osm_lines']] %>%
  filter(grepl(ew_match_pattern, name))


ns_streets_osm <- bind_rows(empty_osm, filtered_ns_streets)


ew_streets_osm <- bind_rows(empty_osm, filtered_ew_streets)


# Extract street data
#streets <- streets_osm_data$osm_lines


rivers <- rivers_osm_data$osm_lines
railways <- railways_osm_data$osm_lines
bigstreets <- bigstreets_osm_data$osm_lines
streets <- streets_osm_data$osm_lines
#ns_streets <- ns_streets_osm$osm_lines

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
