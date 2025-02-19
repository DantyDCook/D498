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

head(chicago)
str(chicago)

####

q2_chi <- subset.data.frame(chicago, select = c(X, Start.Time, End.Time))

View(q2_chi)

#### 

q2_chi$day.of.week <- weekdays(q2_chi$Start.Time)
q2_chi$Start.Hour <- hour(q2_chi$Start.Time)

View(q2_chi)

q2_chi$End.Hour <- hour(q2_chi$End.Time)

####

q2_chi <- q2_chi[c('X', 'Start.Time', 'End.Time', 'day.of.week', 'Start.Hour','End.Hour')]

active_hours <- matrix(0, nrow=nrow(q2_chi), ncol= 24)

active_hours_df <- as.data.frame(active_hours)

colnames(active_hours_df) <- paste0("active_hour.", 0:23)

q2_chi <- cbind(q2_chi, active_hours_df)

####

q2_chi <- update_columns(q2_chi, "Start.Hour", "End.Hour")

q2_chi <- update_columns_batches(q2_chi, "Start.Hour", "End.Hour", "active_hour.", batch_size = 100)
View(q2_chi)

q2_chi$total_hours <- floor(difftime(q2_chi$End.Time, q2_chi$Start.Time, units = 'hours')) +1 

q2_chi$day_change <- day(q2_chi$Start.Time) != day(q2_chi$End.Time)

expanded_q2_chi <- q2_chi %>%
  
  mutate(
    End.Hour = ifelse(day_change == TRUE, End.Hour == 23, End.Hour)
  ) %>%
  
  filter(day_change == TRUE) %>%
  
  slice(rep(1:n(), 1)) %>%
  
  mutate(
    Start.Hour = ifelse(day_change == TRUE, Start.Hour == 0, Start.Hour),
    End.Hour = ifelse(day_change == TRUE, End.Hour == hour(End.Time), End.Hour),
    day.of.week = weekdays(End.Time)
  ) %>%
  bind_rows(q2_chi %>% filter(day_change == FALSE))

View(expanded_q2_chi)
