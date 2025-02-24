
#### #### #### #### #### #### #### #### 

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

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

setwd("D:/WGU/D498/D498/")
getwd()

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 


chicago <- read.csv("datasets/chicago.csv")
new_york_city <- read.csv("datasets/new-york-city.csv")
washington <- read.csv("datasets/washington.csv")

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

head(chicago)

str(chicago)

#### #### #### #### #### #### #### #### 


# Converting the 'Start.Time' column data from character/string to date time.
chicago$Start.Time <- ymd_hms(chicago$Start.Time)

# Converting the 'End.Time' column data from character/string to date time.
chicago$End.Time <- ymd_hms(chicago$End.Time)

# Converting the 'Gender' column data from character/string to factor
chicago$Gender <- as.factor(chicago$Gender)

#Converting the 'User.Type" column data from character/string to factor
chicago$User.Type <- as.factor(chicago$User.Type)

#Converting the 'Birth.Year' column data from character/string to Integer
chicago$Birth.Year <- as.integer(chicago$Birth.Year)

#### #### #### #### #### #### #### #### 

# Running the Structure Command to verify changes. 
str(chicago)

# Visually inspecting the data set with the head command again to verify changes
head(chicago)

# Capturing the 'levels' of the 'User.Type' column data to confirm the factor data type change was successful. 
levels(chicago$User.Type)

# Chicago's User.Types are:
# "Customer"
# "Dependent"
# "Subscriber"

# Capturing the 'levels' of the 'Gender' column data to confirm the factor data type change was successful. 
levels(chicago$Gender)

# Chicago's Gender Levels are:
# ""
# "Female"
# "Male"

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

# Visually inspecting the data set with the 'head' command
head(new_york_city)

# Obtaining the structure data from the data set with the 'str' command
str(new_york_city)

#### #### #### #### #### #### #### #### 

# Converting the 'Start.Time' column data from character/string to date time.
new_york_city$Start.Time <- ymd_hms(new_york_city$Start.Time)

# Converting the 'End.Time' column data from character/string to date time.
new_york_city$End.Time <- ymd_hms(new_york_city$End.Time)

# Converting the 'Gender' column data from character/string to factor
new_york_city$Gender <- as.factor(new_york_city$Gender)

#Converting the 'User.Type" column data from character/string to factor
new_york_city$User.Type <- as.factor(new_york_city$User.Type)

#Converting the 'Birth.Year' column data from character/string to Integer
new_york_city$Birth.Year <- as.integer(new_york_city$Birth.Year)

#### #### #### #### #### #### #### #### 

# Running the Structure Command to verify changes. 
str(new_york_city)

# Visually inspecting the data set with the head command again to verify changes
head(new_york_city)

# Capturing the 'levels' of the 'User.Type' column data to confirm the factor data type change was successful.. 
levels(new_york_city$User.Type)

# New York City's User.Types are:
# "" 
# "Customer"
# "Subscriber"

# Capturing the 'levels' of the 'Gender' column data to confirm the factor data type change was successful.. 
levels(new_york_city$Gender)

# New York City's Gender Levels are:
# ""
# "Female"
# "Male"

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

# Visually inspecting the data set with the 'head' command
head(washington)

# Obtaining the structure data from the data set with the 'str' command
str(washington)

#### #### #### #### #### #### #### #### 

# Converting the 'Start.Time' column data from character/string to date time.
washington$Start.Time <- ymd_hms(washington$Start.Time)

# Converting the 'End.Time' column data from character/string to date time.
washington$End.Time <- ymd_hms(washington$End.Time)

# Trip duration on this data set was stored in millisecond format, needs to be converted into second format
# Rounding up the value to the next whole second value with the 'ceiling command
washington$Trip.Duration <- ceiling(washington$Trip.Duration)

# Converting the numeric/double (decimal) value to integer for whole seconds
washington$Trip.Duration <- as.integer(washington$Trip.Duration)

# The Washington data set did not have a Gender or Birth Year column like New York City and Chicago did. 
# Creating two missing columns, 'Gender' and 'Birth.Year' and assigning them with a Null/NA value
washington[c('Gender','Birth.Year')] <- NA

# Changign the 'Gender' column value to a blank string "" to match the other data set's gender options
washington$Gender <- ""

# Converting the 'Gender' column data to factor type and assigning the levels manually. 
washington$Gender <- factor(washington$Gender, levels =c("", "Female", "Male"))

# Converting the 'User.Type' column data to factor
washington$User.Type <- as.factor(washington$User.Type)

# Converting the 'Birth.Year' column data to integer. 
washington$Birth.Year <- as.integer(washington$Birth.Year)

#### #### #### #### #### #### #### #### 

# Bike shares typically will not rent to anyone under 16. In some areas the minimum age is 18. 
# In theory, I could set all birth years to 16 years ago for this city to keep from having a column full of NA's
# In Washington D.C., the major bikeshare here is Capital Bikeshare and their minimum age is 16. 
# 16 years ago would be: 2008-2009. The safest method to insure all ages are above the minimum would be to select 2008, 
# which would put all users from the month's January and February at 17 and all users from March to December at 16. 
# https://capitalbikeshare.com/pricing/for-all
# https://sharedmobility.ddot.dc.gov/pages/faqs
# https://www.dcpolicycenter.org/publications/how-can-d-c-make-bikesharing-family-friendly/
# https://assets.capitalbikeshare.com/rental-agreement.html

# washington$Birth.Year <- "2008" 
# washington$Birth.Year <- as.integer(washington$Birth.Year)

#### #### #### #### #### #### #### #### 

# Running the Structure Command to verify changes. 
str(washington)

# Visually inspecting the data set with the head command again to verify changes
head(washington)

# Capturing the 'levels' of the 'User.Type' column data to confirm the factor data type change was successful.. 
levels(washington$User.Type)

# Washington's User.Types are:
# "Customer"
# "Subscriber"

washington$User.Type <- factor(washington$User.Type, levels =c("", "Female", "Male"))


# Capturing the 'levels' of the 'Gender' column data to confirm the factor data type change was successful.. 
levels(washington$Gender)

# Washington's Gender Levels were non-existent, they are now:
# ""
# "Female"
# "Male"


#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

# Manually assigning the 'User.Type' factor levels to make the data set structure uniform with the rest.
chicago$User.Type <- factor(chicago$User.Type, levels = c("", "Customer", "Dependent", "Subscriber"))

# Manually assigning the 'User.Type' factor levels to make the data set structure uniform with the rest. 
new_york_city$User.Type <- factor(new_york_city$User.Type, levels = c("", "Customer", "Dependent", "Subscriber"))

