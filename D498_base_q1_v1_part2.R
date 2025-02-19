combined_rides_common_timeframes$start.hour <- hour(combined_rides_common_timeframes$start.time)
combined_rides_common_timeframes$end.hour <- hour(combined_rides_common_timeframes$end.time)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 


active_hours <- matrix(0, nrow=nrow(combined_rides_common_timeframes), ncol= 24)

active_hours_df <- as.data.frame(active_hours)

colnames(active_hours_df) <- paste0("active_hour.", 0:23)

#### #### #### #### #### #### #### #### 

combined_rides_common_timeframes <- cbind(combined_rides_common_timeframes, active_hours_df)

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 


combined_rides_common_timeframes <- update_columns_batches(combined_rides_common_timeframes, "start.hour", "end.hour", "active_hour.", 10)


#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

View(combined_rides_common_timeframes)

#### #### #### #### #### #### #### #### 

dim(combined_rides_common_timeframes)

length(combined_rides_common_timeframes)

nrow(combined_rides_common_timeframes)



#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

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

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 


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


#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

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

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### ####  

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

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### ####  


ggplot(peak_users_dow_crct_processed_df, aes(x = hour, y = total_active_users, color = day.of.the.week)) +
  geom_line() +
  labs(x = "Hour of the Day", y = "Total Active Users", title = "Active Users by Hour and Day of the Week") +
  scale_x_continuous(breaks = 0:23) + 
  theme_minimal()


#### #### #### #### #### #### #### #### 

ggplot(peak_users_dow_crct_processed_df, aes(x = interaction(day.of.the.week, hour), y = total_active_users, group = hour)) +
  geom_line() +
  labs(x = "Day of the Week (Hour)", y = "Total Active Users") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + # Rotate x-axis labels for clarity
  scale_x_discrete(labels = function(x) {
    # Split interaction and return formatted labels (Day-Hour)
    day_hour <- strsplit(x, "\\.")
    sapply(day_hour, function(x) paste(x[1], x[2], sep = " "))
  })


#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### ####  


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
    #Split the day_hour and return formatted labels (Day-Hour)
    day_hour <- strsplit(x, "_")
    sapply(day_hour, function(x) paste(x[1], x[2], sep = " "))
  })


#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### ####  

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

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### ####  
