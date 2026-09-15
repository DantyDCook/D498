
install.packages("ggmap")

library(osmdata)
library(sf)
library(ggplot2)
library(dplyr)
library(stringr)
library(ggmap)

gmaps_key <- Sys.getenv("GOOGLE_MAPS_API_KEY")
if (identical(gmaps_key, "")) {
  stop(
    "GOOGLE_MAPS_API_KEY is not set. Configure it locally before running map-dependent cells."
  )
}
register_google(key = gmaps_key)
google_key()

# Define city and get OSM data
#city <- "Chicago, Illinois, USA"
#city <- "New York City, New York, USA"
#city <- "Washington, D.C., USA"

cites = c("Chicago, Illinois, USA", "New York City, New York, USA", "Washington, D.C., USA")

for (city in cities){

  city_bb <- getbb(city)

  city_name = sub(",.*", "", city)
  city_name <- tolower(city_name)

  bigstreets_local = st_read(paste(city_name, "bigstreets.gpkg", sep="_"))
  streets_local = st_read(paste(city_name, "streets.gpkg", sep="_"))
  rivers_local = st_read(paste(city_name, "rivers.gpkg", sep="_"))
  railways_local = st_read(paste(city_name, "railways.gpkg", sep="_"))
  nw_streets_local = st_read(paste(city_name, "ns_streets.gpkg", sep="_"))
  ew_streets_local = st_read(paste(city_name, "ew_streets.gpkg", sep="_"))

  min_long <- city_bb[1,1]
  max_long <- city_bb[1,2]

  min_lat <- city_bb[2,1]
  max_lat <- city_bb[2,2]

  ggplot() +
    geom_sf(data = rivers_local, inherit.aes = FALSE,color = "steelblue", size = 0.8, alpha = 0.3) +
    geom_sf(data = railways_local, inherit.aes = FALSE,color = "grey", size = 0.2, linetype = "dotdash", alpha = 0.3) +
    geom_sf(data = bigstreets_local, inherit.aes = FALSE, color = "black", size = 0.5, alpha = 0.6) +
    geom_sf(data = streets_local, inherit.aes = FALSE,color = "black", size = 0.3, alpha = 0.5) +
    geom_sf(data = ns_streets_local, inherit.aes = FALSE, color = "red", size = 2, alpha = 1) + 
    geom_sf(data = ew_streets_local, inherit.aes = FALSE, color = "blue", size = 2, alpha = 1) +
    coord_sf(xlim = c(min_long, max_long), 
            ylim = c(min_lat,  max_lat)) +
    theme_minimal() +
    ggtitle(paste(str_to_title(city_name), "OSM Streets (Local GeoPackage)", sep=" "))

  ggsave_file_name = paste(city_name, "most_used_stations.pdf", sep="_")

  ggsave(file = ggsave_file_name, units = "in", width = 6, height = 7)

}