# Manually assigning the 'User.Type' factor levels to make the data set structure uniform with the rest. 
washington$User.Type <- factor(washington$User.Type, levels = c("", "Customer", "Dependent", "Subscriber"))


#### #### #### #### #### #### #### #### 

# Confirming changes:

levels(chicago$User.Type)

levels(new_york_city$User.Type)

levels(washington$User.Type)

# Changes confirmed. 

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

# Adding new column, 'location' to each data set to indicate the location the data set is for

# Created a function to create the new column and add the value for every row. 
# function also places this location column as the first column through cbind ordering.
add_location_column <- function(dataframe, location_name) {
  new_column <- data.frame(location = location_name)
  return(cbind(new_column, dataframe))
}

# Calling function.
chicago <- add_location_column(chicago, "chicago")

# Visual Confirmation addition was successful. It was. 
View(chicago)

#Adding locations to the other two data sets. 

new_york_city <- add_location_column(new_york_city, "new york city")

washington <- add_location_column(washington, "washington")

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

# We will now combined the data sets into one data set to make our analysis easier to perform 

# Creating new data set and using row bind, rbind, to join the first two data set's together. 
bikeshare_main_df <- rbind(chicago, new_york_city)

# Combining the new data set created with the last dataset to have a singular data set. 
bikeshare_main_df <- rbind(bikeshare_main_df, washington)

# Converting the 'location' column data to a factor
bikeshare_main_df$location <- as.factor(bikeshare_main_df$location)

# Verifying the Structure of the new data set. 
str(bikeshare_main_df)

# Getting dimensions
dim(bikeshare_main_df)

# Visual inspection
sample(bikeshare_main_df)

head(bikeshare_main_df)

# Confirm level update
levels(bikeshare_main_df$location)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

# Rename "X" column to "ride_id"

bikeshare_main_df <- bikeshare_main_df %>% rename(ride_id = X)

# Make this change on our original data set's as well 

chicago <- chicago %>% rename(ride_id = X)
new_york_city <- new_york_city %>% rename(ride_id = X)
washington <- washington %>% rename(ride_id = X)


#### #### #### #### #### #### #### #### 

# Let's also convert all column names to lowercase too

normalize_column_names <- function(dataframe){
  colnames(dataframe) <- tolower(colnames(dataframe))
  return(dataframe)
}

#### #### #### #### 

# Applying normalization to bikeshare main dataframe 
bikeshare_main_df <- normalize_column_names(bikeshare_main_df)

# Visually confirming
str(bikeshare_main_df)

#### #### #### #### 

# Let's apply to all to original data frame's as well to maintain uniformity. 

chicago <- normalize_column_names(chicago)
new_york_city <- normalize_column_names(new_york_city)
washington <- normalize_column_names(washington)


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####

# All code above creates the formated, combinded dataset that will be used for all questions moving forward. 

save(bikeshare_main_df, file = "bikeshare_main_df.RData")

save(chicago, file = "chicago_dataframe_cleaned.RData")
save(new_york_city, file = "new_york_city_dataframe_cleaned.RData")
save(washington, file = "washington_dataframe_cleaned.RData")

rm("chicago")
rm("new_york_city")
rm("washington")

gc()


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####

# Create a new dataframe for common timeframes questions
# Dataframe will be a subset of the 'bikeshare_main_df' with only the locaiton, ride_id, start.time, and end.time columns
common_timeframes_df <- subset(bikeshare_main_df, select = c(location, ride_id, start.time, end.time))

# Verifying dataframe visually
View(common_timeframes_df)

#Verifying dataframe structure
str(common_timeframes_df)

# verifying dimensions
dim(common_timeframes_df)


#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

# Create a "Month" Column and populate with the month value from the 'start.time' field. 
common_timeframes_df$month <- month(bikeshare_main_df$start.time)
    

# Create a 'multi.day' column, and populate it with a boolean value for whether or not the ride was started and ended on the same day. 
common_timeframes_df$multi.day <- as.factor(day(common_timeframes_df$start.time) != day(common_timeframes_df$end.time))

#### #### #### #### #### #### #### #### 

multi_day_rides <- common_timeframes_df %>%
  filter(multi.day == TRUE)
  
#### #### #### #### 

View(multi_day_rides)

#### #### #### #### #### #### #### #### 

single_day_rides <- common_timeframes_df %>%
  filter(multi.day == FALSE)

#### #### #### #### 

View(single_day_rides)


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 


split_multi_day_rides <- function(dataframe) {
  dataframe %>%
    rowwise() %>%
    mutate(
      days = list(seq(as.Date(start.time), as.Date(end.time), by = "day"))
    ) %>%
    unnest(days) %>%
    mutate(
      start.time = ifelse(
        days == as.Date(start.time), 
        start.time, 
        as.POSIXct(paste0(days, " 00:00:00"), tz = "UTC")
      ),
      end.time = ifelse(
        days == as.Date(end.time), 
        end.time, 
        as.POSIXct(paste0(days, " 23:59:59"), tz = "UTC")
      ),
      day.of.the.week = weekdays(days)
    ) %>%
    ungroup()
}

#### #### #### #### #### #### #### #### 

multi_day_rides$start.time_original <- multi_day_rides$start.time
multi_day_rides$end.time_orginal <- multi_day_rides$end.time

#### #### #### #### 

