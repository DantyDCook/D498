# Removes all previously created variables.
# https://youtu.be/D_CNmYkGRUc?si=PJJbZY0GBtVsB4dB&t=91
rm(list=ls())
gc()

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

#install.packages("stringr")
#install.packages("dplyr")
#install.packages("ggplot2")
#install.packages("lubridate")
#install.packages("tidyr")
#install.packages("osmdata")
#install.packages("sf")
#install.packages("ggmap")
#install.packages("httr2")
#install.packages("ggraph")
#install.packages("igraph")
#install.packages("tidyverse")
#install.packages("tidygraph")

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

library(stringr)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(osmdata)
library(sf)
library(ggmap)
library(httr2)
library(igraph)
library(ggraph)
library(tidyverse)
library(tidygraph)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

setwd("D:/WGU/D498/D498/")
getwd()

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

load("bikeshare_main_df.RData")


#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 


travel_times_df <- subset(bikeshare_main_df, select = c(location, ride_id, trip.duration, user.type))




#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

#gc()

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 


tt_cities = c('chicago', 'new york city')

# Washington excluded as it did not collect user data/details.

get_trips <- function(dataframe, city){
  
  valid_trips <- dataframe %>% 
    filter(location == city) %>% 
    filter(!is.na(trip.duration)) %>% 
    filter(!is.na(user.type)) %>% 
    mutate( 
      trip_duration_minutes = trip.duration / 60
    )
  
  return(valid_trips)
}

get_users <- function(dataframe, city){
  
  valid_users <- dataframe %>% 
    filter(location == city) %>% 
    filter(!is.na(user.type) & user.type != '') %>%
    mutate(user.type = str_replace(user.type, "Dependent", "Subscriber"))
  
  subscribers <- valid_users %>% filter(user.type == "Subscriber")
  
  customers <- valid_users %>% filter(user.type == "Customer")
    
  return(list(subscribers = subscribers, customers = customers))
}



for (city in tt_cities){
  
  city_name <- str_to_title(city)
  
  print(city_name)
  
  trips <- get_trips(travel_times_df, city)

  users <- get_users(trips, city)
  
  
  print("Subscribers Summary:")
  print(summary(users$subscribers))
  
  print("Customers Summary:")
  print(summary(users$customers))
  
}


all_trips <- bind_rows(
  get_trips(travel_times_df, "chicago"),
  get_trips(travel_times_df, "new york city")
)

all_trips <- all_trips %>%
  filter(!is.na(user.type) & user.type != '') %>%
  mutate(user.type = str_replace(user.type, "Dependent", "Subscriber"))



ggplot(all_trips, (aes(x = location, y=trip_duration_minutes, fill = user.type))) +
         geom_boxplot(outlier.shape = NA) + 
         coord_cartesian(ylim = c(0,60)) + 
         labs(
           x = "City",
           y = "Trip Duration (Minutes)", 
           title = "Trip Duration By City and User Type", 
           fill = "User Type"
         ) + 
         theme_minimal() + 
         facet_wrap(~user.type, scales = "free")


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####


travel_time_summary <- travel_times_df %>%
  filter(!is.na(trip.duration)) %>%
  mutate(trip_duration_minutes = trip.duration / 60) %>%
  group_by(location) %>% 
  summarise(
    Min = min(trip_duration_minutes),
    Q1 = quantile(trip_duration_minutes, 0.25),
    Median = median(trip_duration_minutes), 
    Mean = mean(trip_duration_minutes), 
    Q3 = quantile(trip_duration_minutes, 0.75), 
    Max = max(trip_duration_minutes),
    Total = sum(trip_duration_minutes),
    .groups = "drop"
  )

travel_time_summary <- travel_time_summary %>%
  mutate(across(Min:Max, ~ round(., 2))) %>%
  mutate(Percentage = Total / sum(Total) * 100)


print(travel_time_summary)

ggplot(travel_time_summary, aes(x = "", y = Total, fill = location)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  theme_void() +
  labs(title = "Total Trip Duration by Location",
       fill = "Location") +
  scale_fill_brewer(palette = "Set3", 
                    labels = str_to_title(unique(travel_time_summary$location))) +
  geom_text(aes(label = paste0(round(Percentage, 1), "%")),
            position = position_stack(vjust = 0.5), color = "Black", size = 5)
