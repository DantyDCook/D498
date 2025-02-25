setwd("D:/WGU/D498/D498/")
getwd()

install.packages("stringr")
install.packages("dplyr")

library(stringr)
library(dplyr)


chicago <- read.csv("datasets/chicago.csv")
new_york_city <- read.csv("datasets/new-york-city.csv")
washington <- read.csv("datasets/washington.csv")

View(chicago)

chicago_split_stations <- chicago

chicago_split_stations[c("Start.Station_1", "Start.Station_2")] <- str_split_fixed(chicago_split_stations$Start.Station, '&', 2) 
chicago_split_stations[c("End.Station_1", "End.Station_2")] <- str_split_fixed(chicago_split_stations$End.Station, '&', 2)

View(chicago_split_stations)

chicago_stations_stacked <- chicago_split_stations[c("Start.Station_1")]
View(chicago_stations_stacked)
rm(chicago_stations_stacked)

chicago_stations_stacked <- data.frame(Start.Station = c(chicago_split_stations$Start.Station_1, chicago_split_stations$Start.Station_2))
View(chicago_stations_stacked)

#unique(chicago_stations_stacked)

chicago_stations_stacked$Start.Station <- tolower(chicago_stations_stacked$Start.Station)
View(chicago_stations_stacked)

chicago_stations_stacked$Start.Station <- str_squish(chicago_stations_stacked$Start.Station)

View(chicago_stations_stacked)

chicago_stations_stacked <- data.frame(Stations = c(chicago_split_stations$Start.Station_1, chicago_split_stations$Start.Station_2, chicago_split_stations$End.Station_1, chicago_split_stations$End.Station_2))

View(chicago_stations_stacked)

chicago_stations_stacked$Stations <- tolower(chicago_stations_stacked$Stations)
chicago_stations_stacked$Stations <- str_squish(chicago_stations_stacked$Stations)

View(chicago_stations_stacked)
table(chicago_stations_stacked)

chicago_stations_stacked_cleaned <- chicago_stations_stacked %>%
  filter(!(is.na(Stations) | Stations == ""))

View(chicago_stations_stacked_cleaned)

station_counts <- table(chicago_stations_stacked_cleaned)
head(station_counts, 10)

most_visited_station <- names(station_counts[which.max(station_counts)])

top_ten_stations <- sort(station_counts, decreasing = TRUE)[1:10]
print(most_visited_station)
print(top_ten_stations)
