
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
