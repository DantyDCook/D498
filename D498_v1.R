# Removes all previously created variables.
# https://youtu.be/D_CNmYkGRUc?si=PJJbZY0GBtVsB4dB&t=91
rm(list=ls())

#### #### 

install.packages("stringr")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("lubridate")

#### ####

library(stringr)
library(dplyr)
library(ggplot2)
library(lubridate)

#### ####

setwd("D:/WGU/D498/D498/")
getwd()

#### ####

chicago <- read.csv("datasets/chicago.csv")
new_york_city <- read.csv("datasets/new-york-city.csv")
washington <- read.csv("datasets/washington.csv")

#### ####

head(chicago)

str(chicago)

####

#chicago$Start.Time <- as.POSIXlt(chicago$Start.Time, format="%Y/%m/%d %H:%M:%S")
chicago$Start.Time <- ymd_hms(chicago$Start.Time)

#chicago$End.Time <- as.POSIXlt(chicago$End.Time, format="%Y/%m/%d %H:%M:%S")
chicago$End.Time <- ymd_hms(chicago$End.Time)

chicago$Gender <- as.factor(chicago$Gender)
chicago$User.Type <- as.factor(chicago$User.Type)
chicago$Birth.Year <- as.integer(chicago$Birth.Year)

####

str(chicago)

head(chicago)

levels(chicago$User.Type)
levels(chicago$Gender)

#### #### #### #### 

head(new_york_city)

str(new_york_city)

#new_york_city$Start.Time <- as.POSIXct(new_york_city$Start.Time, format="%m/%d/%Y %H:%M:%S")
new_york_city$Start.Time <- ymd_hms(new_york_city$Start.Time)

#new_york_city$End.Time <- as.POSIXct(new_york_city$End.Time, format="%m/%d/%Y %H:%M:%S")
new_york_city$End.Time <- ymd_hms(new_york_city$End.Time)

new_york_city$Gender <- as.factor(new_york_city$Gender)
new_york_city$User.Type <- as.factor(new_york_city$User.Type)
new_york_city$Birth.Year <- as.integer(new_york_city$Birth.Year)

####

str(new_york_city)

head(new_york_city)

levels(new_york_city$User.Type)
levels(new_york_city$Gender)

#### #### #### #### 

head(washington)

str(washington)

#washington$Start.Time <- as.POSIXct(washington$Start.Time, format="%m/%d/%Y %H:%M:%S")
washington$Start.Time <- ymd_hms(washington$Start.Time)

#washington$End.Time <- as.POSIXct(washington$End.Time, format="%m/%d/%Y %H:%M:%S")
washington$End.Time <- ymd_hms(washington$End.Time)

washington$Trip.Duration <- ceiling(washington$Trip.Duration)
washington$Trip.Duration <- as.integer(washington$Trip.Duration)

washington[c('Gender','Birth.Year')] <- NA
washington$Gender <- ""

washington$Gender <- factor(washington$Gender, levels =c("", "Female", "Male"))

washington$User.Type <- as.factor(washington$User.Type)
washington$Birth.Year <- as.integer(washington$Birth.Year)

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



####

str(washington)

head(washington)

levels(washington$User.Type)
levels(washington$Gender)

#### #### #### #### 

chicago$city <- "chicago"
new_york_city$city <- "new york city"
washington$city <- "washington"

#### #### #### #### 

combined_dataset <- rbind(chicago, new_york_city)
combined_dataset <- rbind(combined_dataset, washington)

combined_dataset$city <- as.factor(combined_dataset$city)

####

attached(combined_dataset, warn.conflicts = FALSE)

####

head(combined_dataset)

str(combined_dataset)

describe(combined_dataset)


####

subscribers <- subset(combined_dataset, combined_dataset$User.Type == "Subscriber")

dependents <- subset(combined_dataset, combined_dataset$User.Type == "Dependent")

nonsubscribers <- subset(combined_dataset, combined_dataset$User.Type == "Customer")
nonsubscribers <- subset(nonsubscribers, select = -c('Gender', 'Birth.Year'))
####