multi_day_rides$start.time <- as.POSIXct(multi_day_rides$start.time, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")
multi_day_rides$end.time <- as.POSIXct(multi_day_rides$end.time, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")

#### #### #### #### #### #### #### #### 

expanded_multi_day_rides_df <- split_multi_day_rides(multi_day_rides)

#### #### #### #### #### #### #### #### 

expanded_multi_day_rides_df$start.time <- as.POSIXct(expanded_multi_day_rides_df$start.time, origin = "1970-01-01", tz = "UTC")
expanded_multi_day_rides_df$end.time <- as.POSIXct(expanded_multi_day_rides_df$end.time, origin = "1970-01-01", tz = "UTC")

#### #### #### #### #### #### #### #### 

View(expanded_multi_day_rides_df)

#### #### #### #### #### #### #### #### 

# Selected Columns From full expanded_multi_day_rides dataframe
expanded_multi_day_rides <- subset(expanded_multi_day_rides_df, select = c(location, ride_id, start.time, end.time, month, multi.day, day.of.the.week))

#### #### #### #### #### #### #### #### 

View(expanded_multi_day_rides)

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

# Creating a 'day of the week' column and populating it with the day of the week, 
single_day_rides$day.of.the.week <- weekdays(single_day_rides$start.time)


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

combined_rides_common_timeframes <- rbind(single_day_rides, expanded_multi_day_rides)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

combined_rides_common_timeframes$start.hour <- hour(combined_rides_common_timeframes$start.time)

combined_rides_common_timeframes$end.hour <- hour(combined_rides_common_timeframes$end.time)



#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 


active_hours <- matrix(0, nrow=nrow(combined_rides_common_timeframes), ncol= 24)

active_hours_df <- as.data.frame(active_hours)

colnames(active_hours_df) <- paste0("active_hour.", 0:23)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 


combined_rides_common_timeframes <- cbind(combined_rides_common_timeframes, active_hours_df)


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

update_columns_batches <- function(df, start.col.name, end.col.name, prefix = "active_hour.", batch_size = 100) {
  
  total_rows <- nrow(df)
  
  for (batch_start in seq(1, total_rows, by = batch_size)) {
    batch_end <- min(batch_start + batch_size - 1, total_rows)
  
    for (i in batch_start:batch_end) {
      starthour <- df[[start.col.name]][i]
      endhour <- df[[end.col.name]][i]
      
      # Ensure valid range
      if (starthour <= endhour) {
        # Generate the correct range of columns
        columns_to_update <- paste0(prefix, starthour:endhour)
        
        # Update those columns
        df[i, columns_to_update] <- 1
      }
    }
  }
  return(df)
}

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 



combined_rides_common_timeframes_active_matrix <- update_columns_batches(combined_rides_common_timeframes, "start.hour", "end.hour", "active_hour.", 100)



#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

save(combined_rides_common_timeframes_active_matrix, file = "combined_rides_common_timeframes_active_matrix.RData")
save(combined_rides_common_timeframes, file = "combined_rides_common_timeframes.RData")

save(common_timeframes_df, file = "common_timeframes_df.RData")
save(expanded_multi_day_rides_df, file = "expanded_multi_day_rides.RData")
save(single_day_rides, file = "single_day_rides.RData")
save(multi_day_rides, file = "multi_day_rides.RData")

rm(common_time_frames_df)
rm(active_hours)
rm(active_hours_df)
rm(expanded_multi_day_rides)
rm(expanded_multi_day_rides_df)
rm(single_day_rides)
rm(multi_day_rides)

gc()



#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

View(combined_rides_common_timeframes_active_matrix)

#### #### #### #### #### #### #### #### 

dim(combined_rides_common_timeframes_active_matrix)

length(combined_rides_common_timeframes_active_matrix)

nrow(combined_rides_common_timeframes_active_matrix)


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 


sunday_crct_df <- combined_rides_common_timeframes_active_matrix %>%
  filter(day.of.the.week == "Sunday")

#### #### #### #### #### #### #### #### 

monday_crct_df <- combined_rides_common_timeframes_active_matrix %>%
  filter(day.of.the.week == "Monday")

#### #### #### #### #### #### #### #### 

tuesday_crct_df <- combined_rides_common_timeframes_active_matrix %>%
  filter(day.of.the.week == "Tuesday")

#### #### #### #### #### #### #### #### 

wednesday_crct_df <- combined_rides_common_timeframes_active_matrix %>%
  filter(day.of.the.week == "Wednesday")

#### #### #### #### #### #### #### #### 

thursday_crct_df <- combined_rides_common_timeframes_active_matrix %>%
  filter(day.of.the.week == "Thursday")

#### #### #### #### #### #### #### #### 

friday_crct_df <- combined_rides_common_timeframes_active_matrix %>%
  filter(day.of.the.week == "Friday")

#### #### #### #### #### #### #### #### 

saturday_crct_df <- combined_rides_common_timeframes_active_matrix %>%
  filter(day.of.the.week == "Saturday")

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

sunday_crct_df <- update_columns_batches(sunday_crct_df, "start.hour", "end.hour", "active_hour.", 100)

#### #### #### #### 

View(sunday_crct_df)

#### #### #### #### #### #### #### #### 

monday_crct_df <- update_columns_batches(monday_crct_df, "start.hour", "end.hour", "active_hour.", 100)

#### #### #### #### #### #### #### #### 

tuesday_crct_df <- update_columns_batches(tuesday_crct_df, "start.hour", "end.hour", "active_hour.", 100)

#### #### #### #### #### #### #### #### 

wednesday_crct_df <- update_columns_batches(wednesday_crct_df, "start.hour", "end.hour", "active_hour.", 100)

#### #### #### #### #### #### #### #### 

thursday_crct_df <- update_columns_batches(thursday_crct_df, "start.hour", "end.hour", "active_hour.", 100)

#### #### #### #### #### #### #### #### 

friday_crct_df <- update_columns_batches(friday_crct_df, "start.hour", "end.hour", "active_hour.", 100)

#### #### #### #### #### #### #### #### 

saturday_crct_df <- update_columns_batches(saturday_crct_df, "start.hour", "end.hour", "active_hour.", 100)

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

process_active_hours <- function(dataframes) {
  # Reshape and process the data
  dataframes_processed <- dataframes %>%
    # Reshape from wide to long format
    pivot_longer(cols = starts_with("active_hour"),
                 names_to = "hour", 
                 values_to = "active",
                 names_prefix = "active_hour.") %>%
    # Convert hour to numeric
    mutate(hour = as.numeric(hour)) %>%
    # Filter only active hours (active == 1)
    filter(active == 1) %>%
    # Group by day of the week and hour, then count total active users
    group_by(day.of.the.week, hour) %>%
    summarise(total_active_users = n(), .groups = "drop")
  
  # Return the processed dataframe
  return(dataframes_processed)
}

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

process_active_hours_per_location <- function(dataframes) {
  # Reshape and process the data
  dataframes_processed <- dataframes %>%
    # Reshape from wide to long format
    pivot_longer(cols = starts_with("active_hour"),
                 names_to = "hour", 
                 values_to = "active",
                 names_prefix = "active_hour.") %>%
    # Convert hour to numeric
    mutate(hour = as.numeric(hour)) %>%
    # Filter only active hours (active == 1)
    filter(active == 1) %>%
    # Group by day of the week and hour, then count total active users
    group_by(location, day.of.the.week, hour) %>%
    summarise(total_active_users = n(), .groups = "drop")
  
  # Return the processed dataframe
  return(dataframes_processed)
}



#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 


sunday_crct_processed_df <- process_active_hours(sunday_crct_df)

#### #### #### #### 

View(sunday_crct_processed_df)

#### #### #### #### #### #### #### #### 

monday_crct_processed_df <- process_active_hours(monday_crct_df)

#### #### #### #### #### #### #### #### 

tuesday_crct_processed_df <- process_active_hours(tuesday_crct_df)

#### #### #### #### #### #### #### #### 

wednesday_crct_processed_df <- process_active_hours(wednesday_crct_df)

#### #### #### #### #### #### #### #### 

thursday_crct_processed_df <- process_active_hours(thursday_crct_df)

#### #### #### #### #### #### #### #### 

friday_crct_processed_df <- process_active_hours(friday_crct_df)

#### #### #### #### #### #### #### #### 

saturday_crct_processed_df <- process_active_hours(saturday_crct_df)

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 


sunday_crct_processed_df_per_location <- process_active_hours_per_location(sunday_crct_df)

#### #### #### #### 

View(sunday_crct_processed_df_per_location)

#### #### #### #### #### #### #### #### 


monday_crct_processed_df_per_location <- process_active_hours_per_location(monday_crct_df)

#### #### #### #### #### #### #### #### 

tuesday_crct_processed_df_per_location <- process_active_hours_per_location(tuesday_crct_df)

#### #### #### #### #### #### #### #### 

wednesday_crct_processed_df_per_location <- process_active_hours_per_location(wednesday_crct_df)

#### #### #### #### #### #### #### #### 

thursday_crct_processed_df_per_location <- process_active_hours_per_location(thursday_crct_df)

#### #### #### #### #### #### #### #### 

friday_crct_processed_df_per_location <- process_active_hours_per_location(friday_crct_df)

#### #### #### #### #### #### #### #### 

saturday_crct_processed_df_per_location <- process_active_hours_per_location(saturday_crct_df)


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 



peak_users_dow_crct_processed_df <- rbind(sunday_crct_processed_df, monday_crct_processed_df)

peak_users_dow_crct_processed_df <- rbind(peak_users_dow_crct_processed_df, tuesday_crct_processed_df)

peak_users_dow_crct_processed_df <- rbind(peak_users_dow_crct_processed_df, wednesday_crct_processed_df)

peak_users_dow_crct_processed_df <- rbind(peak_users_dow_crct_processed_df, thursday_crct_processed_df)

peak_users_dow_crct_processed_df <- rbind(peak_users_dow_crct_processed_df, friday_crct_processed_df)

peak_users_dow_crct_processed_df <- rbind(peak_users_dow_crct_processed_df, saturday_crct_processed_df)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

View(peak_users_dow_crct_processed_df)

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 


peak_users_dow_crct_processed_df_per_location <- rbind(sunday_crct_processed_df_per_location, monday_crct_processed_df_per_location)

peak_users_dow_crct_processed_df_per_location <- rbind(peak_users_dow_crct_processed_df_per_location, tuesday_crct_processed_df_per_location)

peak_users_dow_crct_processed_df_per_location <- rbind(peak_users_dow_crct_processed_df_per_location, wednesday_crct_processed_df_per_location)

peak_users_dow_crct_processed_df_per_location <- rbind(peak_users_dow_crct_processed_df_per_location, thursday_crct_processed_df_per_location)

peak_users_dow_crct_processed_df_per_location <- rbind(peak_users_dow_crct_processed_df_per_location, friday_crct_processed_df_per_location)

peak_users_dow_crct_processed_df_per_location <- rbind(peak_users_dow_crct_processed_df_per_location, saturday_crct_processed_df_per_location)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

View(peak_users_dow_crct_processed_df_per_location)

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 


save(peak_users_dow_crct_processed_df, file = "peak_users_dow_crct.RData")
save(peak_users_dow_crct_processed_df_per_location, file = "peak_users_dow_crct_per_location.RData")

rm(sunday_crct_df)
rm(monday_crct_df)
rm(tuesday_crct_df)
rm(wednesday_crct_df)
rm(thursday_crct_df)
rm(friday_crct_df)
rm(saturday_crct_df)

rm(sunday_crct_processed_df)
rm(monday_crct_processed_df)
rm(tuesday_crct_processed_df)
rm(wednesday_crct_processed_df)
rm(thursday_crct_processed_df)
rm(friday_crct_processed_df)
rm(saturday_crct_processed_df)

rm(sunday_crct_processed_df_per_location)
rm(monday_crct_processed_df_per_location)
rm(tuesday_crct_processed_df_per_location)
rm(wednesday_crct_processed_df_per_location)
rm(thursday_crct_processed_df_per_location)
rm(friday_crct_processed_df_per_location)
rm(saturday_crct_processed_df_per_location)


gc()


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 


peak_users_dow_crct_processed_df <- peak_users_dow_crct_processed_df %>%
  mutate(day.of.the.week = factor(day.of.the.week, 
                                  levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")))

#### #### #### #### #### #### #### #### 

ggplot(peak_users_dow_crct_processed_df, aes(x = hour, y = total_active_users, color = day.of.the.week, group = day.of.the.week)) +
  geom_line() +
  labs(
    title = "Total Active Users by Hour of the Day and Day of the Week",
    x = "Hour of the Day",
    y = "Total Active Users",
    color = "Day of the Week"
  ) +
  scale_x_continuous(breaks = 0:23, labels = c("12 am", "1 am", "2 am", "3 am", "4 am", "5 am", "6 am", " 7am", "8 am", "9 am", "10 am", "11 am", "12 pm", "1 pm", "2 pm", "3 pm", "4 pm", "5 pm", "6 pm", "7 pm", "8 pm", "9 pm", "10 pm", "11 pm")) +
  theme_minimal()

#### #### #### #### #### #### #### #### 

ggsave(file = "peak_users_Per_Hour_Per_Day_Single_Plot.pdf", units = "in", width = 6, height = 7)

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 


peak_users_dow_crct_processed_df_per_location <- peak_users_dow_crct_processed_df_per_location %>%
  mutate(day.of.the.week = factor(day.of.the.week, 
                                  levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")))


#### #### #### #### #### #### #### #### 

ggplot(peak_users_dow_crct_processed_df_per_location, aes(x = hour, y = total_active_users, color = location)) +
  geom_line() +
  labs(
    x = "Hour of the Day", 
    y = "Total Active Users", 
    title = "Active Users by Hour, Location, and Day of the Week",
    color = "City"
  ) +
  scale_x_continuous(breaks = 0:23, labels = c("12 am", "1 am", "2 am", "3 am", "4 am", "5 am", "6 am", " 7am", "8 am", "9 am", "10 am", "11 am", "12 pm", "1 pm", "2 pm", "3 pm", "4 pm", "5 pm", "6 pm", "7 pm", "8 pm", "9 pm", "10 pm", "11 pm")) +
  scale_color_manual(
    values = c("chicago" = "red", "new york city" = "green", "washington" = "blue"),
    labels = c("chicago" = "Chicago", "new york city" = "New York City", "washington" = "Washington D.C.")  # Change legend text
  ) +
  theme_minimal() +
  # One Column Layout - USE ONE ONLY
  # One Column Looks the Best
  facet_wrap(~ day.of.the.week, ncol = 1)
  # One Row Layout - USE ONE ONLY
  #facet_wrap(~ day.of.the.week, nrow = 1)

#### #### #### #### #### #### #### #### 

ggsave(file = "peak_users_Per_Hour_Per_Day_Per_Location.pdf", units = "in", width = 6, height = 7)


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 


peak_users_dow_crct_processed_df_v2 <- peak_users_dow_crct_processed_df %>%
  mutate(
    day_hour = paste(day.of.the.week, hour, sep = "_"),
    day.of.the.week = factor(day.of.the.week, 
                             levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")),
    day_index = as.numeric(day.of.the.week) - 1,
    time_numeric = day_index * 24 + hour)

#### #### #### #### #### #### #### #### 

ggplot(peak_users_dow_crct_processed_df_v2, aes(x = time_numeric, y = total_active_users, group = day.of.the.week, color = day.of.the.week)) +
  #geom_line(size = 1) +  # Thicker line for visibility
  geom_line() +
  labs(x = "Day of the Week", y = "Total Active Users", color = "Day") +
  scale_x_continuous(
    breaks = seq(0, 144, by = 24),  # Major ticks for each day (Sunday 00, Monday 00, ..., Saturday 00)
    minor_breaks = seq(0, 167, by = 6),  # Minor ticks every 6 hours
    labels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")  # 7 labels, 7 breaks
  ) +
  scale_color_manual(values = c(
    "Sunday" = "red", 
    "Monday" = "blue", 
    "Tuesday" = "green", 
    "Wednesday" = "purple", 
    "Thursday" = "orange", 
    "Friday" = "pink", 
    "Saturday" = "brown"
  )) +  # Customize colors per day
  theme_minimal() + 
  theme(
    axis.line = element_line(linewidth = 0.5)
  ) +
  geom_text(data = data.frame(
    x = seq(0, 162, by = 6),
    y = min(peak_users_dow_crct_processed_df_v3$total_active_users) * 
      ifelse(rep(c(TRUE, FALSE, TRUE, FALSE), length.out = length(seq(0, 162, by = 6))), 0.75, 
      ifelse(rep(c(TRUE, FALSE, TRUE, FALSE), length.out = length(seq(0, 162, by = 6))), 0.5, 0.5)),  # Stagger heights, 
    label = rep(c("12a", "6a", "12p", "6p"), 
                length.out = length(seq(0, 162, by = 6)))
  ), aes(x = x, y = y, label = label), inherit.aes = FALSE, size = 3, color = "black") + 
  geom_vline(xintercept = seq(0, 168, by = 24), linetype = "dashed", color = "gray")


#### #### #### #### #### #### #### #### 

ggsave(file = "peak_users_Per_Hour_Per_Day_Week.pdf", units = "in", width = 6, height = 7)



#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

rm(peak_users_dow_crct_processed_df)
rm(peak_users_dow_crct_processed_df_per_location)
rm(peak_users_dow_crct_processed_df_v2)
#rm(peak_users_dow_crct_processed_df_v3)

gc()

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 



#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####

# All code below here is for the most used stations section

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####


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

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

rm(temp_location_scouting_df)

gc()




#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 


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

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

chicago_lsd.station.ns.counts <- table(chicago_lsd$station.ns)
chicago_lsd.station.ew.counts <- table(chicago_lsd$station.ew)

new_york_city_lsd.station.ns.counts <- table(new_york_city_lsd$station.ns)
new_york_city_lsd.station.ew.counts <- table(new_york_city_lsd$station.ew)

washington_lsd.station.ns.counts <- table(washington_lsd$station.ns)
washington_lsd.station.ew.counts <- table(washington_lsd$station.ew)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

chicago_lsd.station.ns.counts_sorted <- sort(chicago_lsd.station.ns.counts, decreasing = TRUE)
chicago_lsd.station.ew.counts_sorted <- sort(chicago_lsd.station.ew.counts, decreasing = TRUE)

new_york_city_lsd.station.ns.counts_sorted <- sort(new_york_city_lsd.station.ns.counts, decreasing = TRUE)
new_york_city_lsd.station.ew.counts_sorted <- sort(washington_lsd.station.ew.counts, decreasing = TRUE)

washington_lsd.station.ns.counts_sorted <- sort(washington_lsd.station.ns.counts, decreasing = TRUE)
washington_lsd.station.ew.counts_sorted <- sort(washington_lsd.station.ew.counts, decreasing = TRUE)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

head(chicago_lsd.station.ns.counts_sorted, 5)
head(chicago_lsd.station.ew.counts_sorted, 5)

head(new_york_city_lsd.station.ns.counts_sorted, 5)
head(new_york_city_lsd.station.ew.counts_sorted, 5)

head(washington_lsd.station.ns.counts_sorted, 5)
head(washington_lsd.station.ew.counts_sorted, 5)


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 


chicago_lsd_station_counts_ns_df <- as.data.frame(chicago_lsd.station.ns.counts_sorted)
View(chicago_lsd_station_counts_ns_df)

#### #### #### #### #### #### #### #### 

chicago_lsd_station_counts_ns_df <- chicago_lsd_station_counts_ns_df %>%
  rename("station" = "Var1" , "count" = "Freq") %>%
  filter(!is.na(station) & station != "") %>%
  mutate(
    rank = row_number(),
    direction = "ns",
    location = "chicago")

#### #### #### #### #### #### #### #### 

#View(chicago_lsd_station_counts_ns_df)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

chicago_lsd_station_counts_ew_df <- as.data.frame(chicago_lsd.station.ew.counts_sorted)

#### #### #### #### #### #### #### #### 

chicago_lsd_station_counts_ew_df <- chicago_lsd_station_counts_ew_df %>%
  rename("station" = "Var1" , "count" = "Freq") %>%
  filter(!is.na(station) & station != "") %>%
  mutate(
    rank = row_number(),
    direction = "ew",
    location = "chicago")

#### #### #### #### #### #### #### #### 


#View(chicago_lsd_station_counts_ew_df)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

new_york_city_lsd_station_counts_ns_df <- as.data.frame(new_york_city_lsd.station.ns.counts_sorted)

#### #### #### #### #### #### #### #### 

new_york_city_lsd_station_counts_ns_df <- new_york_city_lsd_station_counts_ns_df %>%
  rename("station" = "Var1" , "count" = "Freq") %>%
  filter(!is.na(station) & station != "") %>%
  mutate(
    rank = row_number(),
    direction = "ns",
    location = "new york city")

#### #### #### #### #### #### #### #### 

#View(new_york_city_lsd_station_counts_ns_df)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

new_york_city_lsd_station_counts_ew_df <- as.data.frame(new_york_city_lsd.station.ew.counts_sorted)

#### #### #### #### #### #### #### #### 

new_york_city_lsd_station_counts_ew_df <- new_york_city_lsd_station_counts_ew_df %>%
  rename("station" = "Var1" , "count" = "Freq") %>%
  filter(!is.na(station) & station != "") %>%
  mutate(
    rank = row_number(),
    direction = "ew",
    location = "new york city")


#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### ####  

washington_lsd_station_counts_ns_df <- as.data.frame(washington_lsd.station.ns.counts_sorted)

#### #### #### #### #### #### #### #### 

washington_lsd_station_counts_ns_df <- washington_lsd_station_counts_ns_df %>%
  rename("station" = "Var1" , "count" = "Freq") %>%
  filter(!is.na(station) & station != "") %>%
  mutate(
    rank = row_number(),
    direction = "ns",
    location = "washington")


#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

washington_lsd_station_counts_ew_df <- as.data.frame(washington_lsd.station.ew.counts_sorted)

#### #### #### #### #### #### #### #### 

washington_lsd_station_counts_ew_df <- washington_lsd_station_counts_ew_df %>%
  rename("station" = "Var1" , "count" = "Freq") %>%
  filter(!is.na(station) & station != "") %>%
  mutate(
    rank = row_number(),
    direction = "ew",
    location = "washington")


#### #### #### #### #### #### #### #### 

#View(washington_lsd_station_counts_ew_df)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

chicago_lsd_station_counts_nsew_df = rbind(chicago_lsd_station_counts_ns_df, chicago_lsd_station_counts_ew_df)

#### #### #### #### #### #### #### ####

#View(chicago_lsd_station_counts_nsew_df)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

new_york_city_lsd_station_counts_nsew_df = rbind(new_york_city_lsd_station_counts_ns_df, new_york_city_lsd_station_counts_ew_df)

#### #### #### #### #### #### #### ####

washington_lsd_station_counts_nsew_df = rbind(washington_lsd_station_counts_ns_df, washington_lsd_station_counts_ew_df)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 


all_lsd_station_counts_nsew_df = rbind(chicago_lsd_station_counts_nsew_df, new_york_city_lsd_station_counts_nsew_df)

all_lsd_station_counts_nsew_df = rbind(all_lsd_station_counts_nsew_df, washington_lsd_station_counts_nsew_df)


#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

all_top_ten_stations_df <- all_lsd_station_counts_nsew_df %>%
  filter(rank >= 1 & rank <= 10 )

#### #### #### #### #### #### #### #### 


#View(all_top_ten_stations_df)

#### #### #### #### #### #### #### #### 

all_top_ten_stations_df <- select(all_top_ten_stations_df, location, direction, rank, station, count)

#### #### #### #### #### #### #### #### 

#View(all_top_ten_stations_df)

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

save(all_lsd_station_counts_nsew_df, file = "all_lsd_station_counts_nsew_df.RData")
save(all_top_ten_stations_df, file = "all_top_ten_stations_df.RData")

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

rm(location)
rm(locations_list)
rm(filtered_location)


rm(chicago_lsd)
rm(new_york_city_lsd)
rm(washington_lsd)

rm(chicago_lsd_station_counts_ns_df)
rm(chicago_lsd_station_counts_ew_df)
rm(chicago_lsd_station_counts_nsew_df)

rm(new_york_city_lsd_station_counts_ns_df)
rm(new_york_city_lsd_station_counts_ew_df)
rm(new_york_city_lsd_station_counts_nsew_df)

rm(washington_lsd_station_counts_ns_df)
rm(washington_lsd_station_counts_ew_df)
rm(washington_lsd_station_counts_nsew_df)

rm(location_scouting_df)
rm(top_ten_chicago)

rm(all_lsd_station_counts_nsew_df)
rm(stations_bar_plot)

rm(chicago_lsd_station.counts.ns)
rm(chicago_lsd.station.ns.counts)
rm(chicago_lsd.station.ns.counts_sorted)
rm(chicago_lsd.station.ew.counts)
rm(chicago_lsd.station.ew.counts_sorted)

rm(new_york_city_lsd_station.counts.ns)
rm(new_york_city_lsd.station.ns.counts)
rm(new_york_city_lsd.station.ns.counts_sorted)
rm(new_york_city_lsd.station.ew.counts)
rm(new_york_city_lsd.station.ew.counts_sorted)

rm(washington_lsd_station.counts.ns)
rm(washington_lsd.station.ns.counts)
rm(washington_lsd.station.ns.counts_sorted)
rm(washington_lsd.station.ew.counts)
rm(washington_lsd.station.ew.counts_sorted)

rm(station_ns_counts)

rm(station.ns.counts)
rm(station.ns.counts_sorted)
rm(station.ew.counts)
rm(station.ew.counts_sorted)

gc()

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

all_top_ten_stations_df$direction <- factor(all_top_ten_stations_df$direction, levels = c("ns", "ew"), labels = c("North-South", "East-West"))
all_top_ten_stations_df$location <- factor(all_top_ten_stations_df$location, levels = c("chicago", "new york city", "washington"), labels = c("Chicago, IL", "New York City, NY", "Washington, D.C."))

#### #### #### #### #### #### #### #### 

ggplot(all_top_ten_stations_df, aes(x = reorder(station, rank), y = count, fill = direction)) +
  geom_bar(stat = "identity") +
  facet_grid(rows = vars(location), cols = vars(direction), scales = "free_x") +  # Split charts by direction
  labs(title = "Top 10 Stations by Direction and Location",
       x = "Station",
       y = "Count") +
  scale_y_continuous(breaks = seq(0, max(all_top_ten_stations_df$count), by = 2000)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

#### #### #### #### #### #### #### #### 

ggsave(file = "Top 10 Stations By Direction and Location.pdf", units = "in", width = 6, height = 7)

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 



#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 


load("all_top_ten_stations_df.RData")


retry_request <- function(city, attempts = 3) {
  for (i in 1:attempts) {
    tryCatch({
      # OSM queries
      rivers_osm_data <- opq(city, timeout = 300) %>% add_osm_feature(key = "waterway", value = "river") %>% osmdata_sf()
      railways_osm_data <- opq(city, timeout = 300) %>% add_osm_feature(key = "railway", value = "rail") %>% osmdata_sf()
      bigstreets_osm_data <- opq(city, timeout = 300) %>% 
        add_osm_feature(key = "highway", value = c("motorway", "trunk", "primary", "motorway_link", "trunk_link", "primary_link")) %>% 
        osmdata_sf()
      streets_osm_data <- opq(city, timeout = 300) %>% 
        add_osm_feature(key = "highway", value = c("secondary", "tertiary", "secondary_link", "tertiary_link")) %>% 
        osmdata_sf()
      
      return(list(rivers_osm_data = rivers_osm_data, 
                  railways_osm_data = railways_osm_data, 
                  bigstreets_osm_data = bigstreets_osm_data,
                  streets_osm_data = streets_osm_data))  # Return results if successful
    }, error = function(e) {
      if (i == attempts) stop("Request failed after multiple attempts.")
      message("Attempt ", i, " failed. Retrying in 5 seconds...")
      Sys.sleep(5)  # Wait before retrying
    })
  }
}


# Define city and get OSM data
#city <- "Chicago, Illinois, USA"
#city <- "New York City, New York, USA"
#city <- "Washington, D.C., USA"

#cities = c("Chicago, Illinois, USA", "New York City, New York, USA", "Washington, D.C., USA")
cities = c("Chicago, Illinois, USA", "Washington, D.C., USA")
#cities = c("Chicago, Illinois, USA")
#cities = c("Washington, D.C., USA")

for (city in cities) {
  
  print(city)
  
  city_name = sub(",.*", "", city)
  city_name <- tolower(city_name)
  

  osm_data = retry_request(city)
  
  rivers_osm_data <- osm_data$rivers_osm_data
  railways_osm_data <- osm_data$railways_osm_data 
  bigstreets_osm_data <- osm_data$bigstreets_osm_data
  streets_osm_data <- osm_data$streets_osm_data

  
  city_top_ten_ns <- all_top_ten_stations_df %>% 
    filter(location == city_name) %>% 
    filter(direction == "ns") %>%
    mutate(
      station = as.character(station)
    )
  
  city_top_ten_ns_stations <- city_top_ten_ns
  
  city_top_ten_ns_stations$station <- str_remove(city_top_ten_ns_stations$station, "\\b(North|South|East|West|N|S|E|W)\\b\\s*")
  city_top_ten_ns_stations$cleaned.station <- str_remove(city_top_ten_ns_stations$station, "\\s+(St|Dr|Ave|Blvd|Rd)$")
  
  top_ns_streets_list <- city_top_ten_ns_stations$cleaned.station
  

  city_top_ten_ew <- all_top_ten_stations_df %>% 
    filter(location == city_name) %>% 
    filter(direction == "ew") %>%
    mutate(
      station = as.character(station)
    )
  
  city_top_ten_ew_stations <- city_top_ten_ew
  
  city_top_ten_ew_stations$station <- str_remove(city_top_ten_ew_stations$station, "\\b(North|South|East|West|N|S|E|W)\\b\\s*")
  city_top_ten_ew_stations$cleaned.station <- str_remove(city_top_ten_ew_stations$station, "\\s+(St|Dr|Ave|Blvd|Rd)$")
  
  top_ew_streets_list <- city_top_ten_ew_stations$cleaned.station
  
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
  
  city_top_ten_ns <- droplevels(city_top_ten_ns)
  city_top_ten_ew <- droplevels(city_top_ten_ew)
  
  rm(city_name)
  rm(osm_data)
  rm(rivers_osm_data)
  rm(railways_osm_data)
  rm(bigstreets_osm_data)
  rm(streets_osm_data)
  
  rm(city_top_ten_ns)
  rm(city_top_ten_ew)
  
  rm(city_top_ten_ns_stations)
  rm(city_top_ten_ew_stations)
  
  rm(top_ns_streets_list)
  rm(top_ew_streets_list)
  
  rm(ns_match_pattern)
  rm(ew_match_pattern)
  
  rm(empty_osm)
  rm(filtered_ns_streets)
  rm(filtered_ew_streets)
  
  rm(ns_streets_osm)
  rm(ew_streets_osm)
  
  rm(rivers)
  rm(railways)
  rm(bigstreets)
  rm(streets)
  
  rm(streets_file_name)
  rm(big_streets_file_name)
  rm(railways_file_name)
  rm(rivers_file_name)
  rm(ns_streets_file_name)
  rm(ew_streets_file_name)
  
}

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

rm(city)
rm(cities)
rm(city_name)

rm(city_top_ten_ns_stations)
rm(city_top_ten_ns)
rm(top_ns_streets_list)

gc()


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

cities = c("Chicago, Illinois, USA")

register_google(key = "AIzaSyAXT4MOl9BvoQrx0iGYew0Uvpkhea4VVcs")
google_key()


for (city in cities){
  
  #city = "Chicago, Illinois, USA"
  
  print(city)
  
  city_bb <- getbb(city)
  
  city_name = sub(",.*", "", city)
  city_name <- tolower(city_name)
  
  #### #### #### ####  
  
  bigstreets_local = st_read(paste(city_name, "bigstreets.gpkg", sep="_"))
  streets_local = st_read(paste(city_name, "streets.gpkg", sep="_"))
  rivers_local = st_read(paste(city_name, "rivers.gpkg", sep="_"))
  railways_local = st_read(paste(city_name, "railways.gpkg", sep="_"))
  ns_streets_local = st_read(paste(city_name, "ns_streets.gpkg", sep="_"))
  ew_streets_local = st_read(paste(city_name, "ew_streets.gpkg", sep="_"))
  
  #### #### #### ####  
  
  min_long <- city_bb[1,1]
  max_long <- city_bb[1,2]
  
  min_lat <- city_bb[2,1]
  max_lat <- city_bb[2,2]

  #### #### #### ####  
  
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
  
  #### #### #### ####  
  
  ggsave_osm_file_name = paste(city_name, "osm_most_used_stations.pdf", sep="_")
  
  #### #### #### ####  
  
  ggsave(file = ggsave_osm_file_name, units = "in", width = 6, height = 7)
  
  
  #### #### #### #### #### #### #### #### 
  #### #### #### #### #### #### #### #### 
  #### #### #### #### #### #### #### #### 
  
  gmap_city_map <- get_map(city_bb, maptype = "roadmap")

  #### #### #### ####  
    
  ggmap(gmap_city_map) +
    geom_sf(data = ns_streets_local, inherit.aes = FALSE, color = "red", size = 2, alpha = 1) + 
    geom_sf(data = ew_streets_local, inherit.aes = FALSE, color = "blue", size = 2, alpha = 1) +
    coord_sf(xlim = c(min_long, max_long), 
             ylim = c(min_lat,  max_lat)) +
    theme_minimal() +
    ggtitle(paste(str_to_title(city_name), "GGMap OSM Streets (Local GeoPackage)", sep=" "))
  
  #### #### #### #### #### #### #### #### 
  
  ggsave_gmap_file_name = paste(city_name, "ggmap_most_used_stations.pdf", sep="_")
  
  #### #### #### ####  
  
  ggsave(file = ggsave_gmap_file_name, units = "in", width = 6, height = 7)
  
}

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 




#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

load("all_top_ten_stations_df.RData")

cities = c("Chicago, Illinois, USA", "New York City, New York, USA", "Washington, D.C., USA")

for (city in cities) {
  #city = "chicago"
  
  print(city)
  
  #city_bb <- getbb(city)
  
  city_name = sub(",.*", "", city)
  city_name <- tolower(city_name)
  
  
  
  city_top_three_ns <- all_top_ten_stations_df %>% 
    filter(location == city_name) %>% 
    filter(direction == "ns") %>%
    mutate(
      station = as.character(station)
    ) %>% 
    top_n(3)
  
  
  city_top_three_ns_stations <- city_top_three_ns
  
  #city_top_three_ns_stations$station <- str_remove(city_top_three_ns_stations$station, "\\b(North|South|East|West|N|S|E|W)\\b\\s*")
  #city_top_three_ns_stations$cleaned.station <- str_remove(city_top_three_ns_stations$station, "\\s+(St|Dr|Ave|Blvd|Rd)$")
  
  #top_ns_streets_list <- city_top_three_ns_stations$cleaned.station
  top_ns_streets_list <- city_top_three_ns_stations$station
  
  city_top_three_ew <- all_top_ten_stations_df %>% 
    filter(location == city_name) %>% 
    filter(direction == "ew") %>%
    mutate(
      station = as.character(station)
    ) %>% 
    top_n(3)
  
  city_top_three_ew_stations <- city_top_three_ew
  
  #city_top_three_ew_stations$station <- str_remove(city_top_three_ew_stations$station, "\\b(North|South|East|West|N|S|E|W)\\b\\s*")
  #city_top_three_ew_stations$cleaned.station <- str_remove(city_top_three_ew_stations$station, "\\s+(St|Dr|Ave|Blvd|Rd)$")
  
  #top_ew_streets_list <- city_top_three_ew_stations$cleaned.station
  top_ew_streets_list <- city_top_three_ew_stations$station
  
  # Define street names and rankings
  #north_south <- c("1st Ave", "2nd Ave", "3rd Ave")
  #east_west <- c("1st St", "2nd St", "3rd St")
  
  # Create data frame with rank values
  df <- expand.grid(North_South = top_ns_streets_list, East_West = top_ew_streets_list)
  df$Rank <- c(1, 2, 4, 
               2, 3, 5, 
               4, 5, 6)  # Follows your ranking pattern
  
  
  df$North_South <- factor(df$North_South, levels = rev(north_south))
  df$East_West <- factor(df$East_West, levels = rev(east_west))
  
  # Create the heatmap
  ggplot(df, aes(x = East_West, y = North_South, fill = Rank)) +
    geom_tile(color = "white") +
    geom_text(aes(label = Rank), color = "black", size = 6) +
    scale_fill_gradient(low = "blue", high = "white") +
    labs(title = "Street Intersection Rankings", x = "East-West Streets", y = "North-South Streets") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  ggsave_heatmap_file_name = paste(city_name, "heatmap_matrix_most_used_stations.pdf", sep="_")
  
  
  ggsave(file = ggsave_heatmap_file_name, units = "in", width = 6, height = 7)
  
}


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

#### #### #### #### #### #### #### #### 

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

plot_hierarchical_edge_bundling <- subset(bikeshare_main_df, select = c(location, start.station, end.station ))

View(plot_hierarchical_edge_bundling)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

#gc()

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

cities = c("chicago", "new york city", "washington")

for (city in cities) {
  
  city_pheb_df <- plot_hierarchical_edge_bundling %>%
    filter(location == city) 
  
  edge_data <- city_pheb_df %>%
    count(start.station, end.station, name = "count")
  
  edge_data_circle <- edge_data %>%
    arrange(desc(count)) %>%
    top_n(75)  
  
  edge_data_fr <- edge_data %>%
    arrange(desc(count)) %>%
    top_n(125)
  
  
  
  g_circle <- tbl_graph(
    nodes = data.frame(name = unique(c(edge_data_circle$start.station, edge_data_circle$end.station))),  # Unique locations
    edges = edge_data_circle,  
    directed = TRUE
  )
  
  g_fr <- tbl_graph(
    nodes = data.frame(name = unique(c(edge_data_fr$start.station, edge_data_fr$end.station))),  # Unique locations
    edges = edge_data_fr,
    directed = TRUE  
  )
  
  #### #### #### #### #### #### #### #### 
  #### #### #### #### #### #### #### #### 
  #### #### #### #### #### #### #### #### 
  
  
  
  ggraph(g_circle, layout = 'circle') + 
    geom_edge_arc(aes(alpha = count / max(count)), edge_colour = "blue", show.legend = FALSE) +  
    geom_node_point(size = 3, color = "red") +  
    geom_node_text(aes(label = name), vjust = -1) +  
    #coord_fixed(expand = TRUE) +
    #scale_x_continuous(expand = expansion(mult = 0.5)) +  
    #scale_y_continuous(expand = expansion(mult = 0.5)) +
    theme_void() 
  
  ggsave_circle_file_name = paste(city, "circlegraph_most_used_routes.pdf", sep="_")
  
  ggsave(file = ggsave_circle_file_name, units = "in", width = 6, height = 7)
  
  
  
  #### #### #### #### #### #### #### #### 
  #### #### #### #### #### #### #### #### 
  #### #### #### #### #### #### #### #### 
  
  
  ggraph(g_fr, layout = "fr") +  
    geom_edge_link(aes(alpha = count / max(count)), color = "blue") +  
    geom_node_point(size = 3, color = "red") +  
    geom_node_text(aes(label = name), vjust = -1) + 
    #scale_x_continuous(expand = expansion(mult = 0.5)) +  
    #scale_y_continuous(expand = expansion(mult = 0.5)) +
    theme_void()
  
  ggsave_fr_file_name = paste(city, "_frgraph_must_used_routes.pdf", sep="_")
  
  ggsave(file = ggsave_fr_file_name, units = "in", width = 6, height = 7)
  
  
}


#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

cites = c("chicago", "new york city", "washington")

for (city in cities) {
  stats_edge_data <- plot_hierarchical_edge_bundling %>%
    group_by(location, start.station, end.station) %>%
    summarise(count = n(), .groups = "drop")
  
}

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####

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


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####







