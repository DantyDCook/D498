
#### #### #### #### #### #### #### #### 

# Removes all previously created variables.
# https://youtu.be/D_CNmYkGRUc?si=PJJbZY0GBtVsB4dB&t=91
rm(list=ls())

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

#install.packages("stringr")
#install.packages("dplyr")
#install.packages("ggplot2")
#install.packages("lubridate")
#install.packages("tidyr")

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


combined_rides_common_timeframes <- update_columns_batches(combined_rides_common_timeframes, "start.hour", "end.hour", "active_hour.", 100)


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

View(combined_rides_common_timeframes)

#### #### #### #### #### #### #### #### 

dim(combined_rides_common_timeframes)

length(combined_rides_common_timeframes)

nrow(combined_rides_common_timeframes)


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 


sunday_crct_df <- combined_rides_common_timeframes %>%
  filter(day.of.the.week == "Sunday")

#### #### #### #### #### #### #### #### 

monday_crct_df <- combined_rides_common_timeframes %>%
  filter(day.of.the.week == "Monday")

#### #### #### #### #### #### #### #### 

tuesday_crct_df <- combined_rides_common_timeframes %>%
  filter(day.of.the.week == "Tuesday")

#### #### #### #### #### #### #### #### 

wednesday_crct_df <- combined_rides_common_timeframes %>%
  filter(day.of.the.week == "Wednesday")

#### #### #### #### #### #### #### #### 

thursday_crct_df <- combined_rides_common_timeframes %>%
  filter(day.of.the.week == "Thursday")

#### #### #### #### #### #### #### #### 

friday_crct_df <- combined_rides_common_timeframes %>%
  filter(day.of.the.week == "Friday")

#### #### #### #### #### #### #### #### 

saturday_crct_df <- combined_rides_common_timeframes %>%
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



ggplot(peak_users_dow_crct_processed_df, aes(x = hour, y = total_active_users, color = day.of.the.week)) +
  geom_line() +
  labs(x = "Hour of the Day", y = "Total Active Users", title = "Active Users by Hour and Day of the Week") +
  scale_x_continuous(breaks = 0:23) + 
  theme_minimal()

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

ggplot(peak_users_dow_crct_processed_df, aes(x = hour, y = total_active_users, color = day_of_week, group = day_of_week)) +
  geom_line() +
  labs(
    title = "Total Active Users by Hour of the Day and Day of the Week",
    x = "Hour of the Day",
    y = "Total Active Users"
  ) +
  scale_x_continuous(breaks = 0:23, labels = c("00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23")) +
  theme_minimal()


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 


peak_users_dow_crct_processed_df_per_location <- peak_users_dow_crct_processed_df_per_location %>%
  mutate(day.of.the.week = factor(day.of.the.week, 
                                  levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")))


#### #### #### #### #### #### #### #### 

ggplot(peak_users_dow_crct_processed_df_per_location, aes(x = hour, y = total_active_users, color = location)) +
  geom_line() +
  labs(x = "Hour of the Day", y = "Total Active Users", title = "Active Users by Hour, Location, and Day of the Week") +
  scale_x_continuous(breaks = 0:23) + 
  theme_minimal() +
  # One Column Layout - USE ONE ONLY
  # One Column Looks the Best
  facet_wrap(~ day.of.the.week, ncol = 1)
  # One Row Layout - USE ONE ONLY
  #facet_wrap(~ day.of.the.week, nrow = 1)


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

peak_users_dow_crct_processed_df_v2 <- peak_users_dow_crct_processed_df %>%
  mutate(
    day_hour = paste(day.of.the.week, hour, sep = "_")
  )

#### #### #### #### #### #### #### #### 

ggplot(peak_users_dow_crct_processed_df_v2, aes(x = day_hour, y = total_active_users, group = 1)) +
  geom_line() +
  labs(x = "Day of the Week (Hour)", y = "Total Active Users") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + # Rotate x-axis labels for clarity
  scale_x_discrete(labels = function(x) {
    Split the day_hour and return formatted labels (Day-Hour)
    day_hour <- strsplit(x, "_")
    sapply(day_hour, function(x) paste(x[1], x[2], sep = " "))
  })

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 

peak_users_dow_crct_processed_df_v3 <- peak_users_dow_crct_processed_df_v2 %>%
  mutate(
    day.of.the.week = factor(day.of.the.week, 
                             levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")),
    day_index = as.numeric(day.of.the.week) - 1,
    time_numeric = day_index * 24 + hour)

#### #### #### #### #### #### #### #### 

ggplot(peak_users_dow_crct_processed_df_v3, aes(x = time_numeric, y = total_active_users, group = 1)) +
  geom_line() +
  labs(x = "Day of the Week (Hour)", y = "Total Active Users") +
  scale_x_continuous(
    breaks = seq(0, 144, by = 24),
    minor_breaks = seq(0, 167, by = 6),
    labels = c( "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
  ) +
  theme_minimal()


#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 


ggplot(peak_users_dow_crct_processed_df_v3, aes(x = time_numeric, y = total_active_users, group = day.of.the.week, color = day.of.the.week)) +
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
  theme_minimal()

#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### 










subscribers <- subset(bikeshare_main_df, bikeshare_main_df$User.Type == "Subscriber")

dependents <- subset(bikeshare_main_df, bikeshare_main_df$User.Type == "Dependent")

nonsubscribers <- subset(bikeshare_main_df, bikeshare_main_df$User.Type == "Customer")
nonsubscribers <- subset(nonsubscribers, select = -c('Gender', 'Birth.Year'))


####

recreational_ride_matching <- data.frame(bikeshare_main_df)

recreational_ride_matching$matched <- bikeshare_main_df$Start.Location == bikeshare_main_df$End.Location
recreation_rides <- recreational_ride_matching %>% filter(match)


recreation_rides 

#### 


#df$Start.To.End.Stations = paste(df$Start.Station, df$End.Station, sep=" >>> ")


#df[c("Start.Station.NS", "Start.Station.EW")]<- str_split_fixed(df$Start.Station, "&", 2)
#df[c("End.Station.NS", "End.Station.EW")]<- str_split_fixed(df$End.Station, "&", 2)


# <- tolower(df$column)
# <- str_squish(df$column)


#df_stacked <- data.frame(Stations = c(df$Start.Station_NS, df$Start.Station_EW, df$End.Station_NS, df$End.Station_EW))

#df_stacked_cleaned <- df_stacked %>%
    #filter(!(is.na(Stations) | Stations == ""))

#station_normalization <- function(station) {
#    station <- tolower(station)
#    station <- str_squish(station)
#    return (station)
#}

#df$station_column <- sapply(df$station_column, station_normalization)

#station_counts <- table(df_stacked_cleaned)
#most_visited_station <- names(station_counts[which.max(station_counts)])
#top_ten_stations <- sort(station_counts, decreasing = TRUE)[1:10]



