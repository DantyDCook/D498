setwd("D:/WGU/D498/D498/")
getwd()


chicago <- read.csv("datasets/chicago.csv")
new_york_city <- read.csv("datasets/new-york-city.csv")
washington <- read.csv("datasets/washington.csv")


View(chicago)

# https://www.geeksforgeeks.org/how-to-split-column-into-multiple-columns-in-r-dataframe/
# https://www.datacamp.com/tutorial/r-packages-guide?utm_source=google&utm_medium=paid_search&utm_campaignid=19589720830&utm_adgroupid=157156377351&utm_device=c&utm_keyword=&utm_matchtype=&utm_network=g&utm_adpostion=&utm_creative=684592141331&utm_targetid=aud-1903815585993:dsa-2218886984060&utm_loc_interest_ms=&utm_loc_physical_ms=1026036&utm_content=&utm_campaign=230119_1-sea~dsa~tofu_2-b2c_3-us_4-prc_5-na_6-na_7-le_8-pdsh-go_9-nb-e_10-na_11-na&gad_source=1&gclid=CjwKCAiAwaG9BhAREiwAdhv6Y4lwhg5PUUERvEbIFU1l5kRbzjNw_25N66xnGou3_pGFzLs0ZXAhqBoCNxQQAvD_BwE
# 

install.packages("stringr")
library(stringr)

chicago[c('Start.Station_1', 'Start.Station_2')] <- str_split_fixed(chicago$Start.Station, '&', 2)  
chicago[c('End.Station_1', 'End.Station_2')] <- str_split_fixed(chicago$End.Station, '&', 2)  



View(chicago)

sum(duplicated(chicago$Start.Station_1))

unique(chicago$Start.Station_1)


#https://www.geeksforgeeks.org/remove-all-whitespace-in-each-dataframe-column-in-r/ 

station_squished = function(station){
  str_squish(station)
  }


chicago[c('Start.Station_1')] <- lapply(chicago[c('Start.Station_1')], station_squished)

unique(chicago$Start.Station_1)

chicago_stations_df <- chicago[c("Start.Station_1", "Start.Station_2", "End.Station_1", "End.Station_2")]
View(chicago_stations_df)
table(chicago_stations_df)

#chicago_stations_formatted_df <- cbind(chicago_stations_df[1], stack(chicago_stations_df[2]))
#View(chicago_stations_formatted_df)

chicago_stations_df[] <- lapply(chicago_stations_df, station_squished)


chicago_stations_formatted2_df <- data.frame(Station = unlist(chicago_stations_df, use.names = FALSE))
View(chicago_stations_formatted2_df)

sort(table(chicago_stations_formatted2_df))

install.packages("dplyr")
library(dplyr)

chi_station_cleaned_sorted <- table(chicago_stations_formatted2_df) %>%
    as.data.frame() %>%
    filter(complete.cases(.)) %>%
    mutate_all(station_squished) %>%
    arrange(desc(Freq))

View(chi_station_cleaned_sorted)    
chi_station_cleaned_sorted

chi_station_cleaned_sorted_2 <- chi_station_cleaned_sorted %>%
  filter(!(is.na(Station) | Station == ""))

View(chi_station_cleaned_sorted_2)

View(chi_station_cleaned_sorted_2)

unique(chicago$Gender)

str(chicago)

chicago$Gender <- as.factor(chicago$Gender)
levels(chicago$Gender)
